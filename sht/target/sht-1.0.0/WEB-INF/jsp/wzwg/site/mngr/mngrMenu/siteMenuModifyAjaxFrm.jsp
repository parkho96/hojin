<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	
	<script type="text/javascript">
	$(document).ready(function()
			{
				 <c:if test="${resultVO.menuDivision eq 'group' or resultVO.menuTyCode eq 'SC00000033' }">
					 $("#menuDiv").css("display","none");
					$("#linkDiv").css("display","none"); 
					$('#menuPrefix').removeAttr('dir');
				 </c:if>
				 <c:if test="${resultVO.menuDivision eq 'link'}">
				 	$("#menuDiv").css("display","none");
					$(".linkDiv").css("display","");  
					$(".menuDcDiv").css("display","none");
					$(".menuDcEngDiv").css("display","none");
					$("#sysmoduleSeq").val('link');
					$("#menumdTyCode1").val('link');
					$('#menuPrefix').attr('dir', 'required');
				 </c:if> 
				 $("#upperMenuSeq").val('<c:out value="${resultVO.upperMenuSeq eq '0' ? '' : resultVO.upperMenuSeq}"/>');
				 
				//$('.modal-content').draggable({ handle: ".modal-header" });
			    //$(".modal-header").css('cursor', 'move');
			    	
			    	
			});
		function  fnModifyMenuMngrAjax(){ 
			if(!Validator.validate(document.frmMenu)){
				return;
			}
			<c:if test="${resultVO.menuDivision eq 'group'}"> 
			if(<c:out value="${subMenuCnt}"/> > 0 && $("#menumdTyCode1").val() !=''){
				alert('<spring:message code="wzwg.cmm.msg.MSG141" />');
				$("#menumdTyCode1").val("");
				return;
			}
			</c:if>
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrAjax.do'
		        , type:'html'
		        , data: $("#frmMenu").serialize()
		        , success:function (data) {  
		        	$(data).find('value').each(function(){
			        	if($(this).text() == "success"){ 
				        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
				        	location.reload();
				        	//fnListAjax();
				        	//fnLayerPopupClose();
						}else if($(this).text() == "maxMenuLv"){
							alert('<spring:message code="wzwg.cmm.msg.MSG143" />');
						} 
						else if($(this).text() == "maxGroupLv"){
							alert('<spring:message code="wzwg.cmm.msg.MSG425" />');
						} 
			        	})
		        }
		    }); 
		}
		
		function  fnDeleteMenuMngrAjax(){ 
            <c:if test="${resultVO.menuDivision eq 'group'}">
            var dataMenuSeq = '[data-mngrmenuseq=' + document.frmMenu.mngrMenuSeq.value + ']' ;
            //console.log(dataMenuSeq);
            var subMenuCnt = $('#nestable1').find(dataMenuSeq).find('ol').length;
            //console.log(subMenuCnt);
            
            if(subMenuCnt > 0){
            	//하위 아이템이 있을때
	            if (!confirm('<spring:message code="wzwg.cmm.msg.MSG142" />')) return false;
            }/* else{
            	//하위 아이템이 없을때
            	if (!confirm('<spring:message code="common.delete.msg" />')) return false;
            } */

            $.ajax({
                  method:'post'
                , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/deleteSiteMngrMenuLowAjax.do'
                , data: $("#frmMenu").serialize()
                , dataType:'xml'
                , success:function (data) {  
                    var result = $(data).find('value').text();
                    
                    if(result =='success'){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
                    }else{
                        alert('<spring:message code="wzwg.cmm.msg.MSG076" />');     
                    }
                    fnListAjax();
                    fnLayerPopupClose();
                }
            });
            </c:if>
            <c:if test="${resultVO.menuDivision ne 'group'}">
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/deleteSiteMngrMenuMngrAjax.do'
		        , type:'html'
		        , data: $("#frmMenu").serialize()
		        , success:function (data) {  
		        	if(data.msg =='success'){
		        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		        	}else{
		            alert('<spring:message code="wzwg.cmm.msg.MSG140" />');		
		        	}
		        	fnListAjax();
		        	fnLayerPopupClose();
		        }
		    });  
            </c:if>
		}
		
		/** 사이트사용자그룹 리스트로 이동*/
		function fn_list(){
			<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000081'}">
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/selectSiteHdMenuMngrList.do';
			</c:if>
			<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082'}">
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/selectSiteFtrMenuMngrList.do';
			</c:if>
			document.siteHdfrmMenuForm.submit();
		}
		
		function fnMenuModuleTyChange(value){ 
			<c:if test="${resultVO.menuDivision eq 'group'}"> 
			if(<c:out value="${subMenuCnt}"/> > 0){
				alert('<spring:message code="wzwg.cmm.msg.MSG141" />');
				$("#menumdTyCode1").val("");
				return;
			}
			</c:if>
			var sysmoduleSeq = '';
			var moduleTyCode = '';
			if(value !='' && value !='link' ){
				sysmoduleSeq = value.split(",")[0];
				  moduleTyCode = value.split(",")[1];
			}else{
				sysmoduleSeq = value;
				if(value == "link"){
					moduleTyCode ='link';
				}else{
					moduleTyCode ='';
				}
			}
			$("#sysmoduleSeq").val(sysmoduleSeq);
			$("#menuTyCode").val(moduleTyCode); 
			
			if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
				$("#menuDiv").css("display","none");
				$(".linkDiv").css("display","none"); 
				$(".menuDcDiv").css("display","");
				$(".menuDcEngDiv").css("display","");
				$("#upperMenuDiv").css("display",""); 
				$('#menuLinkUrl').attr('disabled', true);
				$('#upperMenuSeq').attr('disabled', false);
				$('#menuPrefix').removeAttr('dir');
			}else if(sysmoduleSeq=='link' ){
				$("#menuDiv").css("display","none");
				$(".linkDiv").css("display","");
				$(".menuDcDiv").css("display","none");
				$(".menuDcEngDiv").css("display","none");
				$("#upperMenuDiv").css("display",""); 
				$('#menuLinkUrl').attr('disabled', false);
				$('#upperMenuSeq').attr('disabled', false);
				$('#menuPrefix').attr('dir', 'required');
			}
		}
		
		function changeCntntsSeq(select){
			//console.log(select);
			$('#mngrMenuNm').val($(select).find(":selected").text());
		}
	</script>

	
	<form id="frmMenu" name="frmMenu" method="post">
		<input type="hidden" name="mngrMenuSeq" value="<c:out value="${resultVO.mngrMenuSeq }"/>"/>
		<input type="hidden" name="menuOrdr" value="<c:out value="${resultVO.menuOrdr }"/>"/>
		<input type="hidden" name="menuLv" value="<c:out value="${resultVO.menuLv}"/>"/> 
		<input type="hidden" name="menuTyCode" id="menuTyCode" value="<c:out value="${resultVO.menuTyCode}"/>"/>

		
				<table class="basic">
				<colgroup>
					<col style="width: 35%;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<tr id="upperMenuDiv">
					<th><spring:message code="wzwg.site.menu.msg.MSG035" /></th>
					<td>
						<select  name="upperMenuSeq" id="upperMenuSeq" dir="required"  title='<spring:message code="wzwg.site.menu.msg.MSG057"/>'>
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<%-- <c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
								<option value="<c:out value="${list.menuSeq}"/>"> <c:out value="${list.menuNm}"/> <c:out value="${list.upperMenuSeq }"/></option>
							</c:forEach> --%>
							<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
								<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
									<option value="<c:out value="${oneDepth.mngrMenuSeq }"/>" <c:if test="${oneDepth.mngrMenuSeq eq resultVO.mngrMenuSeq}">disabled</c:if>><c:out value="${oneDepth.mngrMenuNm }"/></option>
									
									<c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}">
									 	<option value="<c:out value="${twoDepth.mngrMenuSeq }"/>" <c:if test="${twoDepth.mngrMenuSeq eq resultVO.mngrMenuSeq}">disabled</c:if>>- <c:out value="${twoDepth.mngrMenuNm }"/></option>
									 	
										<c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
										<c:if test="${twoDepth.mngrMenuSeq eq threeDepth.upperMenuSeq}"> 
											<option value="<c:out value="${threeDepth.mngrMenuSeq }"/>" <c:if test="${threeDepth.mngrMenuSeq eq resultVO.mngrMenuSeq}">disabled</c:if>>-- <c:out value="${threeDepth.mngrMenuNm }"/></option>
										</c:if>
										</c:forEach>
									</c:if>
									</c:forEach>
								</c:if>
							</c:forEach>
						</select>
						<span class="wz_tableguide mt10">
						     <spring:message code="wzwg.cmm.msg.tip.MSG018" />
						</span>
					</td>
				</tr> 
				
				<tr>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG020" /></th>
					<td>
						<select name="menumdTyCode1" id="menumdTyCode1" onchange="fnMenuModuleTyChange(this.value);">
						  <option value=""><spring:message code="wzwg.cmm.word.group" /></option>
						  <option value="link"><spring:message code="wzwg.cmm.word.link" /></option>
						   
						</select>
					</td>
				</tr>
				
				<tr id="menuDiv" style="display:none ;">
					<th><spring:message code="wzwg.cmm.word.cntnts" />&<spring:message code="wzwg.site.menu.msg.MSG036" /></th>
					<td id="dataConn" class="cntntsNmSpan">
						<select>
							<option><spring:message code="wzwg.cmm.msg.MSG139" /></option>
						</select>
					</td>
				</tr>
				<tr class="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.site.menu.msg.MSG037" /></th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl"   value="<c:out value="${resultVO.menuLinkUrl}"/>"  class="w70" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG026" /></th>
					<td>
						<input  name="mngrMenuNm" id="mngrMenuNm" class="w70" value="<c:out value="${resultVO.mngrMenuNm}"/>"  dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG026" />"/>
						<span class="wz_tableguide mt10">
						     <spring:message code="wzwg.cmm.msg.tip.MSG019" />
						</span>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG050" /></th>
					<td>
						<input  name="mngrMenuNmEng" class="w70" id="mngrMenuNmEng" value="<c:out value="${resultVO.mngrMenuNmEng }"/>" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG050" />"/>
					</td>
				</tr>
				<tr class="menuDcDiv">
					<th><spring:message code="wzwg.site.menu.msg.MSG027" /></th>
					<td>
						<input name="menuDc" class="w70"   value="<c:out value="${resultVO.menuDc}"/>" />
					</td>
				</tr> 
				<tr class="menuDcEngDiv">
					<th><spring:message code="wzwg.site.menu.msg.MSG051" /></th>
					<td>
						<input   name="menuDcEng" class="w70" value="<c:out value="${resultVO.menuDcEng }"/>"/>
					</td>
				</tr> 
				<!-- 
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG004" /></th>
					<td>
						<select name="authgrpId" id="authgrpId">
							<option value="SM" <c:if test="${resultVO.authgrpId eq 'SM'}">selected="selected"</c:if>>사이트관리</option>
							<option value="SC" <c:if test="${resultVO.authgrpId eq 'SC'}">selected="selected"</c:if>>디자인관리</option>
							<option value="MS" <c:if test="${resultVO.authgrpId eq 'MS'}">selected="selected"</c:if>>메뉴서브페이지관리</option>
							<option value="UM" <c:if test="${resultVO.authgrpId eq 'UM'}">selected="selected"</c:if>>회원관리</option>
							<option value="OS" <c:if test="${resultVO.authgrpId eq 'OS'}">selected="selected"</c:if>>홈페이지운영</option>
						</select>
				 
					</td>
				</tr>
				 -->
				<tr class="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.cmm.word.menu" /> Prefix</th>
					<td><input id="menuPrefix" name="menuPrefix" dir="required" title="<spring:message code="wzwg.cmm.word.menu" /> Prefix" class="w70" value="<c:out value="${resultVO.menuPrefix}"/>" /></td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="javascript:fnModifyMenuMngrAjax();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<%-- <a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a> --%> 
			<a href="javascript:void(0);" onclick="javascript:fnDeleteMenuMngrAjax();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
		</div>
			
		</form>
		

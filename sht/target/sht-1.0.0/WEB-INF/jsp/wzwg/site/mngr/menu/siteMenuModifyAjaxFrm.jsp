<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript" src="/clipboard/dist/clipboard.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function()
			{
				 <c:if test="${resultVO.menuDivision eq 'group' or resultVO.menuTyCode eq 'SC00000033' or resultVO.sysmoduleSeq eq '888888888888'}">
					 $("#menuDiv").css("display","none");
					$("#linkDiv").css("display","none"); 
					$("#externalLink").css("display","none"); 
				 </c:if>
				 <c:if test="${resultVO.menuDivision eq 'link'}">
				 	$("#menuDiv").css("display","none");
				 	$("#externalLink").css("display","none");
					$("#linkDiv").css("display","");  
					$("#sysmoduleSeq").val('link');
					$("#menumdTyCode1").val('link');
				 </c:if>
				 <c:if test="${resultVO.sysmoduleSeq eq '888888888888'}"> 
				 $("#upperMenuDiv").css("display","none");
				 $("#linkDiv").css("display","none"); 
				 $("#externalLink").css("display","none"); 
				 $("#sysmoduleSeq").val('888888888888');
				 </c:if>
				 <c:if test="${resultVO.menuDivision eq 'cntnts' and resultVO.menuTyCode ne 'SC00000033'}">
				 $("#menuDiv").css("display","");
					$("#linkDiv").css("display","none");  
					$("#externalLink").css("display","");  
					
					$.ajax({
						  method:'post'
				        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/siteMenuCntntListAjax.do'
				        , type:'html'
				        , data:{"sysmoduleSeq":'<c:out value="${resultVO.sysmoduleSeq}"/>'}
				        , success:function (data) { 
				        	 $(".cntntsNmSpan").html(data); 
							 $("#sitecntntsSeq").val('<c:out value="${resultVO.sitecntntsSeq}"/>');
							 $("#menumdTyCode1").val('<c:out value="${resultVO.sysmoduleSeq}"/>,<c:out value="${resultVO.moduleTyCode}"/>');
				        }
				    }); 
				 </c:if>
                 <c:if test="${(resultVO.menuDivision eq 'cntnts' and resultVO.menuTyCode eq 'SC00000033') or resultVO.sysmoduleSeq eq '888888888888'}">
                 $("#menumdTyCode1").val('<c:out value="${resultVO.sysmoduleSeq}"/>,<c:out value="${resultVO.menuTyCode}"/>');
                 </c:if>
				 $("#upperMenuSeq").val('<c:out value="${resultVO.upperMenuSeq eq '0' ? '' : resultVO.upperMenuSeq}"/>');
				 
				//$('.modal-content').draggable({ handle: ".modal-header" });
			    //$(".modal-header").css('cursor', 'move');
			    
				 $('#copy_externalLink').click(function(){
						$('#copy_externalLink').attr('data-clipboard-text', $('#copy_text').text());    
					    var clipboard = new Clipboard('#copy_externalLink');
					    clipboard.on('success', function(e) {
					        alert('<spring:message code="wzwg.cmm.msg.MSG083" />');
					        clipboard.destroy();
					        $('#copy_externalLink').focus();
					    });
					    clipboard.on('error', function(e) {
					        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					        return false;
					        clipboard.destroy();
					    });
					    
					    $('#copy_externalLink').focus();
				   });
			    	
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

			if($("#sysmoduleSeq").val() == "link" && $("#menuLinkUrl").val().trim().length < 1){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.link" /></spring:argument></spring:message>');
				return false;
			}
			
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/modifySiteMenuMngrAjax.do'
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
            var dataMenuSeq = '[data-menuseq=' + document.frmMenu.menuSeq.value + ']' ;
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
                , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/deleteSiteMenuLowAjax.do'
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
		        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/deleteSiteMenuMngrAjax.do'
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
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteHdMenuMngrList.do';
			</c:if>
			<c:if test="${siteHdftrMenuVO.hdftrCode eq 'SC00000082'}">
			document.siteHdfrmMenuForm.action='<c:out value="${wzwg_contextPath}"/>/mngr/menu/selectSiteFtrMenuMngrList.do';
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
			
			// 외부링크
			if(sysmoduleSeq =='') {
			   $("#externalLink").css("display","none");
			} else if(sysmoduleSeq=='888888888888') {
				$("#externalLink").css("display","none");
			} else if(sysmoduleSeq=='link') {
				$("#externalLink").css("display","none");
			}else {
				$("#externalLink").css("display","");
				$.ajax({
					  method:'post'
			        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/siteMenuCntntListAjax.do'
			        , type:'html'
			        , data:{"sysmoduleSeq":sysmoduleSeq}
			        , success:function (data) { 
			        	 $(".cntntsNmSpan").html(data); 
			        }
			    }); 
			}
			
			
			if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display","none"); 
				$("#upperMenuDiv").css("display","");
				$('#sitecntntsSeq').attr('disabled', true);
				$('#menuLinkUrl').attr('disabled', true);
				$('#upperMenuSeq').attr('disabled', false);
			}else if(sysmoduleSeq=='888888888888'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display","none"); 
				$("#upperMenuDiv").css("display","none");
				$('#sitecntntsSeq').attr('disabled', true);
				$('#menuLinkUrl').attr('disabled', true);
				$('#upperMenuSeq').attr('disabled', true);
			}else if(sysmoduleSeq=='link' ){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display","");
				$("#upperMenuDiv").css("display","");
				$('#sitecntntsSeq').attr('disabled', true);
				$('#menuLinkUrl').attr('disabled', false);
				$('#upperMenuSeq').attr('disabled', false);
			}else{
				$("#menuDiv").css("display","");
				$("#linkDiv").css("display","none");
				$("#upperMenuDiv").css("display","");
				$('#sitecntntsSeq').attr('disabled', false);
				$('#menuLinkUrl').attr('disabled', true);
				$('#upperMenuSeq').attr('disabled', false);
				$.ajax({
					  method:'post'
			        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/siteMenuCntntListAjax.do'
			        , type:'html'
			        , data:{"sysmoduleSeq":sysmoduleSeq}
			        , success:function (data) { 
			        	 $(".cntntsNmSpan").html(data); 
			        }
			    }); 
			}
		}
		
		function changeCntntsSeq(select){
			//console.log(select);
			$('#menuNm').val($(select).find(":selected").text());
		}
	</script>
	
	<form id="frmMenu" name="frmMenu" method="post">
		<input type="hidden" name="menuSeq" value="<c:out value="${resultVO.menuSeq }"/>"/>
		<input type="hidden" name="menuOrdr" value="<c:out value="${resultVO.menuOrdr }"/>"/>
		<input type="hidden" name="menuLv" value="<c:out value="${resultVO.menuLv}"/>"/>
		<input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" value="<c:out value="${resultVO.sysmoduleSeq}"/>"/>
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
						<select  name="upperMenuSeq" id="upperMenuSeq" class="wd100">
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<%-- <c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
								<option value="<c:out value="${list.menuSeq}"/>"> <c:out value="${list.menuNm}"/> <c:out value="${list.upperMenuSeq }"/></option>
							</c:forEach> --%>
							<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
								<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
									<option value="<c:out value="${oneDepth.menuSeq }"/>" <c:if test="${oneDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>><c:out value="${oneDepth.menuNm }" escapeXml="false" /></option>
									
									<c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
									 	<option value="<c:out value="${twoDepth.menuSeq }"/>" <c:if test="${twoDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>>- <c:out value="${twoDepth.menuNm }" escapeXml="false" /></option>
									 	
										<c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
										<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
											<option value="<c:out value="${threeDepth.menuSeq }"/>" <c:if test="${threeDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>>-- <c:out value="${threeDepth.menuNm }" escapeXml="false" /></option>
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
						  <c:forEach items="${resultList['CNTNTS_LIST']}" var="list" varStatus="status">
							<c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                      		<option value="<c:out value="${list.sysmoduleSeq}"/>,<c:out value="${list.moduleTyCode}"/>"> <c:out value="${list.moduleNm}"/></option>  
	                    	</c:if>
							<c:if test="${sessionScope.LANG ne 'SC00000016' }">
	                      		<option value="<c:out value="${list.sysmoduleSeq}"/>,<c:out value="${list.moduleTyCode}"/>"> <c:out value="${list.moduleNmEng}"/></option>  
	                    	</c:if>
						</c:forEach>
						<c:if test="${resultVO.menuLv eq '1'}">
						<option value="888888888888,"><spring:message code="wzwg.cmm.word.anchor" /></option>
						</c:if>
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
				<tr id="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.site.menu.msg.MSG037" /></th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl"   value="<c:out value="${resultVO.menuLinkUrl}"/>"  class="w70" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG026" /></th>
					<td>
						<input  name="menuNm" id="menuNm" class="w70" value="<c:out value="${resultVO.menuNm}" escapeXml="false" />"  dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG026" />"/>
						<span class="wz_tableguide mt10">
						     <spring:message code="wzwg.cmm.msg.tip.MSG019" />
						</span>
					</td>
				</tr>
				<tr style="display: none;">
					<th><spring:message code="wzwg.site.menu.msg.MSG027" /></th>
					<td>
						<input name="menuDc" class="w70"   value="<c:out value="${resultVO.menuDc}"/>" />
					</td>
				</tr>
				<tr>
				   <th><spring:message code="wzwg.cmm.word.sttus" /></th>
				   <td>
				   		<ul class="wzForm">
					   		<li><label><input type="radio" id="menuSttusCode2" name="menuSttusCode" value="SC00000035" <c:if test="${resultVO.menuSttusCode eq  'SC00000035'}">checked="checked" </c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li> 
					   		<li><label><input type="radio" id="menuSttusCode1" name="menuSttusCode" value="SC00000034"   <c:if test="${resultVO.menuSttusCode eq  'SC00000034'}">checked="checked" </c:if>/><span class="spanLabel"><spring:message code="wzwg.cmm.word.hide" /></span></label></li>
				   		</ul>
				   		<span class="wz_tableguide mt10 clboth">
						    <strong><spring:message code="wzwg.cmm.word.use" /></strong> : <spring:message code="wzwg.cmm.msg.tip.MSG020" /><br>
						    <strong><spring:message code="wzwg.cmm.word.hide" /></strong> : 
						<img src="/images/wzwg/site/mngr/menu-hide.png" class="mr5 vert-m"><spring:message code="wzwg.cmm.msg.tip.MSG021" />
						</span>
				   		</td>
				</tr>
				<tr id="externalLink" style="display:none ; font-size:10px;">
				   <th>URL</th>
				   <td>
				   	 <div id="copy_text" class="fs14 grey wd100 mb10"><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%><c:out value="${wzwg_contextPath}"/>/subList/<c:out value="${resultVO.menuSeq }"/></div>
				   	 <p class="admpg-subp w100 fl mb10">
						<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG0201" />
					 </p>
				   	 <button type="button" id="copy_externalLink" class="wzbtn-table btn-basic fs14" data-clipboard-action="copy" >copy</button>
				   </td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="javascript:fnModifyMenuMngrAjax();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<%-- <a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a> --%> 
			<a href="javascript:void(0);" onclick="javascript:fnDeleteMenuMngrAjax();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
		</div>
			
		</form>
		

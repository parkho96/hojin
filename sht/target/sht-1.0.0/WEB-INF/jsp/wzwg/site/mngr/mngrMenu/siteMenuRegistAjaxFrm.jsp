<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(e){
	        
	        $('.modal-content').draggable({ handle: ".modal-header" });
	    	$(".modal-header").css('cursor', 'move');
	    });
		
		function  fnRegistMenuMngrAjax(){ 
			if(!Validator.validate(document.frmMenu)){
				return;
			} 
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}"/>/sysMngr/siteMngr/menu/registSiteMngrMenuMngrAjax.do'
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
						}else if($(this).text() == "maxGroupLv"){
							alert('<spring:message code="wzwg.cmm.msg.MSG425" />');
						}
			        	})
		        }
		    }); 
		} 
		function fnMenuModuleTyChange(value){
			var sysmoduleSeq = '';
			var moduleTyCode = '';
			if(value !='' && value !='link' ){
				sysmoduleSeq = value.split(",")[0];
				  moduleTyCode = value.split(",")[1];
			}else{
				sysmoduleSeq = value;
				moduleTyCode ='';
			}
	
			
			$("#sysmoduleSeq").val(sysmoduleSeq);
			$("#menuTyCode").val(moduleTyCode); 
			
			if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){ 
				$(".linkDiv").css("display","none"); 
				$(".menuDcDiv").css("display","");
				$(".menuDcEngDiv").css("display","");
				$("#upperMenuDiv").css("display",""); 
				$('#menuLinkUrl').attr('disabled', true);
				$('#upperMenuSeq').attr('disabled', false);
				$('#menuPrefix').removeAttr('dir');
			} else if(sysmoduleSeq=='link' ){ 
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
			$('#menuNm').val($(select).find(":selected").text());
		}
	</script>

	
		<form id="frmMenu" name="frmMenu" method="post">
			<input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" value=""/>
			<input type="hidden" name="menuTyCode" id="menuTyCode" value=""/>

		
				<table class="basic">
				<colgroup>
					<col style="width: 35%;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<tr id="upperMenuDiv" >
					<th><spring:message code="wzwg.site.menu.msg.MSG035" /></th>
					<td>
						<select name="upperMenuSeq" id="upperMenuSeq" title="<spring:message code="wzwg.site.menu.msg.MSG057"/>">
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<%-- <c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
								<option value="<c:out value="${list.menuSeq}">"/> <c:out value="${list.menuNm}"/> <c:out value="${list.upperMenuSeq }"/></option>
							</c:forEach> --%>
							<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
							<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<option value="<c:out value="${oneDepth.mngrMenuSeq }"/>"><c:out value="${oneDepth.mngrMenuNm }"/></option>
								
								<c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}">
								 	<option value="<c:out value="${twoDepth.mngrMenuSeq }"/>">- <c:out value="${twoDepth.mngrMenuNm }"/></option>
								 	
									<c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
									<c:if test="${twoDepth.mngrMenuSeq eq threeDepth.upperMenuSeq}"> 
										<option value="<c:out value="${threeDepth.mngrMenuSeq }"/>">-- <c:out value="${threeDepth.mngrMenuNm }"/></option>
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
						<select name="menumdTyCode1" id="menumdTyCode1" onchange="fnMenuModuleTyChange(this.value);" >
						  <option value=""><spring:message code="wzwg.cmm.word.group" /></option>
						  <option value="link"><spring:message code="wzwg.cmm.word.link" /></option>  
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG026" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input  name="mngrMenuNm" class="w70" id="mngrMenuNm" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG026" />"/>
						<span class="wz_tableguide mt10">
						     <spring:message code="wzwg.cmm.msg.tip.MSG019" />
						</span>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG050" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<input  name="mngrMenuNmEng" class="w70" id="mngrMenuNmEng" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG050" />"/>
					</td>
				</tr>
				<tr class="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.site.menu.msg.MSG037" /></th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl"   value="" class="w70" />
					</td>
				</tr>
				
				<tr class="menuDcDiv">
					<th><spring:message code="wzwg.site.menu.msg.MSG027" /></th>
					<td>
						<input   name="menuDc" class="w70" />
					</td>
				</tr> 
				<tr class="menuDcEngDiv">
					<th><spring:message code="wzwg.site.menu.msg.MSG051" /></th>
					<td>
						<input   name="menuDcEng" class="w70" />
					</td>
				</tr> 
				<!-- 
				<tr>
					<th><spring:message code="wzwg.site.menu.msg.MSG004" /></th>
					<td>
						<select name="authgrpId" id="authgrpId">
							<option value="SM">사이트관리</option>
							<option value="SC">디자인관리</option>
							<option value="MS">메뉴서브페이지관리</option>
							<option value="UM">회원관리</option>
							<option value="OS">홈페이지운영</option>
						</select>
				 
					</td>
				</tr>
				 -->
				<tr class="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.cmm.word.menu" /> Prefix
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td><input id="menuPrefix" name="menuPrefix" title="<spring:message code="wzwg.cmm.word.menu" /> Prefix" class="w70" /></td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);"  onclick="javascript:fnRegistMenuMngrAjax();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<%-- <a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></a> --%> 
			<a href="javascript:void(0);" onclick="javascript:fnAllCelar();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.initl" /></a> 
		</div>
		
		</form>
			

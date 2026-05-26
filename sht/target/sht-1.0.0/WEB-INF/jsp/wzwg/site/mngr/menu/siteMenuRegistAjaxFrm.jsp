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
			
			var moduleTyCode = $("#menuTyCode").val();
			
			if(moduleTyCode=='SC00000030' || moduleTyCode == 'SC00000031' || moduleTyCode == 'SC00000032'){
				if(!$('#sitecntntsSeq').val()){
					alert('<spring:message code="wzwg.cmm.msg.MSG406" />');
					$('#sitecntntsSeq').focus();
					return;
				}
			}

			if($("#sysmoduleSeq").val() == "link" && $("#menuLinkUrl").val().trim().length < 1){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.link" /></spring:argument></spring:message>');
				return false;
			}
			
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/registSiteMenuMngrAjax.do'
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
			        , data:{"sysmoduleSeq":sysmoduleSeq,"moduleTyCode":moduleTyCode}
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
						<select name="upperMenuSeq" id="upperMenuSeq" class="wd100">
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<%-- <c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
								<option value="<c:out value="${list.menuSeq}"/>"> <c:out value="${list.menuNm}"/> <c:out value="${list.upperMenuSeq }"/></option>
							</c:forEach> --%>
							<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
							<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<option value="<c:out value="${oneDepth.menuSeq }"/>"><c:out value="${oneDepth.menuNm }"/></option>
								
								<c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
								 	<option value="<c:out value="${twoDepth.menuSeq }"/>">- <c:out value="${twoDepth.menuNm }"/></option>
								 	
									<c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
									<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
										<option value="<c:out value="${threeDepth.menuSeq }"/>">-- <c:out value="${threeDepth.menuNm }"/></option>
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
						  <c:forEach items="${resultList['CNTNTS_LIST']}" var="list" varStatus="status">
							<c:if test="${sessionScope.LANG eq 'SC00000016' }">
	                      		<option value="<c:out value="${list.sysmoduleSeq}"/>,<c:out value="${list.moduleTyCode}"/>"> <c:out value="${list.moduleNm}"/></option>  
	                    	</c:if>
							<c:if test="${sessionScope.LANG ne 'SC00000016' }">
	                      		<option value="<c:out value="${list.sysmoduleSeq}"/>,<c:out value="${list.moduleTyCode}"/>"> <c:out value="${list.moduleNmEng}"/></option>  
	                    	</c:if>

						</c:forEach>
						<option value="888888888888,"><spring:message code="wzwg.cmm.word.anchor" /></option>
						</select>
					</td>
				</tr>
				
				<tr id="menuDiv" style="display:none ;">
					<th><spring:message code="wzwg.cmm.word.cntnts" />&<spring:message code="wzwg.site.menu.msg.MSG036" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td id="dataConn" class="cntntsNmSpan">
						<select>
							<option><spring:message code="wzwg.cmm.msg.MSG139" /></option> 
						</select>
					</td>
				</tr>
				<tr id="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.site.menu.msg.MSG037" />
						<span class="necessary">
								<span></span>
								<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl"   value="" class="w70" />
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
						<input  name="menuNm" class="w70" id="menuNm" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG026" />"/>
						<span class="wz_tableguide mt10">
						     <spring:message code="wzwg.cmm.msg.tip.MSG019" />
						</span>
					</td>
				</tr>
				<tr style="display: none;">
					<th><spring:message code="wzwg.site.menu.msg.MSG027" /></th>
					<td>
						<input   name="menuDc" class="w70" />
					</td>
				</tr>
				<tr>
				   <th><spring:message code="wzwg.cmm.word.sttus" /></th>
				   <td>
				   		<ul class="wzForm wd100 fl">
					   		<li><label><input type="radio" id="menuSttusCode2" name="menuSttusCode" value="SC00000035" checked="checked"/><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li> 
					   		<li><label><input type="radio" id="menuSttusCode1" name="menuSttusCode" value="SC00000034"   /><span class="spanLabel"><spring:message code="wzwg.cmm.word.hide" /></span></label></li> 
				   		</ul>
				   		<span class="wz_tableguide mt10">
						    <strong><spring:message code="wzwg.cmm.word.use" /></strong> : <spring:message code="wzwg.cmm.msg.tip.MSG020" /><br>
						    <strong><spring:message code="wzwg.cmm.word.hide" /></strong> : 
						<img src="/images/wzwg/site/mngr/menu-hide.png" class="mr5 vert-m"><spring:message code="wzwg.cmm.msg.tip.MSG021" />
						</span>
				   	</td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);"  onclick="javascript:fnRegistMenuMngrAjax();" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<%-- <a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.close" /></a> --%> 
			<a href="javascript:void(0);" onclick="javascript:fnAllCelar();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.initl" /></a> 
		</div>
		
		</form>
			

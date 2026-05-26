<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	
	<script type="text/javascript">
	$(document).ready(function()
			{
				 <c:if test="${resultVO.menuDivision eq 'group' or resultVO.menuTyCode eq 'SC00000033'}">
					 $("#menuDiv").css("display","none");
					$("#linkDiv").css("display","none"); 
				 </c:if>
				 <c:if test="${resultVO.menuDivision eq 'link'}">
				 	$("#menuDiv").css("display","none");
					$("#linkDiv").css("display","");  
					$("#sysmoduleSeq").val('link');
					$("#menumdTyCode1").val('link');
				 </c:if>
				 <c:if test="${resultVO.menuDivision eq 'cntnts' and resultVO.menuTyCode ne 'SC00000033'}">
				 $("#menuDiv").css("display","");
					$("#linkDiv").css("display","none");  
					
					
					$.ajax({
						  method:'post'
				        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/siteMenuCntntListAjax.do'
				        , type:'html'
				        , data:{"sysmoduleSeq":'<c:out value="${resultVO.sysmoduleSeq}" />'}
				        , success:function (data) { 
				        	 $("#cntntsNmSpan").html(data); 
							 $("#sitecntntsSeq").val('<c:out value="${resultVO.sitecntntsSeq}" />');
							 $("#menumdTyCode1").val('<c:out value="${resultVO.sysmoduleSeq}" />,<c:out value="${resultVO.moduleTyCode}" />');
				        }
				    }); 
				 </c:if>
				 $("#upperMenuSeq").val('<c:out value="${resultVO.upperMenuSeq}" />');
			});
		function  fnModifyMenuMngrAjax(){ 
			<c:if test="${resultVO.menuDivision eq 'group'}"> 
			if(<c:out value="${subMenuCnt}" /> > 0 && $("#menumdTyCode1").val() !=''){
				alert('<spring:message code="wzwg.cmm.msg.MSG141" />');
				$("#menumdTyCode1").val("");
				return;
			}
			</c:if>

            if(!Validator.validate(document.frmMenu)) return;
            
            if ($('#menumdTyCode1').val().indexOf('SC00000030') > -1 || $('#menumdTyCode1').val().indexOf('SC00000031') > -1 || $('#menumdTyCode1').val().indexOf('SC00000032') > -1) {
                if ($('#sitecntntsSeq').val().trim().length < 1) {
                    var meg = '<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>';
                    meg += '<spring:message code="wzwg.sysMngr.word.cntnts/bbsCnnc" />';
                    meg += '</spring:argument></spring:message>';
                    return alert(meg);
                }
            }
            if ($('#menumdTyCode1').val() == 'link') {
                if ($('#menuLinkUrl').val().trim().length < 1) {
                    var meg = '<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument>';
                    meg += '<spring:message code="wzwg.sysMngr.word.linkAdres" />';
                    meg += '</spring:argument></spring:message>';
                    return alert(meg);
                }
            }
            
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrAjax.do'
		        , type:'html'
		        , data: $("#frmMenu").serialize()
		        , success:function (data) {  
		        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
		        	fnListAjax();
		        	fnLayerPopupClose();
		        	
		        }
		    }); 
		}
		
		function  fnDeleteMenuMngrAjax(){ 
			$.ajax({
				  method:'post'
		        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/deleteSiteMenuMngrAjax.do'
		        , type:'html'
		        , data: $("#frmMenu").serialize()
		        , success:function (data) { 
		           //alert(data.msg);
		        	if(data.msg =='success'){
		        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		        	}else{
		            alert('<spring:message code="wzwg.cmm.msg.MSG140" />');		
		        	}
		        	fnListAjax();
		        	fnLayerPopupClose();
		        	
		        }
		    }); 
		}
		
		function fnMenuModuleTyChange(value){
			<c:if test="${resultVO.menuDivision eq 'group'}"> 
			if(<c:out value="${subMenuCnt}" /> > 0){
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
				moduleTyCode ='';
			}
			$("#sysmoduleSeq").val(sysmoduleSeq);
			$("#menuTyCode").val(moduleTyCode); 
			
			if(sysmoduleSeq =='' || moduleTyCode=='SC00000033'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display","none"); 
			}else if(sysmoduleSeq=='link'){
				$("#menuDiv").css("display","none");
				$("#linkDiv").css("display",""); 
			}else{
				$("#menuDiv").css("display","");
				$("#linkDiv").css("display","none");  
				$.ajax({
					  method:'post'
			        , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbsInfo/siteMenuCntntListAjax.do'
			        , type:'html'
			        , data:{"sysmoduleSeq":sysmoduleSeq}
			        , success:function (data) { 
			        	 $("#cntntsNmSpan").html(data); 
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
		<input type="hidden" name="menuSeq" value="<c:out value="${resultVO.menuSeq }" />"/>
		<input type="hidden" name="menuOrdr" value="<c:out value="${resultVO.menuOrdr }" />"/>
		<input type="hidden" name="menuLv" value="<c:out value="${resultVO.menuLv}" />"/>
		<input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" value="<c:out value="${resultVO.sysmoduleSeq}" />"/>
		<input type="hidden" name="menuTyCode" id="menuTyCode" value="<c:out value="${resultVO.menuTyCode}" />"/>

		
				<table class="basic">
				<colgroup>
					<col style="width: 35%;">
					<col style="width: *;">
				</colgroup>
				<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.groupUpperMenu" /></th>
					<td>
						<select  name="upperMenuSeq" id="upperMenuSeq">
						<option value=""><spring:message code="wzwg.cmm.word.none" /></option>
						<%-- <c:forEach items="${resultList['MENU_LIST']}" var="list" varStatus="status">
							<option value="${list.menuSeq}"> ${list.menuNm}</option>
						</c:forEach> --%>
						<c:forEach items="${resultList['MENU_LIST']}" var="oneDepth" varStatus="status">
							<c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<option value="<c:out value="${oneDepth.menuSeq }" />" <c:if test="${oneDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>><c:out value="${oneDepth.menuNm }" /></option>
								
								<c:forEach items="${resultList['MENU_LIST']}" var="twoDepth" varStatus="status">
								<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
								 	<option value="<c:out value="${twoDepth.menuSeq }" />" <c:if test="${twoDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>>- <c:out value="${twoDepth.menuNm }" /></option>
								 	
									<c:forEach items="${resultList['MENU_LIST']}" var="threeDepth" varStatus="status">
									<c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
										<option value="<c:out value="${threeDepth.menuSeq }" />" <c:if test="${threeDepth.menuSeq eq resultVO.menuSeq}">disabled</c:if>>-- <c:out value="${threeDepth.menuNm }" /></option>
									</c:if>
									</c:forEach>
								</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
						</select>
					</td>
				</tr> 
				
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.pgTy" /></th>
					<td>
						<select name="menumdTyCode1" id="menumdTyCode1" onchange="fnMenuModuleTyChange(this.value);">
						  <option value=""><spring:message code="wzwg.cmm.word.group" /></option>
						  <option value="link"><spring:message code="wzwg.cmm.word.link" /></option>
						  <c:forEach items="${resultList['CNTNTS_LIST']}" var="list" varStatus="status">
							<option value="<c:out value="${list.sysmoduleSeq}" />,<c:out value="${list.moduleTyCode}" />" > <c:out value="${list.moduleNm}" /></option>
						</c:forEach>
						</select>
					</td>
				</tr>
				<tr id="menuDiv" style="display:none ;">
					<th><spring:message code="wzwg.sysMngr.word.cntnts/bbsCnnc" /></th>
					<td id="dataConn">
						<span id="cntntsNmSpan">
						<select>
							<option><spring:message code="wzwg.cmm.msg.MSG139" /></option>
						</select>
						</span>
					</td>
				</tr>
				
				<tr id="linkDiv" style="display:none ;">
					<th><spring:message code="wzwg.sysMngr.word.linkAdres" /></th>
					<td id="dataConn">
					 <input type="text" id="menuLinkUrl" name="menuLinkUrl" title="<spring:message code="wzwg.sysMngr.word.linkAdres" />" value="<c:out value="${resultVO.menuLinkUrl}" />"  class="w70" />
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.menuNm01" /></th>
					<td><input  name="menuNm" class="w70" dir="required" title="<spring:message code="wzwg.sysMngr.word.menuNm01" />" value="<c:out value="${resultVO.menuNm}" />" /></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.menuDc" /></th>
					<td>
						<input   name="menuDc" class="w70" dir="required" title="<spring:message code="wzwg.sysMngr.word.menuDc" />" value="<c:out value="${resultVO.menuDc}" />" />
					</td>
				</tr>
				<tr>
				   <th><spring:message code="wzwg.cmm.word.sttus" /></th>
				   <td> 
				   		<ul class="wzForm">
				   			<li><input type="radio" id="menuSttusCode2" name="menuSttusCode" value="SC00000035" <c:if test="${resultVO.menuSttusCode eq  'SC00000035'}">checked="checked" </c:if>/><label for="menuSttusCode2"><spring:message code="wzwg.cmm.word.use" /></label></li>
				   			<li><input type="radio" id="menuSttusCode1" name="menuSttusCode" value="SC00000034"   <c:if test="${resultVO.menuSttusCode eq  'SC00000034'}">checked="checked" </c:if>/><label for="menuSttusCode1"><spring:message code="wzwg.cmm.word.hide" /></label></li>
				   		</ul>
				   </td>
				</tr>
				</tbody>
				</table>
		
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="javascript:fnModifyMenuMngrAjax();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a> 
			<a href="javascript:void(0);" onclick="javascript:fnLayerPopupClose();" class="wzbtn btn-basic close"><spring:message code="wzwg.cmm.word.list" /></a> 
			<a href="javascript:void(0);" onclick="javascript:fnDeleteMenuMngrAjax();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
		</div>
			
		</form>
		

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/cmm/layer_popup.css" rel="stylesheet" />

<script type="text/javascript">
	
	$(document).ready(function(){
	
		$("#cancle_btn").click(function (){
	    	$('body').css({overflow:'auto'});
	    	$("#bbs_layer").html("");
	   		$('#bbs_layer').hide();	
		});	
		
		$("#modify_btn").click(function (){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
			      , url:'<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/cmmn/modifySubospecAjax.do'
			      , cache : false
			      , data:$("#modifyFrm").serialize()
			      , success:function (result) {
			    	  
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ctgry02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
							$('body').css({overflow:'auto'});
							fnPage(1);
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
			    	  
						$("#close_btn").click();
			      }
			      , error:function (data) {
			          alert('<spring:message code="fail.common.msg" text="error" />');
			      }
			      , dataType: 'xml'
			 	});
			}
			
		});
		
	});
	
	function fnLayerPopupClose(){
		$('body').css({overflow:'auto'});
    	$("#bbs_layer").html("");
   		$('#bbs_layer').hide();
	}
	
</script>

	<c:set var="adminAuthAt" value="N"/>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="popupViewAuthAt" value="N" />
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="popupViewAuthAt" value="Y" />
	</c:if>	
	
	<c:if test="${popupViewAuthAt ne 'Y'}">
		<script type="text/javascript">
			$("#close_btn").click();
			alert("<spring:message code="wzwg.cmm.msg.MSG084" />");
		</script>
	</c:if>	

			<div class="pop-conts" style="">
				
				<form:form modelAttribute="paramVO" name="modifyFrm" id="modifyFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="checkNttSeq" />
					
					<table class="basic">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
				  	<tbody>
					<tr>
						<th><spring:message code="wzwg.sysMngr.word.ctgry02Choise" /></th>
						<td>
							<form:select path="searchSubospecSeq">
								<form:option value=""><label for="unsel"><spring:message code="wzwg.cmm.word.unsel" /></label></form:option>
								<c:forEach var="resultList" items="${subospecList}" varStatus="status">
									<form:option value="${fn:escapeXml(resultList.subospecSeq)}" label="${fn:escapeXml(resultList.subospecSj)}" />
								</c:forEach>
							</form:select>				
						</td>
					</tr>
					</tbody>
					</table>			
				
				</form:form>
				
			</div>
		
		<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-save" id="modify_btn"><spring:message code="wzwg.cmm.word.stre" /></a>
			<%-- <a href="javascript:void(0);" class="wzbtn btn-basic" id="cancle_btn"><spring:message code="wzwg.cmm.word.close" /></a> --%>
		</div>
			

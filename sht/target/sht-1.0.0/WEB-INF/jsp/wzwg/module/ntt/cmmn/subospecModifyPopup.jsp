<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){

		$("#modify_btn").click(function (){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
				return
			}else{
				$.ajax({
			        type:'POST'
			      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/modifySubospecAjax.do'
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
			    	  
						$(".close").click();
			      }
			      , error:function (data) {
			          alert('<spring:message code="fail.common.msg" text="error" />');
			      }
			      , dataType: 'xml'
			 	});
			}
			
		});
		
	});
		
</script>

	<c:set var="adminAuthAt" value="N"/>
	
	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
	
	<c:set var="popupViewAuthAt" value="N" />
	
	<c:if test="${adminAuthAt eq 'Y'}">
		<c:set var="popupViewAuthAt" value="Y" />
	</c:if>	
	
	
			<div class="pop-conts" style="">
				
				<form:form modelAttribute="paramVO" name="modifyFrm" id="modifyFrm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="bbsSeq" />
					<form:hidden path="checkNttSeq" />
					<c:set var="ctgryTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
					
					<table class="basic">
						<colgroup>
							<col width="20%" />
							<col width="80%" />
						</colgroup>
					  	<tbody>
							<tr>
								<th scope="row"><spring:message code="wzwg.module.word.ctgrychoise" /></th>
								<td>
									<form:select path="searchSubospecSeq" title="${fn:escapeXml(ctgryTit)}">
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
		</div>
			

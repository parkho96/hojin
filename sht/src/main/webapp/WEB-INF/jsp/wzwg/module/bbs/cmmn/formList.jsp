<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	function fnSubospecDelete(subospecSeq) {
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/unity/registUnityBbsBassInfoAjax.do'
				, dataType: 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.msg.MSG084" text="saved" />');
						fnList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		
		}
		
	}
	
	
</script>

	<c:if test="${!empty subospecList}">
		<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
			<p class="mg_t10"><c:out value="${subospecList.subospecSj}"/>
				<a href="javascript:void(0);" onclick="fnSubospecModify('<c:out value="${subospecList.subospecSeq}"/>');"><span class="btn btn_default btn_xs"><spring:message code="wzwg.cmm.word.updt" /></span></a>
				<a href="javascript:void(0);" onclick="fnSubospecDelete('<c:out value="${subospecList.subospecSeq}"/>');"><span class="btn btn_default btn_xs"><spring:message code="wzwg.cmm.word.delete" /></span></a>
			</p>
			<c:if test="${!status.last}"><br /></c:if>
		</c:forEach>
	</c:if>
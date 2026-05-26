<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/crossuploader/uploadForm.do"
			, data : "siteSeq=<c:out value="${fileVO.siteSeq}" />&atchFileId=<c:out value="${fileVO.atchFileId}" />&updateFlag=<c:out value="${fileVO.updateFlag}" />&posblAtchFileNumber=<c:out value="${fileVO.posblAtchFileNumber}" />&helpAt=<c:out value="${fileVO.helpAt}" />"
			, success : function (data) {
				$("#file_div").html(data);
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	});
	
</script>

<form:form modelAttribute="fileVO" path="fileFrm" id="fileFrm" name="fileFrm" method="post">
	<form:hidden path="atchFileId" />
	<form:hidden path="fileSn" />
	<form:hidden path="updateFlag" />
	<form:hidden path="posblAtchFileNumber" />
	<form:hidden path="helpAt" />
	
	<div id="file_div"></div>
</form:form>



	
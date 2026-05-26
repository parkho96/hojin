<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){
	   	 $.ajax({
			type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}" />/opnsu/file/selectFileList.do'
			, data : "atchFileId=<c:out value="${fileVO.atchFileId}" />&updateFlag=<c:out value="${fileVO.updateFlag}" />"
			, success : function (data) {
				$("#file_div_<c:out value="${fileVO.atchFileId}" />").html(data);
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});  
		
	});
	
	function fnFileDown(atchFileId, fileSn){
		window.open("<c:url value='${wzwg_contextPath}/opnsu/file/fileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}

	function fnFileDelete(atchFileId, fileSn) {

		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/opnsu/file/deleteFileInfs.do'
			, data:"atchFileId="+atchFileId+"&fileSn="+fileSn+"&updateFlag=<c:out value="${fileVO.updateFlag}" />"
			, success:function (result) {
				
				var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'success'){
					
					$.ajax({
				        type:'POST'
				      , url:'<c:out value="${wzwg_contextPath}" />/opnsu/file/selectFileList.do'
				      , data:"atchFileId=<c:out value="${fileVO.atchFileId}" />&updateFlag=<c:out value="${fileVO.updateFlag}" />"
				      , success:function (data) {
				    	  $("#file_div_<c:out value="${fileVO.atchFileId}" />").html(data);
				      }
				      , error:function (request, status, error) {
				    	  alert('<spring:message code="fail.common.msg" text="error" />');
				      }
				      , dataType: 'html'
				 	});
				}else{
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
				}
				
			}
			, error:function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});  
		
	}

</script>

<form:form modelAttribute="fileVO" path="fileFrm" id="fileFrm" name="fileFrm" method="post">
	<form:hidden path="atchFileId" />
	<form:hidden path="fileSn" />
	<form:hidden path="updateFlag" />
	
	<ul id="file_div_<c:out value="${fileVO.atchFileId}" />"></ul>
</form:form>
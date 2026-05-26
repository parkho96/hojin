<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<html lang="ko">
<head>
<title><spring:message code="${ERROR_INFO.errCd}" /></title>
<script>
<c:if test="${!empty ERROR_INFO.errCd}">
alert('<spring:message code="${ERROR_INFO.errCd}" />');
</c:if>
document.location.href = "<c:out value="${wzwg_contextPath}${ERROR_INFO.retUrl}" />";
</script>
</head>
<body>
</body>
</html>
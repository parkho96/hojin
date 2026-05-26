<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<html lang="ko">
<head>
<title><spring:message code="${message}" /></title>
<script>
<c:if test="${!empty message}">
alert('<spring:message code="${message}" />');
</c:if>
document.location.href = "<c:out value="${wzwg_contextPath}${retUrl}" />";
</script>
</head>
<body>
</body>
</html>




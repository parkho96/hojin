<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<title><spring:message code="${errCd}" /></title>
<script>
<c:if test="${!empty errCd}">
alert('<spring:message code="${errCd}" />');
</c:if>
<c:if test="${not empty retUrl}">
<c:if test="${retUrl eq 'historyBack'}">
history.back();
</c:if>
<c:if test="${retUrl ne 'historyBack'}">
document.location.href = "<c:out value="${wzwg_contextPath}${retUrl}" />";
</c:if>
</c:if>
</script>
</head>
<body>
</body>
</html>
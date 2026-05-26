<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<html lang="ko">
<head>
<title><c:out value="${errCd}" /></title>
<script>
<c:if test="${!errCd}">
alert('<c:out value="${errCd}" />');
</c:if>
self.close();
</script>
</head>
<body>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script>
<c:if test="${!empty msg}">
alert('<c:out value="${msg}" />');
</c:if>
document.location.href = "<c:out value="${retUrl}" />";
</script>

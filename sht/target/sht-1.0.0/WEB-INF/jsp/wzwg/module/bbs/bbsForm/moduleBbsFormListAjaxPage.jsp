<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<c:choose>
	<c:when test="${not empty moduleBbsFormVO }">
		<c:out value="${moduleBbsFormVO.bbsNm }"/>
	</c:when>
	<c:otherwise>
		<spring:message code="wzwg.cmm.msg.MSG107" />
	</c:otherwise>
</c:choose>


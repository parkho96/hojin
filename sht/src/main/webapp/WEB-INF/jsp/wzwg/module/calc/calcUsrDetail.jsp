<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:forEach items="${codeList }" var="list">
	<c:if test="${list.codeNm eq '세금우대' }">	<c:set var="taxPref"><c:out value='${list.codeDc }'/></c:set></c:if>
	<c:if test="${list.codeNm eq '과세' }">		<c:set var="taxNomal"><c:out value='${list.codeDc }'/></c:set></c:if>
	<c:if test="${list.codeNm eq '비과세' }">	<c:set var="taxFree"><c:out value='${list.codeDc }'/></c:set></c:if>
</c:forEach>
<link type="text/css" href="<c:out value='${result.calcCss }'/>" id="calcCssPath" rel="stylesheet" />
<c:set var="temp_calcType"><c:out value="${result.calcType}" /></c:set>
<jsp:include page="${fn:escapeXml(calcType)}.jsp">
	<jsp:param name="result" value="${fn:escapeXml(result)}"/>
    <jsp:param name="taxPref" value="${fn:escapeXml(taxPref)}"/>
    <jsp:param name="taxFree" value="${fn:escapeXml(taxFree)}"/>
    <jsp:param name="taxNomal" value="${fn:escapeXml(taxNomal)}"/>
</jsp:include> 

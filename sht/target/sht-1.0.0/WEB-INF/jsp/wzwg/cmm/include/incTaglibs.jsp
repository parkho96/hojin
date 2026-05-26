<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" 			uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" 			uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" 			uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" 		uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" 		uri="http://www.springframework.org/tags/form" %>
<%-- Spring 6 / Tomcat 10 미지원 taglib 비활성화 (실제 사용처 없음)
<%@ taglib prefix="validator" 	uri="http://www.springmodules.org/tags/commons-validator" %>
--%>
<%@ taglib prefix="ajax" 		uri="http://ajaxtags.sourceforge.net/tags/ajaxtags" %>

<c:set var="nowUrl" value="${requestScope['jakarta.servlet.forward.request_uri']}" scope="request" />

<c:if test="${empty nowUrl}">
<% String getUrl = request.getRequestURL().toString(); %>
<c:set var="nowUrl" value="<%= getUrl %>" scope="request" />
</c:if>

<c:set var="wzwg_siteKey" value="${sessionScope.siteKey}" />
<c:set var="wzwg_contextPath" value="" />
<c:if test="${!empty wzwg_siteKey}">
<c:set var="wzwg_contextPath" value="/${wzwg_siteKey}" />
</c:if>


<c:choose>
	<c:when test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		<c:set var="prefix" value="/sysMngr" scope="request" />
	</c:when>
	<c:otherwise>
		<c:choose>
			<c:when test="${nowUrl.indexOf('/mngr') >-1}">
				<c:set var="prefix" value="/mngr" scope="request" />
			</c:when>
			<c:when test="${nowUrl.indexOf('/subMngr') >-1}">
				<c:set var="subPrefix" value="/subMngr" scope="request" />
			</c:when>
			<c:when test="${nowUrl.indexOf('/subsite') >-1}">
				<c:set var="subPrefix" value="/subsite" scope="request" />
			</c:when>
			<c:otherwise>
				<c:set var="prefix" value="" scope="request" />
			</c:otherwise>
		</c:choose>
	</c:otherwise>
</c:choose>

<% 
	String header = request.getHeader("User-Agent");
	if (header != null && !"".equals(header)){
		header = header.toLowerCase();		
	}
	String mobileAt = "N";
	
	if (header.indexOf("android") > -1 || header.indexOf("iphone") > -1 || header.indexOf("ipad") > -1 || header.indexOf("blackberry") > -1 
			|| header.indexOf("windiws ce") > -1 || header.indexOf("lg") > -1 || header.indexOf("samsung") > -1 || header.indexOf("sony") > -1
			|| header.indexOf("mobile") > -1 || header.indexOf("opera mobi") > -1 || header.indexOf("opera mini") > -1 || header.indexOf("symbian") > -1
			|| header.indexOf("symblanos") > -1 || header.indexOf("nokia") > -1 || header.indexOf("web os") > -1 || header.indexOf("palm") > -1) {
		mobileAt = "Y";
	}		
%>	

<c:set var="mobileAt" value="<%=mobileAt%>" scope="request" />	

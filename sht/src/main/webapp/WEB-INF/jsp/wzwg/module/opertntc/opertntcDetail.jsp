<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%
    pageContext.setAttribute("cn", "\n");
	
	String siteNm = CmmSessionUtil.getSessionSiteNm(request);
	
	if(siteNm != null) {
		siteNm = siteNm.replaceAll("<","&lt;");
		siteNm = siteNm.replaceAll(">","&gt;");
	}else{
		return;
	}

%>
<c:set var="ogUrl" ><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%></c:set>
<!doctype html>
<html lang="ko">
	<head>
		<title>:: <c:out value="${resultVO.opertNm}" /> ::</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta property="og:url" content="<c:out value="${ogUrl }" />">
		<meta property="og:type" content="website">
		<meta property="og:title" content="<%=siteNm %>">
		<meta property="og:description" content="<%=siteNm %> <spring:message code="wzwg.cmm.msg.MSG456" />">
		<meta property="og:image" content="<c:out value="${ogUrl }" /><c:out value="${usrTopLogo}" />">
		
		<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
		<link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
		<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
		<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css">
		<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css">
	</head>
<body>

<div class="serviceBox">
		<div class="serviceTit">
	<div>
				<spring:message code="wzwg.module.word.hmpgsrvc" /><br/>
				<span class="serStop"><spring:message code="wzwg.cmm.word.pause" /></span>
				<spring:message code="wzwg.cmm.word.guidance" />
			</div>
		</div>
		<div class="serviceCo">
				<c:out value='${fn:replace(resultVO.opertCn, cn, "<br />")}' escapeXml="false" />
		</div>
		<dl class="serviceInfo">
			<dt><spring:message code="wzwg.module.word.stpgedt" /></dt>
			<dd>
				<c:out value="${fn:substring(resultVO.opertBgnde, 0, 4)}" /><spring:message code="wzwg.cmm.word.yy" />
				<c:out value="${fn:substring(resultVO.opertBgnde, 5, 7)}" /><spring:message code="wzwg.cmm.word.mt" /> 
				<c:out value="${fn:substring(resultVO.opertBgnde, 8, 10)}" /><spring:message code="wzwg.cmm.word.de" /> 
				<c:out value="${resultVO.beginTime}" /><spring:message code="wzwg.cmm.word.hour" />
				<span>
				~
				<c:out value="${fn:substring(resultVO.opertEndde, 0, 4)}" /><spring:message code="wzwg.cmm.word.yy" />
				<c:out value="${fn:substring(resultVO.opertEndde, 5, 7)}" /><spring:message code="wzwg.cmm.word.mt" />
				<c:out value="${fn:substring(resultVO.opertEndde, 8, 10)}" /><spring:message code="wzwg.cmm.word.de" />
				<c:out value="${resultVO.endTime}" /><spring:message code="wzwg.cmm.word.hour" />
				</span> 
			</dd>
		</dl>
		<div class="siteLogozone">
   		<c:if test="${not empty sessionScope.mngrTopLogo}">
	   			<img src="<c:out value="${mngrTopLogo}" />" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" />
   		</c:if>
	</div>
</div>

</body>
</html>

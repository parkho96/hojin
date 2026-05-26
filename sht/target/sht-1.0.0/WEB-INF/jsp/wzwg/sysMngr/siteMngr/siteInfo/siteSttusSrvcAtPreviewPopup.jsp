<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	pageContext.setAttribute("cn", "\n"); 
%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	
	<title>:: <c:out value="${resultVO.opertNm}" /> ::</title>
	
	<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/main.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/contents.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/style.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/sysMngr/dashboard/form.css" type="text/css" />
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
					<spring:message code="wzwg.sysMngr.word.hmpgSrvc" /><br/>
					<span class="serStop"><spring:message code="wzwg.cmm.word.pause" /></span>
					<spring:message code="wzwg.cmm.word.guidance" />
				</div>
			</div>
			<div class="serviceCo">
					<c:out value='${fn:replace(resultVO.opertCn, cn, "<br />")}' escapeXml="false" />
			</div>
			<dl class="serviceInfo">
				<dt><spring:message code="wzwg.sysMngr.word.stpgeDt" /></dt>
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
				<img src="<c:out value="${mngrTopLogo}" />" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" />
			</div>
		</div>
</body>
</html>

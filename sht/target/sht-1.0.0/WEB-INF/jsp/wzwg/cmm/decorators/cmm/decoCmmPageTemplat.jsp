<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%> 
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<!doctype html>
<html lang="ko">
<head>
	<title><c:out value="${siteNm }"/></title>
    <link rel="shortcut icon" href="<c:out value="${faviconUrl}"/>" type="image/x-icon" />
	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" /> 
	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/swiper.jquery.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/tendina.min.js"></script>
	<!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
    
      gtag('config', 'UA-121105155-1');
    </script>
        
<decorator:head/>
	
</head>
<body>

<decorator:body/> 

</body>
</html>
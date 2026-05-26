<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<title><c:out value="${siteNm }"/></title>
	
   	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->

	<jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/cmm/include/incHead.jsp" />
    <decorator:head></decorator:head>
    
    <!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-121105155-1');
</script>
    
</head>
 <body>  
 
    <div id="wrap">
    
		<jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/cmm/include/incHeader.jsp" />
        <!-- //header_t -->
        
        <div class="header_m">
            <div class="menu">
            </div>
        </div>
        <!-- //header_m -->
    <div id="container">
    
        <div class="lnb">
            <p><b><spring:message code="wzwg.cmm.word.signup" /></b></p>
        </div>
        <!-- //lnb -->
        
        <div class="content">
        <div class="contentpanel">
            <div class="panel panel-default">
                <div class="panel-body">
                
                <decorator:body />
        
                </div>
            </div>
        </div>
        
		<jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/cmm/include/incFooter.jsp" />
        <!-- //footer -->
        
        </div>
        <!-- //content -->
    </div>  
    <!-- //container -->
    </div>
    <!-- //wrap -->
 </body>
</html>

<%@page import="org.springframework.web.util.UrlPathHelper"%>
<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>  
<%-- 로케이션 제목 데이터 인클루드 --%>
<jsp:include page="/sample/template/include/usrSubInc.jsp"></jsp:include>
<c:set var="ogUrl" ><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%></c:set>  
<%
UrlPathHelper up = new UrlPathHelper();
String ogServletPath = up.getOriginatingRequestUri(request);
request.setAttribute("ogServletPath", ogServletPath);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title><%=CmmSessionUtil.getSessionSiteNm(request) %><c:if test="${not empty cntntsInfo.cntntsNm}"> - ${cntntsInfo.cntntsNm}</c:if></title>
	<meta name="description" content="<%=CmmSessionUtil.getSessionSiteNm(request) %><c:if test="${not empty cntntsInfo.cntntsNm}"> - ${cntntsInfo.cntntsNm} 페이지</c:if> 입니다.">
	<meta property="og:url" content="${ogUrl }${ogServletPath }">
	<meta property="og:type" content="website">
	<meta property="og:title" content="<%=CmmSessionUtil.getSessionSiteNm(request) %><c:if test="${not empty cntntsInfo.cntntsNm}"> - ${cntntsInfo.cntntsNm}</c:if>">
	<meta property="og:description" content="<%=CmmSessionUtil.getSessionSiteNm(request) %><c:if test="${not empty cntntsInfo.cntntsNm}"> - ${cntntsInfo.cntntsNm} 페이지</c:if> 입니다.">
	<meta property="og:image" content="${ogUrl }${usrTopLogo}">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<c:choose>
		<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
			<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subsite/${subsiteKey}/subHead.jsp"></c:import>
			<c:import url="/subsite/${subsiteKey}/topMenu.do"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subHead.jsp"></c:import>
			<c:import url="/site/${sessionScope.SITE_SEQ}/topMenu.do"></c:import>
		</c:otherwise>
	</c:choose>
    <decorator:head />
	<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incSubMenuSetting.jsp" %>
    <link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
    <link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />
</head>
<body>

<form name="menuFrm" id="menuFrm" method="post">
<input type="hidden" name="menuSeq" id="menuSeq" value=""/>
<input type="hidden" name="menuNm" id="menuNm" value="${menuNm}"/>
<input type="hidden" name="menuPath" id="menuPath" value="${menuPath }"/>
<input type="hidden" name="menuPathSeq" id="menuPathSeq" value="${menuPathSeq }"/>
<input type="hidden" name="menuDc" id="menuDc" value="${menuDc }"/>
</form>
<!-- middle_contents -->




      

<div class="contents" id="contents" style="margin:0px">  

<div class="inner">

    <div id="sub_visual">
        <img src="/sample/template/basic/basic026/img/mv_03.jpg" alt="" />
        <div class="bluebg">
            <div class="sub_titbox">
                <p></p>
                <strong></strong>
            </div>
        </div>
    </div>

    <div class="sub_div_wrap">
                
        <jsp:include page="/WEB-INF/jsp/wzwg/cmm/decorators/leftMenu/leftMenuUsr.jsp">
        <jsp:param value="${nowUrl}" name="nowUrlNow"/>
        </jsp:include>
        
        <div class="subCon"> 
            <ul class="location" id="menuLocationPath">
                <li class="home"><a href="/">HOME</a></li>
                <li><a href="#"><c:out value="${pageTitle}" /></a></li>
                <li><a href="#"><c:out value="${pageName}" /></a></li>
            </ul>
            <h4 class="tit" id="menuTitle"><c:out value="${pageName}" /></h4>
            <p  id="menuInfo"> </p>

            <div style="margin-top:0px;">
              <decorator:body />
            </div>
        </div>
    </div>


</div><!-- inner 끝 -->
</div>
         
<c:choose>
	<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
	    <c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/subsite/${subsiteKey}/footerMenu.jsp"></c:import>
	</c:when>
	<c:otherwise>
		<c:import url="/WEB-INF/jsp/site/${sessionScope.SITE_SEQ}/footerMenu.jsp"></c:import>
	</c:otherwise>
</c:choose>
</body>
</html>

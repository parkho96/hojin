<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="ogUrl" ><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%></c:set>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<%  
	response.setHeader("Pragma","no-cache");   
	response.setHeader("Cache-Control","no-cache");  
	response.addHeader("Cache-Control","no-store");   
	response.setDateHeader("Expires",0);   
%>  
	
<!doctype html>
<html lang="ko">
 <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta property="og:url" content="<c:out value="${ogUrl }"/>">
  <meta property="og:type" content="website">
  <meta property="og:title" content="<c:out value="siteNm"/>">
  <meta property="og:description" content="<c:out value="siteNm"/> <spring:message code="wzwg.site.cmm.msg.MSG001"/>">
  <meta property="og:image" content="<c:out value="${ogUrl }"/><c:out value="${usrTopLogo}"/>">
  
  <title><spring:message code="wzwg.site.cmm.msg.MSG002" /></title>
  <link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
  <link type="text/css" href="/css/wzwg/cmm/work/style.css" rel="stylesheet" />
  <link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />

 </head>

 <body>

	<div class="wrap">
		<div class="header">
			<div class="inner">
				<ul class="gnb1">
					<li><a href="#">HOME</a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.word.sitemap" /></a></li>
				</ul>
				<ul class="gnb">
					<li><a href="#"><spring:message code="wzwg.cmm.word.login" /></a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.word.signup" /></a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.word.gohm" /></a></li>
				</ul>		
			</div>
		</div>
		<div class="menu"></div>
		<div class="contents">	  

			<!-- -->
			<!-- -->
			<div class="inner">
				<div id="template00">

				<div class="renewal01">
					<div class="renew_img">
						<img src="/images/wzwg/cmm/work/renewal.png" alt="" class="jump"><br>
					</div><img src="/images/wzwg/cmm/work/shadow.png" alt="" class="shadow">

					<h1><spring:message code="wzwg.site.cmm.msg.MSG003" /></h1>
					<p><spring:message code="wzwg.cmm.msg.MSG315" /></p>

				</div>




				</div> <!--template00 끝. -->
			</div><!-- inner 끝 -->
		</div>
		<div class="footer">
			 <div class="footer-list-001">
			   <div class="footer-center-001 inner">
				<ul>
					<li><a href="#"><spring:message code="wzwg.cmm.cntnts.hmpgtermuse" /></a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.cntnts.psnlinfoprcspolicy" /></a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.cntnts.psnlvidinfohandlpolicy" /></a></li>
					<li><a href="#"><spring:message code="wzwg.cmm.cntnts.directions" /></a></li>
				</ul>
			   </div>
			</div> 
			 <div class="footer-area-001">
				<div class="addressArea">
					<div class="inner">
						<h2 class="footerLogo">
							<img src="<c:out value="${ftrMenuInfo.logoFImagePath }"/>" alt="" />
						</h2>
						<div class="p_wrap">
							<p><c:out value="${ftrMenuInfo.cpyrhtCn}"/></p>
							<p><c:out value="${ftrMenuInfo.adres}"/></p>
						</div>
					</div>
				</div>
			 </div>
	</div>


	</div>

 </body>
</html>

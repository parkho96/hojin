<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<!doctype html >
<html lang="ko">
<head>

	<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHead.jsp" />
	 
</head>
 <body>  
 
 
	<div id="wrap">
		<div id="container">
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrHeader.jsp" />
                <jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrLeft.jsp" />
          <div id="contents">
				<div id="main">
					<div class="content-wrapper">
					 <c:set var="locationNm" />
		            <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteInfo/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.bassinfomanage"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteStplat/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.bassinfomanage"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/sysSiteStplat/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.sysStplatPolicy"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteGroup/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.groupmanage"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/siteOpert/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.opertmanage"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/bbsDataMngr/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.dataarng"/></c:set></c:if>
					<c:if test="${fn:indexOf(nowUrl, '/siteMngr/bbsDataBckpRcvr/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.backuprecovry"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/menuEstbs/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.menuestbsmanage"/></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/menu/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.sitemngrmenumanage" /></c:set></c:if>
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/snsKeyMngr/') > -1}"><c:set var="locationNm">SNS KEY</c:set></c:if>	
                    <c:if test="${fn:indexOf(nowUrl, '/siteMngr/trans/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.bassinfomanage"/></c:set></c:if>
						<div class="location-001">
							<ul>
								<li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>
				                <li><spring:message code="wzwg.cmm.cntnts.sitemanage" /></li>
				                <li><c:out value="${locationNm}" /></li>
							</ul>
						</div>
						<h2><c:out value="${locationNm}" /></h2>
        <!-- //header_m -->
                <decorator:body />
        <!-- //contentpanel -->
        	</div>
				</div>				
			</div>	
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrFooter.jsp" />
        <!-- //footer -->
        
		</div>
	</div>
    <!-- //wrap -->
 </body>
</html>

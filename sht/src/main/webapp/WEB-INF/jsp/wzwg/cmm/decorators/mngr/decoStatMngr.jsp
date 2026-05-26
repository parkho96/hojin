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
			            <c:if test="${fn:indexOf(nowUrl, '/stat/selectVisitStat.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.visitrsttus"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/stat/selectUsrStat.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.signupsttus"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/stat/selectBbsStat.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.nttregiststtus"/></c:set></c:if> 
			            <c:if test="${fn:indexOf(nowUrl, '/stat/selectCmntStat.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.cmmntyconnectsttus"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/stat/selectMenuStat.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.menuusesttus"/></c:set></c:if>
						<div class="location-001">
							<ul>
								<li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>
				                <li><spring:message code="wzwg.cmm.cntnts.statsmanage" /></li>
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

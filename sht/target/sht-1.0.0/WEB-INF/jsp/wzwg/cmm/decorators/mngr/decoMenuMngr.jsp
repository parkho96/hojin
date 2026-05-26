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
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuMngrList.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.menumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteHdMenuMngrList.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.upendmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1 and param.hdftrCode eq 'SC00000081'}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.upendmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000081'}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.upendmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteFtrMenuMngrList.do') > -1 }"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.lptmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuRegistFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.lptmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuModifyFrmMngr.do') > -1  and param.hdftrCode eq 'SC00000082'}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.lptmenumanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/menu/linkGrp/') > -1}"><c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.menucomposition"/></c:set><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.linkgroup"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/module/sideQuick/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.menu.sideQuickMenu" /></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/mngr/menu/selectSiteMenuByUsrGroup.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.mbergrpmnupmis" /></c:set></c:if>
						<div class="location-001">
							<ul>
								 <li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>
								 <li><spring:message code="wzwg.cmm.cntnts.menumanage"/></li>
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

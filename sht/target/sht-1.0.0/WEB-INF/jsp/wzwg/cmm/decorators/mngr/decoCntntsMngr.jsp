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
					 	<c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.subpage"/></c:set>
			            <c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/') > -1 && sessionScope.SYSMNGR_AT eq 'Y'}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.cntntsmanage"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/selectCntntsInfoList.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.crtmod"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/selectCntntsInfoDashboard.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.subpage"/> <spring:message code="wzwg.cmm.cntnts.dashboard"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/unity/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.word.gnrl" /> <spring:message code="wzwg.cmm.word.bbs" /></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/image/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.bbs" /></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/qna/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.qnabbs"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/simp/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.simpbbs"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/schdul/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.schdul"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/cntnts/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.cntnts"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/popup/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.popupmanage"/></c:set> <c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/banner/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.bannermanage"/></c:set> <c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
                        <c:if test="${fn:indexOf(nowUrl, '/mngr/inqryDtls/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.questhist"/></c:set>  <c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/sysMngr/usrMngr/usrTy/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.vote"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/bbsForm/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.nttform"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/cntntsMngr/cntntnsTmplat/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.cntntstemplate"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/onlineReqst/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.onlinereqst"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/onlineQustnr/') > -1}">
                        <c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.onlinequstnr"/></c:set>
                        </c:if> 
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/mvp/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.mvpbbs"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/map/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.mapcntnts"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/calc/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.cal"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/upload/fileMngr/fileEstbs/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.atchfilemanage"/></c:set> <c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/upload/fileEstbs/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.atchfilemanage"/></c:set></c:if>
                        <c:if test="${fn:indexOf(nowUrl, '/menu/linkGrp/') > -1}"><c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.menucomposition"/></c:set><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.linkgroup"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/custom/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.custombbs"/></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/bbs/cl/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.word.tab" /> <spring:message code="wzwg.cmm.word.cntnts" /></c:set></c:if>
			             <c:if test="${fn:indexOf(nowUrl, '/sysMngr/usrLog/selectSiteUsrLogList.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.menu.usrlogmanage" /></c:set><c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			             <c:if test="${fn:indexOf(nowUrl, '/sysMngr/usrLog/selectSiteMngrLoginLogList.do') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.menu.mngrconectlogmanage" /></c:set><c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			             <c:if test="${fn:indexOf(nowUrl, '/module/upload/usr/file/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.filestore" /></c:set><c:set var="locationSub"><spring:message code="wzwg.cmm.cntnts.oprtrmanage"/></c:set></c:if>
			            
			            <c:if test="${fn:indexOf(nowUrl, '/module/orgnztInfo/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.organizationchartmanage" /></c:set></c:if>
			            <c:if test="${fn:indexOf(nowUrl, '/module/tabMenu/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.word.tab" /> <spring:message code="wzwg.cmm.word.menu" /></c:set></c:if>
			            
						<div class="location-001">
							<ul>
								<li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>
				                <li><c:out value="${locationSub}" /></li>
                                <c:if test="${!empty locationNm}">
				                <li><c:out value="${locationNm}" /></li>
                                </c:if>
							</ul>
						</div>
						
						<h2>
                            <c:choose>
                            <c:when test="${!empty locationNm}">
                            <c:out value="${locationNm}" />
                            </c:when>
                            <c:otherwise>
                            <c:out value="${locationSub}" />
                            </c:otherwise>
                            </c:choose>
                        </h2>
        
                		<decorator:body />

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

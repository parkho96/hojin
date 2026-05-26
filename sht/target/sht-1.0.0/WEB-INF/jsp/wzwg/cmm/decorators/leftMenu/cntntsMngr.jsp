<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>

                <li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/cntnts/cntntsInfo/selectCntntsInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/cntnts/cntntsInfo/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.cntntsmanage" /></a></li>
                <c:forEach var="result" items="${decoLeftMenu}" varStatus="status">
		            
		            <c:if test="${result.childNo eq 1}">
		            <li><a href="<c:out value="${wzwg_contextPath}${prefix}/${result.mngrPageUrl}" />?cntntsSeq=<c:out value="${result.cntntsSeq}" />&sitecntntsSeq=<c:out value="${result.sitecntntsSeq}" />" class="side-submenu <c:if test="${fn:indexOf(nowUrl, result.pckagePath) > -1}">on</c:if>"><c:out value="${result.moduleNm}" /></a></li>
		            </c:if>
		             
	            </c:forEach>
<%--                 <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                	<li><a href="${prefix}/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/cntntsMngr/cntntnsTmplat/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.cntntstemplate" /></a></li>
                </c:if> --%>
	            <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                	<li><a href="<c:out value="${wzwg_contextPath}${prefix}" />/module/bbs/bbsForm/selectModuleBbsFormList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/bbs/bbsForm/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.nttform" /></a></li>
                	<li><a href="<c:out value="${wzwg_contextPath}" />/mngr/module/onlineQustnr/selectOnlineQustnrInfoList.do" class="side-submenu <c:if test="${fn:indexOf(nowUrl, '/module/onlineQustnr/') > -1}">on</c:if>"><spring:message code="wzwg.cmm.cntnts.onlinequstnr" /></a></li>
                </c:if>

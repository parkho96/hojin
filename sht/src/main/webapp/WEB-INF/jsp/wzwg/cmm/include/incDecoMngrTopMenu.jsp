<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

            <ul>
                <li class="menu1"><a href="<c:out value="${wzwg_contextPath}${prefix}" />/selectDashboardMain.do"><span><spring:message code="wzwg.cmm.cntnts.dashboard" /></span></a></li>
                <li class="menu2"><a href="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do"><span><spring:message code="wzwg.cmm.cntnts.sitemanage" /></span></a></li>
                <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                <li class="menu3"><a href="<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/selectUsrInfoList.do"><span><spring:message code="wzwg.cmm.cntnts.mbermanage" /></span></a></li>
                <li class="menu6"><a href=""><span><spring:message code="wzwg.cmm.cntnts.templatemanage" /></span></a></li>
                <li class="menu6"><a href=""><span><spring:message code="wzwg.cmm.cntnts.oprtrmanage" /></span></a></li>
                <li class="menu6"><a href=""><span><spring:message code="wzwg.cmm.cntnts.statsmanage" /></span></a></li>
                <li class="menu6"><a href=""><span><spring:message code="wzwg.cmm.cntnts.opnsu" /></span></a></li>
                <li class="menu6"><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do"><span><spring:message code="wzwg.cmm.cntnts.modulemanage" /></span></a></li>
                <li class="menu6"><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000001"><span><spring:message code="wzwg.cmm.cntnts.opnsu" /></span></a></li>
                </c:if>
                <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
                <li class="menu3"><a href="<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/siteSbscrb/selectSbscrbInfoForm.do"><span><spring:message code="wzwg.cmm.cntnts.mbermanage" /></span></a></li>
                <li class="menu6"><a href="<c:out value="${wzwg_contextPath}${prefix}" />/cntnts/cntntsInfo/selectCntntsInfoList.do"><span><spring:message code="wzwg.cmm.cntnts.cntntsmanage" /></span></a></li>
                <li class="menu4"><a href="<c:out value="${wzwg_contextPath}${prefix}" />/menu/selectSiteMenuMngrList.do"><span><spring:message code="wzwg.cmm.cntnts.menumanage" /></span></a></li>
                <li class="menu2"><a href="<c:out value="${wzwg_contextPath}" />/mngr/screen/selectSiteScreenTempltList.do" target="_blank"><span><spring:message code="wzwg.cmm.cntnts.screenmanage" /></span></a></li>
                <li class="menu6"><a href="<c:out value="${wzwg_contextPath}" />/mngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000001"><span><spring:message code="wzwg.cmm.cntnts.opnsu" /></span></a></li>
                </c:if>
            </ul>
            
            
            

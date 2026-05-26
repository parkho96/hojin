<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

        <div class="header_t">
            <div class="fl">
                <h1>
                <a href="<c:out value="${wzwg_contextPath}" />/mngr/selectDashboardMain.do"><img src="/images/dggb/mngr/common/logo.jpg" alt="<spring:message code="wzwg.cmm.word.sysmngr" />" /></a>
                <span><spring:message code="wzwg.cmm.word.super" text="super" /> <spring:message code="wzwg.cmm.word.mngr" /></span>
                </h1>
            </div>
            <div class="top_btns">
                <span class="btn btn_logout btn_lg"><a href="/cmm/mber/login/actionMngrLogout.do"><spring:message code="wzwg.cmm.word.logout" /></a></span>
                <span class="btn btn_made btn_lg" onclick="openHomepage();"><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.hmpg" /> &gt; </a></span>
            </div>
        </div>
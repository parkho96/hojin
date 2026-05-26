<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
function fnTabLink(num) {
	
	var tabUrl = ["<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoForm.do"
	              , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteAdiInfoForm.do"
	              , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteDomnList.do"
	              , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteSttusForm.do"
	              , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/info/selectStplatInfoList.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/info/selectEssntlStplatInfoList.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteStplat/log/selectStplatLogList.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectMngrInfoList.do"
                  ,	"<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteFileProvdForm.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/trans/registSysMngrTrans.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteModuleInfoForm.do"
                  , "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteTemplateInfoForm.do"];
	
	var frm = document.frmTab;
	
	frm.action = tabUrl[num];
	frm.submit();
}
</script>
 
    <form id="frmTab" name="frmTab" method="post">
        <input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
    </form>
    
<%--     <h3 class="table_tit" style="padding-bottom:10px;">${paramVO.siteFullNm}</h3> --%>
    <div class="wztab underLine theme-blue">
	    <div class="wztab-list">
	        <a href="#" onclick="fnTabLink(0);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'SiteInfo') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.detailinfo" /></a>
	        <a href="#" onclick="fnTabLink(1);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'SiteAdiInfo') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.adiinfo" /></a>
	         <c:if test="${paramVO.siteSeq ne '10000000001'}">  
	        <a href="#" onclick="fnTabLink(2);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'SiteDomn') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.domnmanage" /></a>
	        <a href="#" onclick="fnTabLink(3);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'SiteSttus') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.sttusmanage" /></a>
	        <a href="#" onclick="fnTabLink(4);" class="wztab-item <c:if test="${(fn:indexOf(nowUrl, 'StplatInfo') > -1) && fn:indexOf(nowUrl, 'EssntlStplat') < 0}">active</c:if>"><spring:message code="wzwg.cmm.menu.stplatmanage" /></a>
	        </c:if>
	        <%-- <a href="#" onclick="fnTabLink(5);" class="tab <c:if test="${fn:indexOf(nowUrl, 'EssntlStplat') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.rqrtrmmanage" /></a> --%>
	        <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
	              <a href="#" onclick="fnTabLink(7);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'MngrInfo') > -1}">active</c:if>"><c:if test="${paramVO.siteSeq ne '10000000001'}">  <spring:message code="wzwg.cmm.word.site" /></c:if><c:if test="${paramVO.siteSeq eq '10000000001'}"> <spring:message code="wzwg.cmm.word.system" /> </c:if> <spring:message code="wzwg.sysMngr.word.mngrMng" /></a>
	        <c:if test="${paramVO.siteSeq ne '10000000001'}">
	        <a href="#" onclick="fnTabLink(8);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'SiteFileProvd') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.fileprovdmg" /></a>
	        </c:if>
	        </c:if>
	<%--        <a href="#" onclick="fnTabLink(6);" class="tab <c:if test="${fn:indexOf(nowUrl, 'StplatLog') > -1}">active</c:if>"><spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.cmm.word.hist" /> <spring:message code="wzwg.cmm.word.manage" /></a> --%>
			<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
			  <c:if test="${paramVO.siteSeq ne '10000000001'}">
			 	<a href="#" onclick="fnTabLink(9);" class="wztab-item <c:if test="${(fn:indexOf(nowUrl, 'Trans') > -1)}">active</c:if>"><spring:message code="wzwg.cmm.menu.datatrnsfer" /></a>
			 	<a href="#" onclick="fnTabLink(10);" class="wztab-item <c:if test="${(fn:indexOf(nowUrl, 'SiteModule') > -1)}">active</c:if>"><spring:message code="wzwg.cmm.menu.moduleauthormanage" /></a>
			 	<a href="#" onclick="fnTabLink(11);" class="wztab-item <c:if test="${(fn:indexOf(nowUrl, 'SiteTemplate') > -1)}">active</c:if>"><spring:message code="wzwg.cmm.menu.templtauthormanage" /></a>
			  </c:if>
			 </c:if>
	    </div>
    </div>
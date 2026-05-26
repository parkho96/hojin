<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
function fnTabLink(num) {
	
	var tabUrl = ["<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrTyCode/selectUsrTyCodeForm.do"
	              , "<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrTyCode/selectUsrTySbscrbFormList.do"];
	
	var frm = document.frmTab;
	
	frm.action = tabUrl[num];
	frm.submit();
}
</script>
 
    <form id="frmTab" name="frmTab" method="post">
        <input type="hidden" id="code" name="code" value="<c:out value="${resultVO.code}" />" />
    </form>
    
    <div class="wztab underLine theme-blue">
	    <div class="wztab-list">
	        <a href="#" onclick="fnTabLink(0);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'UsrTyCode') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.bassinfo" /></a>
	        <a href="#" onclick="fnTabLink(1);" class="wztab-item <c:if test="${fn:indexOf(nowUrl, 'UsrTySbscrbForm') > -1}">active</c:if>"><spring:message code="wzwg.cmm.menu.signupform" /></a>
	    </div>
    </div>
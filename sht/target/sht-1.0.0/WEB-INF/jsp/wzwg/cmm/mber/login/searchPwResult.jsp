<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 
<script type="text/javascript">
	$(document).ready(function(){

	    $(".cancelBtn").click(function(){
	        var frm = document.pwForm;
	        frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
	        frm.submit();
	    }); 
	    
	    $(".nextBtn").click(function(){
	        var frm = document.pwForm;
	        frm.action = "<c:out value="${wzwg_contextPath}" />/loginForm.do";
	        frm.submit();
	    });
	    
	});
</script>

    <form id="pwForm" name="pwForm" method="post">
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.passwordchange" /></h4>
    <div class="sbscrbWrap">
	    <div class="sbscrbBox">
	        <ul class="sbscrbIdsac">
	            <c:choose>
	            <c:when test="${empty resultCnt}">
	            <li style="width:100%;text-align:center;"><spring:message code="wzwg.cmm.msg.MSG078" /></li>
	            </c:when>
	            <c:otherwise>
	            <li style="width:100%;text-align:center;"><spring:message code="wzwg.cmm.msg.MSG079" /> <spring:message code="wzwg.cmm.msg.MSG074" /></li>
	            </c:otherwise>
	            </c:choose>
	        </ul>
	    </div>
	    
	    <div class="sbscrbBtnbox">
	        <div class="sbscrbBtnwidth">
	            <a href="#" class="cancelBtn"><spring:message code="wzwg.cmm.word.main" /></a>
	            <a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.login" /></a>
	        </div>
	    </div>
    </div>
    </form>
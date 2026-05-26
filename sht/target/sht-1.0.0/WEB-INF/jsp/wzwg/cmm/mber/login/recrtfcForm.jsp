<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>
<script type="text/javascript">
$(document).ready(function(){

    <c:if test="${!empty retMsg}">    
    alert('<spring:message code="${retMsg}" />');
    if ('<c:out value="${retMsg}"/>"'.indexOf('success') > -1) {
        document.stplatFrm.action = '<c:out value="${wzwg_contextPath}" />/loginForm.do';
        document.stplatFrm.submit();
    }
    </c:if>
    fnCrtfcModuleSetting('recrtfc');
});

</script>
</head>
<body>
     
    <form:form modelAttribute="paramVO" id="stplatFrm" name="stplatFrm" method="post" onsubmit="return false">
    <form:hidden path="userId" />
    <form:hidden path="crtfctSeCode" />    
    <input type="hidden" name="crtfctDn" id="crtfctDn" />
    
    <div class="sbscrbWrap">
    
		<h4 class="fs40 fw400 txt-c mb50"><spring:message code="wzwg.cmm.word.mberinfocrtfc" /></h4>
		<div class="sbscrbText fs17 fw400 linehgt140 txt-c mb50">
            <span><spring:message code="wzwg.cmm.msg.MSG012" /> <spring:message code="wzwg.cmm.msg.MSG071" /></span>
		</div>
		
        <table class="sbscrbTable basic" style="border-top:2px solid #000;">
            <colgroup>
                <col width="25%">
                <col width="*">
            </colgroup>
            <tr>
                <th><spring:message code="wzwg.cmm.word.id02" /></th>
                <td><c:out value="${paramVO.userId}" /></td>
            </tr>
            <tr>
                <th><spring:message code="wzwg.cmm.word.password" /></th>
                <td><input type="password" name="password" id="password" maxlength="20" autocomplete="off" /></td>
            </tr>
        </table>
        
		<div class="sbscrbBtnbox">
			<div class="sbscrbBtnwidth">
			    <a href="#" class="nextBtn" id="crtfc_btn" onclick="fnCrtfc('<c:out value="${crtfcSeCode}" />');"><spring:message code="wzwg.cmm.word.next" /></a>
			</div>
		</div>
         
    </div>
    </form:form>
   
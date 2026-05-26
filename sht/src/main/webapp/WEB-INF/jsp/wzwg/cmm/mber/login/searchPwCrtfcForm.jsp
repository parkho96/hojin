<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/mber/sbscrb.js" ></script>
<script type="text/javascript">
$(document).ready(function(){

    fnCrtfcModuleSetting('recrtfc');
});

function fnModify() {

    var frm = document.stplatFrm;
    
    if(frm.password.value == "") {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
        return;
    }
    
    if(frm.password.value != "") {
        if(!fn_checkPassword(frm.userId, frm.password, frm.passwordCnfirm)){
            return;
        }
    }
    
    frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/search/modifyPwForm.do';
    frm.submit();
}
</script>
</head>
<body>
     
    <form:form modelAttribute="paramVO" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="userId" />
    <form:hidden path="usrSeq" />
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.passwordchange" /></h4>
    <div class="sbscrbWrap">
    	
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
				<td><form:password path="password" maxlength="20" /><span class="sbscrbPwspan"><spring:message code="wzwg.cmm.msg.MSG052" /></span></td>
			</tr>                
			<tr>
				<th><spring:message code="wzwg.cmm.word.passwordcnfirm" /></th>
			    <td><input type="password" name="passwordCnfirm" id="passwordCnfirm" maxlength="20" autocomplete="off" /><a class="id_select_bt" href="javascript:void(0);"></td>
		    </tr>
		</table>
		
		<div class="sbscrbBtnbox">
		    <div class="sbscrbBtnwidth">
		        <a href="#" class="nextBtn" id="crtfc_btn" onclick="fnModify();"><spring:message code="wzwg.cmm.word.next" /></a>
		   </div>
		</div>

    </div>    
    </form:form>

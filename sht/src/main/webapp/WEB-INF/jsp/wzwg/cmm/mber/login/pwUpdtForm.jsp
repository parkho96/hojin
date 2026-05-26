<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/mber/sbscrb.js" ></script>
 
<script type="text/javascript">

function modifyPwUpdt() {

    if(document.loginForm.password.value != "") {
        if(!fn_checkPassword(document.loginForm.userId, document.loginForm.password, document.loginForm.passwordCnfirm)){
            return;
        }
    }
    
    $.ajax({
        type:'POST'
        , url: '<c:out value="${wzwg_contextPath}" />/modifyPwUpdt.do'
        , dataType: 'xml'
        , data:$("#loginForm").serialize()
        , success:function (result) {
          
            var value = "";
            
            $(result).find("value").each(function() {  
                value = $(this).text();  
            });
            
            var frm = document.loginForm;
            
            if(value == 'success'){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
                frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
                frm.submit();
            } else {
            	alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
            }
        }
        , error:function (request, status, error) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });    	
}

function modifyPwUpdtDe() {
    
    $.ajax({
        type:'POST'
        , url: '<c:out value="${wzwg_contextPath}" />/modifyPwUpdtDe.do'
        , dataType: 'xml'
        , data:$("#loginForm").serialize()
        , success:function (result) {
          
            var value = "";
            
            $(result).find("value").each(function() {  
                value = $(this).text();  
            });
            
            var frm = document.loginForm;
            
            if(value == 'success'){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
                frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
                frm.submit();
            } else {
                alert('<spring:message code="wzwg.cmm.msg.MSG076" />');
            }
          
        }
        , error:function (request, status, error) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });     
}

function fnKeypress() {
    if(event.keyCode == 13){
        modifyPwUpdt();
    }
}
</script>
     
    <form:form modelAttribute="paramVO" path="loginForm" id="loginForm" name="loginForm" method="post">
    <form:hidden path="siteSeq" />
    <form:hidden path="userId" />
    <form:hidden path="usrSeq" />
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.findp" /></h4>
    
	<div class="sbscrbBox searchPw">
	    <div class="sbscrbLoginbox bg_btm">
	    
	    	<div class="textBox">
				<table class="sbscrbTable">
	                <colgroup>
	                    <col width="25%">
	                    <col width="*">
	                </colgroup>
	                <tr>
		                <th><spring:message code="wzwg.cmm.word.password" /></th>
		                <td><form:password path="password" maxlength="20" /></td>
	                </tr> 
	            </table>
	            <p class="txt mt50 fs18"><spring:message code="wzwg.cmm.msg.MSG052" /></p>
            </div>
            
            <div class="textBox">
				<table class="sbscrbTable">
	                <colgroup>
	                    <col width="25%">
	                    <col width="*">
	                </colgroup>             
	                <tr>
		                <th><spring:message code="wzwg.cmm.word.passwordcnfirm" /></th>
		                <td><input type="password" name="passwordCnfirm" id="passwordCnfirm" maxlength="20" onkeypress="fnKeypress();" autocomplete="off" /><a class="id_select_bt" href="javascript:void(0);"></td>
	                </tr>
	            </table>
            </div>
	            
	    </div>
	    
	    
	    <div class="sbscrbBtnbox">
			<div class="sbscrbBtnwidth">
				<a href="#" class="nextBtn wzbtn-lg btn-black-bg" onclick="modifyPwUpdt();"><spring:message code="wzwg.cmm.word.change" /></a>
				<a href="<c:out value="${wzwg_contextPath}" />/index.do" class="cancelBtn wzbtn-lg btn-basic"><spring:message code="wzwg.cmm.msg.MSG038" /></a>
				<a href="#" class="cancelBtn wzbtn-lg btn-basic" onclick="modifyPwUpdtDe();"><spring:message code="wzwg.cmm.msg.MSG029" /></a>
			</div>
		</div>
	</div>
	
    </form:form>
    
    

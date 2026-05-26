<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:import url="/WEB-INF/jsp/site/10000000100/subHead.jsp"></c:import> 
<script type="text/javascript">

$(document).ready(function() {
    $('.location_1_depth').append('<spring:message code="wzwg.cmm.word.login" />');
    $('.sub_navigation h2').append('<spring:message code="wzwg.cmm.word.login" />');
    $('.subCntntsTitle').append('<spring:message code="wzwg.cmm.word.login" />');
});

function actionLogin() { 
    if (document.loginForm.userId.value =="") {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
    } else if (document.loginForm.password.value =="") {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
    } else {
        document.loginForm.action="<c:out value='${wzwg_contextPath}'/>/actionLogin.do";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.loginForm.submit();
    }
}
</script>

                            <div class="member_login_container">
                                <div class="member_login_box">
                    
                                    <form name="loginForm" id="loginForm" autocomplete="off" method="post" onSubmit="return false;">
                                    <fieldset class="member_loginForm">
                                        <legend><spring:message code="wzwg.cmm.word.login" /></legend>
                                        <div class="items">
                                            <div class="item">
                                                <label for="UserId"></label>
                                                <input type="text" id="userId" name="userId" class="i_text" value="" />
                                            </div>
                                            <div class="item">
                                                <label for="Password"></label>
                                                <input type="password" id="password" name="password" class="i_text" value="" />
                                            </div>
                                        </div>
                                        <button class="member_join" onclick="javascript:actionLogin();"><spring:message code="wzwg.cmm.word.login" /></button>
                                    </fieldset>
                                    </form>
                                    <div class="member">
                                        <ul>
                                            <li><a href="#"><spring:message code="wzwg.cmm.word.signup" /></a></li>
                                            <li><a href="#"><spring:message code="wzwg.cmm.word.id02" /> <spring:message code="wzwg.cmm.word.search02" /></a></li>
                                            <li><a href="#"><spring:message code="wzwg.cmm.word.password" /> <spring:message code="wzwg.cmm.word.search02" /></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
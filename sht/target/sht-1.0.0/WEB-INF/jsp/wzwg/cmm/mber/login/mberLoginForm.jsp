<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<head>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery.cookie.js"></script>
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.login" />';}catch(e){console.log(e.message);}
$(document).ready(function(){
    
    <c:if test="${!empty message}">
    alert('<spring:message code="${message}" />');
    </c:if>
    
    $('#sbscrb_btn').click(function(){
        document.loginForm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
        document.loginForm.submit();
    });
    
    $('#cancle_btn').click(function(){
        document.loginForm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/login/mngrLoginForm.do";
        document.loginForm.submit();
    });
    
    fnCrtfcModuleSetting('login');
    
    var saveId = $.cookie('usrSaveId');
    var saveIdElement = $("#id_save");
    
    if(saveId != null && saveId != ""){ 
		$('#userId').val(saveId);
		$('#password').focus();
		saveIdElement.attr("checked", true);
	}
	else{
		$('#userId').focus();
	}
    
    saveIdElement.bind("click", function(){
    	if($(this).is(":checked")){
    		if(!cookieEnabled()){
    			alert('<spring:message code="wzwg.cmm.msg.MSG166" />');
    			$(this).attr("checked", false);
    		}
    	}
    });
    
    
});

function fnKeypress() {
	if(event.keyCode == 13){
		actionLogin();
	}
}

function actionLogin() {
    if (document.loginForm.userId.value =="") {
        $("#userId").focus();
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.id02" /></spring:argument></spring:message>');
    } else if (document.loginForm.password.value =="") {
        $("#password").focus();
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG015"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument></spring:message>');
    } else {
    	if($("#id_save").is(":checked")){
    		$.cookie("usrSaveId", document.loginForm.userId.value);
    	}
        $.ajax({
            type:'POST'
            , url: '<c:out value="${wzwg_contextPath}" />/actionLogin.do'
            , dataType:'html'
            , data:$("#loginForm").serialize()
            , success:function (result) {
                fnLoginCallback(result);
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });   
    }
}


function actionSnsLogin() {
 
        $.ajax({
            type:'POST'
            , url: '<c:out value="${wzwg_contextPath}" />/actionSnsLogin.do'
            , dataType:'html'
            , data:$("#stplatFrm").serialize()
            , success:function (result) {
                fnLoginCallback(result);
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });   
}

function fnSearchId() {
	var frm = document.loginForm;
	frm.action = "<c:out value="${wzwg_contextPath}" />/searchIdForm.do";
	frm.submit();
}

function fnSearchPw() {
	var frm = document.loginForm;
	frm.action = "<c:out value="${wzwg_contextPath}" />/searchPwForm.do";
	frm.submit();
}

function cookieEnabled(){
	var cookieEnabled;
	
	if (document.all){
		cookieEnabled = navigator.cookieEnabled;
	}
	else {
		var cookieName = "testCookie" + (new Date().getTime());
		
		document.cookie = cookieName + "=cookieValue";
		cookieEnabled = document.cookie.indexOf(cookieName) != -1;
	}
	
	return  cookieEnabled;
}

</script>

</head>
<body>

	<h4 class="tit mb0"><spring:message code="wzwg.cmm.word.login" /></h4>
	<!-- sbscrbBox start -->
    <div class="sbscrbBox">
        <!--  
        <div class="sbscrbTopbox">
            <ul class="sbscrbTxtbox">
            <c:choose>
  				<c:when test="${fn:indexOf(nowUrl, '/adLoginForm.do') > -1}">
                <li><spring:message code="wzwg.cmm.msg.MSG423" /></li>
                <li><spring:message code="wzwg.cmm.msg.MSG424" /></li>
  				</c:when>
  				<c:otherwise>
                <li><spring:message code="wzwg.cmm.msg.MSG070" /></li>
                <li><spring:message code="wzwg.cmm.msg.MSG069" /></li>
  				</c:otherwise>
  			</c:choose>
            </ul>
        </div>
        -->
        
        <div class="sbscrbLoginbox">
        
        	<div class="textBox">
        		<spring:message code="wzwg.cmm.msg.MSG069" />
        	</div>
        	
        	<!-- login start --> 
            <div class="loginWrap">             
            	<div class="loginLine">
                    <div class="loginBox">  
                     
	                    <form id="stplatFrm" name="stplatFrm" method="post">
		                    <input type="hidden" id="crtfctSeCode" name="crtfctSeCode" />
		                    <input type="hidden" id="crtfctDn" name="crtfctDn" />
	                    </form>
	                     
	                    <form id="loginForm" name="loginForm" method="post">
		                    <input type="hidden" id="crtfctSeCode" name="crtfctSeCode" />
		                    <input type="hidden" id="crtfctDn" name="crtfctDn" />
		                    
	                        <div class="inputLabel">
	                            <input type="text" class="loginId" placeholder="<spring:message code="wzwg.cmm.word.id02" />" id="userId" name="userId" onkeypress="fnKeypress();" title="<spring:message code="wzwg.cmm.word.idinput" />" />
	                        </div>
	                        <div class="inputLabel">
	                            <input type="password" class="loginPw" placeholder="<spring:message code="wzwg.cmm.word.password" />" id="password" name="password" onkeypress="fnKeypress();" title="<spring:message code="wzwg.cmm.word.passwordinput" />" autocomplete="off" />
	                        </div>
	                        <span class="idSaveBox">
	                            <input type="checkbox" id="id_save"/>
	                            <label for="id_save"><span class="idSave"><spring:message code="wzwg.cmm.word.saveid" /></span></label>
	                        </span>
	                        <a href="javascript:void(0);" class="loginBt" onclick="actionLogin();"><spring:message code="wzwg.cmm.word.login" /></a>
	                 	</form>
                     
                     </div>
                </div>
				<div class="BtnBox">
					<c:if test="${fn:indexOf(nowUrl, '/adLoginForm.do') eq -1}">
					<div class="memJoin">
						<p class="txt">
							<spring:message code="wzwg.cmm.msg.MSG063" /><br>
							<spring:message code="wzwg.cmm.msg.MSG045" />
						</p>
						<a href="javascript:void(0);" id="sbscrb_btn"><spring:message code="wzwg.cmm.word.signup" /></a>
					</div>
					<div class="memSearch">
						<p class="txt">
							<spring:message code="wzwg.cmm.msg.MSG391" />
						</p>
					    <a href="javascript:void(0);" onclick="fnSearchId();"><spring:message code="wzwg.cmm.word.findi" /></a>
					  	<a href="javascript:void(0);" onclick="fnSearchPw();"><spring:message code="wzwg.cmm.word.findp" /></a>
					</div>
					</c:if>
				</div>
	        </div>
	        <!-- login end -->
	    </div>
	<!-- sbscrbBox end -->
	
    <div class="divSnsBtn">
	    <table>
	   <c:if test="${fn:indexOf(nowUrl, '/adLoginForm.do') eq -1}">
	    <c:if test="${!empty crtfcEstbsList}">
		    <c:forEach var="result" items="${crtfcEstbsList}" varStatus="status">
			    <c:if test="${result.usrMngrestbsCode ne 'SC00000397' and result.usrMngrestbsCode ne 'SC00000306' and not empty result.clientId }">
			    <tr style="cursor:pointer;" onclick="fnCrtfc('<c:out value="${result.usrMngrestbsCode}" />');" class="<c:out value="${result.usrMngrestbsCode} ${result.usrMngrestbsCodeNm}" />">
			        <td><c:out value="${result.usrMngrestbsCodeNm}" /> <spring:message code="wzwg.cmm.word.login" /></td>
			    </tr>
			    </c:if>
		    </c:forEach>
	    </c:if>
	   </c:if>
	    </table>
    </div> 
</body>
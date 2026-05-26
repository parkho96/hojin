<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
    <title>::: <spring:message code="wzwg.cmm.word.mngr" /> <spring:message code="wzwg.cmm.word.login" /> :::</title>
 
    <link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/sysMngr/style.css" type="text/css" /> 
    
    <script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
    <script type="text/javascript" src="/js/wzwg/cmm/resize.js"></script>

    
    <script type="text/javascript" src="/js/wzwg/cmm/jquery.cookie.js"></script>
    
    <script type="text/javascript">
    // login
    $(document).ready(function() {
    	
    	//actionLogin();
    	
    	<c:if test="${!empty message}">
    		alert('<c:out value="${message}" />');
    	</c:if>
    	var saveId = $.cookie('saveId');
    	var idElement = $(".in_id");
    	var pwElement = $(".in_pw");
    	var saveIdElement = $("#id_save");
 
        //search background image
        idElement.change(function() {
            if ($(this).val().length > 0){
                $(this).css("background-position", "3px -18px");
            }
        }).focus(function() {
            $(this).css("background-position", "0 -136px");
        }).blur(function() {
            if ($(this).val().length == 0) {
                $(this).css("background-position", "3px -18px");
            } else {
                $(this).css("background-position", "0 -136px");
            }
        }).bind("keypress", function(event){
        	if(event.keyCode == 13){
        		if (document.loginForm.userId.value =="") {
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                }
        		else{
        			$(".in_pw").focus();
        		}
        	}
        });
        
        if(saveId != null && saveId != ""){ 
    		idElement.css({"background-position": "0 -136px"}).val(saveId);
    		pwElement.css({"background-position": "0 -136px"}).focus();
    		saveIdElement.attr("checked", true);
    	}
    	else{
    		idElement.css({"background-position": "0 -136px"}).focus();
    	}
        
        pwElement.change(function() {
            if ($(this).val().length > 0){
                $(this).css("background-position", "4px -58px");
            }
        }).focus(function() {
            $(this).css("background-position", "0 -136px");
        }).blur(function() {
            if ($(this).val().length == 0) {
                $(this).css("background-position", "4px -58px");
            } else {
                $(this).css("background-position", "0 -136px");
            }
        }).bind("keypress", function(event){
        	if(event.keyCode == 13){
        		if (document.loginForm.password.value =="") {
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                }
        		else{
        			actionLogin();
        		}
        	}
        });
        
        $(".btn_login").bind("mouseover", function(){
    		$(this).css({
    		    "box-shadow": "0 2px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)"
    		});
    	}).bind("mouseout", function(){
    		$(this).css({
    			"box-shadow": "none"
    		});
    	});
        
        $(".join_box").find("label").bind("mouseover", function(){
    		$(this).css({
    			"color": "#0000FF"
    			/*, "text-decoration": "underline"*/
    		});
    	}).bind("mouseout", function(){
    		$(this).css({
    			"color": "#000000"
    			/*, "text-decoration": "blink"*/
    		});
    	});
        
        saveIdElement.bind("click", function(){
        	if($(this).is(":checked")){
        		if(!cookieEnabled()){
        			alert('<spring:message code="wzwg.cmm.msg.MSG166" />');
        			$(this).attr("checked", false);
        		}
        	}
        });
        
        /** 회원가입 */
        $("#sbscrb_btn").click(function(){
        	document.loginForm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbMain.do";
        	document.loginForm.submit();
        });
        
        /** 네이버 로그인 */
        $("#naver-login-button").click(function(){
        	window.open("<c:out value="${wzwg_contextPath}" />/cmm/mber/login/naverCrtfcAjax.do", "naverLoginPop", "width=500, height=500");
        });
        
        var otherLoginMsg = '<c:out value="${OtherLoginMsg}" />';		//string
        if(otherLoginMsg == 'Y'){
        	alert(wz_msg('wzwg.cmm.msg.member.OtherLoginMsg'));
        }
        
    });//end ready
    
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
    
    function actionLogin() {
        if (document.loginForm.userId.value =="") {
        	$("#userId").focus();
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
        } else if (document.loginForm.password.value =="") {
        	$("#password").focus();
        	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
        } else {
        	if($("#id_save").is(":checked")){
        		$.cookie("saveId", document.loginForm.userId.value);
        	}
        	else{
        		$.removeCookie("saveId");
        	}
            document.loginForm.action="<c:out value="${wzwg_contextPath}" />/cmm/mber/login/actionMngrLogin.do";
            //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
            //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
            document.loginForm.submit();
        }
    }
    
    </script>
</head>

 <body>
	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		<c:set var="classNm" value="sys"/>
	</c:if>
	<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
		<c:set var="classNm" value="site"/>
	</c:if> 
    
	<form name="loginForm" method="post">
	<div class="<c:out value="${classNm}"/>Wrap">
	 
		<div class="<c:out value="${classNm}"/>Login">
		
			<!-- site name  -->
			<div class="<c:out value="${classNm}"/>Loginbar">
				<!-- system mngr -->
				<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
           			<spring:message code="wzwg.cmm.word.sysmngr" />
           		</c:if>
           		<!-- system mngr -->
           		
           		<!-- site mngr -->
           		<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
           			<spring:message code="wzwg.cmm.word.sitemngr" />
           		</c:if> <spring:message code="wzwg.cmm.word.login" />
           		<!-- /site mngr -->
			</div>
			<!-- /site name  -->
			
			<div class="<c:out value="${classNm}"/>loginbox">
				<!-- Logo  -->
				<h1>
					<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
					 	<img src="/images/wzwg/site/mngr/logo.png" alt="<spring:message code="wzwg.cmm.word.sysmngr" />" />
					</c:if>
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
						<!-- <img src="/images/wzwg/site/mngr/logo.png" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" /> -->
						<c:if test="${empty mngrTopLogo}">
							<h2 style="margin-top: 10px; text-align: center;"><c:out value="${mngrSiteNm}" /></h2>
						</c:if>
						<c:if test="${not empty mngrTopLogo}">
							<img src="<c:out value="${mngrTopLogo}" />&type=w" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" />
						</c:if>
					</c:if>
				</h1>
				<!-- /Logo  -->
				
				<div class="<c:out value="${classNm}" />Loginctn">
					<ul>
						<li>
							<input type="text" name="userId" id="userId" placeholder="<spring:message code="wzwg.cmm.word.idinput" />" title="<spring:message code="wzwg.cmm.word.id02" />" class="login-control in_id"/>
						</li>
						<li>
							<input type="password" name="password" id="password" placeholder="<spring:message code="wzwg.cmm.word.passwordinput" />" title="<spring:message code="wzwg.cmm.word.password" />" class="login-control in_pw" autocomplete="off"/>
						</li>
					</ul>
					
					<a href="javascript:void(0);" onclick="javascript:actionLogin();" class="<c:out value="${classNm}" />Loginbtn"><spring:message code="wzwg.cmm.word.login" /></a>
			
					<span class="info_check">
						<label for="id_save">
							<input type="checkbox" id="id_save" class="<c:out value="${classNm}" />Inch" />
							<em><spring:message code="wzwg.cmm.word.id02" /> <spring:message code="wzwg.cmm.word.stre" /></em>
						</label>
					</span>
				</div>
			</div>
			
			
			<!-- copyright  -->
			<c:set var="now" value="<%=new java.util.Date()%>" />
			<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set>			
			<div class="copywrap">
				<p>
					<c:out value="${sysYear }"/> Copyright <b>WIZWIG Resource</b> All right reserved.
				</p>
			</div>
			<!-- /copyright  -->
			
			
		</div>
	</div>
	</form>
 
	        
	        <!-- 소셜 로그인 영역 Start -->
			<!--         	
			<p class="mg_t10 fr">

		       	 페이스북 로그인 Start
				<a href="javascript:void(0)" onclick="FB.login(FaceBookApp.statusChangeCallback, FaceBookApp.FBScopes);">
					<img src="/images/wzwg/cmm/mber/login/ico-facebook-login.png" width="50" height="50" />
				</a>
				<script type="text/javascript" src="/js/wzwg/login/facebook-login.js"></script>
				페이스북 로그인 End
				
				네이버 로그인 Start
				<a href="javascript:void(0)" id="naver-login-button">
					<img src="/images/wzwg/cmm/mber/login/ico-naver-login.png" width="50" height="50" />
				</a>
				네이버 로그인 End

				구글 로그인 Start
				<a href="javascript:void(0)" id="google-login-button">
					<img src="/images/wzwg/cmm/mber/login/ico-google-login.png" width="50" height="50" />
				</a>
				<script type="text/javascript" src="https://apis.google.com/js/api:client.js"></script>
				<script type="text/javascript" src="/js/wzwg/login/google-login.js"></script>
				구글 로그인 End
				
				카카오 로그인 Start
				<a href="javascript:void(0)" onclick="loginWithKakao();">
					<img src="/images/wzwg/cmm/mber/login/ico-kakao-login.png" width="50" height="50" />
				</a>
				<script type="text/javascript" src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
				<script type="text/javascript" src="/js/wzwg/login/kakao-login.js"></script>
				카카오 로그인 End
				
			</p>
 			-->		
			<!-- 소셜 로그인 영역 End -->
		 
	</body>
</html>

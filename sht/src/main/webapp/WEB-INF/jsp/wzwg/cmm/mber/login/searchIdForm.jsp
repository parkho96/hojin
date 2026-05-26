<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.login" />-<spring:message code="wzwg.cmm.word.findi" />-<spring:message code="wzwg.cmm.word.moblphon" />(<spring:message code="wzwg.cmm.word.mber" />)<spring:message code="wzwg.cmm.word.crtfc" />';}catch(e){console.log(e.message);}
$(document).ready(function(){

    <c:if test="${!empty retMsg}">    
    alert('<spring:message code="${retMsg}" />');
    if ('<c:out value="${retMsg}"/>"'.indexOf('success') > -1) {
        document.stplatFrm.action = '<c:out value="${wzwg_contextPath}" />/loginForm.do';
        document.stplatFrm.submit();
    }
    </c:if>
    fnCrtfcModuleSetting('searchId');
}); 
function fnGoCrtfc(usrMngrestbsCode){
	 if(usrMngrestbsCode == 'SC00000433'){
		document.stplatFrm.action="https://nid.naver.com/user2/help/idInquiry.nhn?menu=idinquiry";
		document.stplatFrm.target="_blank";
		document.stplatFrm.submit();
	}else if(usrMngrestbsCode == 'SC00000434'){
		var openNewWindow = window.open("about:blank");
		 openNewWindow.location.href = 'https://accounts.kakao.com/weblogin/find_account_guide?continue=https://accounts.kakao.com/weblogin/account/info';

	}else if(usrMngrestbsCode == 'SC00000436'){
		var openNewWindow = window.open("about:blank");
		 openNewWindow.location.href = 'https://accounts.google.com/signin/v2/usernamerecovery?service=accountsettings&passive=1209600&osid=1&flowName=GlifWebSignIn&flowEntry=ServiceLogin';
	}
}
</script>
</head>
<body>
     
    <form:form modelAttribute="paramVO" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="userId" />
    <form:hidden path="crtfctSeCode" />
    <input type="hidden" name="crtfctDn" id="crtfctDn" />
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.findi" /></h4>
    <!-- sbscrbBox start -->
    <div class="sbscrbBox sbscrbWrap">
        <div class="sbscrbLoginbox bg_btm bg_mnone">
    
	     	<div class="textBox sbscrbContbox">
	     		
				<ul class="typeBtn">
			           
			        <c:if test="${!empty crtfcEstbsList}">
			    	<c:forEach var="result" items="${crtfcEstbsList}" varStatus="status">
				    <c:if test="${result.usrMngrestbsCode eq 'SC00000306' }">
				    	<li class="<c:out value="${result.usrMngrestbsCode}" />">
		                   <a href="#" class="i-block" onclick="fnCrtfc('<c:out value="${result.usrMngrestbsCode}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">
		                       <img src="/images/wzwg/cmm/mber/sbscrb/crtfc/<c:out value="${result.usrMngrestbsCode}" />.png" alt="" />
		                       <p class="snsName">
			                       <em class="fs16"><c:out value="${result.usrMngrestbsCodeNm}" /></em><br />
			                       <span class="fw600"><spring:message code="wzwg.cmm.word.mbercrtfc" /></span>
		                       </p>
		                   </a>    
		              	 </li>
		            </c:if>
			    	<c:if test="${not empty result.clientId }">
			        	<li class="<c:out value="${result.usrMngrestbsCode}" />">
		                   <a href="#" class="i-block" onclick="fnGoCrtfc('<c:out value="${result.usrMngrestbsCode}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">
		                       <img src="/images/wzwg/cmm/mber/sbscrb/crtfc/<c:out value="${result.usrMngrestbsCode}" />.png" alt="" />
		                       <p class="snsName">
			                       <em class="fs16"><c:out value="${result.usrMngrestbsCodeNm}" /></em><br />
			                       <span class="fw600"><spring:message code="wzwg.cmm.word.mbercrtfc" /></span>
		                       </p>
		                   </a>    
			        	</li>
	              	</c:if>
	              	</c:forEach>
	              	</c:if> 
			               
				</ul>
	
	      	</div>
	      		
		</div>
    </div>
    <!-- /sbscrbBox end -->
</div>
</form:form>
    
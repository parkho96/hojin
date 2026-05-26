<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>
 
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.login" />-<spring:message code="wzwg.cmm.word.findp" />-<spring:message code="wzwg.cmm.word.moblphon" />(<spring:message code="wzwg.cmm.word.mber" />)<spring:message code="wzwg.cmm.word.crtfc" />';}catch(e){console.log(e.message);}
$(document).ready(function(){

    <c:if test="${!empty retMsg}">    
    alert('<spring:message code="${retMsg}" />');
    </c:if>
    
    fnCrtfcModuleSetting('searchPw');
});

function fnGoCrtfc(usrMngrestbsCode){
	 if(usrMngrestbsCode == 'SC00000433'){
		document.stplatFrm.action="https://nid.naver.com/user2/help/pwInquiry.nhn?menu=pwinquiry";
		document.stplatFrm.target="_blank";
		document.stplatFrm.submit();
	}else if(usrMngrestbsCode == 'SC00000434'){
		var openNewWindow = window.open("about:blank");
		 openNewWindow.location.href = 'https://accounts.kakao.com/weblogin/find_password?continue=https%3A%2F%2Faccounts.kakao.com%2Fweblogin%2Faccount%2Finfo';

	}else if(usrMngrestbsCode == 'SC00000436'){
		var openNewWindow = window.open("about:blank");
		 openNewWindow.location.href = 'https://accounts.google.com/signin/v2/sl/pwd?flowName=GlifWebSignIn&flowEntry=ServiceLogin';
	}
}

</script>

    <form:form modelAttribute="paramVO" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="crtfctSeCode" />
    <input type="hidden" name="crtfctDn" id="crtfctDn" />
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.findp" /></h4>
    <!-- sbscrbBox start -->    
    <div class="sbscrbBox searchPw">
        <div class="sbscrbLoginbox bg_btm">
    		
    		<div class="textBox">
	    		<table class="sbscrbTable">
	            	<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.findp" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.idinputtable" /></spring:argument></spring:message></caption>
	                <colgroup>
	                    <col width="25%">
	                    <col width="*">
	                </colgroup>
	                <tr>
	                    <th scope="row"><label for="userId"><spring:message code="wzwg.cmm.word.id02" /></label></th>
	                    <td><form:input cssClass="loginId" placeholder="ID" path="userId" name="userId" /></td>
	                </tr>
		        </table>
		        <p class="txt mt50 fs18"><spring:message code="wzwg.cmm.msg.MSG427" /></p>
	        </div>
    		
     		<div class="textBox">
				<ul class="typeBtn i-block">
	               
		            <c:if test="${!empty crtfcEstbsList}">
					<c:forEach var="result" items="${crtfcEstbsList}" varStatus="status">
					<c:if test="${result.usrMngrestbsCode eq 'SC00000306' }">
						<li class="<c:out value="${result.usrMngrestbsCode}" />">
					       <a href="#" onclick="fnCrtfc('<c:out value="${result.usrMngrestbsCode}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">
					           <img src="/images/wzwg/cmm/mber/sbscrb/crtfc/<c:out value="${result.usrMngrestbsCode}" />.png" alt="" /><br />
					           <em class="fs16"><c:out value="${result.usrMngrestbsCodeNm}" /></em><br />
					           <span class="fw600"><spring:message code="wzwg.cmm.word.mbercrtfc" /></span>
					       </a>    
						</li>
             		</c:if>
    				<c:if test="${not empty result.clientId }">
              			<li class="<c:out value="${result.usrMngrestbsCode}"/>">
                   			<a href="#" onclick="fnGoCrtfc('<c:out value="${result.usrMngrestbsCode}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />">
                       			<img src="/images/wzwg/cmm/mber/sbscrb/crtfc/<c:out value="${result.usrMngrestbsCode}" />.png" alt="" /><br />
                       			<em class="fs16"><c:out value="${result.usrMngrestbsCodeNm}" /></em><br />
                       			<span class="fw600"><spring:message code="wzwg.cmm.word.mbercrtfc" /></span>
                   			</a>    
              			</li>
	              	</c:if>
	              	</c:forEach>
	              	</c:if> 
              
          		</ul>
    		</div>
		</div>
	</div>
    </form:form>
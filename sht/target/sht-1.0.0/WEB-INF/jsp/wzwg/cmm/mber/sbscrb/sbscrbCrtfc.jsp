<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>

<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
<!-- <link rel="stylesheet" href="/css/wzwg/cmm/mber/sbscrb/crtfc/style.css" type="text/css" />  -->

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.signupcrtfc" />';}catch(e){console.log(e.message);}

$(document).ready(function(){
    
    $(".cancelBtn").click(function(){
        var frm = document.stplatFrm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
        frm.submit();
    });
    
    $(".nextBtn").click(function(){
        var frm = document.stplatFrm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbForm.do";
        frm.submit();
    });
    
    fnCrtfcModuleSetting('sbscrb');
});
</script>
</head>
<body>
     
    <form:form modelAttribute="paramVO" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="siteSeq" />
    <form:hidden path="usrtySeq" />
    <form:hidden path="usrTyCode" />
    <form:hidden path="usrgroupSeq" />
    <form:hidden path="crtfctSeCode" />
    <form:hidden path="stplatArr" /> 
    
    <input type="hidden" name="crtfctDn" id="crtfctDn" />
    
    <input type="hidden" id="crtfc_name" name="crtfc_name" /> 
    <input type="hidden" id="crtfc_email" name="crtfc_email" /> 
    <input type="hidden" id="crtfcSns" name="crtfcSns" /> 
    <input type="hidden" id="apiResult" name="apiResult" /> 
    <input type="hidden" id="crtfcSe" name="crtfcSe" /> 
    <!-- sbscrbWrap start -->  
    <div class="sbscrbWrap">
    
    	<h4 class="fs40 fw400 txt-c mb50"><spring:message code="wzwg.cmm.word.signup" /></h4>
    	
        <ul class="sbscrbStep">
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">01</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.stplat" /></span>
	                    <span class="blind"><spring:message code="wzwg.cmm.word.nowstep" /></span> 
	                </p>
                </div>
            </li>
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">02</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.crtfc" /></span>
	                </p>
                </div>
            </li>
            <li>
            	<div class="stepBox">
	                <p class="num">03</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.input" /></span>
	                </p>
                </div>
            </li>
            <li>
            	<div class="stepBox">
	                <p class="num">04</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.compt" /></span>
	                </p>
                </div>
            </li>
        </ul>
        
        <div class="sbscrbText fs17 fw400 linehgt140 txt-c mb50">
       		<span><spring:message code="wzwg.cmm.msg.member.MSG003" /></span>
       	</div>
        
		<div class="sbscrbNaming">
			<spring:message code="wzwg.cmm.word.crtfc" />
		</div>

        <div class="sbscrbContbox">
            <ul class="typeBtn">               
                <c:if test="${!empty crtfcEstbsList}">
                <c:forEach var="result" items="${crtfcEstbsList}" varStatus="status">
                <c:if test="${result.usrMngrestbsCode ne 'SC00000397'}">
                <c:forEach var="usrTyCrtfc" items="${usrTyCrtfcList}">
                <c:if test="${result.usrMngrestbsCode eq usrTyCrtfc.ucrtfcEstbsCode}">
                <li class="<c:out value="${result.usrMngrestbsCode}" />">
                    <a href="#" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" onclick="fnCrtfc('<c:out value="${result.usrMngrestbsCode}" />');">
                        <img src="/images/wzwg/cmm/mber/sbscrb/crtfc/<c:out value="${result.usrMngrestbsCode}" />.png" alt="" />
                        <p class="snsName">
	                        <sapn><c:out value="${result.usrMngrestbsCodeNm}" /></span><br>
	                        <span><spring:message code="wzwg.cmm.word.signup" /><!-- <img src="/images/wzwg/cmm/mber/sbscrb/sbscrbArrow.png" alt="" /> --></span>
                    	</p>
                    </a>    
                </li>
                </c:if>
                </c:forEach>
                </c:if>
                </c:forEach>
                </c:if>
            </ul>
        </div>
        
        <div class="sbscrbBtnbox">
			<div class="sbscrbBtnwidth">
			    <a href="#" class="cancelBtn"><spring:message code="wzwg.cmm.word.cancl" /></a>
				<c:forEach var="usrTyCrtfc" items="${usrTyCrtfcList}">
				<c:if test="${empty usrTyCrtfc.ucrtfcEstbsCode}">
					<a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.next" /></a>
				</c:if>
				</c:forEach>
			</div>
        </div>
    </div>
	<!-- sbscrbWrap end-->  
    </form:form>
    
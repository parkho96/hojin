<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.signupcompt" />';}catch(e){console.log(e.message);}
$(document).ready(function(){
    
    $("#main_btn").click(function(){
        var frm = document.comptForm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
        frm.submit();
    });
    
    $("#login_btn").click(function(){
        var frm = document.comptForm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/loginForm.do";
        frm.submit();
    });    
    
    $("#stpAgre_btn").click(function(){
        var frm = document.comptForm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyStplatAgreList.do";
        frm.submit();
    });    
});

</script>
         
    <form:form modelAttribute="paramVO" path="comptForm" id="comptForm" name="comptForm" method="post">
    <form:hidden path="siteSeq" />
    </form:form> 
                        
    <c:if test="${empty sbscrbFail && empty StplatAgre}">
    <!-- sbscrbWrap start -->  
    <div class="sbscrbWrap">
		<h4 class="fs40 fw400 txt-c mb50"><spring:message code="wzwg.cmm.word.signupcompt" /></h4>
        
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
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">03</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.input" /></span>
	                </p>
                </div>
            </li>
            <li class="stepOn">
            	<div class="stepBox">
	                <p class="num">04</p>
	                <p class="txt">
	                    <span><spring:message code="wzwg.cmm.word.compt" /></span>
	                </p>
                </div>
            </li>
        </ul>
        
        <div class="sbscrbText fs17 fw400 linehgt140 txt-c mb50">
       		<spring:message code="wzwg.cmm.cmmMsg.CMG004">
                <spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument>
                <spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument>
            </spring:message><br />
            <spring:message code="wzwg.cmm.msg.MSG074" />
       	</div>
       	
		<div class="sbscrbNaming linebt">
        	<div class="textBox">
        		<span class="fs24">'<c:out value="${paramVO.userNm}" />'</span> <span><spring:message code="wzwg.cmm.word.sir" /></span><br />
        		<span><spring:message code="wzwg.cmm.msg.member.MSG006" /></span><br />
        		<span><spring:message code="wzwg.cmm.msg.member.MSG007" /></span>
        	</div>
		</div>
		
	    <div class="sbscrbBtnbox">
            <div class="sbscrbBtnwidth">
                <a href="#" class="cancelBtn" id="main_btn"><spring:message code="wzwg.cmm.word.main" /></a>
                <a href="#" class="nextBtn" id="login_btn"><spring:message code="wzwg.cmm.word.login" /></a>
            </div>
        </div>
	</div>
	
	<!--  
    </c:if>
    <c:choose>
    <c:when test="${!empty StplatAgre && StplatAgre}">
    <div class="sbscrb004">
        <div class="sbscrbBtmbox">
            <div class="sbscrbIdbox">
                <ul class="sbscrbIdsac_stplatAgre">
                    <li><spring:message code="wzwg.cmm.msg.MSG075" /></li>
                </ul>
            </div>
            <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="cancelBtn" id="main_btn"><spring:message code="wzwg.cmm.word.main" /></a>
                    <a href="#" class="nextBtn" id="stpAgre_btn"><spring:message code="wzwg.cmm.word.stplat" /></a>
                </div>
            </div>
        </div>
    </div><!-- sbscrb004 end -->
    </c:when>
    <c:otherwise>
    <c:choose>
    <c:when test="${!empty sbscrbFail && sbscrbFail}">
    <div class="sbscrb004">
        <div class="sbscrbBtmbox">
            <p class="sbscrbNaming"><spring:message code="wzwg.cmm.word.signup" />
            <span>
                <spring:message code="wzwg.cmm.cmmMsg.CMG004">
                    <spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument>
                    <spring:argument><spring:message code="wzwg.cmm.word.reject" /></spring:argument>
                </spring:message>
            </span></p>
            <div class="sbscrbIdbox">
                <ul class="sbscrbIdsac">
                    <li>
                        <spring:message code="wzwg.cmm.cmmMsg.CMG001">
                            <spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument>
                        </spring:message>
                    </li>
                </ul>
            </div>
            <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="cancelBtn" id="main_btn"><spring:message code="wzwg.cmm.word.main" /></a>
                    <a href="#" class="nextBtn" id="login_btn"><spring:message code="wzwg.cmm.word.login" /></a>
                </div>
            </div>
        </div>
    </div><!-- sbscrb004 end -->
    </c:when>
    <c:otherwise>
    <div class="sbscrb004">
        <div class="sbscrbBtmbox">
            <p class="sbscrbNaming"><spring:message code="wzwg.cmm.word.signup" />
            <span>
                <spring:message code="wzwg.cmm.cmmMsg.CMG004">
                    <spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument>
                    <spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument>
                </spring:message> <spring:message code="wzwg.cmm.msg.MSG074" />
            </span>
            </p>
            <div class="sbscrbIdbox">
                <ul class="sbscrbIdsac">
                    <li>
                        <spring:message code="wzwg.cmm.cmmMsg.CMG004">
                            <spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument>
                            <spring:argument><spring:message code="wzwg.cmm.word.compt" /></spring:argument>
                        </spring:message>
                    </li>
                </ul>
            </div>
            <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="cancelBtn" id="main_btn"><spring:message code="wzwg.cmm.word.main" /></a>
                    <a href="#" class="nextBtn" id="login_btn"><spring:message code="wzwg.cmm.word.login" /></a>
                </div>
            </div>
        </div>
    </div><!-- sbscrb004 end -->
    </c:otherwise>
    </c:choose>
    </c:otherwise>
    </c:choose>
    
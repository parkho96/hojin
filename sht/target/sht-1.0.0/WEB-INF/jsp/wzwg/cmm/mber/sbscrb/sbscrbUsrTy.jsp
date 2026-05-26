<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.signup" />-<spring:message code="wzwg.cmm.word.mberty" />';}catch(e){console.log(e.message);}

$(document).ready(function(){
    
    $(".nextBtn").click(function(){
        var frm = document.usrTyFrm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbMain.do";
        frm.submit();
    });
    
    $(".cancelBtn").click(function(){
        var frm = document.usrTyFrm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/loginForm.do";
        frm.submit();
    });
});

function fnSelectUsrTy(usrTyCode) {
    $('#usrTyCode').val(usrTyCode);
    $('.siteUsrTy').hide();
    $('.'+usrTyCode).show();
}

function fnCrtfc(usrTyCode, usrtySeq) {

    var frm = document.usrTyFrm;

    frm.usrTyCode.value = usrTyCode;
    frm.usrtySeq.value = usrtySeq;
    
    frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbStplat.do';
    frm.submit();
}
</script>

     
    <form:form modelAttribute="paramVO" path="usrTyFrm" id="usrTyFrm" name="usrTyFrm" method="post">
    <input type="hidden" name="usrtySeq" id="usrtySeq" />
    <input type="hidden" name="usrTyCode" id="usrTyCode" />
    <input type="hidden" name="crtfctSeCode" id="crtfctSeCode" />
    </form:form>
    
    
    <h4 class="tit mb0">
   		<spring:message code="wzwg.cmm.word.mber" /> 
   		<spring:message code="wzwg.cmm.word.ty" />
   	</h4>
    <!-- memType start -->    
    <div class="sbscrbBox">
    	<div class="sbscrbLoginbox memType">
	
		    <div class="sbscrbCustomers">
		        <ul class="customersType">
		            <c:if test="${!empty sysUsrTyList}">
		            <c:forEach var="result" items="${sysUsrTyList}" varStatus="status">
		            <li class="memWrap">
					<%-- <p class="sbscrbNaming" onclick="javascript:fnSelectUsrTy('${result.usrTyCode}');">${result.usrTyCodeNm}<span>${result.usrTyCodeDc}</span></p> --%>
		                <p class="sbscrbNaming">
			               <c:out value="${result.usrTyCodeNm}" /> 
			                <span><c:out value="${result.usrTyCodeDc}" /></span>
		                </p>
		                
		                <ul class="type">
		                    <c:if test="${!empty siteUsrTyList}">
		                    <c:forEach var="chResult" items="${siteUsrTyList}" varStatus="status">
		                    <c:if test="${chResult.usrTyCode eq result.usrTyCode}">
			                    <li class="siteUsrTy <c:out value="${chResult.usrTyCode}" />">
			                        <a href="#" onclick="fnCrtfc('<c:out value="${result.usrTyCode}" />','<c:out value="${chResult.usrtySeq}" />');">
			                            <span><c:out value="${chResult.tyNm}" /></span>
			                            <p>
				                            <c:out value="${chResult.tyNm}" />
				                            <br/>
				                            
				                            <span class="typePoint"><c:out value="${chResult.tyDc}" /></span>
			                            </p>
			                            <div class="usrTyBtn"><spring:message code="wzwg.cmm.word.signup" /></div>
			                        </a>
			                    </li>
		                    </c:if>
		                    </c:forEach>
		                    </c:if>                        
		                </ul>
		            </li>
		            </c:forEach>
		            </c:if>
		        </ul>               
		    </div>
		    
	    </div>
    </div>
    <!-- memType start -->
                
    
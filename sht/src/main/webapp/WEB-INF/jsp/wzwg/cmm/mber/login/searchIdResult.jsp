<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){

	    $(".cancelBtn").click(function(){
	        var frm = document.idForm;
	        frm.action = "<c:out value="${wzwg_contextPath}" />/loginForm.do";
	        frm.submit();
	    }); 
	    
	    $(".nextBtn").click(function(){
	        var frm = document.idForm;
	        frm.action = "<c:out value="${wzwg_contextPath}" />/searchPwForm.do";
	        frm.submit();
	    });
	    
	});
</script>

    <form id="idForm" name="idForm" method="post">
    
    <h4 class="tit mb0"><spring:message code="wzwg.cmm.word.findicompt" /></h4>
    <!-- sbscrbBox start -->
    <div class="sbscrbBox">
        <div class="sbscrbLoginbox">
    
	     	<div class="textBox">
		     	<p class="fs18 gray mb15">
	            	<span><spring:message code="wzwg.cmm.msg.MSG077" /></span>
	            </p>
				<ul class="typeBtn i-block">
                    <c:choose>
                    <c:when test="${empty resultList}">
	                    <li>
	                        <spring:message code="wzwg.cmm.cmmMsg.CMG014">
	                            <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
	                        </spring:message>
	                    </li>
                    </c:when>
                    <c:otherwise>
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                    <c:if test="${status.first}">
                    	<li><spring:message code="wzwg.cmm.word.id02" /></li>
	                    <li>
	                    </c:if>
	                    <c:out value="${result.userId}"/> <c:if test="${!status.last}">, </c:if><c:if test="${status.last}"> <spring:message code="wzwg.cmm.msg.MSG254" />
	                    </li>
                    </c:if>
                    </c:forEach>
                    </c:otherwise>
                    </c:choose>
                </ul>
            </div>
            
            <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="cancelBtn"><spring:message code="wzwg.cmm.word.login" /></a>
                    <a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.findp" /></a>
                </div>
            </div>
            
        </div>
    </div><!-- sbscrb004 end -->
    </form>
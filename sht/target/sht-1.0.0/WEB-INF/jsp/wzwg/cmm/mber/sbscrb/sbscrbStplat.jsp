<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.signup" />-<spring:message code="wzwg.cmm.word.stplat" />';}catch(e){console.log(e.message);}

$(document).ready(function(){
	
	if(document.stplatFrm.usrtySeq.value=="") {
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.cmm.word.mberty" /></spring:argument></spring:message>\n<spring:message code="wzwg.cmm.msg.MSG018" />');
		document.stplatFrm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
		document.stplatFrm.submit();
	}
    
    $(".nextBtn").click(function(){
        var frm = document.stplatFrm;

        var stplatArr = new Array();

        <c:if test="${!empty resultList}">
        for(var i = 1; i <= '<c:out value="${fn:length(resultList)}" />'; i++){
             
            var data = new Object();
            
            data.stplatSeq			= $("#stplatSeq"+i).val();
            data.stplatsimpSeq	= $("#stplatsimpSeq"+i).val();

            
            if($("#agreAt"+i).val() == 'Y'){
                if($("#agreAt"+i).is(":checked") == false){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.rqrtrm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.agre" /></spring:argument></spring:message>');
                    return;
                }else{
                    data.agreAt = 'Y';
                }
            }else{
                data.agreAt    = $("#agreAt"+i).is(":checked") == true ? 'Y':'N';
            }
            
            stplatArr.push(data);
        }
        </c:if>
        
        frm.stplatArr.value = JSON.stringify(stplatArr);

        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbCrtfc.do";
        frm.submit();
    });
    
    $(".cancelBtn").click(function(){
        var frm = document.stplatFrm;
        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
        frm.submit();
    });
});
</script>
                 
    <form:form modelAttribute="paramVO" path="stplatFrm" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="siteSeq" />
    <form:hidden path="usrtySeq" />
    <form:hidden path="usrTyCode" />
    <form:hidden path="usrgroupSeq" />
    
    <input type="hidden" id="crtfc_name" name="crtfc_name" />
    <input type="hidden" id="crtfc_email" name="crtfc_email" />
    <input type="hidden" id="stplatArr" name="stplatArr" /> 
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
            <li>
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
       		<span><spring:message code="wzwg.cmm.msg.member.MSG001" /></span><br />
       		<span><spring:message code="wzwg.cmm.msg.member.MSG002" /></span>
       	</div>
        
		<div class="sbscrbNaming">
			<spring:message code="wzwg.cmm.word.bass" />
		</div>
         
		<div class="signupWrap">
			<c:if test="${!empty resultList }">
			<c:forEach items="${resultList }" var="resultList" varStatus="status">
		    	<input type="hidden" id="stplatSeq<c:out value="${status.index + 1}" />" name="stplatSeq" value="<c:out value="${resultList.stplatSeq}" />" />
		    	<input type="hidden" id="stplatsimpSeq<c:out value="${status.index + 1}" />" name="stplatsimpSeq" value="<c:out value="${resultList.stplatsimpSeq}" />" />
				<div class="signupBox">
					<h3><span class="sbscrbPointc"><spring:message code="wzwg.cmm.word.essntl" /></span><c:out value="${resultList.stplatNm }"/><c:if test="${resultList.essntlAt eq 'Y' }"></c:if></h3>
					<ul class="signText">
						<li tabindex="0">
							<c:out value='${fn:replace(resultList.stplatCn, cn, "<br />")}' escapeXml="false" />
						</li>
					</ul>
		            <div class="signClick">
	                    <span>
		                    <label>
		                    	<input type="checkbox" id="agreAt${status.index + 1}" name="agreAt" value="<c:out value="${resultList.essntlAt}" />" title="<spring:message code="wzwg.cmm.word.stplatagrececk" />" /><em><spring:message code="wzwg.cmm.msg.MSG042" /></em>
		                    </label>
	                    </span>
		            </div>
				</div>
	        </c:forEach>
	     	</c:if>
		</div>
		<!-- signupWrap end -->
		
		<div class="sbscrbBtnbox">
	        <div class="sbscrbBtnwidth">
	            <a href="#" class="cancelBtn"><spring:message code="wzwg.cmm.word.cancl" /></a>
	            <a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.next" /></a>
	        </div>
        </div>
    </div>
    <!-- sbscrbWrap end-->  
    </form:form>
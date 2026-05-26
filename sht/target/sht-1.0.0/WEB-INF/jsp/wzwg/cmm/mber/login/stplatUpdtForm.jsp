<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>

<script type="text/javascript">
$(document).ready(function(){
	
    $(".nextBtn").click(function(){
        var frm = document.stplatFrm;

        var stplatArr = new Array();
        var listSize = parseInt('<c:out value="${fn:length(resultList)}"/>"');
        for(var i = 1; i <= listSize; i++){
             
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
        
        frm.stplatArr.value = JSON.stringify(stplatArr);

        frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/modifyMyStplatAgre.do";
        frm.submit();
    });
    
});
</script>
                 
    <form:form modelAttribute="paramVO" path="stplatFrm" id="stplatFrm" name="stplatFrm" method="post">
    <form:hidden path="siteSeq" />
    <input type="hidden" id="stplatArr" name="stplatArr" /> 
    <div class="sbscrb006">
        <div class="signupWrap">
        
		<c:if test="${!empty resultList }">
		<c:forEach items="${resultList }" var="resultList" varStatus="status">
	    	<input type="hidden" id="stplatSeq<c:out value="${status.index + 1}" />" name="stplatSeq" value="<c:out value="${resultList.stplatSeq}" />" />
	    	<input type="hidden" id="stplatsimpSeq<c:out value="${status.index + 1}" />" name="stplatsimpSeq" value="<c:out value="${resultList.stplatsimpSeq}" />" />
			<div class="signupBox">
				<h3><c:out value="${resultList.stplatNm }"/><c:if test="${resultList.essntlAt eq 'Y' }"><span class="sbscrbPointc">(<spring:message code="wzwg.cmm.word.essntl" />)</span></c:if></h3>
				<ul class="signText">
					<li>
						<c:out value='${fn:replace(resultList.stplatCn, cn, "<br />")}' escapeXml="false" />
					</li>
				</ul>
	            <div class="signClick">
                   <span><input type="checkbox" id="agreAt<c:out value="${status.index + 1}" />" name="agreAt" value="<c:out value="${resultList.essntlAt}" />" /><spring:message code="wzwg.cmm.msg.MSG042" /></span>
	            </div>
			</div>
        </c:forEach>
     	</c:if>
         
         
         </div><!-- signupWrap end -->
         <div class="sbscrbBtnbox">
                <div class="sbscrbBtnwidth">
                    <a href="#" class="nextBtn"><spring:message code="wzwg.cmm.word.agre" /></a>
                </div>
         </div>
    </div><!-- sbscrb006 end-->  
    </form:form>
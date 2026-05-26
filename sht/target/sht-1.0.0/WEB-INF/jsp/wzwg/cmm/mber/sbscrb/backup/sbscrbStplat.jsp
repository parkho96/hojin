<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />

<script type="text/javascript">
$(document).ready(function(){
	
	if(document.stplatFrm.usrtySeq.value=="") {
		alert("<spring:message code="wzwg.cmm.msg.MSG120" />");
		document.stplatFrm.action = "/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
		document.stplatFrm.submit();
	}
    
    /** 가입폼으로 이동 */
    $("#next_btn").click(function(){
        var frm = document.stplatFrm;

        var stplatArr = new Array();
        
        for(var i = 1; i <= '<c:out value="${fn:length(resultList)}" />'; i++){
             
            // 객체 생성
            var data = new Object();
            
            // 약관SEQ, 약관세부SEQ 
            data.stplatSeq			= $("#stplatSeq"+i).val();
            data.stplatdetailSeq	= $("#stplatdetailSeq"+i).val();
            
            if($("#agreAt"+i).val() == 'Y'){
                if($("#agreAt"+i).is(":checked") == false){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.rqrtrm" /></spring:argument>'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.agre" /></spring:argument>'+
                    	  '</spring:message>');
                    return;
                }else{
                    data.agreAt = 'Y';
                }
            }else{
                data.agreAt    = $("#agreAt"+i).is(":checked") == true ? 'Y':'N';
            }
            
            // 리스트에 생성된 객체 삽입
            stplatArr.push(data);
        }
        
        frm.stplatArr.value = JSON.stringify(stplatArr);

        frm.action = "/cmm/mber/sbscrb/selectSbscrbCrtfc.do";
        frm.submit();
    });
    
    /** 취소 */
    $("#cancle_btn").click(function(){
        var frm = document.stplatFrm;
        frm.action = "/loginForm.do";
        frm.submit();
    });
    
});
</script>

	<div class="subConall">
		<div class="signUp001 mg10">
				 <ul class="signTop_ul mb40">
						<li><span class="sign_menu_on">1. <spring:message code="wzwg.cmm.word.tmacnd" /> <spring:message code="wzwg.cmm.word.cnfirm" /></span></li>
						<li><span>2. <spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /> <spring:message code="wzwg.cmm.word.input" /></span></li>
						<li><span>3. <spring:message code="wzwg.cmm.word.signup" /> <spring:message code="wzwg.cmm.word.compt" /></span></li>				 </ul>
				 <h2><spring:message code="wzwg.cmm.word.stplat" /> <spring:message code="wzwg.cmm.word.agre" /></h2>
				 <p><spring:message code="wzwg.cmm.msg.MSG115" /></p>
				 
				 <div class="signUp_wrap pt10">
				 
		        <form:form modelAttribute="paramVO" path="stplatFrm" id="stplatFrm" name="stplatFrm" method="post">
		        <form:hidden path="siteSeq" />
		        <form:hidden path="usrtySeq" />
		        <form:hidden path="usrTyCode" />
		        <form:hidden path="usrgroupSeq" />
		        <input type="hidden" id="stplatArr" name="stplatArr" />				 
				 
				<c:if test="${!empty resultList}">
        		<c:forEach var="resultList" items="${resultList}" varStatus="status">
        		
						<div class="signUp_box pt10">
						
							<input type="hidden" id="stplatSeq<c:out value="${status.index + 1}" />" name="stplatSeq" value="<c:out value="${resultList.stplatSeq}" />" />
                			<input type="hidden" id="stplatdetailSeq<c:out value="${status.index + 1}" />" name="stplatdetailSeq" value="<c:out value="${resultList.stplatdetailSeq}" />" />
						
							<h3><c:out value="${resultList.stplatNm}" /></h3>
							<div class="signText pd10">
								<c:out value='${fn:replace(resultList.stplatDetailCn, cn, "<br />")}' escapeXml="true" />
							</div>
							<div class="signClick mt10">
								<div class="fl">
                        			<span><c:out value="${resultList.stplatDetailNm}" /></span>
                    			</div>
                    			<div class="fr">
			                        <c:choose>
			                        <c:when test="${resultList.essntlAgreAt eq 'Y'}"><font color="#FF2424">(<spring:message code="wzwg.cmm.word.essntl" />)</font></c:when>
			                        <c:otherwise>(<spring:message code="wzwg.cmm.word.choise" />)</c:otherwise>
			                        </c:choose>
			                        <input type="checkbox" class="mg_r5" id="agreAt<c:out value="${status.index + 1}" />" name="agreAt" value="<c:out value="${resultList.essntlAgreAt}" />" /><span> <spring:message code="wzwg.cmm.msg.MSG042" /></span>
			                    </div>
							</div>
						</div>
					
				</c:forEach>
        		</c:if>
        		
				</form:form>
						
				 </div>
 
				 <ul class="signUp_ul mt60">
			        <c:if test="${!empty resultList}">
			            <li id="next_btn"><a href="javascript:void(0);"><spring:message code="wzwg.cmm.word.agre" /></a></li>
			        </c:if>
			        <li id="cancle_btn"><a class="sign_ftbt_on" href="javascript:void(0);"><spring:message code="wzwg.cmm.msg.MSG041" /></a></li>
				 </ul>
		</div> <!-- 약관동의 끝 --> 
	</div>

    
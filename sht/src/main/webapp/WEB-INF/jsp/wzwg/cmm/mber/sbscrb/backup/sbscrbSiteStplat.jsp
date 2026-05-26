<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>

<script type="text/javascript">
$(document).ready(function(){
    
    /* 동의함 */
    $("#sbscrbAgreAtY").click(function(){
    
        var frm = document.regForm;

        var siteStplatArr = new Array();
        var dataSize = parseInt('<c:out value="${fn:length(resultList)}"/>');
        
        for(var i = 1; i <= dataSize; i++){
            
            // 객체 생성
            var data = new Object();
            
            // 약관SEQ, 약관세부SEQ 
            data.stplatSeq          = $("#stplatSeq"+i).val();
            data.stplatdetailSeq    = $("#stplatdetailSeq"+i).val();
            
            if($("#agreAt"+i).val() == 'Y'){
                if($("#agreAt"+i).is(":checked") == false){
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.rqrtrm" /></spring:argument>'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.agre" /></spring:argument>'+
                    	  '</spring:message>');
                    $(this).attr("checked", false);
                    return;
                }else{
                    data.agreAt = 'Y';
                }
            }else{
                data.agreAt = $("#agreAt"+i).is(":checked") == true ? 'Y':'N';
            }
            
            $("#agreAt"+i).prop("disabled", true);
            
            // 리스트에 생성된 객체 삽입
            siteStplatArr.push(data);
        }
        
        frm.siteStplatArr.value = JSON.stringify(siteStplatArr);
        
        $("#sbscrbSiteArea").show();
        $("#sbscrb_btn").show();
        $("#agreBtn").hide();

        var topHeight=0;
        $("#content > div").each(function(){
               if(topHeight< Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""))){
                   topHeight = Number($(this).css("top").replace("px",""))+ Number($(this).css("height").replace("px",""));
               }
           });
        
        if($("#content").css("height")=='100%'){
            $("#content").css("height",topHeight);
        }
        
        $("#content").css("height",$(document).height());
    });
    
});
</script>
     

    <div class="signUp001 pd10" style="border:1px solid #f3f3f3;">
    <c:if test="${!empty resultList}">
    <c:forEach var="resultList" items="${resultList}" varStatus="status">
    <c:if test="${status.first}">
    <h2><c:out value="${resultList.stplatNm}" /></h2>
    <p><c:out value="${resultList.stplatDc}" /></p>
    </c:if>
    </c:forEach>
    </c:if>
     
    <div class="signUp_wrap pt10">

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
            
    </div>
    <ul class="signUp_ul mt60">
        <c:if test="${!empty resultList}">
            <li id="agreBtn"><a href="javascript:void(0);" id="sbscrbAgreAtY"><spring:message code="wzwg.cmm.word.agre" /></a></li>
        </c:if>
     </ul>
    </div>
    
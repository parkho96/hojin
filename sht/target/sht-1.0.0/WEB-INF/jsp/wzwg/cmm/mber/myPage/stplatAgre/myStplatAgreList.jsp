<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("stplatCn", "\n"); 
%>
<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.stplatagrehist" />';}catch(e){console.log(e.message);}
function fnDetail(stplatSeq) {
    var frm = document.frmSrh;
    
    frm.stplatSeq.value = stplatSeq;
    
    frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyStplatAgreDetail.do';
    frm.submit();
}

function fnKeypress() {
    if(event.keyCode == 13){
        fnCrtfc();
    }
}

function fnTdStplatCnCtrl(count, el) {
    if ($('.stplatCn'+count).css('display') == 'none') {
        //$('.tdLogCn').hide();
        $('.stplatCn'+count).show();
    	$(el).attr('title', $(el).html()+' <spring:message code="wzwg.cmm.word.cnclose" />');
    } else {
    	$('.stplatCn'+count).hide();
        $(el).attr('title', $(el).html()+' <spring:message code="wzwg.cmm.word.cnopen" />')
    }
}
</script>
             
    <form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh" method="post">
    <form:hidden path="pageIndex" />
    <form:hidden path="stplatSeq" />
    </form:form>
    
    <h4 class="fs40 fw400 txt-c mb50"><spring:message code="wzwg.cmm.word.stplatagrehist" /></h4>
    <div class="sbscrb005">
            <table class="sbscrbTable basic-table">
            	<caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.signupofstplatNm" />, <spring:message code="wzwg.cmm.word.opertnDe" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
                <colgroup>
                    <col width="5%">
                    <col width="*">
                    <col width="30%">
                </colgroup>
                <thead>
                <tr>
                    <th scope="col">No</th>
                    <th scope="col"><spring:message code="wzwg.cmm.word.stplatNm" /></th>
                    <th scope="col"><spring:message code="wzwg.cmm.word.opertnDe" /></th>
                </tr>
                </thead>
                <tbody>
                <c:choose>
                <c:when test="${empty resultList}">
                <tr style="text-align:center;">
                    <td colspan="3">
                    <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                        <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                    </spring:message>
                    </td>
                </tr>
                </c:when>
                <c:otherwise>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                <tr class="stplatTd">
                    <td><c:out value="${fn:length(resultList)-status.count+1}" /></td>
                    <td><a style="cursor:pointer;" href="javascript:void(0);" onclick="fnTdStplatCnCtrl('<c:out value="${status.count}" />', this);" title="<c:out value="${result.stplatNm}" /> <spring:message code="wzwg.cmm.word.cnopen" />"><c:out value="${result.stplatNm}" /></a></td>
                    <td><c:out value="${result.opertnDe}" /> ~ <c:out value="${result.endDe}" /></td>
                </tr>
                <tr class="tdLogCn stplatCn<c:out value="${status.count}" />" style="display:none;">
                    <td colspan="3">
                        <a href="javascript:void(0);"><h3><c:out value="${result.stplatSj}" /></h3></a>
                        <c:out value='${fn:replace(result.stplatCn, stplatCn, "<br />")}' escapeXml="false" />
                    </td>
                </tr>
                </c:forEach>
                </c:otherwise>
                </c:choose>
                </tbody>
            </table>
    </div><!-- sbscrb003 end -->
    <c:if test="${!empty resultList}">
    <div class="sbscrbBtnbox">
        <div class="sbscrbBtnwidth">
            <ul style="text-align:center;">
            </ul>
        </div>
    </div>
    </c:if>
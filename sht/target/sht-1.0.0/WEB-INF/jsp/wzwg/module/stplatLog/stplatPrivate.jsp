<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("stplatCn", "\n"); 
%>

	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />

	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

	
    <link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css" />


<script type="text/javascript">
function fnTdStplatCnCtrl(count) {
    if ($('.stplatCn'+count).css('display') == 'none') {
        $('.tdLogCn').hide();
        $('.stplatCn'+count).show();
    } else {
        $('.tdLogCn').hide();
    }
}
</script>

         
    <div class="clause001"> 
        <p class="clauseNaming"><spring:message code="wzwg.cmm.word.pivply" /></p>
        <div class="clauseWrap"> 
            <ul class="clauseAllbox">

                <li class="active"> <!-- 게시판 2개 -->
                    <div class="clauseBox">
                        <div class="clauseTxt" style="margin-top:0px;">
                        <c:if test="${!empty resultList}">
                        <c:forEach items="${resultList}" var="result" varStatus="status">
                        <c:if test="${status.first}">
                            <h3><c:out value="${result.stplatNm}" /></h3>
                            <p><c:out value="${result.stplatDc}" /> <span>[<spring:message code="wzwg.cmm.word.opertnDe" />] <c:out value="${result.opertnDe}" /> ~ <c:out value="${result.endDe}" /></span></p>
                            <ul class="ContentsWrap">
                                <li>
                                    <p><c:out value="${result.stplatSj}" /></p>
                                    <ul class="ContentsList">
                                        <li>
                                             <c:out value='${fn:replace(result.stplatCn, stplatCn, "<br />")}' escapeXml="false" />
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </c:if>
                        </c:forEach>
                        </c:if>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

    </div><!-- clause001 end
     -->
    </form>
         
         <div class="sbscrb005">
            
            <table class="sbscrbTable">
            <colgroup>
                <col width="5%">
                <col width="*">
                <col width="30%">
            </colgroup>
            <thead>
            <tr>
                <th>No</th>
                <th><spring:message code="wzwg.cmm.word.stplatNm" /></th>
                <th><spring:message code="wzwg.cmm.word.opertnDe" /></th>
            </tr>
            </thead>
            <tbody>
            
            <c:choose>
            <c:when test="${!empty resultList}">
            <c:forEach items="${resultList}" var="result" varStatus="status">
            <c:if test="${!status.first}">
            <tr style="cursor:pointer;" onclick="fnTdStplatCnCtrl('<c:out value="${status.count}" />');">
                <td><c:out value="${fn:length(resultList)-status.count+1}" /></td>
                <td><c:out value="${result.stplatSj}" /></td>
                <td><c:out value="${result.opertnDe}" /> ~ <c:out value="${result.endDe}" /></td>
            </tr>
            <tr class="tdLogCn stplatCn<c:out value="${status.count}" />" style="display:none;">
                <td colspan="3">
                    <h3><c:out value="${result.stplatSj}" /></h3>
                    <c:out value='${fn:replace(result.stplatCn, stplatCn, "<br />")}' escapeXml="false" />
                </td>
            </tr>
            </c:if>
            </c:forEach>
            </c:when>
            <c:otherwise>
                <tr>
                    <td colspan="5">
                        <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                            <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                        </spring:message>
                    </td>
                </tr>
            </c:otherwise>
            </c:choose>
            
            </tbody>
            </table>
        
        </div>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<div>
<table>
<c:choose>
<c:when test="${empty resultList}">
<tr>
    <td><spring:message code="wzwg.cmm.msg.MSG097" /></td>
</tr>
</c:when>
<c:otherwise>
<c:forEach var="result" items="${resultList}" varStatus="status">
<tr>
    <td>
        <c:out value="${result.nttSeq}"/>
    </td>
    <td class="ta_l">
        
        <c:if test="${fn:length(result.nttSj) > 43}">
            <c:set var="nttSj"><c:out value='${fn:substring(result.nttSj, 0, 43)}'/>...</c:set>
        </c:if>
        <c:if test="${fn:length(result.nttSj) < 44}">
            <c:set var="nttSj"><c:out value='${result.nttSj}'/></c:set>
        </c:if>
        
        <c:if test="${result.lv > 1}">
            <img src="/images/wzwg/cmm/ico-reply.gif" class="mg_l10 mg_r5" />
        </c:if>
        
        <c:if test="${!empty result.subospecSj}"><font style="font-size:8pt;" color="#A6A6A6">[ <c:out value='${result.subospecSj}'/> ]</font></c:if>
        <a href="javascript:void(0);" class="samu" onclick="fnView('<c:out value="${result.nttSeq}"/>');"><c:out value="${nttSj}"/></a>
        
        <c:if test="${result.answerCnt > 0}">
            <a href="javascript:void(0);" onclick="fnAnswerPop('<c:out value="${result.nttSeq}"/>')">
                <span style="font-size:8pt;color:#FF8224">[<c:out value="${result.answerCnt}"/>]</span>
            </a>
        </c:if>
        
        <c:if test="${result.nttNew eq 'Y'}">
            <img src="/images/wzwg/cmm/ico-new.gif" />
        </c:if>
        
    </td>
    <td>
        <c:if test="${result.annymtyAt eq 'Y'}">익&nbsp;&nbsp;&nbsp;명</c:if>
        <c:if test="${result.annymtyAt ne 'Y'}"><c:out value="${result.ntcrNm}"/></c:if>
    </td>
    <td><c:out value="${result.frstRegistPnttm}"/></td>
    <td><c:out value="${result.inqireCnt}"/></td>
    <td><c:out value="${result.likeCnt}"/></td>
</tr>
</c:forEach>
</c:otherwise>
</c:choose>
</table>
</div>
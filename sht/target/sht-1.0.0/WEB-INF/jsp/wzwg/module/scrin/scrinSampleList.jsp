<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
 

<c:set var="menuSclCode" />
<table>
<c:forEach var="result" items="${resultList}" varStatus="status">
<c:if test="${menuSclCode ne result.menuSclCode}">
<c:set var="menuSclCode" value="${result.menuSclCode}" />
<tr>
    <td><h3><c:out value="${result.menuSclNm}" /></h3></td>
</tr>
</c:if>

<c:if test="${status.count%2 != 0 || status.first}"><tr></c:if>
<c:if test="${param.mode eq '1'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrint('<c:out value="${result.smmenuSeq}" />');">
</c:if>
<c:if test="${param.mode eq '2'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrintTop('<c:out value="${result.smmenuSeq}" />');">
</c:if>
<c:if test="${param.mode eq '3'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrintLeft('<c:out value="${result.smmenuSeq}" />');">
</c:if>
    <div id="<c:out value="${result.smmenuSeq}" />" data-sample='{"fileNm":"<c:out value="${result.sampleFileNm}" />.html", "fileCours":"/design/<c:out value="${result.sampleFileCours}" />"}'>
        <img alt="<c:out value="${result.menuNm}" />" src="/design/<c:out value="${result.thumbStreCours}" />/<c:out value="${result.thumbFileNm}" />.png" width="100px">
    </div>
</td>

<c:if test="${param.mode eq '1'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrint('<c:out value="${result.smmenuSeq}" />');"><c:out value="${result.menuNm}" /></td>
</c:if>
<c:if test="${param.mode eq '2'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrintTop('<c:out value="${result.smmenuSeq}" />');"><c:out value="${result.menuNm}" /></td>
</c:if>
<c:if test="${param.mode eq '3'}">
<td style="cursor:pointer;" onclick="javascript:fnSamplePrintLeft('<c:out value="${result.smmenuSeq}" />');"><c:out value="${result.menuNm}" /></td>
</c:if>
<c:if test="${status.count%2 == 0 || status.last}"></tr></c:if>
</c:forEach>
</table>
 
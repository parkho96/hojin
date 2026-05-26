<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<select id="bbsSel" name="bbsSel" onchange="fnBbsChage(this.value);">
	<option value="" <c:if test="${empty paramVO.bbsSeq}">selected="selected"</c:if> ><spring:message code="wzwg.cmm.word.all" /></option>
	<c:forEach var="bbsList" items="${bbsList}">					
		<option value="<c:out value="${bbsList.cntntsSeq}" />|<c:out value="${bbsList.sitecntntsSeq}" />" <c:if test="${paramVO.bbsSeq eq bbsList.cntntsSeq}">selected="selected"</c:if>><c:out value="${bbsList.cntntsNm}" /></option>
	</c:forEach>
</select>			

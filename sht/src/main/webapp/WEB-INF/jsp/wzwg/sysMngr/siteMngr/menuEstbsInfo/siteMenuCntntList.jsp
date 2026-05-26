<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<select id="sitecntntsSeq" name="sitecntntsSeq" onchange="changeCntntsSeq(this)" class="w70">
	<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
	<c:forEach items="${menuCntntList}" var="list" varStatus="status">
	<option value="<c:out value="${list.sitecntntsSeq }" />"><c:out value="${list.cntntsNm}" /></option>
	</c:forEach>
</select>
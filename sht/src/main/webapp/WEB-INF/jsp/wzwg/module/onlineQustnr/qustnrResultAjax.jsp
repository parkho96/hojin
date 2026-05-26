<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<ul>
<c:forEach items="${resultList }" var="resultList" varStatus="status">
	<c:choose>
			<c:when test="${resultList.iemTyCode eq 'SC00000328' or resultList.iemTyCode eq 'SC00000329' }">
				<li>
					<span><c:out value="${resultList.iemNm }"/></span>
					<div class="wzprogress">
						<div class="wzprogress-bar bg-blue-strong" style="width: <c:out value="${resultList.respondPercent }" />%"><c:out value="${resultList.respondPercent }"/>%</div>
					</div>
					<span><c:out value="${resultList.respondCount }"/><spring:message code="wzwg.cmm.word.people" /></span>
				</li>
			</c:when>
			<c:otherwise>
				<li class="message">
					<c:out value="${resultList.dscrpAnswer }" />
				</li>
			</c:otherwise>
	</c:choose>
</c:forEach>
</ul>
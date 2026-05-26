<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>

<c:forEach var="result" items="${resultList}" varStatus="status">
<li>
	<a href="<c:out value="${wzwg_contextPath}" /><c:out value="${result.menuLinkUrl}"/>">
		<c:if test="${sessionScope.LANG eq 'SC00000016' }">
           <c:out value="${result.mngrMenuNm}"/>
        </c:if>
        <c:if test="${sessionScope.LANG eq 'SC00000019' }">
           <c:out value="${result.mngrMenuNmEng}"/>
        </c:if>
	</a>
</li>	
</c:forEach>
<c:if test="${empty resultList}">
	<div class="nonFavorite"><spring:message code="wzwg.cmm.msg.tip.MSG161" /></div>
</c:if>
					
 
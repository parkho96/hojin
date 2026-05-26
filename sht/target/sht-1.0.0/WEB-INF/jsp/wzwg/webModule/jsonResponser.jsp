<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="com.fasterxml.jackson.core.JsonProcessingException"%>
<%@page import="com.fasterxml.jackson.databind.ObjectMapper"%>
<%@ page language="java" contentType="application/json; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%

request.setAttribute("contextPath", request.getContextPath());
request.setAttribute("jsp_replace_char_lf", "\n");
request.setAttribute("jsp_replace_char_cr", "\r");
request.setAttribute("jsp_replace_char_tab", "\t");

		ObjectMapper m = new ObjectMapper();
		String r ="";
		try {
			r = m.writeValueAsString(request.getAttribute("ajaxResponse"));
			request.setAttribute("ajaxResponseJson", r.substring(0, r.lastIndexOf("}")));
//			request.setAttribute("ajaxResponseJson", r);
			//out.println();
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
%>
<%-- json 파싱 오류료 <c:out> 작업 불가 --%>
${ajaxResponseJson}
<c:choose>
	<c:when test="${not empty html}">
		,"html":{
		<c:forEach items="${html}" var="_jsp" varStatus="c">
			<c:if test="${not empty _jsp.value}">
			<c:set var="t"><jsp:include page="/WEB-INF/jsp/${_jsp.value}.jsp"/></c:set>
			                                                                     <%-- jsp value 부분은 <c:out> 작업해주면 안됩니다 재대로 작동하질 않습니다 --%>
			<c:if test="${not c.first}">,</c:if>"<c:out value="${_jsp.key}" />":"${fn:replace(fn:replace(fn:replace(fn:replace(t,'\"','\\\"'),jsp_replace_char_lf,''),jsp_replace_char_cr,''),jsp_replace_char_tab,'')}"
			</c:if>
		</c:forEach>}}
	</c:when>
	
	<c:otherwise>}</c:otherwise>
</c:choose>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="sysYear"><fmt:formatDate value="${now}" pattern="yyyy" /></c:set> 

<div id="footer">
	<p><img src="/images/wzwg/site/mngr/layout/mngrFooterIcon.png"><br><c:out value="${sysYear } " />Copyright WIZWIG<br/>Resource<br/> All right reserved.</p>
</div>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<div class="location-001">
	<ul>
		 <li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>
		  <c:if test="${not empty resultVO.upperMenuNm }">
		  <li>
			<c:out value="${resultVO.upperMenuNm}" />
		  </li>
		  </c:if>
          <li>  
           	<c:out value="${resultVO.mngrMenuNm}" /> 
          </li>
	</ul>
</div>
<h2><c:out value="${resultVO.mngrMenuNm}" /></h2>
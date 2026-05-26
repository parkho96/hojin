<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>   

	<div>
		<c:if test="${empty likeList}">
			<p><spring:message code="wzwg.cmm.msg.MSG020" /></p>				
		</c:if>
		<c:if test="${!empty likeList}">
			<p><spring:message code="wzwg.cmm.msg.MSG066" /></p>
			<ul>				
				<c:forEach var="resultList" items="${likeList}" varStatus="status">
				<li>
					<p class="com_cont">
						<img src="/images/wzwg/module/ntt/men.png" alt="<spring:message code="wzwg.module.word.emplyricon" />" style="vertical-align:middle;"/>
						<c:out value="${resultList.userNm}"/>
						<span class="gray"><c:out value="${resultList.frstRegistPnttm}"/></span>
					</p>				
				</li>
				</c:forEach>
			</ul>
		</c:if>
	</div>
	

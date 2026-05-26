<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


	<c:if test="${!empty subospecList}">
		<%-- <form:select path="subospecSeq" id="subospecSeq">
			<form:option value=""><label for="ctgry01"><spring:message code="wzwg.cmm.word.ctgry02" /> <spring:message code="wzwg.cmm.word.choise" /></label></form:option>
			<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
				<form:option value="${subospecList.subospecSeq}" label="${subospecList.subospecSj}" />
			</c:forEach>
		</form:select>	 --%>
		
		<%-- 
		<input type="hidden" name="subospecSj" id="subospecSj" value="${paramVO.subospecSj}"> --%>
		<input type="hidden" name="subospecSeq" id="subospecSeq" value="<c:out value="${paramVO.subospecSeq}" />">
		<div class="wztab board">
			<ul class="wztab-list">
					<li class="wztab-item<c:if test="${empty paramVO.subospecSeq }"> active</c:if>">
						<button type="button" onclick="fnSelectSubospec('')"><spring:message code="wzwg.cmm.word.all" /></button>
					</li>
				<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
					<li class="wztab-item<c:if test="${paramVO.subospecSeq eq subospecList.subospecSeq}"> active</c:if>">
						<button type="button" onclick="fnSelectSubospec('<c:out value="${subospecList.subospecSeq}" />')" id="tabBtn-<c:out value="${subospecList.subospecSeq }" />"><c:out value="${subospecList.subospecSj}" /></button>
					</li>
				</c:forEach>
			</ul>
		</div>
		<script>
			$(document).ready(function(){
				wzTabInit();
			})
		</script>
	</c:if>
	
	
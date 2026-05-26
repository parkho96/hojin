<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<table class="basic-table01">
		<caption><spring:message code="wzwg.cmm.msg.wa.MSG001" /></caption>
		  <colgroup>
			<col width="40%" />
			<col width="40%" />
			<col width="20%" />
	      </colgroup>
		  <thead>
			<tr>
				<th scope="col"><spring:message code="wzwg.cmm.word.sj" /></th>
				<th scope="col"><spring:message code="wzwg.module.word.lastupdde" /></th>
				<th scope="col"></th>
			</tr>
	      </thead>
		  <tbody>
		  
			<c:if test="${!empty tmprnttList}">
	
				<c:forEach var="resultList" items="${tmprnttList}" varStatus="status">						
					
					<tr>
						<td class="txtLeft">
							<c:set var="nttSjNone" ><spring:message code="wzwg.cmm.word.untitle" /></c:set>
							<c:if test="${fn:length(resultList.nttSj) > 20}">
								<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 20)}..." />
							</c:if>
							<c:if test="${fn:length(resultList.nttSj) < 21}">
								<c:set var="nttSj" value="${resultList.nttSj}" />
							</c:if>
							<c:if test="${fn:length(resultList.nttSj) == 0}">
								<c:set var="nttSj" value="${nttSjNone}" />
							</c:if>
					
							<a href="javascript:void(0);" onclick="fnNttRegistForm('<c:out value="${resultList.tmprnttSeq}"/>');"><c:out value="${nttSj}"/></a>

						</td>
						<td><c:out value="${resultList.lastUpdtPnttm}"/></td>
						<td>
							<button type="button" class="wzbtn-table btn-basic" onclick="fnTmprnttDelete('<c:out value="${resultList.tmprnttSeq}"/>');">
								<spring:message code="wzwg.cmm.word.delete" />
							</button>						
						</td>
					</tr>	
				</c:forEach>
			</c:if>		
			
			<c:if test="${empty tmprnttList}">
				<tr>
					<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
				</tr>
			</c:if>			  
		  </tbody>
	</table>
	
			
					

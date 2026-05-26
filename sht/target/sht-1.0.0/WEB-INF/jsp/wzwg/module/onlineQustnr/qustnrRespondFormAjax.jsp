<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<ul class="wzForm">
<c:forEach items="${iemList }" var="iemList" varStatus="status">
	<c:choose>
			<c:when test="${iemList.iemTyCode eq 'SC00000328' }">
				<li>
					<input type="checkbox" name="chkVal<c:out value="${iemList.qesitmSeq}" />" value="<c:out value="${iemList.iemSeq }" />" dir="required" title="<c:out value="${iemList.iemNm }"/> <spring:message code="wzwg.cmm.word.ceck" />" id="q_<c:out value="${iemList.iemSeq }" />"/>
					
					<label for="q_<c:out value="${iemList.iemSeq }" />">
						<c:out value="${iemList.iemNm }"/>
					</label>
				</li>
			</c:when>
			<c:when test="${iemList.iemTyCode eq 'SC00000329' }">
				<li>
					<input type="radio" name="chkVal<c:out value="${iemList.qesitmSeq}" />" value="<c:out value="${iemList.iemSeq }" />" dir="required" title="<c:out value="${iemList.iemNm }"/> <spring:message code="wzwg.cmm.word.choise" />" id="q_<c:out value="${iemList.iemSeq }" />"/>
					<label for="q_<c:out value="${iemList.iemSeq }" />">
						<c:out value="${iemList.iemNm }"/>
					</label>
				</li>
			</c:when>
			<c:when test="${iemList.iemTyCode eq 'SC00000330' }">
				<li class="message">
					<input type="hidden" name="chkIemSeq<c:out value="${iemList.qesitmSeq}" />" value="<c:out value="${iemList.iemSeq }" />"/>
					<input type="text" name="chkVal<c:out value="${iemList.qesitmSeq}" />" dir="required" title="<spring:message code="wzwg.module.word.answerinpcmpt02" />" id="q_<c:out value="${iemList.iemSeq }" />"/>
				</li>
			</c:when>
			<c:otherwise>
				<li class="message">
					<input type="hidden" name="chkIemSeq<c:out value="${iemList.qesitmSeq}" />" value="<c:out value="${iemList.iemSeq }" />"/>
					<textarea cols="30" rows="10" name="chkVal<c:out value="${iemList.qesitmSeq}" />" dir="required" title="<spring:message code="wzwg.module.word.answerinpcmpt02" />"></textarea>
				</li>
			</c:otherwise>
	</c:choose>
</c:forEach>
</ul>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
		
		<c:if test="${resultVO.popupTyCode eq 'SC00000414' }">
			<c:out value="${resultVO.popupCn }" escapeXml="false"/>
		</c:if>
		<c:if test="${resultVO.popupTyCode eq 'SC00000413' }">
			<c:choose>
				<c:when test="${resultVO.imgLinkuseAt eq 'Y'}">
					<c:set var="popCnLink">javascript:void(0);</c:set>
					
					<c:if test="${not empty resultVO.linkUrl}">
						<c:choose>
							<c:when test="${fn:indexOf(resultVO.linkUrl, 'http') > -1 }">
								<c:set var="popCnLink"><c:out value="${resultVO.linkUrl }" /></c:set>
							</c:when>
							<c:otherwise>
								<c:set var="popCnLink"><%=request.getScheme() %>://<c:out value="${resultVO.linkUrl }" /></c:set>
							</c:otherwise>
						</c:choose>
					</c:if>
					
					<c:set var="popCnLinkTarget">_blank</c:set>
					<c:if test="${resultVO.linkTargetSe eq 'N'}">
						<c:set var="popCnLinkTarget">_self</c:set>
					</c:if>
					<a href="<c:out value='${popCnLink}'/>" target="<c:out value='${popCnLinkTarget}'/>" title="<spring:message code='wzwg.cmm.word.wa.newOpWin' />">
					    <img src="<c:url value='/module/upload/file/selectOrignlImageView.do'/>?atchFileId=<c:out value='${resultVO.atchFileId}'/>&fileSn=0" id="imgInfo" alt="<c:out value='${resultVO.imgReplcText}'/>"/>
					</a>
					
				</c:when>
				<c:otherwise>
					<img src='<c:url value='/module/upload/file/selectOrignlImageView.do'/>?atchFileId=<c:out value="${resultVO.atchFileId }"/>&fileSn=0' id="imgInfo" alt="<c:out value="${resultVO.imgReplcText }" />"/>
				</c:otherwise>
			</c:choose>
		</c:if>

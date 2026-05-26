<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
		<table class="basic-table mt20">
			<thead>
				<tr class="bg-white">
					<th><spring:message code="wzwg.cmm.word.ty" /></th>
					<th><spring:message code="wzwg.cmm.word.icon"/></th>
					<th><spring:message code="wzwg.module.word.linksj"/></th>
					<!-- <th><spring:message code="wzwg.cmm.word.exposure"/><spring:message code="wzwg.cmm.word.no"/></th> -->
					<th><spring:message code="wzwg.cmm.word.ordr"/></th>
					<!-- <th><spring:message code="wzwg.cmm.word.rgsde"/></th> -->
					<th><spring:message code="wzwg.cmm.word.manage"/></th>
				</tr>
			</thead>
			<tbody id="sideQuickItemList">
				<c:set var="viewCnt" value="1"></c:set>
				<c:forEach items="${linkList }" var="list">
				<c:set var="viewAt" value="false"></c:set>
				<c:if test="${list.qmenuTySe eq 'L' and list.menuSttusCode eq 'Y' }"><c:set var="viewAt" value="true"></c:set></c:if>
				<tr data-viewat="<c:out value="${viewAt }" />" data-qmenuSeq="<c:out value="${list.qmenuSeq }" />">
					<td>
						<c:choose>
							<c:when test="${list.qmenuTySe eq 'L' }"><spring:message code="wzwg.cmm.word.link"/></c:when>
							<c:when test="${list.qmenuTySe eq 'D' }"><spring:message code="wzwg.module.word.segroupnm"/></c:when>
						</c:choose>
					</td>
					<td>
						<c:choose>
							<c:when test="${list.qmenuTySe eq 'D' }"><span class="gray">-</span></c:when>
							<c:when test="${empty list.menuImagePath }"><span class="gray">(<spring:message code="wzwg.cmm.word.none"/>)</span></c:when>
							<c:otherwise><img src="<c:out value="${list.menuImagePath }" />" style="width:50px;"></c:otherwise>
						</c:choose>
						
					</td>
					<td>
						<c:out value="${list.qmenuNm }" /><c:if test="${list.menuSttusCode eq 'N' }"><span class="circle_badge bg-grey-strong br3 vert-m ml10"><spring:message code="wzwg.cmm.word.unexposure"/></span></c:if>
					</td>
					<!-- <td>
						<c:if test="${viewAt }"><c:out value="${viewCnt}" /><c:set var="viewCnt" value="${viewCnt + 1 }"></c:set></c:if>
						<c:if test="${not viewAt }">-</c:if>
					</td> -->
					<td class="ordBtns">
						<button class="btn-basic iconOnlyBtn btn-sortUp" data-qmenuSeq="<c:out value="${list.qmenuSeq }" />" onclick="fnQuickLinkOrdrChange('prev', this)" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>
						<button class="btn-basic iconOnlyBtn btn-sortDown" data-qmenuSeq="<c:out value="${list.qmenuSeq }" />" onclick="fnQuickLinkOrdrChange('next', this)" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
					</td>
					<!-- <td><c:out value="${list.frstRegistPnttm }" /></td> -->
					<td>
						<button type="button" class="iconOnlyBtn btn-basic btn-modify" onclick="fnQuickLinkModifyForm('<c:out value="${list.qmenuSeq}" />')" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></button>
						<button type="button" class="iconOnlyBtn btn-basic btn-delete" onclick="fnQuickLinkDelete('<c:out value="${list.qmenuSeq}" />', '<c:out value="${list.qmenuTySe }" />', '<c:out value="${list.qmenuNm }" />')" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></button>
					</td>
				</tr>
				</c:forEach>
				
				
				
				<c:if test="${empty linkList }">
				<tr>
					<th colspan="6" class="txt-c"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.module.word.regiedlink"/></spring:argument></spring:message></th>
				</tr>
				</c:if>
			</tbody>
		</table>
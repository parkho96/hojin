<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<table class="basic-table mt20 fl"> 
		<colgroup>
			<!-- <col width="10%"> -->
			<col width="20%">
			<col width="7%">
			<col width="*">
			<col width="15%">
			<col width="17%">
			<col width="100px">
			<col width="12%">
		</colgroup>
		<thead>
			<tr>
				<!-- <th>카테고리</th> -->
				<th><spring:message code="wzwg.sysMngr.word.widgNm02" /></th>
				<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
				<th><spring:message code="wzwg.sysMngr.word.provdLayout" /></th>
				<th><spring:message code="wzwg.sysMngr.word.provdHg" /></th>
				<th><spring:message code="wzwg.cmm.word.preview" /></th>
				<th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
				<th><spring:message code="wzwg.cmm.word.manage" /></th>
			</tr>	
		</thead>
		<tbody>
			<c:if test="${not empty widgetList}">
			<c:forEach items="${widgetList }" var="list">
				
				<tr style="height:60px;">
					<td><c:out value="${list.layoutcntntsNm}" /></td>
					<td>
						<c:if test="${list.useAt eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></c:if>
						<c:if test="${list.useAt eq 'N'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:if>
					</td>
					<td><c:out value="${fn:replace(list.width, ',', '% ')}" />%</td>
					<td><c:out value="${list.height}" /></td>
					<td class="wiget-listThumb">
						<div class="hoverBox">
						<c:choose>
							<c:when test="${not empty list.thumbMPath }">
                        		<img src="<c:out value="${list.thumbMPath}" />"> 
							</c:when>
							<c:when test="${not empty list.thumbHPath }">
                        		<img src="<c:out value="${list.thumbHPath}" />"> 
							</c:when>
							<c:when test="${not empty list.thumbLPath }">
                        		<img src="<c:out value="${list.thumbLPath}" />"> 
							</c:when>
							<c:when test="${not empty list.thumbWPath }">
                        		<img src="<c:out value="${list.thumbWPath}" />"> 
							</c:when>
						</c:choose>
						</div>
					</td>
					<td><c:out value="${list.frstRegistPnttm}" /></td>
					<td>
						<c:if test="${not empty list.layoutcntntsSeq}">
						<button type="button" class="btn-setting iconOnlyBtn btn-basic" onclick="fnWidgetEdit('edit', '<c:out value="${list.layoutcntntsSeq}" />')"><spring:message code="wzwg.cmm.word.toedit" /></button>
						<button type="button" style="display: none;" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetDel('edit', '<c:out value="${list.layoutcntntsSeq}" />')"><spring:message code="wzwg.cmm.word.delete" /></button>
						</c:if>
						<c:if test="${not empty list.layoutcntntsworkSeq}">
						<button type="button" class="btn-setting iconOnlyBtn btn-basic" onclick="fnWidgetEdit('work', '<c:out value="${list.layoutcntntsworkSeq}" />')"><spring:message code="wzwg.cmm.word.toedit" /></button>
						<button type="button" style="display: none;" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetDel('work', '<c:out value="${list.layoutcntntsworkSeq}" />')"><spring:message code="wzwg.cmm.word.delete" /></button>
						</c:if>
					</td>
				</tr>
			</c:forEach>
			</c:if>
			<c:if test="${empty widgetList}">
			<tr>
				<td colspan="6"><spring:message code="wzwg.sysMngr.msg.MSG030" /></td>
			</tr>
			</c:if>
		</tbody>
	</table>
	<div class="ctr-box">
		<ul id="pageInfo" class="num">
			<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
		</ul>
	</div>
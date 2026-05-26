<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>

function fnPage<c:out value="${paramVO.pblcSn }"/>(pageIndex){
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
	fnSelectSubBplbcList('<c:out value="${paramVO.pblcSn }"/>', pageIndex);
}

</script>
<table class="wztable_line tbl_line_inner">
		<colgroup>
			<col width="*">
			<col width="20%">
			<col width="25%">
		</colgroup>
		<!-- <thead>
			<tr>
				<th class="fw600"><spring:message code="wzwg.cmm.word.detail02" /> <spring:message code="wzwg.cmm.word.list" /></th>
				<th><spring:message code="wzwg.cmm.word.rgsde02" /></th>
				<th style="width: 200px;"><spring:message code="wzwg.cmm.word.publict" /> <spring:message code="wzwg.cmm.word.mth" /></th>
			</tr>
		</thead> -->
		<body class="txt-l">
			<c:forEach items="${beffatPlbcSubList }" var="list">
			<tr>
				<td class="fw600"><c:out value="${list.beffatPblcSubSj }"/></td>
				<td><c:out value="${fn:substring(list.frstRegistPnttm, 0 , 10) }"/></td>
				<td class="file_custom">
					<c:if test="${list.pblcMthCd eq 'file' and not empty list.storFileId}">
						<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" 		value="${list.storFileId}" />
							<c:param name="param_updateFlag" 		value="N" />
							
						</c:import>
					</c:if>
					<c:if test="${list.pblcMthCd eq 'link'}">
						<c:set var="subLink" value="${fn:replace(list.linkUrl, '/subList', 'subList') }"></c:set>
						<c:choose>
							<c:when test="${fn:indexOf(subLink, 'subList') > -1}">
							<a href="<c:out value='${wzwg_contextPath}'/>/<c:out value='${subLink}'/>" class="link wzbtn btn-blue" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"><spring:message code="wzwg.cmm.word.shrtcut" /></a>	
							</c:when>
							<c:otherwise>
							<a href="<c:out value='${subLink}'/>" class="link wzbtn btn-blue" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"><spring:message code="wzwg.cmm.word.shrtcut" /></a>	
							</c:otherwise>
						</c:choose>
						
					</c:if>
				</td>
			</tr>			
			</c:forEach>
			<c:if test="${empty beffatPlbcSubList }">
			<tr>
				<td colspan="3" class="txt-c"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.module.word.regieddetaillist" /></spring:argument></spring:message></td>
			</tr>
			</c:if>
		</body>
</table>

<c:if test="${!empty beffatPlbcSubList}">
<div class="ctr-box" id="pageInfo">
	<c:set var="pageFnName" value="fnPage3"/>
	<ul class="num mobile-none" style="margin-top:0px;">
		<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage${fn:escapeXml(paramVO.pblcSn)}" />
	</ul>
	
	<ul class="num pc-none" style="margin-top:0px;">
		<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage${fn:escapeXml(paramVO.pblcSn)}" />
	</ul>
</div>
</c:if>
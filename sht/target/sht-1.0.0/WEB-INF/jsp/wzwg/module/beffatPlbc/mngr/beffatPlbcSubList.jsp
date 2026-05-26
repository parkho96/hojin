<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script>

function fnPage<c:out value="${paramVO.pblcSn }"/>(pageIndex){
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
	fnSelectSubBplbcList('<c:out value="${paramVO.pblcSn }"/>', pageIndex);
}

</script>
<table class="basic mb0 txt-c">
	<colgroup>
			<col width="*">
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.module.word.detaillist" /></th>
				<th><spring:message code="wzwg.cmm.word.exposure" /></th>
				<th><spring:message code="wzwg.cmm.word.rgsde02" /></th>
				<th style="width: 200px;"><spring:message code="wzwg.module.word.publictmth" /></th>
				<th><spring:message code="wzwg.cmm.word.rm" /></th>
			</tr>
		</thead>
		<body>
			<c:forEach items="${beffatPlbcSubList }" var="list">
			<tr>
				<td><c:out value="${list.beffatPblcSubSj }"/></td>
				<td>
					<c:if test="${list.expsrYn eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.exposure" /></span></c:if>
					<c:if test="${list.expsrYn ne 'Y'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unexposure" /></span></c:if>
				</td>
				<td><c:out value="${fn:substring(list.frstRegistPnttm, 0 , 10) }"/></td>
				<td>
					<c:if test="${list.pblcMthCd eq 'file'}">
						<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
							<c:param name="param_atchFileId" 		value="${list.storFileId}" />
							<c:param name="param_updateFlag" 		value="N" />
							
						</c:import>
					</c:if>
					<c:if test="${list.pblcMthCd eq 'link'}">
						<c:set var="subLink" value="${fn:replace(list.linkUrl, '/subList', 'subList') }"></c:set>
						<c:choose>
							<c:when test="${fn:indexOf(subLink, 'subList') > -1}">
							<a href="<c:out value='${wzwg_contextPath}'/>/<c:out value='${subLink}'/>" class="link" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"><spring:message code="wzwg.cmm.word.shrtcut" /><i class="fa fa-external-link ml5" aria-hidden="true"></i></a>	
							</c:when>
							<c:otherwise>
							<a href="<c:out value='${subLink}'/>" class="link" target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"><spring:message code="wzwg.cmm.word.shrtcut" /><i class="fa fa-external-link ml5" aria-hidden="true"></i></a>	
							</c:otherwise>
						</c:choose>
					</c:if>
				</td>
				<td><button type="button" class="iconOnlyBtn btn-basic btn-modify" onclick="fnBeffatPlbcSubModifyFrm('<c:out value="${paramVO.pblcSn}"/>', '<c:out value="${list.listSn }"/>')" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></button></td>
			</tr>			
			</c:forEach>
			<tr>
				<td colspan="4"><c:if test="${empty beffatPlbcSubList }"><spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.module.word.regieddetaillist" /></spring:argument></spring:message></c:if></td>
				<td><button type="button" class="iconOnlyBtnSameSize btn-save bg white" onclick="fnBeffatPlbcSubRegFrm('<c:out value="${paramVO.pblcSn}"/>')"><spring:message code="wzwg.cmm.word.regist" /></button></td>
			</tr>
		</body>
</table>

<c:if test="${!empty beffatPlbcSubList}">
<div class="ctr-box" id="pageInfo">
	<c:set var="pageFnName" value="fnPage3"/>
	<ul class="num mobile-none" style="margin-top:0px;">
		<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage${fn:escapeXml(paramVO.pblcSn)}" />
	</ul>
</div>
</c:if>
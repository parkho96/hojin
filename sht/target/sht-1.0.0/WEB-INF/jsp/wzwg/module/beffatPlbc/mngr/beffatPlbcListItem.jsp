<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<table class="basic txt-c">
		<colgroup>
			<col width="10%">
			<col width="15%">
			<col width="10%">
			<col width="20%">
			<col width="*">
			<col width="*">
			<col width="*">
			<col width="10%">
			<col width="10%">
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.cmm.word.choise" /></th>
				<th>
					<spring:message code="wzwg.cmm.word.ordr" />
					<div class="menu_help">
							<img src="/images/wzwg/site/mngr/ico_help_grey.png">
							<div class="help_pop"><spring:message code="wzwg.cmm.msg.MSG439" /></div>
					</div>
				</th>
				<th><spring:message code="wzwg.cmm.word.exposure" /></th>
				<th><spring:message code="wzwg.cmm.word.cl" /></th>
				<th><spring:message code="wzwg.module.word.publictlist" /></th>
				<th><spring:message code="wzwg.module.word.chrgdept" /></th>
				<th><spring:message code="wzwg.module.word.publictcycle" /></th>
				<th><spring:message code="wzwg.module.word.publictperiod" /></th>
				<th><spring:message code="wzwg.module.word.publictmth" /></th>
				<th><spring:message code="wzwg.cmm.word.rm" /></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${beffatPlbcList }" var="list">
			<tr>
				<td><input type="checkbox" name="qkMenuYn" value="<c:out value='${list.pblcSn}'/>"></td>
				<td>
					<c:choose>
						<c:when test="${paramVO.srchCtgryCd eq 'ALL'}">-</c:when>
						<c:otherwise>
							<button class="btn-basic iconOnlyBtn btn-sortUp" onclick="fnBplbcListModifyOrdr('D','<c:out value="${list.pblcSn}"/>')" title="<spring:message code="wzwg.cmm.word.up"/>">▲</button>
							<button class="btn-basic iconOnlyBtn btn-sortDown" onclick="fnBplbcListModifyOrdr('U','<c:out value="${list.pblcSn}"/>')" title="<spring:message code="wzwg.cmm.word.down"/>">▼</button>
						</c:otherwise>
					</c:choose>
				</td>
				<td>
					<c:if test="${list.expsrYn eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.exposure" /></span></c:if>
					<c:if test="${list.expsrYn ne 'Y'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unexposure" /></span></c:if>
				</td>
				<td>
					<c:choose>
					<c:when test="${list.ctgryYn eq 'N' }"><span class="red">(<spring:message code="wzwg.module.word.clvaluenone" />)</span></c:when>
					<c:otherwise><c:out value="${list.ctgryDcCn }"/></c:otherwise>
					</c:choose>
				</td>
				<td><c:out value="${list.beffatPblcSj }"/></td>
				<td><c:out value="${list.deptVal }"/></td>
				<td><c:out value="${list.beffatPblcCycleVal }"/></td>
				<td><c:out value="${list.beffatPblcEraVal }"/></td>
				<td><button type="button" class="iconOnlyBtnSameSize btn-basic" onclick="fnSubBplbcListToggle('<c:out value="${list.pblcSn }"/>')"><spring:message code="wzwg.module.word.listview" /></button></td>
				<td><button type="button" class="iconOnlyBtn btn-basic btn-modify" onclick="fnBplbcListModifyMainData('<c:out value="${list.pblcSn }"/>')" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></button></td>
			</tr>
			<tr id="subtr_<c:out value='${list.pblcSn }'/>" style="display: none">
				<td colspan="10" id="subtd_<c:out value='${list.pblcSn }'/>" class="bg-lightgrey" style="padding: 20px"></td>
			</tr>
			</c:forEach>
			<c:if test="${empty beffatPlbcList }">
			<tr>
				<th colspan="10" class="txt-c"><spring:message code="wzwg.cmm.msg.MSG246" /></th>
			</tr>
			</c:if>
		</tbody>
	</table>
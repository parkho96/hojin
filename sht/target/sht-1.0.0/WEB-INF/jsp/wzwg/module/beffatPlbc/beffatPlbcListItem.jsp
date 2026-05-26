<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>



	<table class="wztable_line">
		<caption id="cap_main"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.module.word.priorinfooflistnm" />, <spring:message code="wzwg.module.word.chrgdept" />, <spring:message code="wzwg.module.word.othbccycle" />, <spring:message code="wzwg.module.word.othbcperiod" />, <spring:message code="wzwg.module.word.publictmth" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
		<colgroup>
			<col width="*">
              <col width="15%">
              <col width="15%">
              <col width="15%">
              <col width="15%">
		</colgroup>
		<thead>
			<tr>
				<th scope="row"><spring:message code="wzwg.cmm.word.list" /></th>
				<th scope="row"><spring:message code="wzwg.module.word.chrgdept" /></th>
				<th scope="row"><spring:message code="wzwg.module.word.othbccycle" /></th>
				<th scope="row"><spring:message code="wzwg.module.word.othbcperiod" /></th>
				<th scope="row"><spring:message code="wzwg.module.word.othbcmth" /></th>
			</tr>
		</thead>
		<tbody class="txt-c">
			<c:forEach items="${beffatPlbcList }" var="list">
			<tr>
				<td class="txt-l fw600"><c:out value="${list.beffatPblcSj }"/>
				 	<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT}">
					<button type="button" class="wzbtn btn-basic admBtn fr" data-clipboard-text=""  data-pblcSn="<c:out value='${list.pblcSn }'/>" id="btn_cp_<c:out value='${list.pblcSn }'/>" onclick="fnOnClipboard('btn_cp_<c:out value="${list.pblcSn }"/>')" ><spring:message code="wzwg.module.word.adrescopy" /></button>
					</c:if>
				</td>
				<td><c:out value="${list.deptVal }"/></td>
				<td><c:out value="${list.beffatPblcCycleVal }"/></td>
				<td><c:out value="${list.beffatPblcEraVal }"/></td>
				<td class="btn_box">
					<button type="button" class="wzbtn btn-basic arrow_down" onclick="fnSubBplbcListToggle('<c:out value="${list.pblcSn }"/>')"><spring:message code="wzwg.module.word.listview" /></button>
				</td>
			</tr>
			<tr id="subtr_<c:out value='${list.pblcSn }'/>" style="display: none">
				<td colspan="10" id="subtd_<c:out value='${list.pblcSn }'/>" class="bg-lightgrey"></td>
			</tr>
			</c:forEach>
			<c:if test="${empty beffatPlbcList }">
			<tr>
				<td colspan="10" class="txt-c"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
			</tr>
			</c:if>
		</tbody>
	</table>
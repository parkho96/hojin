<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<input type="hidden" name="filectgrySeq" id="filectgrySeq" />

 <table class="basic mb10">
	<colgroup>
	<col width="15%">
	<col width="*">
	</colgroup>
	<tbody>
	<tr>
	    <th><spring:message code="wzwg.module.word.ctgryadd" /></th>
	    <td>
	    <input name="filectgryNm" class="w70" id="filectgryNm" type="text" title="<spring:message code="wzwg.module.word.ctgryadd" />"  dir="required">
		<a class="wzbtn-table btn-basic"  href="javascript:void(0);" onclick="fnCtgryAdd()"><spring:message code="wzwg.cmm.word.add" /></a>
	    </td>
	</tr>
	</tbody>
</table>

<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.module.word.ctgrylist" /></h3>
 
<table class="basic-table">
			  <colgroup>
				<col width="8%">
				<col width="*">
				<col width="8%"> 
		      </colgroup>
			  <thead>
				<tr class="bg-white">
					<th scope="col">No</th>
					<th scope="col"><spring:message code="wzwg.module.word.ctgrynm" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  <c:forEach items="${ctgryList}" var="list" varStatus="status">
					<tr> 
						<td>
							<c:out value="${status.count}" />
						</td>
						<td>
							<c:out value="${list.filectgryNm}" />	
						</td>
						 
						<td>
							<a class="iconOnlyBtn btn-basic btn-delete" onclick="fnCtgryDelete('<c:out value="${list.filectgrySeq}" />');" href="javascript:void(0);" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
						</td>
					</tr>
					</c:forEach>
			  </tbody>
		</table>

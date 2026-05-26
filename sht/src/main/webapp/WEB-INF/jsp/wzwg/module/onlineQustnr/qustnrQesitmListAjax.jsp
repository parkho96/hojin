<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

/** 체크박스 전체 선택 && 전체 삭제 */
$(document).ready(function(){
	$("#chkAll").click(function(){
		if($("#chkAll").prop("checked")){
			$("input[name=qesitmSeqArr]").prop("checked", true);
		}else{
			$("input[name=qesitmSeqArr]").prop("checked", false);
		}
	});
});

</script>

	<table class="basic-table">
		<colgroup>
			<col width="8%" />
			<col width="5%" />
			<col width="10%" />
			<col width="*" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<thead>
			<tr>
				<th><ul class="wzForm fn"><li class="mr0"><label><input type="checkbox" id="chkAll"/><span class="spanLabel"></span></label></li></ul></th>
			
				<th>No</th>
				<th><spring:message code="wzwg.module.word.qesitmform" /></th>
				<th><spring:message code="wzwg.module.word.qesitmnm" /></th>
				<th><spring:message code="wzwg.cmm.word.ordr" /></th>
				<th><spring:message code="wzwg.cmm.word.manage" /></th>
			</tr>
		</thead>
		<tbody>
		<c:choose>
			<c:when test="${!empty resultList }">
			<c:forEach items="${resultList }" var="resultList" varStatus="status">
			<tr>
				<td><ul class="wzForm fn"><li class="mr0"><label><input type="checkbox" name="qesitmSeqArr" value="<c:out value="${resultList.qesitmSeq }" />"/><span class="spanLabel"></span></label></li></ul></td>
				<td>
					<c:out value="${status.count}"/>
				</td>
				<td>
					<c:out value="${resultList.qesitmTyCodeNm }"/>
				</td>
				<td class="txt-l">
					<c:out value="${resultList.qesitmNm }"/>
				</td>
				<td>
					<c:if test="${not status.first }">
						<a href="javascript:void(0);" onclick="fnOrdrChange('<c:out value="${resultList.qesitmSeq }" />','<c:out value="${resultList.ordr}" />','<c:out value="${resultList.prevQesitmSeq }" />','<c:out value="${resultList.prevOrdr }" />');"><span class="btn-basic iconOnlyBtn btn-sortUp">▲</span></a>
					</c:if>
					<c:if test="${not status.last }">
						<a href="javascript:void(0);" onclick="fnOrdrChange('<c:out value="${resultList.qesitmSeq }" />','<c:out value="${resultList.ordr}" />','<c:out value="${resultList.nextQesitmSeq }" />','<c:out value="${resultList.nextOrdr }" />');"><span class="btn-basic iconOnlyBtn btn-sortDown">▼</span></a>
					</c:if>
				</td>
				<td>
					<a href="javascript:void(0);" onclick="fnQesitmPopup('<c:out value="${resultList.qesitmTyCode}" />','<c:out value="${resultList.qesitmTyCodeNm}" />', '<c:out value="${resultList.qesitmSeq}" />');" class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></a>
					<a href="javascript:void(0);" onclick="fnQesitmDelete('<c:out value="${resultList.qesitmSeq}" />')" class="iconOnlyBtn btn-basic btn-delete" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
				</td>
			</tr>
			</c:forEach>
			</c:when>
			<c:otherwise>
			<tr>
				<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG242" /></td>
			</tr>
			</c:otherwise>
		</c:choose>
		</tbody>
	</table>

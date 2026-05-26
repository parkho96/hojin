<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function (){
		<c:forEach items="${resultList }" var="resultList">
			iemInit('<c:out value="${resultList.qesitmSeq }" />','<c:out value="${resultList.qesitmTyCode}" />');
		</c:forEach>
	});

	function iemInit(paramSeq, paramTyCode){
    	$.ajax({
			  type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrIemResultListAjax.do'
			, data:{'qesitmSeq':paramSeq,'qesitmTyCode':paramTyCode}
			, success:function (data) {
				$('#iemDiv'+paramSeq).html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
			, dataType: 'html'
		});
	}
	
	function fnExcelDown(){
		document.resultFrm.action='<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/selectOnlineQustnrResultExcel.do';
		document.resultFrm.submit();
	}

</script>

<form id="resultFrm" name="resultFrm" method="post">
	<input type="hidden" name="qustnrSeq" value="<c:out value="${resultVO.qustnrSeq }" />"/>
</form>


	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<thead></thead>
		<tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.qustnrnm" /></th>
				<td>
					<c:out value="${resultVO.qustnrNm }"></c:out>
					<span class="excel">
						<a class="wzbtn btn-green ico-excel fr" href="javascript:void(0);" onclick="fnExcelDown();" style="font-size:16px;"><spring:message code="wzwg.module.word.exceldwld" />.xlsx</a>
					</span>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.qustnrsj" /></th>
				<td><c:out value="${resultVO.qustnrNm }"/></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.qustnrpd" /></th>
				<td><c:out value="${resultVO.bgnde } ~ ${resultVO.endde }"/></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.qustnrcn" /></th>
				<td><c:out value="${resultVO.rm }" escapeXml="false"/></td>
			</tr>
		</tbody>
	</table>
	
	<div class="survey">
		<ul>
		<c:forEach items="${resultList }" var="resultList" varStatus="status">
			<li>
				<p><c:out value="${status.count }. ${resultList.qesitmNm }"/></p>
				<div id="iemDiv<c:out value="${resultList.qesitmSeq}" />"/>
			</li>
		</c:forEach>
		</ul>
	</div>

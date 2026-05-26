<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 
<script>
function fnpaging(pageIndex){
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
	$('#pageIndex').val(pageIndex);
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/evlScoreDetailViewAjax.do'
		 , data:{
			 pagadiestbsSeq : $('#pagadiestbsSeq').val(),
			 pageIndex : $('#pageIndex').val()
		 }
		 , success:function (data) {
			 	$(".pop-container").html(data);
				   }
		 , dataType: 'html'
	});
}

function fnExcelDown() {
	if($('.pop-conts #scoreForm').length > 0) {
		$('.pop-conts #scoreForm').remove();
	}
	$('.pop-conts').append('<form id="scoreForm" name="scoreForm"></form>');
	
	document.scoreForm.action="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntPagadiEstbs/evlScoreExcelAjax.do?pagadiestbsSeq="+$('#pagadiestbsSeq').val()+"&sitecntntsSeq="+ $('#sitecntntsSeq').val();
	document.scoreForm.method ="post";
	document.scoreForm.submit();
}
</script>
			<div class="pop-conts" style="">
				<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>"/>
				<h3 class="txt-r mb15">
				    <c:set var="temp_label"><spring:message code="wzwg.cmm.word.ratescor" text="평가점수"/></c:set>
				    <c:set var="temp_unit"><spring:message code="wzwg.cmm.word.count04" text="건"/></c:set>
				
				    <c:set var="temp_avg">
				        <fmt:formatNumber value="${evlEstbsSummary.evlAverage}" pattern="#.##" />
				    </c:set>
				    <c:set var="temp_count">
				        <fmt:formatNumber value="${evlEstbsSummary.evlCount}" pattern="#,###" />
				    </c:set>
				
				    <c:out value="${temp_label}" /> 
				    <c:out value="${temp_avg}" /> / 
				    <c:out value="${temp_count}" />
				    <c:out value="${temp_unit}" />
				</h3>
				<table class="basic-table">
				<colgroup>
					<col width="10%"/>
					<col width="15%"/>
					<col width="15%"/>
					<col width="*"/>
					<col width="15%"/>
				</colgroup>
				<thead>
				<tr>
					<th>NO</th>
					<th><spring:message code="wzwg.site.cntnts.msg.MSG040" text="회원 아이디"/></th>
					<th><spring:message code="wzwg.cmm.word.ratescor" text="평가점수"/></th>
					<th><spring:message code="wzwg.cmm.word.opin" text="의견"/></th>
					<th><spring:message code="wzwg.cmm.word.de01" text="일자"/></th>
				</tr>
				</thead>
				
				<tbody>
				
				<c:if test="${!empty evlScoreList}">
				<c:forEach var="result" items="${evlScoreList}" varStatus="status">
				<tr>
	                <td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}"/></td>
					<td><c:out value="${result.frstRegisterId}"/></td>
					<td><c:out value="${result.evlScore}"/></td>
					<td><c:if test="${empty result.evlOpinion}"><span class="gray">(<spring:message code="wzwg.site.cntnts.msg.MSG041" text="내용 없음"/>)</span></c:if><c:out value="${result.evlOpinion}"/></td>
					<td><c:out value="${result.frstRegistPnttm}"/></td>
				</tr>
				</c:forEach>
				</c:if>
							
				</tbody>
				</table>
				<div class="rt-box"> 
    				<a class="wzbtn btn-green ico-excel fr" onclick="fnExcelDown();" href="javascript:void(0);"><spring:message code="wzwg.site.cntnts.msg.MSG042" text="엑셀 다운로드" /></a> 
				</div>
				<div class="of mg_t20">
					<div class="ctr-box">
						<ul class="num">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnpaging" />
						</ul>
					</div>
				</div>
			</div>

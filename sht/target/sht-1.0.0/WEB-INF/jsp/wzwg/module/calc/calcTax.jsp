<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style type="text/css">
.calcDash {border: dashed 2px #3899ec; min-height: 14px; min-width: 50px; }
table td{text-align: center;}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		//fn_calcView();
	});
	
	/** 컨텐츠 내용 수정 */
	function fn_modifyTaxAjax(){
		
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url :'<c:out value="${wzwg_contextPath}${prefix}"/>/module/calc/modifyCalcTaxAjax.do'
			, cache : false
			, async : false
			, data:$("#calcBassForm").serialize()
			, success:function (data) {
				if(data.result == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
				}else{
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
  
</script>
	<h4 style="font-weight: 100;">금융계산기 세율관리</h4>
	<form id="calcBassForm" name="calcBassForm" method="post" onsubmit="return false">
        <input type="hidden" name="sitecntntsSeq" id="sitecntntsSeq" value="<c:out value='${resultVO.sitecntntsSeq}'/>"/>
		<input type="hidden" name="calcinfoSeq" id="calcinfoSeq" value="<c:out value='${resultVO.calcinfoSeq }'/>"/>
		<textarea id="calcCn" name="calcCn" style="display:none"><c:out value='${resultVO.calcCn }'/></textarea>
		<table class="basic" style="margin-top: 20px;">
			<tbody>
				<colgroup>
					<col width="33.3333333%">
					<col width="33.3333333%">
					<col width="33.3333333%">
				</colgroup>
				<tr>
					<c:forEach items="${codeList }" var="list">
						<th><c:out value="${list.codeNm }"/></th>
					</c:forEach>
				</tr>
				<tr>
					<c:forEach items="${codeList }" var="list">
						<td><input name="<c:out value='${list.code }'/>" type="text" value="<c:out value='${list.codeDc }'/>" style="width: 80px;"><span>%</span></td>
					</c:forEach>
				</tr>
			</tbody>
		</table>
	</form>

	<div class="rt-box">
        <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fn_modifyTaxAjax();" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

	
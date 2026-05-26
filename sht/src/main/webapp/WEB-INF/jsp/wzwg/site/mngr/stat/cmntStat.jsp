<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
	
<script>
$(document).ready(function(){
	$(".datePicker").datepicker({ 		
	     dateFormat: 'yy-mm-dd',
	     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
	     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
	     weekHeader: 'Wk',
	     changeMonth: true, 	//월변경가능
	     changeYear: true, 	//년변경가능
	     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
	     showMonthAfterYear: true, 	//년 뒤에 월 표시
	     buttonImageOnly: false, //이미지표시  
	     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
	     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
	  	});
	
	fnList();
});
function fnList(){
$.ajax({
	type:'POST'
	, url:'<c:out value="${wzwg_contextPath}" />/mngr/stat/selectCmntStatAjax.do'
	, data:$("#statFrm").serialize()
	,success:function (result){ 
		 $("#statDiv").html(result);
	}
	, error:function (request, status, error) {
          alert('<spring:message code="fail.common.msg" text="error" />');
      }
});
}

function fnExcelDown(){
	document.statFrm.action="<c:out value="${wzwg_contextPath}" />/mngr/stat/selectCmntStatExcel.do";
	document.statFrm.method = "post";
	document.statFrm.submit();
}

</script> 
<form id="statFrm" name="statFrm">

</form>
<div id="statDiv">

</div>
<div class="rt-box"> 
    <a class="wzbtn btn-green ico-excel fr" id="regist_btn" onclick="fnExcelDown();" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.excel" text="엑셀" /> <spring:message code="wzwg.cmm.word.dwld" text="다운로드" /></a> 
</div>
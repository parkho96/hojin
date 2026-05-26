<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
	<jsp:useBean id="currTime" class="java.util.Date" />

	<fmt:formatDate value="${currTime}" var="temp_rawDay" pattern="yyyy-MM-dd" />
	<c:set var="curDay"><c:out value="${fn:escapeXml(temp_rawDay)}" /></c:set>	
	
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
	$("#endde").val("<c:out value='${curDay}'/>");
    goMonth(1);
});

function fnList(){
	var bgnde = $("#bgnde").val().replace(/-/g, '');
	var endde = $("#endde").val().replace(/-/g, '');
	
	if(bgnde > endde){
		alert('<spring:message code="wzwg.cmm.msg.MSG323" text="error" />');
		return;
	}
	if(endde.substring(0,4) - bgnde.substring(0,4) > 1){
		alert('<spring:message code="wzwg.cmm.msg.MSG322" text="error" />');
		return;
	}
		if(endde.substring(0,4) - bgnde.substring(0,4) == 1){
		if(endde.substring(4,8) - bgnde.substring(4,8) >= 0){
			alert('<spring:message code="wzwg.cmm.msg.MSG322" text="error" />');
			return;
		}
	}
	$.ajax({
		type:'POST'
		, url:'/mngr/stat/selectBbsStatAjax.do'
		, data:$("#statFrm").serialize()
		,success:function (result){ 
			 $("#statDiv").html(result);
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}

function goMonth(type){
	var endde = $("#endde").val().replace(/-/g, '');
	var bgnYear = Number(endde.substring(0,4));
	var bgnMonth = Number(endde.substring(4,6));
	var bgnDate = Number(endde.substring(6,8));
	
	if(type == '1'){
		if(bgnMonth - 3 < 1){
			bgnYear = bgnYear - 1;
			bgnMonth = (bgnMonth - 3) + 12;
		}else{
			bgnMonth = bgnMonth - 3;
		}
	} else if(type == '2'){
		if(bgnMonth - 6 < 1){
			bgnYear = bgnYear - 1;
			bgnMonth = (bgnMonth - 6) + 12;
		}else{
			bgnMonth = bgnMonth - 6;
		}
	} else if(type == '3'){
		bgnYear = bgnYear - 1;
	}
	
	var bgnLstDay = new Date(bgnYear, bgnMonth, 0);
	var bgnLstDate = bgnLstDay.getDate();
	
	if(bgnDate > bgnLstDate){
		bgnDate = bgnLstDate;
	}
	
	bgnDate = bgnDate + 1;
	if(bgnDate > bgnLstDate){
		bgnDate = 1;
		bgnMonth = bgnMonth + 1;
		
		if(bgnMonth > 12){
			bgnMonth = 1;
			bgnYear = bgnYear + 1;
		}
	}
	
	if(bgnDate < 10){
		bgnDate = '0' + bgnDate;
	}
	if(bgnMonth < 10){
		bgnMonth = '0' + bgnMonth;
	}
	
	$("#bgnde").val(bgnYear + "-" + bgnMonth + "-" + bgnDate);
	fnList();
}

function fnExcelDown(){
	document.statFrm.action="<c:out value="${wzwg_contextPath}" />/mngr/stat/selectBBSStatExcel.do";
	document.statFrm.method = "post";
	document.statFrm.submit();
}
</script>
 <div class="main-menu-bar">
 <form name="statFrm" id="statFrm" >
    
	<c:set var="msg_txt01">
		<spring:message code="wzwg.cmm.cmmMsg.CMG011">
			<spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument>
			<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
		</spring:message>
	</c:set>
	<c:set var="msg_txt02">
		<spring:message code="wzwg.cmm.cmmMsg.CMG011">
			<spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument>
			<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
		</spring:message>
	</c:set>

	<input type="text" class="datePicker cal" style="width:180px;" readonly="readonly" id="bgnde" name="bgnde" dir="required,vdate" placeholder="<c:out value="${msg_txt01}" />" title="<spring:message code="wzwg.cmm.word.bgnde"/>"/>
	 ~ 
	<input type="text" class="datePicker cal" style="width:180px;" readonly="readonly" id="endde" name="endde" dir="required,vdate" placeholder="<c:out value="${msg_txt02}" />" title="<spring:message code="wzwg.cmm.word.endde"/>"/>
	
	<span onclick="fnList();"  ><a class="wzbtn-table btn-srch" href="javascript:void(0);" ><spring:message code="wzwg.cmm.word.search01" /></a></span>
	<span onclick="goMonth(1);"><a class="wzbtn-table btn-basic" href="javascript:void(0);" >3<spring:message code="wzwg.cmm.word.month" text="개월" /> </a></span>
	<span onclick="goMonth(2);"><a class="wzbtn-table btn-basic" href="javascript:void(0);" >6<spring:message code="wzwg.cmm.word.month" text="개월" /></a></span>
	<span onclick="goMonth(3);"><a class="wzbtn-table btn-basic" href="javascript:void(0);" >12<spring:message code="wzwg.cmm.word.month" text="개월" /></a></span>
</form>
</div>
<div id="statDiv">

</div>
<div class="rt-box"> 
    <a class="wzbtn btn-green ico-excel fr" id="regist_btn" onclick="fnExcelDown();" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.excel" text="엑셀" /> <spring:message code="wzwg.cmm.word.dwld" text="다운로드" /></a>
</div>
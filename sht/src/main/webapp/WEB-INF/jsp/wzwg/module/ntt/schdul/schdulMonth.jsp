<%@page import="egovframework.com.cmm.service.Globals"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@page import="egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageVO"%>

<%
	Calendar cal = java.util.Calendar.getInstance();
	
	String strYear = request.getParameter("searchYear");
	String strMonth = request.getParameter("searchMonth");

	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH);
	int nowDate = cal.get(Calendar.DATE);
	//String nowDay = nowYear + "";
	//nowDay += (String.valueOf(nowMonth+1).length() < 2)? "0"+(nowMonth+1):(nowMonth+1);
	//nowDay += (String.valueOf(nowDate).length() < 2)? "0"+nowDate:nowDate;
	
	//String paramYear = nowYear + "";
	//String paramMonth = Integer.toString(nowMonth+1);
	//paramMonth = (paramMonth.length() < 2)? "0"+paramMonth:paramMonth; 
	
	if(strYear != null && !"".equals(strYear))
	{
		nowYear = Integer.parseInt(strYear);
		if(Integer.parseInt(strMonth) > 0){
			if (Integer.parseInt(strMonth) < Integer.MAX_VALUE) {
				nowMonth = Integer.parseInt(strMonth)-1;
				if(nowMonth <0){
					nowMonth = 0;
				}
			}
		}
	}
	if(strMonth == null || "".equals(strMonth)) {
		strMonth = Integer.toString(nowMonth+1);
		strMonth = (strMonth.length() < 2)? "0"+strMonth:strMonth; 
	}
	
	int toDateMonth = cal.get(Calendar.MONTH) +1;
	int toDateDay = cal.get(Calendar.DATE);
	int toDateYear = cal.get(Calendar.YEAR);
	request.setAttribute("toDateDay", toDateDay);
	request.setAttribute("toDateMonth",  toDateMonth < 10 ? "0" + toDateMonth : toDateMonth);
	request.setAttribute("toDateYear", toDateYear);
	cal.set(nowYear, nowMonth, 1); 
	
	
	//int monthStartDate = cal.getMinimum(Calendar.DATE);
	//int monthEndDate = cal.getActualMaximum(Calendar.DATE);
	//
	//int startDay = cal.get(Calendar.DAY_OF_WEEK);
	//int count = 0;
	
	Calendar preCal = java.util.Calendar.getInstance();
	preCal.set(nowYear, nowMonth-1, 1);
	int preEndDay = preCal.getActualMaximum(Calendar.DATE);
	
	int lastDay = cal.getActualMaximum(Calendar.DATE);
	request.setAttribute("lastDay", lastDay);
	
	// 정수 오버플로우 방지를 위한 안전한 연산
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	int firstWeekDay;
	
	// 각 요일별로 명시적 처리 (정수 연산 제외를 위함)
	if (dayOfWeek == 1) {
		firstWeekDay = 0; // 일요일
	} else if (dayOfWeek == 2) {
		firstWeekDay = 1; // 월요일
	} else if (dayOfWeek == 3) {
		firstWeekDay = 2; // 화요일
	} else if (dayOfWeek == 4) {
		firstWeekDay = 3; // 수요일
	} else if (dayOfWeek == 5) {
		firstWeekDay = 4; // 목요일
	} else if (dayOfWeek == 6) {
		firstWeekDay = 5; // 금요일
	} else if (dayOfWeek == 7) {
		firstWeekDay = 6; // 토요일
	} else {
		firstWeekDay = 0; // 기본값
	}
	
	request.setAttribute("firstWeekDay", firstWeekDay);
	request.setAttribute("preEndDay", preEndDay);
	
	String searchYear = request.getParameter("searchYear");
	String searchMonth = request.getParameter("searchMonth");
	
	if(searchYear == null || searchYear.equals("")){
		searchYear = String.valueOf(toDateYear);
	}
	
	if(searchMonth == null || searchMonth.equals("")){
		searchMonth = String.valueOf(toDateMonth);
	}
	
	if(searchMonth.length() == 1){
		searchMonth = "0" + searchMonth;
	}
	
	request.setAttribute("paramYear", searchYear);
	request.setAttribute("paramMonth", searchMonth);
	
%>

<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<c:if test="${empty moduleSchdulCssVO}">
		<c:set var="cssFileNm" value="schdul.css"/>
		<c:set var="cssPath" value="/css/wzwg/module/ntt/basic"/>
	</c:if>
	<c:if test="${!empty moduleSchdulCssVO}">
		<c:set var="cssFileNm" value="${moduleSchdulCssVO.cssFileNm}"/>
		<c:set var="cssPath" value="${moduleSchdulCssVO.cssPath}"/>	
	</c:if>
	
	
	<!-- 날자 계산용 라이브러리 -->
	<script src="/js/wzwg/cmm/moment-with-locales.js"></script>
	
	<script type="text/javascript">
	if($('#schdulDefaultCss').length == 0){
		$('head').append('<link type="text/css" id="schdulDefaultCss" href="/css/wzwg/module/ntt/schdul.css" rel="stylesheet">');
	}
	if($('#schdulCss').length == 0){
		$('head').append('<link type="text/css" id="schdulCss" href="<c:out value="${cssPath}"/>/<c:out value="${cssFileNm}"/>" rel="stylesheet" onload="fnRepositonSchdul()">');
	}
	
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.mnthngschdul" />';}catch(e){console.log(e.message);}
	
	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.cmm.word.sun01" />, <spring:message code="wzwg.cmm.word.mon01" />, <spring:message code="wzwg.cmm.word.tue01" />, <spring:message code="wzwg.cmm.word.wed01" />, <spring:message code="wzwg.cmm.word.thu01" />, <spring:message code="wzwg.cmm.word.fri01" />, <spring:message code="wzwg.cmm.word.sat01" /> <spring:message code="wzwg.cmm.word.mnthng" /> <spring:message code="wzwg.cmm.word.schdul" />');
		
		var hldyAt = '<c:out value="${schdulBassInfoVO.hldyAt}"></c:out>';
		if(hldyAt == 'Y') {
			var res = '';
			var sendUrl = 'https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo?serviceKey=<%=Globals.OPENAPI_HOLIDAYKEY%>&_type=json';
			var year = document.searchForm.searchYear.value;
			var month = document.searchForm.searchMonth.value;
			sendUrl += '&solYear=' + year;
			sendUrl += '&solMonth=' + month;
			$.ajax({
		        type:'GET'
		       , url: sendUrl
		       , data : {}
		       , cache : false
		       , async : true
		       , success:function (data) {
		    	   res = data;
					 var str = '';
					 var resultCode = res.response.header.resultCode;
					 
					 if(resultCode == '00') {
						 $(res.response.body.items.item).each(function(){
							 console.log(this.locdate);
							 $('td[data-dateno=' + this.locdate + ']').addClass("holyTd");
							 if(String(this.locdate).indexOf('0101') > -1){
								 $('td[data-dateno=' + this.locdate + '] .tdBox').append('<span class="holyText">신정</span>');
								 
							 }else if(String(this.locdate).indexOf('1225') > -1){
								 $('td[data-dateno=' + this.locdate + '] .tdBox').append('<span class="holyText">성탄절</span>');
								 
							 }else{
								 $('td[data-dateno=' + this.locdate + '] .tdBox').append('<span class="holyText">'  + this.dateName + '</span>');
								 
							 }
							 $('td[data-dateno=' + this.locdate + '] .tdBox').addClass("holiday");
						 })
					 } else {console.log(' error')}
	       		}
		       , error:function (data) {
		           alert('<spring:message code="fail.common.msg" text="error" />');
		       	}
		       , dataType: 'json'
		       
			})
		}	
	})
	
	//등록화면이동
	function fnRegistFrom(date, callId) {
		$('#openBtnId').val(callId);// pageCallCtrlSchdul.jsp 에 있는 hidden 객체
		$('body').css({overflow:'hidden'});
		
		var year = document.searchForm.searchYear.value;
		var month = document.searchForm.searchMonth.value;
		
		var siteSeq = document.searchForm.siteSeq.value;
		var schdulSeq = document.searchForm.schdulSeq.value;
		
		if(date<10) date = "0" + date;
		
		var searchDate = year + "-" + month + "-" + date;
		
		if(searchDate.length != 10) {
			searchDate="";
		}

		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/registSchdulFormAjax.do'
	      , async : true
	      , data:"searchDate="+searchDate + "&siteSeq=" + siteSeq + "&schdulSeq=" + schdulSeq
	      , success:function (data) {
	    	  //$("#divLayerPopup").html(data);
	    	  //$("#divLayerPopup").show();
	    	  var title = '<spring:message code="wzwg.module.word.schdulregist" />';
	    	  wzAjaxModal('popup_s', title, data, true);
	    	  
	    	  $('.datePicker').not('.hasDatePicker').datepicker();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	
	//수정화면 이동
	function fnModifyForm(schdetSeq) {
		$('body').css({overflow:'hidden'});
		document.detailForm.schdetaSeq.value = schdetaSeq;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/modifySchdulFormAjax.do'
	      , async : true
	      , data:$("#detailForm").serialize()
	      , success:function (data) {
	    	  //$("#divLayerPopup").html(data);
	    	  //$("#divLayerPopup").show();
	    	  var title = '<spring:message code="wzwg.module.word.schdulupdt" />';
	    	  wzAjaxModal('popup_s', title, data);
	    	  $('.datePicker').not('.hasDatePicker').datepicker();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	//미리보기
	function fnPreview(schdetaSeq, schdulCntntsSe, connCntntsSeq, callId) {
		$('#openBtnId').val(callId);// pageCallCtrlSchdul.jsp 에 있는 hidden 객체
		
		var subUrl = "";
		
		if(schdulCntntsSe == "schdul"){	// 일정
			subUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttPreviewAjax.do';
			document.detailForm.schdetaSeq.value = schdetaSeq;
		}
		
		if(schdulCntntsSe == "onreqst"){	// 온라인신청
			if('<c:out value="${loginVO.userId}"/>' == ''){
				alert('<spring:message code="wzwg.cmm.msg.MSG417"/>');
				return;
			}
			subUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/onlineReqst/selectOnlineReqstNttPreviewAjax.do';
			document.detailForm.reqstnttSeq.value = schdetaSeq;
			document.detailForm.reqstSeq.value = connCntntsSeq;
		}
		
		if(schdulCntntsSe == "qustnr"){	// 온라인설문
			//subUrl = '<c:out value="${prefix}"/>/module/ntt/schdul/selectSchdulNttPreviewAjax.do';
			alert('Preparing !!');
			return;
		}
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:subUrl
	      , async : true
	      , data:$("#detailForm").serialize()
	      , success:function (data) {
	    	  //$("#divLayerPopup").html(data);
	    	  //$("#divLayerPopup").show();
	    	  var title = '<spring:message code="wzwg.module.word.schdulview" />';
	    	  wzAjaxModal('popup_s', title, data, true, $('#'+callId));
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	//삭제
	function fnDelete(schdetaSeq) {
		
		if(!confirm('<spring:message code="wzwg.cmm.msg.MSG304" />')) {
			return;
		}
		
		document.detailForm.schdetaSeq.value = schdetaSeq;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/modifySchdulFormAjax.do'
	      , async : true
	      , data:$("#detailForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	    	  
	    	  fnRepositonSchdul();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	//검색
	function fnSearch(callType) {
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttMonthAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').html(data);
	    	  if(callType == 'now'){
	    		  $('#movBtn-now').focus();
	    	  }
	    	  
	    	  fnRepositonSchdul();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	 	  }
	      , dataType: 'html'
	 	});
	}
	
	function fnList(callType) {
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttMonthAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	    	  $(callType).focus();
	    	  fnRepositonSchdul();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	
	function fnDateSearch(val) {
		var frm = document.searchForm;
		
		var date = new Date(frm.searchYear.value,frm.searchMonth.value,'05');
		
		if(val == "next") {
			date.setMonth(date.getMonth() + 1); // +1은 한달을 추가
		} else if(val == "pre"){
			date.setMonth(date.getMonth() - 1); // -1은 한달을 추가
		} else {
			alert('<spring:message code="wzwg.cmm.msg.MSG040" />');
			return;
		}
		
		var year = date.getFullYear();
		var month = date.getMonth();
		
		if(month == 0) {
			year = year - 1;
			month = 12;
		}
		
		
		if(year < 2016) {
			alert('<spring:message code="wzwg.cmm.msg.MSG028" />');
			return;
		}
		
		if(month<10) month = "0" + month; // 월을 2자리로 수정
		if(date<10) date = "0" + date; // 일을 2자리로 수정
		
		frm.searchYear.value = year;
		frm.searchMonth.value = month;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttMonthAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	    	  
	    	  if(val == "next") {
		    	  $('#movBtn-next').focus();
	  		  } else if(val == "pre"){
		    	  $('#movBtn-pre').focus();
	  		  }
	    	  
	    	  fnRepositonSchdul();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
		
	function fnSubTabLink(val) {
		
		var urlLink = "";
		
		if(val == "month") {
			urlLink = "<c:out value='${wzwg_contextPath}'/>/module/ntt/schdul/selectSchdulNttMonthAjax.do";
		} else if(val == "list") {
			urlLink = "<c:out value='${wzwg_contextPath}'/>/module/ntt/schdul/selectSchdulNttListAjax.do";
		} else if(val == "date") {
			urlLink = "<c:out value='${wzwg_contextPath}'/>/module/ntt/schdul/selectSchdulNttDateAjax.do";
		} else {
			urlLink = "<c:out value='${wzwg_contextPath}'/>/module/ntt/schdul/selectSchdulNttWeekAjax.do";
		}
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${prefix}"/>'+urlLink
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	    	  
	    	  if(val == "month") {
		  			$('#movBtn-month').focus();
		  	  } else if(val == "list") {
		  			$('#movBtn-list').focus();
		  	  } else if(val == "date") {
		  			$('#movBtn-date').focus();
		  	  } else {
		  			$('#movBtn-week').focus();
		  	  }
	    	  
	    	  fnRepositonSchdul();
	    	  
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
	}
	
	function fnNowSearch() {
		var nowDate = new Date();

		document.searchForm.searchYear.value  = nowDate.getFullYear();
		document.searchForm.searchMonth.value = ('0' + (nowDate.getMonth() + 1)).slice(-2);

		fnSearch('now');
	}
	
	function fnDateTogle(date) {
		
		if($(".fnSchdulTogle"+date).css("display") == "none") { 
				$(".fnSchdulTogle"+date).css("display", "");
				$('#togleId'+date).text('-');
			} else { 
				$(".fnSchdulTogle"+date).css("display", "none");
				$('#togleId'+date).text('+');
			}
	}
	
	function fnLayerPopupClose() {
	    $("#divLayerPopup").hide();
	    $("#divLayerPopup").empty();
	    $('body').css({overflow:'auto'});
	}
	
	function fnSelectDayList(paramDate){
		
		document.searchForm.searchDate.value = paramDate;
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttDayAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $("#divLayerPopup").html(data);
	    	  $("#divLayerPopup").show();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
		
	</script>
		<c:if test="${nowUrl.indexOf('/mngr') > -1 }">
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0075"/></li>
		        </ul>
			</div>
		</c:if>

		<c:set var="adminAuthAt" value="N"/>
		<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
			<c:set var="adminAuthAt" value="Y"/>
		</c:if>

		<c:set var="schReadAuthAt" value="N" />
		<c:set var="schwriteAuthAt" value="N" />	
		<c:if test="${nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y'}">
			<c:set var="schReadAuthAt" value="Y" />
		</c:if>
		<c:if test="${nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y'}">
			<c:set var="schwriteAuthAt" value="Y" />
		</c:if>
							
		<!-- 레이어팝업 영역 Start -->
		<div id="divLayerPopup" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
		
		<div class="board-detail-001">
			
			<div class="content_top">
				<div class="calTit">
					<a href="javascript:void(0);" onclick="fnDateSearch('pre');" id="movBtn-pre" title="<spring:message code="wzwg.module.word.prevmnthngview" />">
						<img src="/images/wzwg/module/ntt/leftbar.png" alt="" />
					</a>
					<span><c:out value="${paramVO.searchYear}"/>. <c:out value="${paramVO.searchMonth}"/></span>
					<a href="javascript:void(0);" onclick="fnDateSearch('next');" id="movBtn-next" title="<spring:message code="wzwg.module.word.nextmnthngview" />">
						<img src="/images/wzwg/module/ntt/rightbar.png" alt="" />
					</a>
				</div>
				<ul>
					<li><a href="javascript:void(0);" onclick="fnSubTabLink('month');" id="movBtn-month" title="<spring:message code="wzwg.cmm.word.mnthng" />" class="chackOn on" ><spring:message code="wzwg.cmm.word.mnthng" /></a></li>
					<li><a href="javascript:void(0);" onclick="fnSubTabLink('week');" id="movBtn-week" title="<spring:message code="wzwg.cmm.word.wik" />" ><spring:message code="wzwg.cmm.word.wik" /></a></li>
					<li style="float:right;"><a href="javascript:void(0);" onclick="fnNowSearch();" id="movBtn-now" title="<spring:message code="wzwg.cmm.word.today02" />"><spring:message code="wzwg.cmm.word.today02" /></a></li>
				</ul>
			</div>
			
			<form name="searchForm" id="searchForm" method="post">
	   			<input type="hidden" name="siteSeq" value="<c:out value='${paramVO.siteSeq}'/>" />
	   			<input type="hidden" name="schdulSeq" value="<c:out value='${paramVO.schdulSeq}'/>" />
	   			<input type="hidden" name="searchYear" value="<c:out value='${paramVO.searchYear}'/>" />
	   			<input type="hidden" name="searchMonth" value="<c:out value='${paramVO.searchMonth}'/>" />
	   			<input type="hidden" name="searchDate" id="searchDate" value=""/>
	   			<input type="hidden" name="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
			</form>
						
			<form name="detailForm" id="detailForm" method="post">
		   		<input type="hidden" name="schdetaSeq" value="" />
		   		<input type="hidden" name="siteSeq" value="<c:out value='${paramVO.siteSeq}'/>" />
		   		<input type="hidden" name="schdulSeq" value="<c:out value='${paramVO.schdulSeq}'/>" />
		   		<input type="hidden" name="reqstSeq" />
		   		<input type="hidden" name="reqstnttSeq" />
		   		<input type="hidden" name="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>" />
		   	</form>
			<%-- 
			<div class="monthly_calendar">
				<div class="month_table">
				<table class="week">
					 <caption id="contentsCaption"><spring:message code="wzwg.cmm.word.sun01" />, <spring:message code="wzwg.cmm.word.mon01" />, <spring:message code="wzwg.cmm.word.tue01" />, <spring:message code="wzwg.cmm.word.wed01" />, <spring:message code="wzwg.cmm.word.thu01" />, <spring:message code="wzwg.cmm.word.fri01" />, <spring:message code="wzwg.cmm.word.sat01" /> <spring:message code="wzwg.cmm.word.mnthng" /> <spring:message code="wzwg.cmm.word.schdul" /></caption>
					 <colgroup>
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
					  </colgroup>
					  <thead>
						<tr class="grid_header">
							<th class="Red" scope="col"><spring:message code="wzwg.cmm.word.sun01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.mon01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.tue01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.wed01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.thu01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.fri01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.sat01" /></th>
						</tr>
					  </thead>
					<tbody>
                <c:set var="weekCnt" value="1" />
				
                    
						<tr class="date week_date week_<c:out value='${weekCnt }'/>" style="height:10px;">
						<%
							List<ModuleNttSchdulDataManageVO> resultList = (List<ModuleNttSchdulDataManageVO>)request.getAttribute("schdulList");
						
							int preDayCnt = startDay -2;
							for(int i=1; i<startDay; i++){
								count++;
						%>
							<td style="height:10px;"><div class="tdBox"><span href="javascript:void(0);" class="mt5 preTxt"><%=preEndDay - preDayCnt %></span></div></td>
						<%
							preDayCnt--;
							}
							
							for(int i=monthStartDate; i<=monthEndDate; i++){
								count++;
								
								/** 오늘 날짜 체크 */
								String chkToday = "";
								String chkDay = nowYear + "";
								chkDay += (String.valueOf(nowMonth+1).length() < 2)? "0"+(nowMonth+1):(nowMonth+1);
								chkDay += (String.valueOf(i).length() < 2)? "0"+i:i;
								
								if(nowDay.equals(chkDay)){
									chkToday = " class='today'";
								}else{
									chkToday = "";
								}
								
						%>
								<td<%=chkToday %>>
									<div class="tdBox">
											<c:if test="${schwriteAuthAt eq 'Y' }">
												<a href="javascript:void(0);" id="btn_day_<%=count%>" class="<%if(count%7==1){%>redDate <%}%>mt5" style="height:10px;" onclick="fnRegistFrom('<%=i%>', $(this).attr('id'));" >
												<%=i %>
												</a>
											</c:if> 
											<c:if test="${schwriteAuthAt ne 'Y' }">
												<span class="<%if(count%7==1){%>redDate <%}%>mt5" style="height:10px; cursor: default;" >
												<%=i %>
												</span>
											</c:if>
									</div>
								</td>
						<%
								if(count%7 == 0 && i<monthEndDate){
						%>
						</tr>
						<tr class="date week_schdul week_<c:out value='${weekCnt}'/> week_add_<c:out value='${weekCnt}'/>">
						<c:forEach begin="1" end="7" var="dayCnt"><td class="week_day_<c:out value='${dayCnt }'/>"></td></c:forEach>
						</tr>
						<tr class="date week_date week_<c:out value='${weekCnt+1}'/>">
                              
						<c:set var="weekCnt" value="${weekCnt+1}" />
						<%
								}
							} //end for
							
							int nextDay = 1;
							while(count%7 != 0){
						%>
								<td><div class="tdBox"><span href="javascript:void(0);" class="mt5 nextTxt"><%=nextDay %></span></div></td>
						<%
								count++;
								nextDay++;
							}
						%>
						</tr>
						<tr class="date week_schdul week_<c:out value='${weekCnt}'/> week_add_<c:out value='${weekCnt}'/>">
						<c:forEach begin="1" end="7" var="dayCnt"><td class="week_day_<c:out value='${dayCnt }'/>"></td></c:forEach>
						</tr>
						</tbody>
					</table>
				</div>
			</div> --%>
		 <%-- ${lastDay } / ${firstWeekDay } / ${preEndDay } --%> 
			<div class="monthly_calendar">
				<div class="month_table">
				<table class="week">
					 <caption id="contentsCaption"><spring:message code="wzwg.cmm.word.sun01" />, <spring:message code="wzwg.cmm.word.mon01" />, <spring:message code="wzwg.cmm.word.tue01" />, <spring:message code="wzwg.cmm.word.wed01" />, <spring:message code="wzwg.cmm.word.thu01" />, <spring:message code="wzwg.cmm.word.fri01" />, <spring:message code="wzwg.cmm.word.sat01" /> <spring:message code="wzwg.cmm.word.mnthng" /> <spring:message code="wzwg.cmm.word.schdul" /></caption>
					 <colgroup>
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
						<col width="12%">
					  </colgroup>
					  <thead>
						<tr class="grid_header">
							<th class="Red" scope="col"><spring:message code="wzwg.cmm.word.sun01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.mon01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.tue01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.wed01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.thu01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.fri01" /></th>
							<th scope="col"><spring:message code="wzwg.cmm.word.sat01" /></th>
						</tr>
					  </thead>
					<tbody>
	               		<%-- 일 전체 개수 --%>
						<c:set var="allDayCnt" value="${lastDay }"/>
						<c:if test="${firstWeekDay ne '0' }">
						<%-- 시작일이 일요일이 아니면 그만큼 갯수 더해줌 --%>
						<c:set var="allDayCnt" value="${allDayCnt + (firstWeekDay)}"/>
						</c:if>
						<%-- [첫날 : ${firstWeekDay }][전월잔일합산 : ${allDayCnt } (${allDayCnt mod 7 })] --%>
						<%-- 마지막일에 7배수가 되도록 더해줌 --%>
						<c:set var="allDayCnt" value="${allDayCnt + (allDayCnt mod 7 > 0 ? 7 - allDayCnt mod 7 : 0)}"/>
						<%-- [7배수계산 : ${allDayCnt }] --%>
						<c:set var="addDayCnt" value="${allDayCnt + (firstWeekDay) -1}"/>
						<%-- [역계산차수 : ${addDayCnt }] --%>
						<%-- <c:set var="addWeekCnt" value="${allDayCnt / 7 + (allDayCnt mod 7)}"/> --%>
						<fmt:formatNumber var="addWeekCnt" value="${allDayCnt / 7 }" pattern="0"></fmt:formatNumber>
						
						<c:set var="toDateYYYYMM" value="${toDateYear += toDateMonth}"/>
						<c:set var="searchDateYYYYMM" value="${paramYear += paramMonth}"/>
						
						<c:forEach begin="1" end="${addWeekCnt }" var="weekCnt" varStatus="status">
							<tr class="date week_date week_<c:out value='${weekCnt }'/>" style="height:10px;">
								<c:forEach begin="1" end="7" var="dayCnt">
								<c:set var="dayNo" value="${allDayCnt - addDayCnt }"/>
								<c:set var="dayClass" value=""/>
								<c:set var="toDayClass" value=""/>
								<c:set var="isPreDate" value=""/>
								<c:set var="isNextDate" value=""/>
								<c:set var="dateNo" value=""/>
								
								<c:choose>
									<c:when test="${dayNo < 1 }">
										<%-- 이전달 날자 --%>
										<c:set var="dayNo" value="${(preEndDay + dayNo)}"/>
										<c:set var="dayClass" value="preTxt"/>
										<c:set var="isPreDate" value="Y"/>
										
									</c:when>	
									<c:when test="${dayNo > lastDay }">
										<%-- 다음달 날자 --%>
										<c:set var="dayNo" value="${(dayNo - lastDay) }"/>
										<c:set var="dayClass" value="nextTxt"/>
										<c:set var="isNextDate" value="Y"/>
									</c:when>
									<c:otherwise>
										<c:set var="dayNo" value="${dayNo}"/>
										<c:if test="${toDateYYYYMM eq searchDateYYYYMM and toDateDay eq dayNo }">
										<c:set var="toDayClass" value="today"/>
										</c:if>
										<c:set var="dateNo" >${searchDateYYYYMM}${dayNo < 10 ? '0' += '' += dayNo : dayNo}</c:set>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${dayCnt eq '1' }">
										<%-- 일요일 --%>
										<%-- <c:set var="dayClass" value="${dayClass } redDate"/> --%> 									
									</c:when>
									<c:when test="${dayCnt eq '7'}">
										<%-- 토요일 --%>
										<%-- <c:set var="dayClass" value="${dayClass } sat"/> --%> 									
									</c:when>
								</c:choose>
								<td class="<c:out value="${toDayClass }"/>" data-day="${dayCnt -1 }" data-dateno="<c:out value="${dateNo }"/>">
									<%-- [${toDateYYYYMM}]/[${searchDateYYYYMM}]/[${toDateDay }]/[${dayNo }]  --%>
									<%-- [${searchDateYYYYMM}/${param.searchYear }-${param.searchMonth }] --%>
									<div class="tdBox">
										<c:choose>
											<c:when test="${schwriteAuthAt eq 'Y' and isPreDate ne 'Y' and isNextDate ne 'Y'}">
												
												<a href="javascript:void(0);" id="btn_day_<c:out value="${dayNo }"/>" class="mt5 <c:out value="${dayClass }"/>" onclick="fnRegistFrom('<c:out value="${dayNo }"/>', $(this).attr('id'));" >
													<c:out value="${dayNo }"/>
												</a>
											</c:when>
											<c:otherwise>
												<span class="mt5 <c:out value="${dayClass }"/>" style="cursor: default;" >
													<c:out value="${dayNo }"/>
													</span>
											</c:otherwise>
										</c:choose>
									</div>
								</td>
								<c:set var="addDayCnt" value="${addDayCnt - 1 }"/>
								</c:forEach>
							</tr>
							<tr class="date week_schdul week_<c:out value='${weekCnt}'/> week_add_<c:out value='${weekCnt}'/>">
								<c:forEach begin="1" end="7" var="dayCnt">
								<td class="week_day_${dayCnt }" data-day="${dayCnt -1 }"></td>
								</c:forEach>
							</tr>
							
						</c:forEach>
					</tbody>
					</table>
				</div>
			</div>
			
			<script>
        		
	            //console.log('<c:out value="${schdulListJson}"/>');
	            
	            /* 달력 계산 준비 */
	            moment.locale('ko');   
	            
	            var month = '<c:out value="${month}"/>';
	            var year = '<c:out value="${year}"/>';
	            //console.log('검색년월 : ' + year+'-'+month);
	            var thisMmt = moment(year + month + '01');
	            
	            var firstDay = new Date(year + '-' + month + '-01');//선택월의 첫번째날
	            var lastDay = new Date(firstDay.getFullYear(), parseInt(month), 0); //선택월의 마지막날
	            
	            var mmtFd = moment(firstDay);	//moment 객채로 변환
	            var mmtLd = moment(lastDay);	//moment 객채로 변환
	            
	            var firstDayCode = parseInt(mmtFd.format('d')); //첫째날 요일코드
	            var lastDayCode = parseInt(mmtLd.format('d')); //첫째날 요일코드
	            
	            mmtFd = mmtFd.add((firstDayCode * -1), 'days');	//달력의 전체 첫날자로 이동
	            mmtLd = mmtLd.add((6 - lastDayCode), 'days');	//달력의 전체 마지막날자로 이동(moment 날자코드가 0부터 시작이므로 6에서 뺌)
	            //console.log('달력시작일 : ' + mmtFd.format('YYYYMMDD'));
	            //console.log('달력종료일 : ' + mmtLd.format('YYYYMMDD'));
	            var weekCount = Math.ceil(mmtLd.diff(mmtFd, 'days') / 7); /**해당월의 전체 주차 계산*/

	            
	            
	            /* 달력 데이터 세팅 */
	            <c:set var="schdulListTemp" value="${schdulListJson}" />
				var schdulListJson = <c:out value="${schdulListTemp}" escapeXml="false" />; //json 데이터
	            var schReadAuthAt = '<c:out value="${schReadAuthAt}"/>'; //읽기권한값 : Y면 권한 있음
	            var schwriteAuthAt = '<c:out value="${schwriteAuthAt}"/>'; //쓰기권한값 : Y면 권한 있음
	            for (var i = 0 ; i < schdulListJson.length ; i++){
	            	schdul = schdulListJson[i];
	            	
	            	//console.log('');console.log('');console.log('');console.log('');console.log('');
	            	//console.log(schdul.schdulNm + ' 일정시작');
	            	
	            		var weekCnt = weekCount;
	            		
	            		//momentWeekFirst 주차첫번째 날(일요일)
	            		var mmtWf = moment(firstDay);	//moment에서 add 할경우 객체 자체 시간이 증가하므로 새롭게 계산할 객채가 필요함
	            		mmtWf = mmtWf.add((firstDayCode * -1), 'days');	//달력의 전체 첫날자로 이동
	            		//console.log('이벤트일정 계산용 세팅 : ' + mmtWf.format('YYYYMMDD'));
	            		
	            		//momentWeekLast 주차마지막 날(토요일)
	            		var mmtWl = moment(firstDay);	//moment에서 add 할경우 객체 자체 시간이 증가하므로 새롭게 계산할 객채가 필요함
	            		mmtWl = mmtWl.add((firstDayCode * -1)+6, 'days');	//달력의 전체 첫날자로 이동 +6을 해서 토요일로 맞춤
	            		//console.log('이벤트일정 계산용 세팅 : ' + mmtWl.format('YYYYMMDD'));
	            		
	    	            
	            		
		            	//console.log('schdul.bgnde : ' + schdul.bgnde);
		            	//console.log('schdul.endde : ' + schdul.endde);
	            		var mmtBgnde = moment(schdul.bgnde);	//일정 시작일을 moment로 변환
		            	var mmtEndde = moment(schdul.endde);	//일정 종료일을 moment로 변환
		            	//console.log('이벤트 시작일 : ' + mmtBgnde.format('YYYYMMDD'));
		            	//console.log('이벤트 종료일 : ' + mmtEndde.format('YYYYMMDD'));
		            	
	            		for(var k = 0 ; k < weekCnt; k++){
	            			if(k > 0){
	            				mmtWf.add(7, 'days');//첫주가 아니면 7일씩 증가 시킨다
	            				mmtWl.add(7, 'days');//첫주가 아니면 7일씩 증가 시킨다
	            			}
			            	//console.log('이벤트 시작 일정 계산 : ' + mmtWf.format('YYYYMMDD'));
			            	//console.log('이벤트 종료 일정 계산 : ' + mmtWl.format('YYYYMMDD'));
			            	var bgnDiff = mmtBgnde.diff(mmtWf, 'days');
			            	var endDiff = mmtWl.diff(mmtEndde, 'days');
			            	
			            	
			            	var weekNo =  k+1; //시작주간 세팅
	            			var dayNo = 0;
	            			var width = 1;
	            			
	            			if( moment(mmtEndde.format('YYYYMMDD')).isBefore(mmtWf.format('YYYYMMDD')) ){
	            				//console.log('이벤트 종료일 이번주 앞에 있음');
	            				break;
	            			}
	            			
			            	//var isStarSchdul = moment(mmtBgnde.format('YYYYMMDD')).isBetween(mmtWf.format('YYYYMMDD'), mmtWl.format('YYYYMMDD'));
			            	//var isEndSchdul = moment(mmtEndde.format('YYYYMMDD')).isBetween(mmtWf.format('YYYYMMDD'), mmtWl.format('YYYYMMDD')); 
			            	var isStarSchdul = moment(mmtBgnde.format('YYYYMMDD')).isSameOrAfter(mmtWf.format('YYYYMMDD')) 
			            					&& moment(mmtBgnde.format('YYYYMMDD')).isSameOrBefore(mmtWl.format('YYYYMMDD'));
			            	var isEndSchdul = moment(mmtEndde.format('YYYYMMDD')).isSameOrAfter(mmtWf.format('YYYYMMDD')) 
			            				   && moment(mmtEndde.format('YYYYMMDD')).isSameOrBefore(mmtWl.format('YYYYMMDD')); 

			            	//console.log(mmtEndde.format('YYYYMMDD') + ' isSame ' + mmtWf.format('YYYYMMDD'));
			            	//console.log(moment(mmtEndde.format('YYYYMMDD')).isSame(mmtWf.format('YYYYMMDD')));
			            	//console.log("isStarSchdul : " +isStarSchdul);
			            	//console.log("isEndSchdul : " +isEndSchdul);
			            	
			            	if(isStarSchdul && isEndSchdul){
			            		//console.log('시작일과 종료일이 해당주에 포함됨');
			            		var dayCodeStart = parseInt(mmtBgnde.get('d'));
			            		var dayCodeEnd = parseInt(mmtEndde.get('d'));
			            		var width = moment(mmtEndde.format('YYYYMMDD')).diff(mmtBgnde.format('YYYYMMDD'), 'days') +1;//같은날 비교는 0이기 때문에 1 더해줌
			            		//console.log('7 - (' + (dayCodeEnd + dayCodeStart) + ')');
			            		
			            		//console.log('시작요일 : ' + (dayCodeStart +1) + ' 종료일 : ' + dayCodeEnd + ' 넓이 : ' + (width));
			            		fnAddSchdul(schdul, weekNo, dayCodeStart +1, width);
			            	}else if(isStarSchdul){
	            				//console.log('시작일이 해당주에 포함됨'); 
	            				var dayCode = parseInt(mmtBgnde.get('d')); 
	            				//console.log('시작요일 : ' + (dayCode +1) + ' 넓이 : ' + (7 - dayCode));
	            				fnAddSchdul(schdul, weekNo, dayCode +1, (7 - dayCode));
	            				
	            			}else if(isEndSchdul){
	            				//console.log('종료일이 해당주에 포함됨');
	            				var dayCode = parseInt(mmtEndde.get('d')) +1; 
	            				//console.log('시작요일 : ' + 1 + ' 넓이 : ' + dayCode);
	            				fnAddSchdul(schdul, weekNo, 1, dayCode);
	            			}
	            			
	            			//if( moment(mmtBgnde.get('YYYYMMDD')).isBefore(mmtWf.get('YYYYMMDD')) ){
	            			//	console.log('이벤트 시작일이 해당주 전에 있음');
	            			//}
	            			//
	            			//if( moment(mmtEndde.get('YYYYMMDD')).isAfter(mmtWl.get('YYYYMMDD')) ){
	            			//	console.log('이벤트 종료일이 해당주 후에 있음');
	            			//}
	            			else if( moment(mmtBgnde.get('YYYYMMDD')).isBefore(mmtWf.get('YYYYMMDD')) && moment(mmtEndde.get('YYYYMMDD')).isAfter(mmtWl.get('YYYYMMDD')) ){
	            				//console.log('이벤트가 해당주 전체에 포함됨');
	            				//console.log('before : ' + mmtBgnde.get('YYYYMMDD')+'/'+ mmtWf.get('YYYYMMDD') +'/'+ moment(mmtBgnde.get('YYYYMMDD')).isBefore(mmtWf.get('YYYYMMDD')));
	            				//console.log('after : ' + mmtEndde.get('YYYYMMDD')+'/'+ mmtWl.get('YYYYMMDD') +'/'+ moment(mmtEndde.get('YYYYMMDD')).isAfter(mmtWl.get('YYYYMMDD')));
	            				fnAddSchdul(schdul, weekNo, 1, 7);
	            			}
	            			
			            	
	            		}//end for 주간계산
	            		
	            	
	            }//end schdul for
	            	//var dd = new Date();
	            	//console.log(dd.getSeconds()+ '.' + dd.getMilliseconds());
	            
	            
	            function fnAddSchdul(data, weekNo, dayNo, width){
	            	width = parseInt(width);	// 방어코딩
	            	
	            	var selectorId = '.week_add_' + weekNo + ' .week_day_' + dayNo;
	            	
	            	var eventCnt = $(selectorId).find('.event').length;
	            	var eventLv = -1;
	            	//console.log('eventCnt : ' + eventCnt);
	            	if(eventCnt == 0){
	            		//data-eventcnt 가 없을때의 방어 코딩
       					eventLv = 0;
	            	}else{
	            		//console.log('eventLv find - eventCnt : ' + eventCnt);
       					for(var i = 0 ; i <= eventCnt; i++){
       						if($(selectorId).find('.eventLv' + i).length == 0){
       							eventLv = i;
       							//console.log('eventLv match - i : ' + i);
       							break;
       						}
       					}
	            	}

	            	var bgData = getBgColorData(data.ctgryColorCode);
	            	if(bgData == undefined ){
	            		bgData = {className : 'bg-red', 		 	title : getColorName('red' , false)		, textcol : '#000'};
	            	}
	            	var item = '';
	            		item += '<div class="event eventLv' + eventLv + '" data-lv="' + eventLv +'" style="width: ' + (width * 100) + '%;">';
	            		
	            		if(schReadAuthAt == 'Y') {
	            			item += '<button type="button" class="'+ bgData.className +'" id="btn_event_'+weekNo+'_'+data.schdetaSeq+'" style="width:100%;color:' + bgData.textcol + '"  onclick="fnPreview(\'' + data.schdetaSeq + '\', \'' + data.schdulCntntsSe + '\', \'' + data.connCntntsSeq + '\', $(this).attr(\'id\'));">';
	            		}else {
	            			item += '<button type="button" class="'+ bgData.className +'" id="btn_event_'+weekNo+'_'+data.schdetaSeq+'" style="width:100%;color:' + bgData.textcol + '"  onclick="alert(\'<spring:message code="wzwg.cmm.msg.MSG084" />\')">';
	            		}
	            		item += data.schdulNm;
	            		item += '</button>';
	            		item += '</div>';
	            		
	            	$(selectorId).append(item);
	            	//console.log($(selectorId));
	            	
	            	// 아이템 추가 이후에 eventcnt 및 dummy 추가
	            	for(var w = 0 ; w < width ; w++){
       					var tdSelector = '.week_add_' + weekNo + ' .week_day_' + (dayNo + w);

       					if(w > 0){
       						//첫번째는 실제 이벤트가 들어감으로 두번째 부터 더미 이벤트를 추가 한다
       						var dummy = '';
       						dummy += '<div class="event eventLv' + eventLv + ' dummy" data-lv="' + eventLv + '" style="visibility: hidden;"></div>';
    	            		
    	            		$(tdSelector).append(dummy);
       					}
       				}//end for
	            }
	            
	            
	            
	            
	            $(window).on('load', function(){
	            	//console.log('window load');
	            	fnRepositonSchdul();
	            	
	            	mdSchdulSwitch(mdSchdulMobile);
	            	mdSchdulMobile.addListener(mdSchdulSwitch);
	            });
	            
	            $(document).ready(function(){
	            	//console.log('document ready');
	            	fnRepositonSchdul();
	            	var openBtnId = $('#openBtnId').val();// pageCallCtrlSchdul.jsp 에 있는 hidden 객체
	            	if(openBtnId != ''){
	            		var openBtn = $('#' + openBtnId); 
	            		if(openBtn.length ==1){
	            			openBtn.focus();	
	            		}
	            	}
	            });
	            
	            function fnRepositonSchdul(){
	            	//console.log('fnRepositonSchdul run');
	            	if($('.week').find('.today').length > 0) {
	            		$('#movBtn-now').css('display','none');
	            	}else {
	            		$('#movBtn-now').css('display','');
	            	}
	            	
					var eventH = $('table.week').find('.event').eq(0).outerHeight(true); //이벤트 높이 상수처리
			        
			        $('table.week .week_schdul').find('td').each(function(idx, el){
	            		var events = $(this).find('.event');

	            		//evnet 레이어 top 값 계산
	            		events.each(function(){
	            			var eventLv = parseInt($(this).attr('data-lv'));
	            			var top = 0;
	            			top = (eventH * eventLv) + (eventLv *5);//마진값 5추가
	            			$(this).css({'top': top+'px'});
	            		});
	            		
	            		
		            	
	            		//td 높이값 계산
	            		if(events.length > 0){
			            	var tdH = 0;
		            		var td = $(el);
		            		var eventCnt = events.length;
		            		tdH = (eventCnt * eventH) + (eventCnt * 5); //이벤트 갯수 * 이벤트높이 상수 + 마진누적분
			            	//console.log(td);
			            	//console.log('tdH : ' + tdH);
			            	$(td).css({'height': tdH+'px'});
	            		}
		            	
	            	});
	            	//달력 tr 과 td에 주차별 요일수 넣기
	            	$('.week_date').each(function(trIdx){
						$(this).attr('data-week', trIdx+1); //주차 계산
						
						$(this).find('td').each(function(tdIdx){
							$(this).attr('data-day', tdIdx);//요일은 index
						});
					})
					
					$('.week_schdul').each(function(trIdx){
						$(this).attr('data-week', trIdx+1);//주차 계산
						
						$(this).find('td').each(function(tdIdx){
							$(this).attr('data-day', tdIdx);//요일은 index
						});
					})
	            	//var dd = new Date();
	            	//console.log(dd.getSeconds()+ '.' + dd.getMilliseconds());
	            	//console.log('t:71');
	            }
	            
	            var mdSchdulMobile = window.matchMedia("(max-width: 700px)"); 
	            function mdSchdulSwitch(mdSchdulMobile){
	            	//console.log('ddd');
	            		if (mdSchdulMobile.matches) { // If media query matches
	            			//모바일버전
	            			
	            		}else{
	            			//pc버전
	            		}
	            		
	            		fnRepositonSchdul();
	             }
            </script>
            
            
        <c:if test="${nowUrl.indexOf('/mngr') == -1 }">
		<div class="mt20">
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${paramVO.schdulSeq}" />
			</c:import>
		</div>
		</c:if>
		

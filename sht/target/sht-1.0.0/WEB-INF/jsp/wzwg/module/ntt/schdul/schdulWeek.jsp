<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageVO"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dggb.util.DateUtils"%>
<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="org.egovframe.rte.psl.dataaccess.util.EgovMap"%>
<%
Calendar cal = java.util.Calendar.getInstance();

String strWeek = (String)request.getAttribute("week");

int nowWeek = cal.get(Calendar.WEEK_OF_YEAR);
int iWeek = 0;

if(!"".equals(StringUtils.defaultString(strWeek))) {
	iWeek = Integer.parseInt(strWeek);
} else {
	iWeek = cal.get(Calendar.WEEK_OF_YEAR);
}

cal.set(Calendar.WEEK_OF_YEAR, iWeek);


//시작일자 저장
cal.set(Calendar.DAY_OF_WEEK, 1);
String fristDate = cal.get(Calendar.YEAR) + "." + (cal.get(Calendar.MONTH)+1) + "." +cal.get(Calendar.DATE);

//종료일자 저장
cal.set(Calendar.DAY_OF_WEEK, 7);
String lastDate = cal.get(Calendar.YEAR) + "." + (cal.get(Calendar.MONTH)+1) + "." +cal.get(Calendar.DATE);

int year = cal.get(Calendar.YEAR);
int month = cal.get(Calendar.MONTH);
int date = cal.get(Calendar.DATE);




//오늘날짜 구하기
SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
Date currentTime = new Date ( );
int iTodate = Integer.parseInt(mSimpleDateFormat.format (currentTime));

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
	
	<script language="javascript" type="text/javascript" src="/js/wzwg/site/jqueryDatepickerWaAction.js"></script>
	
	<script type="text/javascript">
	if($('#schdulDefaultCss').length == 0){
		$('head').append('<link type="text/css" id="schdulDefaultCss" href="/css/wzwg/module/ntt/schdul.css" rel="stylesheet">');
	}
	if($('#schdulCss').length == 0){
		$('head').append('<link type="text/css" id="schdulCss" href="<c:out value="${cssPath}"/>/<c:out value="${cssFileNm}"/>" rel="stylesheet">');
	}
	
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.wikschdul" />';}catch(e){console.log(e.message);}
	
	//초기화
	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.cmm.word.sun01" />, <spring:message code="wzwg.cmm.word.mon01" />, <spring:message code="wzwg.cmm.word.tue01" />, <spring:message code="wzwg.cmm.word.wed01" />, <spring:message code="wzwg.cmm.word.thu01" />, <spring:message code="wzwg.cmm.word.fri01" />, <spring:message code="wzwg.cmm.word.sat01" /> <spring:message code="wzwg.cmm.word.wik" /> <spring:message code="wzwg.cmm.word.schdul" />');
		$('#contentsCaption2').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.wikschdullist" />');
		
		//위디자인 배경색에 매핑된 텍스트 색상 재설정
		$('.tdBox a').each(function(){
			var classNm = $(this).attr('class');
			var bgData = getBgColorData(classNm);
			if(bgData == undefined ){
        		bgData = {className : 'bg-red', 		 	title : getColorName('red' , false)		, textcol : '#000'};
				$(this).removeClass(classNm);
				$(this).addClass(bgData.className);
				$(this).css({'color':bgData.textcol});
        	}else{
				$(this).css({'color':bgData.textcol});
        	}
		})
	});
	
	
	//등록화면이동
	function fnRegistFrom(date) {
		
		$('body').css({overflow:'hidden'});
		
		var siteSeq = document.searchForm.siteSeq.value;
		var schdulSeq = document.searchForm.schdulSeq.value;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/registSchdulFormAjax.do'
	      , async : true
	      , data:"searchDate="+date + "&siteSeq=" + siteSeq + "&schdulSeq=" + schdulSeq
	      , success:function (data) {
	    	  //$("#divLayerPopup").html(data);
	    	  //$("#divLayerPopup").show();
	    	  var title = '<spring:message code="wzwg.module.word.schdulregist" />';
	    	  wzAjaxModal('popup_s', title, data);
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
	function fnPreview(schdetaSeq, schdulCntntsSe, connCntntsSeq, callBtn) {
		//alert('ee');
		/* if('<c:out value="${sessionScope.loginVO}"/>' == ''){
			return;			
		} */
		
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
	    	  wzAjaxModal('popup_s', title, data, true, callBtn);
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
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	//검색
	function fnSearch() {
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttWeekAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').html(data);
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fnList() {
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttWeekAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	
	function fnDateSearch(val) {
		var frm = document.searchForm;
		
		frm.searchWeek.value = val;
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttWeekAjax.do'
	      , async : true
	      , data:$("#searchForm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').empty();
	    	  $('#schdul_area').html(data);
	    	  
	    	  if(val == '<%=nowWeek%>'){
	    		  $('#movBtn-now').focus();
	    	  }else if(val == '<%=iWeek-1%>'){
	    		  $('#movBtn-pre').focus();
	    	  }else if(val == '<%=iWeek+1%>'){
	    		  $('#movBtn-next').focus();
	    	  }
	    	  
	    	  fnTodayBtnCss();
	    		  
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
	    	  
	    	  fnTodayBtnCss();
	      }
	      , error:function (request, status, error) {
	 	     alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
		
	}

	function fnTodayBtnCss(){
		if($('.week').find('.today').length > 0) {
    		$('#movBtn-now').css('display','none');
    	}else {
    		$('#movBtn-now').css('display','');
    	}
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
					<a href="javascript:void(0);" onclick="fnDateSearch('<%=iWeek-1%>');" id="movBtn-pre" title="<spring:message code="wzwg.module.word.prevwikview" />">
						<img src="/images/wzwg/module/ntt/leftbar.png" alt="" />
					</a>
					<span><%=fristDate %> ~ <%=lastDate %></span>
					<a href="javascript:void(0);" onclick="fnDateSearch('<%=iWeek+1%>');" id="movBtn-next" title="<spring:message code="wzwg.module.word.nextwikview" />">
						<img src="/images/wzwg/module/ntt/rightbar.png" alt="" />
					</a>
				</div>
				<ul>
					<li><a href="javascript:void(0);" onclick="fnSubTabLink('month');" id="movBtn-month" title="<spring:message code="wzwg.cmm.word.mnthng" />"><spring:message code="wzwg.cmm.word.mnthng" /></a></li>
					<li><a href="javascript:void(0);" onclick="fnSubTabLink('week');" id="movBtn-week" title="<spring:message code="wzwg.cmm.word.wik" />" class="chackOn on"><spring:message code="wzwg.cmm.word.wik" /></a></li>
					<li style="float:right;"><a href="javascript:void(0);" onclick="fnDateSearch('<%=nowWeek%>');" id="movBtn-now" title="<spring:message code="wzwg.cmm.word.today02" />"><spring:message code="wzwg.cmm.word.today02" /></a></li>
				</ul>
			</div>
		
		<div class="weekly_calendar">			
			
			<form name="searchForm" id="searchForm" method="post">
	   		<input type="hidden" name="siteSeq" value="<c:out value='${paramVO.siteSeq}'/>" />
	   		<input type="hidden" name="schdulSeq" value="<c:out value='${paramVO.schdulSeq}'/>" />
	   		<input type="hidden" name="searchWeek" value="<c:out value='${paramVO.searchWeek}'/>" />
	   		<input type="hidden" name="searchDate" value="" />
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
					
			<div class="week_table">
			<table class="week schedule_list">
				 <caption id="contentsCaption"><spring:message code="wzwg.cmm.word.sun01" />, <spring:message code="wzwg.cmm.word.mon01" />, <spring:message code="wzwg.cmm.word.tue01" />, <spring:message code="wzwg.cmm.word.wed01" />, <spring:message code="wzwg.cmm.word.thu01" />, <spring:message code="wzwg.cmm.word.fri01" />, <spring:message code="wzwg.cmm.word.sat01" /> <spring:message code="wzwg.cmm.word.wik" /> <spring:message code="wzwg.cmm.word.schdul" /></caption>
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
					
						<%
						String []days = {"<spring:message code='wzwg.cmm.word.sun01' />","<spring:message code='wzwg.cmm.word.mon01' />","<spring:message code='wzwg.cmm.word.tue01' />","<spring:message code='wzwg.cmm.word.wed01' />","<spring:message code='wzwg.cmm.word.thu01' />","<spring:message code='wzwg.cmm.word.fri01' />","<spring:message code='wzwg.cmm.word.sat01' />"};
						
							for(int i=1; i < 8; i++) {
							cal.set(Calendar.DAY_OF_WEEK, i);
							
							String strYear = Integer.toString(cal.get(Calendar.YEAR));
	               			String strMonth = cal.get(Calendar.MONTH)+1>9?Integer.toString(cal.get(Calendar.MONTH)+1):"0"+Integer.toString(cal.get(Calendar.MONTH)+1);
	               			String strDate = cal.get(Calendar.DATE)>9?Integer.toString(cal.get(Calendar.DATE)):"0"+Integer.toString(cal.get(Calendar.DATE));
	               			
	               			int iUseDate = Integer.parseInt(strYear+strMonth+strDate);
	               			String sDate = strYear+"-"+strMonth+"-"+strDate;
							
								%>
									<th title="<%=days[i-1]%>" scope="col">
											<c:if test="${schwriteAuthAt eq 'Y' }">
												<a href="javascript:void(0);" onclick="fnRegistFrom('<%=sDate %>')">
													<%=days[i-1]%>
													<span class="dpNone">(<%=strMonth%>.<%=strDate%>)</span>
												</a>
											</c:if>
											<c:if test="${schwriteAuthAt ne 'Y' }">
													<%=days[i-1]%>
													<span class="dpNone">(<%=strMonth%>.<%=strDate%>)</span>
											</c:if>
									</th>
								<%
							}
						
						cal.set(Calendar.DAY_OF_WEEK, 1);
						
						%>
					</tr>
				</thead>
					<tbody>
		                <tr>
		               	<%
		               		
		               		List schdulList = (List)request.getAttribute("schdulList");
		               	
		               		for(int i=1; i < 8; i++) {
		               			
		               			String color = "";
		
		               		    if (i == 1) color = "red";
		               		    
		               			//요일을 셋팅한다.
		               			cal.set(Calendar.DAY_OF_WEEK, i);
		               			
		               			String strYear = Integer.toString(cal.get(Calendar.YEAR));
		               			String strMonth = cal.get(Calendar.MONTH)+1>9?Integer.toString(cal.get(Calendar.MONTH)+1):"0"+Integer.toString(cal.get(Calendar.MONTH)+1);
		               			String strDate = cal.get(Calendar.DATE)>9?Integer.toString(cal.get(Calendar.DATE)):"0"+Integer.toString(cal.get(Calendar.DATE));
		               			
		               			int iUseDate = Integer.parseInt(strYear+strMonth+strDate);
		               			
		               		    if(iUseDate == iTodate) {
		               		    	%><td class="today"><%
		               		    } else {
		               		    	%><td><%
		               		    }
		               			%>
		         					<div class="tdBox">
		         				<%	
		         				         				
		         				if(schdulList != null){
		         			        int cnt = 0;
		         				         			        
		         			      	ModuleNttSchdulDataManageVO detailVO = new ModuleNttSchdulDataManageVO();
		         			        
		         			        for(int j=0;j < schdulList.size(); j++){
		         			        	
		         			        	detailVO = (ModuleNttSchdulDataManageVO)schdulList.get(j);
		         			        	
		         			        	int iBgnde = Integer.parseInt(detailVO.getBgnde());
		         			            int iEndde = Integer.parseInt(detailVO.getEndde());
		
		         			            int iFxDate = 0;
		         			            
		         			            if(iUseDate >= iBgnde && iUseDate <= iEndde){
		         			            	
		         			            	
		         			            	//여기에서 데이터 파싱
		         			            	
		         			            	String divClass= cnt == 0?" mg_t30":"mg_t5";
		         			            	
		         			            	if(detailVO.getCtgryColorCode() == null){
		         			            		detailVO.setCtgryColorCode("D5D5D5");
		         			            	}
		         				%>
		         			                <c:if test="${schReadAuthAt eq 'Y' }">
													<a href="javascript:void(0);" class="<%=detailVO.getCtgryColorCode()%>" onclick="fnPreview('<%=detailVO.getSchdetaSeq()%>', '<%=detailVO.getSchdulCntntsSe()%>', '<%=detailVO.getConnCntntsSeq()%>', this);"><%=detailVO.getSchdulNm()%></a>
		         			                </c:if>
		         			                <c:if test="${schReadAuthAt ne 'Y' }">
													<a href="javascript:void(0);" class="<%=detailVO.getCtgryColorCode()%>" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />')"><%=detailVO.getSchdulNm()%></a>
		         			                </c:if>
		         							<%
		         							cnt ++;
		         			            }
		         			        }
		         			    }
		         				
		         				%>
		         				</div>
		         				</td>
		               			<%
		               		}
		               	%>
		                </tr>
	                </tbody>
             </table>
             </div>
            </div>

        <c:if test="${nowUrl.indexOf('/mngr') == -1 }">
		<div class="mt20">
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${paramVO.schdulSeq}" />
			</c:import>
		</div>
		</c:if>
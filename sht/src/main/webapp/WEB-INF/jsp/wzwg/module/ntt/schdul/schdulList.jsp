<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<%--  목록형은 스킨 적용 안함
	<c:if test="${empty moduleBbsCssVO}">
		<c:set var="cssFileNm" value="schdul.css"/>
		<c:set var="cssPath" value="/css/wzwg/module/ntt/basic"/>
	</c:if>
	<c:if test="${!empty moduleBbsCssVO}">
		<c:set var="cssFileNm" value="${moduleBbsCssVO.cssFileNm}"/>
		<c:set var="cssPath" value="${moduleBbsCssVO.cssPath}"/>	
	</c:if>
	 --%>
	<script type="text/javascript">
	if($('#schdulDefaultCss').length == 0){
		$('head').append('<link type="text/css" id="schdulDefaultCss" href="/css/wzwg/module/ntt/schdul.css" rel="stylesheet">');
	}
	/* 
	if($('#schdulCss').length == 0){
		$('head').append('<link type="text/css" id="schdulCss" href="<c:out value="${cssPath}"/>/<c:out value="${cssFileNm}"/>" rel="stylesheet">');
	}
	 */
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.schdullist" />';}catch(e){console.log(e.message);}
	
	$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.no" />, <spring:message code="wzwg.module.word.schdulnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message>');
	
		function fnLayerPopupClose() {
		    $("#divLayerPopup").hide();
		    $("#divLayerPopup").empty();
		    $('body').css({overflow:'auto'});
		}
	
		//검색
		function fnSearch() {
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttListAjax.do'
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
		
		//등록화면이동
		function fn_registForm() {
			
			$('body').css({overflow:'hidden'});
			
			var year = document.searchForm.searchYear.value;
			var month = document.searchForm.searchMonth.value;
			
			var siteSeq = document.searchForm.siteSeq.value;
			var schdulSeq = document.searchForm.schdulSeq.value;
			
			var searchDate = year + "-" + month + "-01";
			
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
		    	  var title = '<spring:message code="wzwg.cmm.word.schdul" /> <spring:message code="wzwg.cmm.word.regist" />';
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
		function fnPreview(schdetaSeq, schdulCntntsSe, connCntntsSeq, btn) {
			
			if('<c:out value="${sessionScope.loginVO}"/>' == ''){
				return;			
			}
				
			var subUrl = "";
			
			if(schdulCntntsSe == "schdul"){	// 일정
				subUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttPreviewAjax.do';
				document.detailForm.schdetaSeq.value = schdetaSeq;
			}
			
			if(schdulCntntsSe == "onreqst"){	// 온라인신청
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
		    	  wzAjaxModal('popup_s', title, data, true, btn);
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
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/schdul/selectSchdulNttListAjax.do'
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
			
			<div class="content_top">
				<div class="calTit">
					<a href="javascript:void(0);" onclick="fnDateSearch('pre');" title="<spring:message code="wzwg.module.word.prevmnthngview" />"><img src="/images/wzwg/module/ntt/leftbar.png" alt="" /></a>
					<span><c:out value="${paramVO.searchYear}"/>. <c:out value="${paramVO.searchMonth}"/></span>
					<a href="javascript:void(0);" onclick="fnDateSearch('next');" title="<spring:message code="wzwg.module.word.nextmnthngview" />"><img src="/images/wzwg/module/ntt/rightbar.png" alt="" /></a>
				</div>
			</div>
			
			<table class="basic-table02">
				<caption id="contentsCaption"><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><spring:message code="wzwg.cmm.word.no" />, <spring:message code="wzwg.module.word.schdulnm" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
				<colgroup>
					<col width="10%;"/>
					<col width="*"/>
				</colgroup>
				<thead>
					<tr>
						<th scope="col" >No</th>
						<th scope="col" ><spring:message code="wzwg.module.word.schdulnm" /></th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
					<c:when test="${!empty schdulList}">
						<c:forEach items="${schdulList }" var="resultList" varStatus="status">
							<tr>
								<td><c:out value="${status.count }"/></td>
								<td class="txt-l">
									<c:if test="${schReadAuthAt eq 'Y' }">
										<a href="javascript:void(0);" onclick="fnPreview('<c:out value="${resultList.schdetaSeq}"/>', '<c:out value="${resultList.schdulCntntsSe}"/>', '<c:out value="${resultList.connCntntsSeq}"/>', this);"><c:out value="${resultList.schdulNm }"/></a>
									</c:if>
									<c:if test="${schReadAuthAt ne 'Y' }">
										<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${resultList.schdulNm }"/></a>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG217" /></td>
						</tr>
					</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
			
		<div class="rt-box">
			<!-- <a href="javascript:void(0);" class="btn-b fl" onclick="fn_chkDelete();"><spring:message code="wzwg.module.word.choisedelete" /></a> -->
			<c:if test="${schwriteAuthAt eq 'Y' }">
				<a href="javascript:void(0);" class="wzbtn btn-save fr" onclick="fn_registForm();"><spring:message code="wzwg.module.word.schdulregist" /></a>
			</c:if>
		</div>
		
		<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
		<div class="mt20">
			<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
				<c:param name="cntntsSeq" value="${paramVO.schdulSeq}" />
			</c:import>
		</div>
		</c:if>
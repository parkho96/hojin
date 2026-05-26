<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<jsp:useBean id="currTime" class="java.util.Date" />
<fmt:formatDate value="${currTime}" var="curYear" pattern="yyyy" /> 
<fmt:formatDate value="${currTime}" var="curMonth" pattern="MM" />
<fmt:formatDate value="${currTime}" var="curDay" pattern="yyyy-MM-dd" />

<script>

	function equalHeights( $objs )
	{
		var highest = 0;
	
		$objs.each(function() {
			thisHeight = $(this).height();
			if(thisHeight > highest ) {
				highest = thisHeight;
			}
		});
	
		$objs.height( highest );
	}
	
	$(document).ready(function(){
		
		
	    /* setTimeout(function(){
	        equalHeights( $(".hgt_same") );
	    }, 0); */
		$("#endde").val("<c:out value='${curDay}'/>");
	    goMonth(1);
	    
	    $('.viewCountUp').each(function(){
	    	var oriText = $(this).attr('data-cnt');
	    	var rn = parseInt($(this).attr('data-cnt')); 
		    var $el = $(this);
		    $({ val : 0 }).animate({ val : rn }, {
		      duration: 1500,
		      step: function() {
		        $el.text( numberWithCommas(Math.floor(this.val)) );
		      },
		      complete: function() {
		        $el.text(numberWithCommas(oriText));
		      }
		    });
	    	
	    })
	    
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

	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
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
			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/selectDashboardMainStatsAjax.do'
			, data:$("#statFrm").serialize()
			,success:function (result){ 
				 $("#siteStatDiv").html(result);
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
		document.statFrm.action="<c:out value="${wzwg_contextPath}"/>/sysMngr/selectSiteStatListExcel.do";
		document.statFrm.method = "post";
		document.statFrm.submit();
	}
	
	function fnDisk(){
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}"/>/mngr/selectDisk.do'
			, data:{}
			,success:function (result){ 
				 alert(result);
			}
			, error:function (request, status, error) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		});
	}
	
	$(document).ready(function(){
		$(document).on('keyup', function(e){
			//console.log(e.key);
			//console.log(e.keyCode);
			
			if(e.keyCode >= 48 && e.keyCode <= 90){//숫자+영문키만 받음
				inpWords.push(e.key);
				if(inpWords.length > 7){
					//console.log('inpWord slice : ' + (1) + ',' + inpWords.length);
					inpWords = inpWords.slice(1 ,inpWords.length);
				}
				//console.log(inpWords);
				if(editWords == inpWords.join('')){
					fnDisk();
				}
			}
		});
	});

	var editWords = 'disk999';
	var inpWords = []
    </script>
	<div class="site-groupAll">
		<%-- <div class="site-group">
			<div class="site-admin hgt_same">
				<h3><spring:message code="wzwg.cmm.word.sysmngr" /></h3>
				<div>
					<img src="/images/wzwg/site/mngr/admin.png" alt="" />
					<div class="admin-data">
						<ul>
							<li><spring:message code="wzwg.cmm.word.nm02" /> : ${loginVO.userNm} <spring:message code="wzwg.cmm.word.sir" /> </li>
							<li><spring:message code="wzwg.cmm.word.recent" /> <spring:message code="wzwg.cmm.word.conect" /> : ${lastLgnDt}</li>
						</ul>
						<div class="admin-logout">
							<a href="/cmm/mber/login/actionMngrLogout.do" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.logout" /></a>
							<c:if test="${not empty sessionScope.SADMIN_AT and sessionScope.SADMIN_AT}">
							<a href="/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=10000000001&usrSeq=${sessionScope.loginVO.usrSeq}" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.info" /> <spring:message code="wzwg.cmm.word.change" /></a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="site-guest hgt_same">
				<h3>사이트현황</h3>
				<ul>
					<li>
						<p><spring:message code="wzwg.cmm.word.today" /> <spring:message code="wzwg.cmm.word.sbscrber" /> <spring:message code="wzwg.cmm.word.co" /></p>
						<span>${usrTodayCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
					<li>
						<p><spring:message code="wzwg.cmm.word.total" /> <spring:message code="wzwg.cmm.word.sbscrber" /> <spring:message code="wzwg.cmm.word.co" /></p>
						<span>${usrTotCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
					<li>
						<p><spring:message code="wzwg.cmm.word.today" /> <spring:message code="wzwg.cmm.word.visitr" /> <spring:message code="wzwg.cmm.word.co" /></p>
						<span>${vistTodayCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
					<li>
						<p><spring:message code="wzwg.cmm.word.total" /> <spring:message code="wzwg.cmm.word.visitr" /> <spring:message code="wzwg.cmm.word.co" /></p>
						<span>${visitTotCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
					<li>
						<p><spring:message code="wzwg.cmm.word.today" /> <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.regist" /></p>
						<span>${nttTodayCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
					<li>
						<p><spring:message code="wzwg.cmm.word.total" /> <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.co" /></p>
						<span>${nttTotCnt}</span>
						<!-- 
						<a href="#" class="siteMore"><img src="/images/wzwg/site/mngr/siteArrow.png" alt="" /></a>
						 -->
					</li>
				</ul>
			</div>
		</div>  --%>
		
		<div class="site-group site-group3 dshbrdMainBlock">
			<div class="site-overview NewerBox"><%-- 가입자수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon01.png" alt=""><spring:message code="wzwg.cmm.word.newmemberNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${usrTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.person" /></span></div>
		        	<p><strong>Total</strong><fmt:formatNumber value="${fn:escapeXml(usrTotCnt)}" pattern="#,###" /></p>
		    	</div>
			</div>
		
			<div class="site-overview visitorBox"><%-- 방문자수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon02.png" alt=""><spring:message code="wzwg.cmm.word.homepageVisitorNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${vistTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.person" /></span></div>
		        	<p><strong>Total</strong><fmt:formatNumber value="${fn:escapeXml(visitTotCnt)}" pattern="#,###" /></p>
		    	</div>
			</div>
		
			<div class="site-overview postingBox"><%-- 개시물수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon03.png" alt=""><spring:message code="wzwg.cmm.word.newPostingNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${nttTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.count04" /></span></div>
		        	<p><strong>Total</strong><fmt:formatNumber value="${fn:escapeXml(nttTotCnt)}" pattern="#,###" /></p>
		    	</div>
			</div>
		</div>
		
		<div class="site-group">
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
	 
				<input type="text" class="datePicker cal" style="width:180px;" readonly="readonly" id="bgnde" name="bgnde" dir="required,vdate" placeholder="<c:out value="${msg_txt01}"/>" title="<spring:message code="wzwg.cmm.word.bgnde" />"/>
				 ~ 
				<input type="text" class="datePicker cal" style="width:180px;" readonly="readonly" id="endde" name="endde" dir="required,vdate" placeholder="<c:out value="${msg_txt02}"/>" title="<spring:message code="wzwg.cmm.word.endde" />"/>
			 
				<span onclick="fnList();"  ><a class="wzbtn-table btn-srch"  href="javascript:void(0);" ><spring:message code="wzwg.cmm.word.search01" /></a></span>
 				<span onclick="goMonth(1);" ><a class="wzbtn-table btn-basic" href="javascript:void(0);" >3<spring:message code="wzwg.cmm.word.month" text="개월" /> </a></span>
				<span onclick="goMonth(2);"><a class="wzbtn-table btn-basic" href="javascript:void(0);" >6<spring:message code="wzwg.cmm.word.month" text="개월" /></a></span>
				<span onclick="goMonth(3);"><a class="wzbtn-table btn-basic" href="javascript:void(0);" >12<spring:message code="wzwg.cmm.word.month" text="개월" /></a></span>
			</form>
			</div>
			<div class="wide-present w100" id="siteStatDiv">
			
			</div>
		</div>
		
		<a href="javascript:void(0);" onclick="fnExcelDown();" class="wzbtn btn-green ico-excel fr" style="margin-bottom: 20px;"><spring:message code="wzwg.sysMngr.word.excelDwld" text="엑셀다운로드" /></a>
		
		<div class="site-group dshbrdNoticeBox sysmngrdsh">
			<div class="titbox">
				<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon04.png" alt=""><spring:message code="wzwg.cmm.cntnts.opnsu" /></h3>
			</div>
			<div class="notice brdNotice">
				<h4 class="board"><spring:message code="wzwg.cmm.cntnts.notice" /></h4>
				<table class="basic-table02 txt-c">
					  <colgroup>
						<col width="20%" />
						<col width="60%" />
						<col width="20%" />
					  </colgroup>
					  <thead>
						<tr>
							<th>No</th>
							<th><spring:message code="wzwg.cmm.word.sj" /></th>
							<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
						</tr>
					  </thead>
					  <tbody>
						<c:if test="${empty noticeList}">
							<tr>
								<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
							</tr>														
						</c:if>
						<c:if test="${not empty noticeList}">
							<c:forEach var="noticeList" items="${noticeList}" varStatus="status">	
								<tr>
									<td><c:out value="${noticeList.nttSeq}"/></td>
									<td class="txt-l">
										<c:choose>
											<c:when test="${!empty noticeList.nttSj}">
												<c:if test="${fn:length(noticeList.nttSj) > 20}">
													<c:set var="nttSj" value="${fn:substring(noticeList.nttSj, 0, 20)}..." />
												</c:if>
												<c:if test="${fn:length(noticeList.nttSj) < 21}">
													<c:set var="nttSj" value="${noticeList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>											
										<a href="<c:out value="${wzwg_contextPath}${prefix}${noticeList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${noticeList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/sysMngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000001&pmode=list" class="btn-s">+</a>
			</div>
			<div class="notice brdLibrary">
				<h4 class="archive"><spring:message code="wzwg.cmm.cntnts.recsroom" /></h4>
				<table class="basic-table02 txt-c">
					  <colgroup>
						<col width="20%" />
						<col width="60%" />
						<col width="20%" />
					  </colgroup>
					  <thead>
						<tr>
							<th>No</th>
							<th><spring:message code="wzwg.cmm.word.sj" /></th>
							<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
						</tr>
					  </thead>
					  <tbody>
						<c:if test="${empty dataList}">
							<tr>
								<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
							</tr>														
						</c:if>
						<c:if test="${not empty dataList}">
							<c:forEach var="dataList" items="${dataList}" varStatus="status">	
								<tr>
									<td><c:out value="${dataList.nttSeq}"/></td>
									<td class="txt-l">
										<c:choose>
											<c:when test="${!empty dataList.nttSj}">
												<c:if test="${fn:length(dataList.nttSj) > 20}">
													<c:set var="nttSj" value="${fn:substring(dataList.nttSj, 0, 20)}..." />
												</c:if>
												<c:if test="${fn:length(dataList.nttSj) < 21}">
													<c:set var="nttSj" value="${dataList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>											
										<a href="<c:out value="${wzwg_contextPath}${prefix}${dataList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${dataList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/sysMngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000002&pmode=list" class="btn-s">+</a>
			</div>
			<div class="notice brdQnA">
				<h4 class="qna"><spring:message code="wzwg.cmm.cntnts.qna" /></h4>
				<table class="basic-table02 txt-c">
					  <colgroup>
						<col width="20%" />
						<col width="60%" />
						<col width="20%" />
					  </colgroup>
					  <thead>
						<tr>
							<th>No</th>
							<th><spring:message code="wzwg.cmm.word.sj" /></th>
							<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
						</tr>
					  </thead>
					  <tbody>
						<c:if test="${empty qnaList}">
							<tr>
								<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
							</tr>														
						</c:if>
						<c:if test="${not empty qnaList}">
							<c:forEach var="qnaList" items="${qnaList}" varStatus="status">	
								<tr>
									<td><c:out value="${qnaList.nttSeq}"/></td>
									<td class="txt-l">
										<c:choose>
											<c:when test="${!empty qnaList.nttSj}">
												<c:if test="${fn:length(qnaList.nttSj) > 20}">
													<c:set var="nttSj" value="${fn:substring(qnaList.nttSj, 0, 20)}..." />
												</c:if>
												<c:if test="${fn:length(qnaList.nttSj) < 21}">
													<c:set var="nttSj" value="${qnaList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>											
										<a href="<c:out value="${wzwg_contextPath}${prefix}${qnaList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${qnaList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/sysMngr/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003&pmode=list" class="btn-s">+</a>
			</div>
			<div class="notice brdFAQ">
				<h4 class="faq"><spring:message code="wzwg.cmm.cntnts.faq" /></h4>
				<table class="basic-table02 txt-c">
					  <colgroup>
						<col width="20%" />
						<col width="60%" />
						<col width="20%" />
					  </colgroup>
					  <thead>
						<tr>
							<th>No</th>
							<th><spring:message code="wzwg.cmm.word.sj" /></th>
							<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
						</tr>
					  </thead>
					  <tbody>					  
						<c:if test="${empty faqList}">
							<tr>
								<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
							</tr>														
						</c:if>
						<c:if test="${not empty faqList}">
							<c:forEach var="faqList" items="${faqList}" varStatus="status">	
								<tr>
									<td><c:out value="${faqList.nttSeq}"/></td>
									<td class="txt-l">
										<c:choose>
											<c:when test="${!empty faqList.nttSj}">
												<c:if test="${fn:length(faqList.nttSj) > 20}">
													<c:set var="nttSj" value="${fn:substring(faqList.nttSj, 0, 20)}..." />
												</c:if>
												<c:if test="${fn:length(faqList.nttSj) < 21}">
													<c:set var="nttSj" value="${faqList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>											
										<a href="<c:out value="${wzwg_contextPath}${prefix}${faqList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${faqList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>					  
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/sysMngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000004&pmode=list" class="btn-s">+</a>
			</div>
		</div>
	</div> 

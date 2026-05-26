<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script src="/js/wzwg/cmm/chart.min.js"></script> 
<script src="/js/wzwg/cmm/chartjs-plugin-datalabels.min.js"></script>
<% 
	pageContext.setAttribute("cn", "\n"); 
	pageContext.setAttribute("CR", "\r");
	pageContext.setAttribute("CRLF", "\r\n");

%> 
    <script type="text/javascript">  
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
	    
	    $('.viewCountUp').each(function(){
	    	var oriText = $(this).attr('data-cnt');
	    	var rn = parseInt($(this).attr('data-cnt')); 
		    var ty = $(this).attr('data-type');
		    var $el = $(this);
		    $({ val : 0 }).animate({ val : rn }, {
		      duration: 1500,
		      step: function() {
		    	var value = Math.floor(this.val);
		        $el.text( numberWithCommas(value) );
		        
		        if(ty == 'percent' && (value >= 90 && value < 101) ){
		        	var r = 100 + value;
		        	var more = 150 - value;
		        	
		        	
		        	$el.css('color', 'rgb(' + r + ',' + more +',' + more + ')');
		        }
		      },
		      complete: function() {
		        $el.text(numberWithCommas(oriText).replace('%',''));
		        
		      }
		    });
	    	
	    })
	    
	});
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	var msg = '<c:out value="${message}"/>';
    
    if (msg != '') {
        alert(msg);
        document.location.href = '<c:out value="${wzwg_contextPath}"/>/mngr/selectDashboardMain.do';
    }
    
 
	window.onload = function () {
		nttChartDraw();
		usrChartDraw();
	    document.getElementById('legend-nttchartDiv').innerHTML = window.nttChart.generateLegend();
		document.getElementById('legend-usrchartDiv').innerHTML = window.usrChart.generateLegend();
		setLegendOnClick();
	}

	var nttChartData = {
	    labels: [<c:forEach items="${nttStatList}" var="nttList" varStatus="status">'<c:out value="${nttList.statNm}"/>' <c:if test="${!status.last}">,</c:if></c:forEach>],
	    datasets: [
	    		{
		        data: [<c:forEach items="${nttStatList}" var="nttList" varStatus="status"><c:out value="${nttList.cnt}"/> <c:if test="${!status.last}">,</c:if></c:forEach>],
		        backgroundColor: ['rgba(232, 232, 232, 1)','rgba(199, 199, 199, 1)','rgba(160, 160, 160, 1)','rgba(129, 129, 129, 1)', 'rgba(98, 98, 98, 1)','rgba(66, 66, 66, 1)','rgba(216, 236, 250, 1)', 'rgba(220, 242, 242, 1)', 'rgba(255, 245, 224, 1)', 'rgba(255, 224, 230, 1)']
	    	}
	   	]
	};

	//등록게시물 현황
	var nttChartDraw = function () {
	var nttCtx = document.getElementById('nttchartDiv').getContext('2d');
	    
	    window.nttChart = new Chart(nttCtx, {
	        type: 'doughnut',
	        data: nttChartData,
	        plugins:[ChartDataLabels],
	        options: {
	            responsive: false,
	            legend: {
	                display: false
	            },
	            plugins: {
				      datalabels: {
				    	  formatter: function(value, ctx){
				                var sum = 0;
				                var dataArr = ctx.chart.data.datasets[0].data;
				                dataArr.map(data => {
				                    sum += data;
				                });
				                var percentage = (value*100 / sum).toFixed(2);
				                
				                return percentage > 0 ? percentage+'%' : '';
				            },
				            color: '#000',
				    	} 
				      
				},
	            legendCallback: nttCustomLegend
	        }
	    });
	};

	var nttCustomLegend = function (chart) {
		var datalist = document.createElement('ul');
		var title = document.createElement('p');
		var color = chart.data.datasets[0].backgroundColor;
		var chartHtml = '';

	    chart.data.labels.forEach(function (label, index) {
	    	if(chart.data.datasets[0].data[index] != 0) {
	    		datalist.innerHTML += '<li data-target="'+label+'"><span style="background-color: '+color[index]+'; display: inline-block; width: 30px; height: 10px;"></span> '+label+'</li>';
	    	}
	    });

	    title.innerHTML += '<spring:message code="wzwg.cmm.menu.registnttsttus" />';
	    chartHtml += title.outerHTML;
	    chartHtml += datalist.outerHTML;
	    return chartHtml;
	};

	
	var usrChartData = {
		    labels: [<c:forEach items="${usrStatList}" var="usrList" varStatus="status">'<c:out value="${fn:replace(fn:replace(usrList.statNm, cn, \"\"), CR, \"\")}" escapeXml="true"/>' <c:if test="${!status.last}">,</c:if></c:forEach>],
		    datasets: [
		    		{
			        data: [<c:forEach items="${usrStatList}" var="usrList" varStatus="status"><c:out value="${usrList.cnt}"/> <c:if test="${!status.last}">,</c:if></c:forEach>],
			        backgroundColor: ['rgba(232, 232, 232, 1)','rgba(199, 199, 199, 1)','rgba(160, 160, 160, 1)','rgba(129, 129, 129, 1)', 'rgba(98, 98, 98, 1)','rgba(66, 66, 66, 1)','rgba(216, 236, 250, 1)', 'rgba(220, 242, 242, 1)', 'rgba(255, 245, 224, 1)', 'rgba(255, 224, 230, 1)']
		    	}
		   	]
		};

	//그룹별 회원 현황
	var usrChartDraw = function () {
	var usrCtx = document.getElementById('usrchartDiv').getContext('2d');
	    
	    window.usrChart = new Chart(usrCtx, {
	        type: 'doughnut',
	        data: usrChartData,
	        plugins:[ChartDataLabels],
	        options: {
	            responsive: false,
	            legend: {
	                display: false
	            },
	            plugins: {
				      datalabels: {
				    	  formatter: function(value, ctx){
				    		  	var sum = 0;
				                var dataArr = ctx.chart.data.datasets[0].data;
				                dataArr.map(data => {
				                    sum += data;
				                });
				                var percentage = (value*100 / sum).toFixed(2);
				                
				                return percentage > 0 ? percentage+'%' : '';
				            },
				            color: '#000',
				    	} 
				      
				},
	            legendCallback: usrCustomLegend
	        }
	    });
	};

	var usrCustomLegend = function (chart) {
		var datalist = document.createElement('ul');
		var title = document.createElement('p');
		var color = chart.data.datasets[0].backgroundColor;
		var chartHtml = '';

	    chart.data.labels.forEach(function (label, index) {
	    	if(chart.data.datasets[0].data[index] != 0) {
	    		datalist.innerHTML += '<li data-target="'+label+'"><span style="background-color: '+color[index]+'; display: inline-block; width: 30px; height: 10px;"></span> '+label+'</li>';
	    	}
	    });

	    title.innerHTML += '<spring:message code="wzwg.cmm.menu.groupmbersttus" />';
	    chartHtml += title.outerHTML;
	    chartHtml += datalist.outerHTML;
	    return chartHtml;
	};
	
	
	var setLegendOnClick = function () {
	    var nttList = document.querySelectorAll('#legend-nttchartDiv ul li');
	    var usrList = document.querySelectorAll('#legend-usrchartDiv ul li');

	    for (var element of nttList) {
	        element.onclick = function () {
	            updateChart(event, this.dataset.target, window.nttChart);

	            if (this.style.textDecoration.indexOf("line-through") < 0) {
	                this.style.textDecoration = "line-through";
	            } else {
	                this.style.textDecoration = "";
	            }
	        }
	    }
	    
	    for (var element of usrList) {
	        element.onclick = function () {
	            updateChart(event, this.dataset.target, window.usrChart);
	            
	            if (this.style.textDecoration.indexOf("line-through") < 0) {
	                this.style.textDecoration = "line-through";
	            } else {
	                this.style.textDecoration = "";
	            }
	        }
	    }
	};
	
	
	var updateChart = function (e, target, chart) {
		  var i, ilen, meta;
		  
		  var usrList = [<c:forEach items="${usrStatList}" var="usrList" varStatus="status"><c:out value="${usrList.cnt}"/> <c:if test="${!status.last}">,</c:if></c:forEach>];
		  var nttList = [<c:forEach items="${nttStatList}" var="nttList" varStatus="status"><c:out value="${nttList.cnt}"/> <c:if test="${!status.last}">,</c:if></c:forEach>];
		  
		  for (i = 0, ilen = (chart.data.datasets || []).length; i < ilen; ++i) {
		      meta = chart.getDatasetMeta(i);

		      for (var j = 0; j < meta.data.length; j++) {
		          if (meta.data[j]._view.label.includes(target)) {
		              
		              if(meta.data[j].hidden){
		            	  meta.data[j].hidden = false;
		            	  
		            	  var canvas = meta.controller.chart.canvas;
			              var canvasId = $(canvas).attr('id');
		            	  
		            	  if(canvasId == 'nttchartDiv') {
		            		  meta.controller._data[j] = parseInt(nttList[j]);
		            	  }else if(canvasId == 'usrchartDiv'){
		            		  meta.controller._data[j] = parseInt(usrList[j]);
		            	  }
		            	  
		              }else {
		            	  meta.data[j].hidden = true;
		            	  meta.controller._data[j] = 0;
		              }
		          }
		      }
		  }

		  chart.update();
	};
		
	</script> 
    
	<div class="site-groupAll">
		<%-- <div class="site-group">
			<div class="site-admin hgt_same">
				<h3><spring:message code="wzwg.cmm.menu.sitemngr" /></h3>
				<div>
					<img src="<c:out value="${mngrTopLogo}"/>" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" width="120px" height="40px" />
					<!-- <img src="/images/wzwg/site/mngr/admin.png" alt="" /> -->
					<div class="admin-data">
						<ul>
							<li><spring:message code="wzwg.cmm.word.nm02" /> : <c:out value="${loginVO.userNm}"/> <spring:message code="wzwg.cmm.word.sir" /> </li>
							<li><spring:message code="wzwg.site.dashboard.msg.MSG001" /> : <c:out value="${lastLgnDt}"/></li>
						</ul>
						<div class="btnbox-c">
							<a href="/cmm/mber/login/actionMngrLogout.do" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.logout" /></a>
							 <c:if test="${not empty sessionScope.SADMIN_AT and sessionScope.SADMIN_AT}">
							<a href="/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=10000000001&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}"/>" class="wzbtn btn-basic"><spring:message code="wzwg.site.dashboard.msg.MSG002" /></a>
							</c:if>
							<c:if test="${not empty sessionScope.NADMIN_AT and sessionScope.NADMIN_AT}">
							 <a href="/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=<c:out value="${sessionScope.SITE_SEQ}"/>&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}"/>" class="wzbtn btn-basic"><spring:message code="wzwg.site.dashboard.msg.MSG002" /></a>
							 </c:if>
						</div>
					</div>
				</div>
			</div>
			<div class="site-guest hgt_same">
				<h3><spring:message code="wzwg.cmm.menu.sitesttus" /></h3>
				<ul>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG003" /></p>
						<span><c:out value="${usrTodayCnt}"/></span>
					</li>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG004" /></p>
						<span><c:out value="${usrTotCnt}"/></span>
					</li>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG005" /></p>
						<span><c:out value="${nttTodayCnt}"/></span>
					</li>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG006" /></p>
						<span><c:out value="${nttTotCnt}"/></span>
					</li>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG007" /></p>
						<span><c:out value="${vistTodayCnt}"/></span>
					</li>
					<li>
						<p><spring:message code="wzwg.site.dashboard.msg.MSG008" /></p>
						<span><c:out value="${visitTotCnt}"/></span>
					</li>
					
					<c:if test="${siteAdiInfo.fileProvdAt eq 'Y'}">
					<li>
						<p>첨부파일 사용량</p>
						<span><fmt:formatNumber value="${siteAtchFileSize}" pattern="#,###.##"/> <c:out value="${siteAdiInfo.fileCpctySe}"/>B ( <fmt:formatNumber value="${siteAtchFileSize/siteAdiInfo.fileProvdMg}" type="percent"/> )</span>
					</li>
					<li>
						<p>첨부파일 제공량</p>
						<span><fmt:formatNumber value="${siteAdiInfo.fileProvdMg}" pattern="#,###.##"/> <c:out value="${siteAdiInfo.fileCpctySe}"/>B</span>
					</li>
					</c:if>
				</ul>
			</div>
		</div> --%>
		<c:if test="${siteAdiInfo.fileProvdAt ne 'Y'}"><c:set var="fileGroupClass">site-group3 dshbrd3Block</c:set></c:if>
		<div class="site-group <c:out value="${fileGroupClass }"/> dshbrdMainBlock">
			<div class="site-overview NewerBox"><%-- 가입자수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon01.png" alt=""><spring:message code="wzwg.cmm.word.newmemberNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${usrTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.person" /></span></div>
		        	<p><strong class="total">Total</strong><fmt:formatNumber value="${usrTotCnt}" pattern="#,###" /></p>
		    	</div>
			</div>
		
			<div class="site-overview visitorBox"><%-- 방문자수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon02.png" alt=""><spring:message code="wzwg.cmm.word.homepageVisitorNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${vistTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.person" /></span></div>
		        	<p><strong class="total">Total</strong><fmt:formatNumber value="${visitTotCnt}" pattern="#,###" /></p>
		    	</div>
			</div>
		
			<div class="site-overview postingBox"><%-- 개시물수 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon03.png" alt=""><spring:message code="wzwg.cmm.word.newPostingNo" /></h3>
		            <div><h4 class="viewCountUp" data-cnt="<c:out value="${nttTodayCnt}"/>">0</h4><span class="unit"><spring:message code="wzwg.cmm.word.count04" /></span></div>
		        	<p><strong class="total">Total</strong><fmt:formatNumber value="${nttTotCnt}" pattern="#,###" /></p>
		    	</div>
			</div>
			
			<c:if test="${siteAdiInfo.fileProvdAt eq 'Y'}">
			<div class="site-overview upfileBox"><%-- 데이터사용량 --%>
		    	<div>
		        	<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon05.png" alt=""><spring:message code="wzwg.site.dashboard.msg.MSG009" /></h3>
		        	<div>
		       			<h4 style="display: inline;" class="viewCountUp" data-cnt="<fmt:formatNumber value="${siteAtchFileSize/siteAdiInfo.fileProvdMg}" type="percent"/>" data-type="percent">0</h4>
		       			<span class="unit">% (<fmt:formatNumber value="${siteAtchFileSize}" pattern="#,###.##"/> <c:out value="${siteAdiInfo.fileCpctySe}"/>B)</span>
		        	</div>
		        	<p><strong class="total"><spring:message code="wzwg.site.dashboard.msg.MSG010" /></strong><fmt:formatNumber value="${siteAdiInfo.fileProvdMg}" pattern="#,###.##"/> <c:out value="${siteAdiInfo.fileCpctySe}"/>B</p>
		    	</div>
			</div>
			</c:if>
		</div>

		<div class="site-group dshbrdChart">
			<div class="chartBox">
				<canvas id="nttchartDiv" style="width:50%; height: 400px; float: left;"></canvas>
		  		<div id="legend-nttchartDiv" class="legend-nttchartDiv" style="float: left;"></div>
			</div>
			<div class="chartBox">
				<canvas id="usrchartDiv" style="width:50%; height: 400px; float: right;"></canvas>
	  			<div id="legend-usrchartDiv"" class="legend-usrchartDiv" style="float: right;"></div> 
			</div>
		</div>
		<div class="site-group dshbrdNoticeBox">
			<div class="titbox">
				<h3><img src="/images/wzwg/site/mngr/layout/dshbrdMIcon04.png" alt=""><spring:message code="wzwg.cmm.cntnts.opnsu" /></h3>
				<p><spring:message code="wzwg.cmm.msg.tip.MSG112" /></p>
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
										<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/><c:out value="${noticeList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${noticeList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/mngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000001" class="btn-s">+</a>
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
										<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/><c:out value="${dataList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${dataList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/mngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000002" class="btn-s">+</a>
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
									<td><c:out value="${qnaList.nttSeq}" escapeXml="true"/></td>
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
										<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/><c:out value="${qnaList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${qnaList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>	
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/mngr/opnsu/bbs/qna/selectBbsInc.do?bbsSeq=10000000003" class="btn-s">+</a>
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
										<a href="<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/><c:out value="${faqList.bbsViewLink}"/>">
											<c:out value="${nttSj}"/>
										</a>
									</td>
									<td><c:out value="${faqList.frstRegistPnttm}"/></td>
								</tr>
							</c:forEach>														
						</c:if>					  
					  </tbody>
				</table>
				<a href="<c:out value="${wzwg_contextPath}"/>/mngr/opnsu/bbs/unity/selectBbsInc.do?bbsSeq=10000000004" class="btn-s">+</a>
			</div>
		</div>
	</div>    
	
	
	<!-- 대시보드 가이드 추가 2021.03.29 -->
	<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
	<div class="guidemngr_CO guidemngr_dashboard" style="display: none;">

		<div class="guideSlide">
			<div class="mngr-guide-swiper-container swiper-container-horizontal ">
				<div class="swiper-wrapper">
					<div class="swiper-slide  swiper-slide-active"> 
						<div>

							<!-- <button type="button" class="btn00 btn01" id="guide_top_menu1" onclick="guide_swiper.slideTo(0);"><spring:message code="wzwg.cmm.cntnts.sitemanage" /></button> -->

							<div class="slideInnerbox">
								<!-- <div class="guidearrow btn01_arrow"></div> -->
								<div class="guideTit"><spring:message code="wzwg.cmm.cntnts.sitemanage" /></div>
								<div class="guideInfo">
									<spring:message code="wzwg.cmm.mngr.guid.MSG001" />
									<hr>
									<spring:message code="wzwg.cmm.mngr.guid.MSG002" />
								</div>
								<div class="guideImgbox">
									<img id="guide_img1" >
								</div>
							</div>

						</div>
					</div>
	
					<div class="swiper-slide  swiper-slide-next">
						<div>

							<!-- <button type="button" class="btn00 btn02" id="guide_top_menu2" onclick="guide_swiper.slideTo(1);"><spring:message code="wzwg.cmm.cntnts.designmanage" /></button> -->

							<div class="slideInnerbox">
								<!-- <div class="guidearrow btn02_arrow"></div> -->
								<div class="guideTit"><spring:message code="wzwg.cmm.cntnts.designmanage" /></div>
								<div class="guideInfo">
									<spring:message code="wzwg.cmm.mngr.guid.MSG003" />
									<hr>
									<spring:message code="wzwg.cmm.mngr.guid.MSG004" />
								</div>
								<div class="guideImgbox">
									<img id="guide_img2" >
								</div>
							</div>

						</div>
					</div>


					<div class="swiper-slide  swiper-slide-next">
						<div>

							<!-- <button type="button" class="btn00 btn03" id="guide_top_menu3" onclick="guide_swiper.slideTo(2);"><spring:message code="wzwg.cmm.cntnts.menusubpagemanage" /></button> -->

							<div class="slideInnerbox">
								<!-- <div class="guidearrow btn02_arrow"></div> -->
								<div class="guideTit"><spring:message code="wzwg.cmm.cntnts.menusubpagemanage" /></div>
								<div class="guideInfo">
									<dl class="txtdl">
										<dt><spring:message code="wzwg.site.dashboard.msg.MSG011"/></dt>
										<dd><spring:message code="wzwg.cmm.mngr.guid.MSG005" /></dd>
										<hr>
										<dt><spring:message code="wzwg.cmm.word.menu"/></dt>
										<dd><spring:message code="wzwg.cmm.mngr.guid.MSG006" /></dd>
									</dl>

									<spring:message code="wzwg.cmm.mngr.guid.MSG007" />
								</div>
								<div class="guideImgbox">
									<img id="guide_img3" >
								</div>
							</div>

						</div>
					</div>


					<div class="swiper-slide  swiper-slide-next">
						<div>

							<!-- <button type="button" class="btn00 btn04" id="guide_top_menu4" onclick="guide_swiper.slideTo(3);"><spring:message code="wzwg.cmm.cntnts.mbermanage" /></button> -->

							<div class="slideInnerbox">
								<!-- <div class="guidearrow btn02_arrow"></div> -->
								<div class="guideTit"><spring:message code="wzwg.cmm.cntnts.mbermanage" /></div>
								<div class="guideInfo">
									<spring:message code="wzwg.cmm.mngr.guid.MSG008" />
								</div>
								<div class="guideImgbox">
									<img id="guide_img4" >
								</div>
							</div>

						</div>
					</div>


					<div class="swiper-slide  swiper-slide-next">
						<div>

							<!-- <button type="button" class="btn00 btn05" id="guide_top_menu5" onclick="guide_swiper.slideTo(4);"><spring:message code="wzwg.cmm.cntnts.hmpgoper" /></button> -->

							<div class="slideInnerbox">
								<!-- <div class="guidearrow btn02_arrow"></div> -->
								<div class="guideTit"><spring:message code="wzwg.cmm.cntnts.hmpgoper" /></div>
								<div class="guideInfo">
									<spring:message code="wzwg.cmm.mngr.guid.MSG009" />
								</div>
								<div class="guideImgbox">
									<img id="guide_img5" >
								</div>
							</div>

						</div>
					</div>




				</div>



				<!-- Add Pagination -->
				<div class="mngr-guide-wzwg-swiper-pagination swiper-pagination  swiper-pagination-clickable swiper-pagination-bullets swiper-container-horizontal">
					<span class="swiper-pagination-bullet swiper-pagination-bullet-active"></span>
					<span class="swiper-pagination-bullet"></span>
					<span class="swiper-pagination-bullet"></span>
				</div>
				<!-- Add Arrows -->
				<div class="mngr-guide-wzwg-swiper-pagination-next swiper-button-next"></div>
				<div class="mngr-guide-wzwg-swiper-pagination-prev swiper-button-prev swiper-button-disabled"></div>
				

			</div>	   
	</div>





	
	</div>
	<div class="admin_guidemngr guideOFF" id="admGuid">
		<a href="#">
			<spring:message code="wzwg.site.dashboard.msg.MSG012"/>
		</a>
		<span class="closeTxt"><spring:message code="wzwg.cmm.word.close"/></span>
	</div>







    <script>
			$( document ).ready( function() {
				$( '#admGuid' ).click( function() {
					$(this).toggleClass("guideOFF");
					$('#fade').fadeToggle();
					//$('.guidemngr_CO').fadeToggle();
					//$('.OnedayDetail').slideToggle("showDetail");
					fnGuidePlay();
				} );
			} );

		var guideSlide = $('.mngr-guide-swiper-container');
		var guide_swiper;
		var guide_imgs_ko = [
							'/images/wzwg/site/mngr/guide/tutorial_guide_01.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_02.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_03.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_04.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_05.gif'
							]
		
		var guide_imgs_eng = [
							'/images/wzwg/site/mngr/guide/tutorial_guide_01_en.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_02_en.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_03_en.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_04_en.gif'
						,	'/images/wzwg/site/mngr/guide/tutorial_guide_05_en.gif'
							]
		
		function fnGuidePlay(){
			if( guide_swiper == undefined){
				//swipe 가 활성화 되어 있지 않다면 이미지가 없으므로 가이드 패널이 오픈되기전에 이미지를 먼저 세팅한다
				var imgs;
				if('<c:out value="${sessionScope.langCode}"/>'.toLowerCase().indexOf('ko') > -1){
					imgs = guide_imgs_ko;
				}else{
					imgs = guide_imgs_eng;
				}
				
				for (var i = 1; i <= imgs.length; i++) {
					$('#guide_img' + i).attr('src', imgs[i-1]);
				}
				//기본 메뉴 크기에 따른 하이라이트 메뉴 사이즈 재조정
				//fnCopyPosition('mngr_top_menu1', 'guide_top_menu1'); 
				//fnCopyPosition('mngr_top_menu2', 'guide_top_menu2'); 
				//fnCopyPosition('mngr_top_menu3', 'guide_top_menu3'); 
				//fnCopyPosition('mngr_top_menu4', 'guide_top_menu4'); 
				//fnCopyPosition('mngr_top_menu5', 'guide_top_menu5'); 
			}
			
			if($('.guidemngr_CO').css('display') == 'none'){
				//close -> open
				wzHideScrollbar();
			}
			
			$('.guidemngr_CO').fadeToggle(function(){
				//console.log($(this).css('display'));
				if($(this).css('display') == 'none'){
					//open -> close
					wzShowScrollbar();
				}
				if( guide_swiper == undefined){
					//setInterval(fnGuideSwipe, 700);
					guide_swiper = new Swiper(guideSlide, {
						effect : 'fade',
						pagination: guideSlide.find('.mngr-guide-wzwg-swiper-pagination'),
						paginationClickable: true,
						nextButton: guideSlide.find('.mngr-guide-wzwg-swiper-pagination-next'),
						prevButton: guideSlide.find('.mngr-guide-wzwg-swiper-pagination-prev')
					});
				}else{
					guide_swiper.slideTo(0);
				}
				
				
			});
			
		}
		
		function fnCopyPosition(srcId, targetId){
			var top = $('#' + srcId).offset().top;
			var left = $('#' + srcId).offset().left;
			//var width = $('#' + srcId).outerWidth(true);
			var width = $('#' + srcId).width();
			var fontSize = $('#' + srcId).css('font-size');
			//var padding = $('#' + srcId).css('padding');
			
			$('#' + targetId).css({
								'top' : top+'px'
							,	'left' : left+'px'
							,	'width' : width+'px'
							,	'font-size' : fontSize
							,	'padding-left' : '0px'
							,	'padding-right' : '0px'
								});
		}
	</script>
 
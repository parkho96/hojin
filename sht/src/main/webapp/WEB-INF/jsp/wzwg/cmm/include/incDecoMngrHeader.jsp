<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery.dd.js"></script>

<script type="text/javascript">
	var x = window.matchMedia("(max-width: 899px)"); 

	$(document).ready(function(e) {
		
		sessionStorage.setItem('siteKey', '<c:out value="${wzwg_siteKey}" />');
		
		$("#useLang").msDropDown();
		
		//새로 추가해준 부분. 심수정 0315 
		//메인 모바일팝업메뉴
		$("#lnb_showbtn").click(function(){
			var toggle = $('#lnb_showbtn').attr('data-toggle');
			if(!toggle || toggle == 'off'){
				$('#lnb_showbtn').attr('data-toggle', 'on');
			}else{
				$('#lnb_showbtn').attr('data-toggle', 'off');
			}
			
			$("#lnb_showbtn").toggleClass("close");
			$("#sidebar").toggle();
			$("#sidebar").toggleClass("sidebar_m");
			fnMenuFade();
		});
		


		//사이트관리자 퀵메뉴
		$("#quick_showbtn").click(function(){
			var toggle = $('#quick_showbtn').attr('data-toggle');
			if(!toggle || toggle == 'off'){
				$('#quick_showbtn').attr('data-toggle', 'on');
			}else{
				$('#quick_showbtn').attr('data-toggle', 'off');
			}
			
			$("#quick_showbtn").toggleClass("q_close");
			$(".mngr_top_menu").fadeToggle();
			$(".mngr_top_menu").addClass("quick_m");
			fnMenuFade();
		});

		//시스템관리자 상단 사이트검색팝업
		$("#m-srchbtn").click(function(){
			var toggle = $('#m-srchbtn').attr('data-toggle');
			if(!toggle || toggle == 'off'){
				$('#m-srchbtn').attr('data-toggle', 'on');
			}else{
				$('#m-srchbtn').attr('data-toggle', 'off');
			}
			
			$(".srchbox").fadeToggle();
			fnMenuFade();
		});
		
		//시스템/사이트 관리자 공통 배경 클릭
		$(".menu_fade").click(function(){
			fnMenuFadeAction();
		});
		
		//모바일 화면 대응 스크립트
		
		fnResizeMngr(x) // Call listener function at run time
		x.addListener(fnResizeMngr) // Attach listener function on state changes
		fnMobileHederScroll();
		
		
		//로그인 시간 유지 스크립트
		<c:if test="${not empty sessintvl and sessintvl ne '0'  }">
		fnLoginTimerCalc();
		fnLoginTimeCheck();
		</c:if>
	}); // end ready
		
	function openHomepage(){
		window.open('<c:out value="${wzwg_contextPath}" />/index.do','_blank');
	}
	
	function fnTopSearch(pageIndex) {
	    var frm = document.frmTopSrh;
	    
	    frm.pageIndex.value = pageIndex;
	    
	    frm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do";
	    frm.submit();
	}
	
	function fnChangeLang(selLang) {
        document.location.href = '<c:out value="${wzwg_contextPath}${prefix}" />/mngr/selectDashboardMain.do?lang='+selLang;
	}

	
	
	function fnMenuFade(){
		
		// menuBtnToggle 은 사이트/시스템관리자 공통사항
		var menuBtnToggle = $('#lnb_showbtn').attr('data-toggle') == 'on' ? true : false;
		//사이트관리자 퀵메뉴 컨트롤
		var sitMgrQckMn = $('#quick_showbtn').attr('data-toggle') == 'on' ? true : false;
		// 시스템관리자 버튼 컨트롤
		var sysMgrSchBn = $('#m-srchbtn').attr('data-toggle') == 'on' ? true : false;

		//console.log(menuBtnToggle);
		if(menuBtnToggle){
			$("#quick_showbtn").attr('disabled','disabled'); 
			$("#m-srchbtn").attr('disabled','disabled'); 
		}else{
			$("#quick_showbtn").removeAttr('disabled');
			$("#m-srchbtn").removeAttr('disabled');
		}
		
		if(sitMgrQckMn || sysMgrSchBn){
			$("#lnb_showbtn").attr('disabled','disabled'); 
		}else{
			$("#lnb_showbtn").removeAttr('disabled');
		}
		
		if( $(".menu_fade").css('display') == 'none'){
			$('body').css('overflow', 'hidden');
		}else{
			$('body').css('overflow', 'auto');
		}
		
		$(".menu_fade").fadeToggle();  
		
		
	}
	
	function fnMenuFadeAction(){
		// menuBtnToggle 은 사이트/시스템관리자 공통사항
		var menuBtnToggle = $('#lnb_showbtn').attr('data-toggle') == 'on' ? true : false;
		//사이트관리자 퀵메뉴 컨트롤
		var sitMgrQckMn = $('#quick_showbtn').attr('data-toggle') == 'on' ? true : false;
		// 시스템관리자 버튼 컨트롤
		var sysMgrSchBn = $('#m-srchbtn').attr('data-toggle') == 'on' ? true : false;
		
		if(menuBtnToggle){
			$('#lnb_showbtn').click();
		}else if(sitMgrQckMn){
			$('#quick_showbtn').click();
		}else if(sysMgrSchBn){
			$('#m-srchbtn').click();
		}
		
		
		
	}
	
	var headerScrollSwitch = false;
	//모바일 화면 대응 스크립트
	function fnResizeMngr(x){
		//console.log('ddd');
		if (x.matches) { // If media query matches
			 //console.log('mobile view');
	    	$('#header').addClass('fixed');
	    	$('#sidebar').css('position', 'fixed');
	    	$('#sidebar').css('overflow-y','auto');
	    	//var sidebarH = $('#sidebar ul').height();
	    	//$('#sidebar').css('height', 'calc(100vh - 65px)'); 
	    	//$('#sidebar').css('box-sizing', 'border-box'); 
	    	
	    	$('.mngr_top_menu').css('position', 'fixed');
	    	headerScrollSwitch = true;
		}else{
			 //console.log('pc view');
	    	$('#header').removeClass('fixed');
	    	$('#sidebar').css('position', '');
	    	$('.mngr_top_menu').css('position', '');
	    	//$('#sidebar').removeClass('fixed');
	    	//$('#sidebar').css('height', '100%');
	    	headerScrollSwitch = false;
		}
	}
	
	var scrolPos = 0;
	function fnMobileHederScroll(){
		var headerPoint =  $('#header').height() ;
		//console.log(1);
		$(document).scroll(function(){ 
			//console.log($(this).scrollTop());
			//console.log($('body').scrollTop());
			if (x.matches) { 
				var movScrolpx = $(this).scrollTop();
				
				if(movScrolpx < headerPoint){
					$('#header').show();
				}else if($(document).height() - $(window).height() == movScrolpx){
					//스크롤이 마지막까지 내려오면 헤더를 열어준다
					$('#header').slideDown();
				}else if(movScrolpx > scrolPos){
					//console.log('스크롤 내려감');
					$('#header').slideUp();
				}else{
					//console.log('스크롤 올라감');
					$('#header').slideDown();
				}
				
				scrolPos = movScrolpx; 
				
			}else{
				$('#header').show();
			}
			//if (headerScrollSwitch) { //반응형 설정된 모바일 환경에서만 작동하도록
			//	console.log();
			//}
		    
		  });
	}
	
	
	var sessionInterval = parseInt('<c:out value="${sessintvl}" />');
	var lognPopupTime = 30;
	var lognPopupCheck = false;
	function fnLoginSetInterval(sessionTime){
		//console.log('recive sessionTime : ' + sessionTime);
		sessionInterval = sessionTime;
	}
	function fnLoginTimeCheck(){
		
		setInterval(function() {  
			--sessionInterval;
			var t = fnLoginTimerCalc();
			//console.log(sessionInterval + " : " + lognPopupTime);
			if(sessionInterval == 0){
				location.href = '<c:out value="${wzwg_contextPath}" />/cmm/mber/login/actionMngrLogout.do';
			}else if( sessionInterval < lognPopupTime && lognPopupCheck == false){
				fnAddSessionTimePopup(t);
			}
		}, 1000);
		
	}
	
	function fnLoginTimerCalc(){
		var m = Math.floor(sessionInterval / 60);
		m = m < 10 ? '0'+m : m;
		var s = sessionInterval % 60;
		s = s < 10 ? '0'+s : s;
		//console.log(m + ':' + s);
		$('.lognTimer').html(m + ':' + s);
		return m + ':' + s;
	} 
	
	function fnAddSessionTime(){
		$.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}" />/cmm/code/selectSessionIntervalAjax.do'
            /* , data:$("#usrTyModifyForm").serialize() */
            ,success:function (data){
                //console.log(data.body.sessionInterval);
                //console.log(data.head.result);
                if(data.body.sessionInterval == 0){
                	//console.log('여기도 안옴?');
                	$('.sessIntvl').hide();//?뭔가이상한데
                }else{
                	//console.log('여기안옴?');
                	sessionInterval = parseInt(data.body.sessionInterval);
                	lognPopupCheck = false;
                }
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
	}
	
	function fnAddSessionTimePopup(time){
		
		//wzModalClose();// 혹시 팝업이 띄워져 있으면 내려라
		
		var pop = '';
			pop += '<div>';
			pop += '	<table class="basic">';
			pop += '		<tr>';
			pop += '			<th class="txt-c">';
			pop += '			<spring:message code="wzwg.cmm.msg.MSG341" />';
			pop += '			</th>';
			pop += '		</tr>';
			pop += '		<tr>';
			pop += '			<td class="txt-c">';
			pop += '				<h3 class="mg20"><spring:message code="wzwg.cmm.word.remaintm" /> <i class="fa fa-clock-o" style="color: #aaa;"></i> <small class="lognTimer" style="color: #2b71b9;">' + time + '</small></h3>';
			pop += '				<div class="mg15">';
			pop += '					<spring:message code="wzwg.cmm.msg.MSG342" />';
			pop += '				</div">';
			pop += '				<p class="btnbox-c mt30">';
			pop += '				<button type="button" class="wzbtn btn-save" onclick="fnAddSessionTime();wzModalClose()"><spring:message code="wzwg.cmm.word.applyextended" /></button>';
			pop += '				</p>';
			pop += '			</td>';
			pop += '		</tr>';
			pop += '	</table>';
			pop += '</div>';
			
		wzAjaxModal('popup_s', '<spring:message code="wzwg.cmm.msg.MSG340" />', pop);
		lognPopupCheck = true;
	}

</script>
<div id="header">

					<button type="button" id="lnb_showbtn" title="<spring:message code="wzwg.cmm.word.menu" />"> <!-- 새로 추가해준 부분. 심수정 0315. -->
					    <span></span>
					    <span></span>
					    <span></span>
					</button>
					<div class="logo">
					
		                	<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		                		<a href="<c:out value="${wzwg_contextPath}" />/sysMngr/selectDashboardMain.do"  onclick="sessionStorage.removeItem('authgrpId')">
		                		<img src="/images/wzwg/site/mngr/logo.png" alt="<spring:message code="wzwg.cmm.word.sysmngr" />" />
		                		</a>
		                	</c:if>
		                	<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
		                		<a href="<c:out value="${wzwg_contextPath}" />/mngr/selectDashboardMain.do"  onclick="sessionStorage.removeItem('authgrpId')">
		                		<!-- <img src="/images/wzwg/site/mngr/logo.png" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" /> -->
		                		<c:if test="${empty sessionScope.usrTopLogo}">
		                		<h2 style="margin-top: 10px;"><c:out value="${sessionScope.SITE_NM}" /></h2>
		                		</c:if>
		                		<c:if test="${not empty sessionScope.usrTopLogo}">
		                		<img src="<c:out value="${sessionScope.usrTopLogo}" />&type=w" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" width="220px" height="42px" />
		                		</c:if>
		                		</a>
		                	</c:if>
		                
					</div>
					<div class="header-menu"> 
						<ul>
                           <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
                            <button type="button" id="m-srchbtn" title="<spring:message code="wzwg.cmm.word.search01" />">  <!-- 새로 추가해준 부분. 심수정 0315. -->
							    <span></span>
							    <span></span>
							</button>
							
                           <li class="fl srchbox"> 
                               <form id="frmTopSrh" name="frmTopSrh" method="post">
                               <input type="hidden" id="pageIndex" name="pageIndex" />
                               <select name="searchCondition" id="searchCondition01">
                                <option value="1" <c:if test="${param.searchCondition eq '1'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sitenm" /></option>
								<option value="2" <c:if test="${param.searchCondition eq '2'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.reprsntsiteurl" /></option>
                               </select>
                               <input type="text" name="searchKeyword" id="searchKeyword" class="txt" style="width: 150px;" onkeydown="if(event.keyCode == 13){fnTopSearch(1);}" placeholder="<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>" />
                               <button onclick="fnTopSearch(1);" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></button>
                               </form>
                           </li>
                           </c:if>
                           
                           
                           	
							<li class="mngr_info">
								<div>
									<c:if test="${not empty sessionScope.SADMIN_AT and sessionScope.SADMIN_AT}">
									<a class="wzbtn-table btn-grey" href="<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=10000000001&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}"/>" title="<spring:message code="wzwg.cmm.word.infochange" />">
										<p><c:out value="${loginVO.userNm}" /></p>
	    								<%-- <span><spring:message code="wzwg.cmm.word.recent" /> <spring:message code="wzwg.cmm.word.conect" /> : ${lastLgnDt}</span> --%>
	    							</a>
									</c:if>
									<c:if test="${not empty sessionScope.NADMIN_AT and sessionScope.NADMIN_AT}">
							 		<a class="wzbtn-table btn-grey" href="<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrInfo/modifyUsrInfoForm.do?siteSeq=<c:out value="${sessionScope.SITE_SEQ}" />&usrSeq=<c:out value="${sessionScope.loginVO.usrSeq}" />" title="<spring:message code="wzwg.cmm.word.infochange" />">
										<p><c:out value="${loginVO.userNm}" /></p>
	    								<%-- <span><spring:message code="wzwg.cmm.word.recent" /> <spring:message code="wzwg.cmm.word.conect" /> : ${lastLgnDt}</span> --%>
	    							</a>
							 		</c:if>
							 	</div>
								<%-- <img src="/images/wzwg/site/mngr/user.png" alt="<spring:message code="wzwg.cmm.word.emplyr" /> <spring:message code="wzwg.cmm.word.image" />" />
								<p><spring:message code="wzwg.cmm.msg.MSG110" />  
								<spring:message code="wzwg.cmm.msg.MSG111">
									<spring:argument>
										<c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
						                	<span><spring:message code="wzwg.cmm.word.sysmngr" /></span>
						                </c:if>
						                <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
						                	<span><spring:message code="wzwg.cmm.word.sitemngr" /></span>
						                </c:if>
									</spring:argument>
				                </spring:message>
								 </p> --%>
							</li> 
							
							
							
							<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
							<li class="langli">
                           		<select id="useLang" name="useLang" onchange="fnChangeLang(this.value);" >
									<option value="SC00000016" data-image="/images/wzwg/cmm/ico-kor.png" data-title="<spring:message code="wzwg.cmm.word.langkor" />" <c:if test="${sessionScope.useLangCode eq 'SC00000016'}">selected</c:if>></option>
									<option value="SC00000019" data-image="/images/wzwg/cmm/ico-eng.png" data-title="<spring:message code="wzwg.cmm.word.langeng" />" <c:if test="${sessionScope.useLangCode eq 'SC00000019'}">selected</c:if>></option>
<%-- 									<option value="SC00000017" data-image="/images/wzwg/cmm/ico-jap.png" data-title="<spring:message code="wzwg.cmm.word.langjap" />" <c:if test="${sessionScope.useLangCode eq 'SC00000017'}">selected</c:if>></option>
									<option value="SC00000018" data-image="/images/wzwg/cmm/ico-chi.png" data-title="<spring:message code="wzwg.cmm.word.langchi" />" <c:if test="${sessionScope.useLangCode eq 'SC00000018'}">selected</c:if>></option> --%>
								</select>
                           	</li>
							<li>
                           		<a href="<c:out value="${wzwg_contextPath}" />/" class="wzbtn-table btn-basic" target="_blank" ><spring:message code="wzwg.cmm.menu.hmpgopen" /></a>
							</li>
                           	</c:if>
                           	
                           	<c:if test="${not empty sessintvl and sessintvl ne '0' }">
							<li class="login_time sessIntvl">
							     <button type="button" class="time_limit" onclick="fnAddSessionTime()">
							         <p><i class="fa fa-clock-o"></i> <span class="lognTimer" style="color:white;">05:29</span></p>
							         <spring:message code="wzwg.cmm.word.extended" />
							    </button> 
							</li>
							</c:if>
                           	
							<li class="logout">
								<a href="<c:out value="${wzwg_contextPath}" />/cmm/mber/login/actionMngrLogout.do">
									<b><spring:message code="wzwg.cmm.word.logout" /></b>
								</a>
							</li>
						</ul>
					</div>
					
					<c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
					<button type="button" id="quick_showbtn" title="<spring:message code="wzwg.cmm.word.fastmenu" />"> <!-- 새로 추가해준 부분. 심수정 0315. -->
					    <span></span>
					    <span></span>
					    <span></span>
					</button>
					</c:if>
			</div>
			 
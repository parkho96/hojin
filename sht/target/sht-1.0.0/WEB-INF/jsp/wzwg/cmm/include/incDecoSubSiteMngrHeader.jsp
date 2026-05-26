<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	function openHomepage(){
		window.open('<c:out value="${wzwg_contextPath}/subsite/${sessionScope.subsiteKey}" />','_blank');
	}
	
	function fnTopSearch(pageIndex) {
	    var frm = document.frmTopSrh;
	    
	    frm.pageIndex.value = pageIndex;
	    
	    frm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do";
	    frm.submit();
	}
	
	var x = window.matchMedia("(max-width: 899px)"); 

	$(document).ready(function(e) {
		
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
			$(".menu_fade").fadeToggle();
		});
		
		
		//시스템/사이트 관리자 공통 배경 클릭
		$(".menu_fade").click(function(){
			$('#lnb_showbtn').click();
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
	    	
	    	//$('.mngr_top_menu').css('position', 'fixed');
	    	headerScrollSwitch = true;
		}else{
			 //console.log('pc view');
	    	$('#header').removeClass('fixed');
	    	$('#sidebar').css('position', '');
	    	//$('.mngr_top_menu').css('position', '');
	    	//$('.mngr_top_menu').css('display', 'none !important');//서브사이트 관리자만 다른 스크립트
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
	function fnLoginTimeCheck(){
		
		setInterval(function() {  
			--sessionInterval;
			var t = fnLoginTimerCalc();
			//console.log(sessionInterval + " : " + lognPopupTime);
			if(sessionInterval == 0){
				location.href = '<c:out value="${wzwg_contextPath}${subPrefix}/subsite/${subsiteKey}" />/actionMngrLogout.do';
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
		wzModalClose();// 혹시 팝업이 띄워져 있으면 내려라
		
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
					
		                 
		                		<c:if test="${empty sessionScope.subsiteMngrTopLogo}">
		                		<h2 style="margin-top: 10px;"><c:out value="${sessionScope.subsiteMngrSiteNm}" /></h2>
		                		</c:if>
		                		<c:if test="${not empty sessionScope.subsiteMngrTopLogo}">
		                		<img src="<c:out value="${subsiteMngrTopLogo}" />" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" width="220px" height="42px" />
		                		</c:if>
		                
					</div>
					<div class="header-menu"> 
						<ul> 
							<li class="mngr_info">
								<div>
									<p><c:out value="${loginVO.userNm}" /></p>
							 	</div>
							</li> 
                           	<li >
                           		<a href="<c:out value="${wzwg_contextPath}/subsite/${sessionScope.subsiteKey}" />" class="wzbtn-table btn-basic" target="_blank"><spring:message code="wzwg.cmm.word.hmpgopen" /></a>
                           	</li>
							<%-- <li>
								<img src="/images/wzwg/site/mngr/user.png" alt="<spring:message code="wzwg.cmm.word.emplyr" /> <spring:message code="wzwg.cmm.word.image" />" />
								<p><spring:message code="wzwg.cmm.msg.MSG110" />  
								<spring:message code="wzwg.cmm.msg.MSG111">
									<spring:argument>
										<span><spring:message code="wzwg.cmm.word.sub" /> <spring:message code="wzwg.cmm.word.sitemngr" /></span>
									</spring:argument>
				                </spring:message>
				                </p>
							</li>  --%>
							
							<c:if test="${not empty sessintvl and sessintvl ne '0' }">
							<li class="login_time sessIntvl">
							     <button type="button" class="time_limit" onclick="fnAddSessionTime()">
							         <p><i class="fa fa-clock-o"></i> <span class="lognTimer" style="color:white;">05:29</span></p>
							         <spring:message code="wzwg.cmm.word.extended" />
							    </button> 
							</li>
							</c:if>
							
							<li class="logout">
								<a href="<c:out value="${wzwg_contextPath}${subPrefix}/subsite/${subsiteKey}" />/actionMngrLogout.do">
									<b><spring:message code="wzwg.cmm.word.logout" /></b>
								</a>
							</li>
						</ul>
					</div>
					
					
			</div>
			 
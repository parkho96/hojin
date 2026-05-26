<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:if test="${fn:length(popupList) > 0}"> 
<script>
	
$(document).ready(function(){
	if(getCookie('mainPopup') != null){
		$("#mainPopup").css('display', 'none'); 
	} else {
		if($('.wzwgPopupList .popup-slide').length > 0){
	        $("#mainPopup").css('display', 'block'); 
		}
	}
	
	<c:set var="orderCnt" value="${fn:length(popupList)}" />
    <c:forEach items="${popupList}" var="list" varStatus="status">
        <c:if test="${list.popupTyCode ne 'SC00000415'}">
	        <c:if test="${list.exposureAt eq 'Y'}">
		    	if(getCookie('div<c:out value="${list.popupSeq}" />') == null){
	            	fnPopupOpen('<c:out value="${list.popupSeq}" />', '<c:out value="${orderCnt-status.count}" />');
		    	}
	        </c:if>
        </c:if>
    </c:forEach>
});

// 쿠키 설정 
function setCookie(name, value, expiredays) {
	var todayDate = new Date();
	todayDate.setDate( todayDate.getDate() + expiredays );
	document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
}

// 쿠키 확인
function getCookie(name) {
	var prefix = name + "=";
	var cookieStartIndex = document.cookie.indexOf(prefix);
	
	if (cookieStartIndex == -1) {
		return null;
	}
	
	var cookieEndIndex = document.cookie.indexOf(";", cookieStartIndex + prefix.length);
	
	if (cookieEndIndex == -1) { 
		cookieEndIndex = document.cookie.length; 
	}
	
	return unescape(document.cookie.substring(cookieStartIndex + prefix.length, cookieEndIndex));
}

// 체크버튼 클릭시
function fnPopupCheck() {
	var dayCheck = $("input:checkbox[name=popupCloseDay]:checked").val();
	
	if(dayCheck == 'on'){
		setCookie('mainPopup', "done", 1);	
	}
		
	$("#mainPopup").slideUp(); 
}

function fnPopupOpen(popupSeq, ordr) {
	//console.log(callObj);
    if ($('#div'+popupSeq).length > 0) {
        var displayVal = $('#div'+popupSeq).css('display');
        
        if (displayVal != 'none') {
            $('#div'+popupSeq).css('display', 'none');
        } else {
            $('#div'+popupSeq).css('display', 'block');
            $('#div'+popupSeq).find('#popupCloseChk'+popupSeq).focus();
        }
    } else {
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}" />/module/popup/selectModulePrevewPopup.do'
            , data:{'popupSeq':popupSeq}
            ,success:function (result){
                $('#popupZone').append('<div id="div'+popupSeq+'" class="popupZoneIn" style="z-index: ' + (1000 + parseInt(ordr)) + ';"></div>');
                $('#div'+popupSeq).html(result);
                
                var popClose = '';
                    popClose += '<div class="closeZone">';
                    popClose += '   <label for="popupCloseChk'+popupSeq+'"><input type="checkbox" class="fl" id="popupCloseChk'+popupSeq+'" style="margin-right:5px; "/><spring:message code="wzwg.cmm.msg.wa.MSG004" /></label>';
                    popClose += '<button type="button" class="popupZoneInClose" onclick="fnPopupClose('+popupSeq+');" style="cursor:pointer;"><spring:message code="wzwg.cmm.word.close" /></button></div>';
                
                $('#div'+popupSeq).append(popClose);
                $('#div'+popupSeq).find('#popupCloseChk'+popupSeq).focus();
                fnPopupCloseFocusPrison($('#div'+popupSeq).find('.popupZoneInClose'));
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
    }
}

function fnPopupCloseFocusPrison(btnCls){
	 $(btnCls).on('keydown', function(e){
	    	//console.log(e.keyCode);
	    	
	    	if(e.keyCode == '9'){
	    		//닫기버튼에서 탭키를 누르면
	    		e.stopPropagation();
				e.preventDefault();
	    		
	    		var poplen = $('#popupZone').children().length;
	    		for(var i = poplen ; i > 0; i--){
	    			var pop = $('#popupZone').children().eq(i-1);
	    			if($(pop).css('display') != 'none'){
	    				//console.log('next pop focus');
	    				//console.log(pop);
	    				
	    				$(pop).find('input').focus();
	    				return;
	    			}
	    		}//end for 
	    		
	    		
	    	}
	    });
}

function fnPopupClose(pSeq) {
	if($('#popupCloseChk'+pSeq).is(":checked") == true){
		setCookie('div'+pSeq, "done", 1);
	}
		
	$('#div'+pSeq).css('display', 'none');
	
	var popOpenBtn = $('#popLink-' + pSeq); 
	var poplen = $('#popupZone').children().length;
	var popClsePass = true;
	for(var i = poplen ; i > 0; i--){
		var pop = $('#popupZone').children().eq(i-1);
		if($(pop).css('display') != 'none'){
			//console.log('next pop focus');
			//console.log(pop);
			
			$(pop).find('input').focus();
			popClsePass = false;
			return;
		}
	}//end for 
	// for문을 빠져나왔다는것은 모든팝업이 닫혔다는 의미
	if(popOpenBtn.length == 1){
		popOpenBtn.focus();//호출한 팝업 버튼으로 포커스 이동
	}else{
		$('#skipnavi').find('li:first-child a').focus();
	}
		
}

</script>
	  <link type="text/css" href="/css/wzwg/module/popup/adm_popupzone.css" rel="stylesheet" />	
		<div class="adm_popupzone" id="mainPopup" style="display:none;">
						<div class="wzwgPopupList wzwg-popup-slide-info">
							<div class="indicator">
								<button class="play" type="button" id="btn-popctrl-start"><spring:message code="wzwg.cmm.word.begin" /></button>		
								<button class="stop off" type="button" id="btn-popctrl-stop" style="display: none;"><spring:message code="wzwg.cmm.word.wa.stop" /></button>				
							</div>
							<div class="indecator_number">
							    <span class="this_count" title="<spring:message code="wzwg.module.word.nowslideno" />">1</span>
							    /
							    <span class="total_count" title="<spring:message code="wzwg.module.word.totalslideno" />">1</span>
							</div>
							
							<div class="wzwg-popup-slide-data">
								<!-- 팝업슬라이드 하나 --> 
							<c:forEach items="${popupList}" var="list" varStatus="status">
								<c:if test="${list.positionAt ne 'N' }">
	                                <c:set var="color" value="${list.tmplatSeq}" />
	                                
	                                <c:if test="${empty color}">
	                                <c:set var="color" value="popcol_blue" />
	                                </c:if>
	
									<div class="popup-slide changeBg <c:out value="${color }" />" >
										<div class="adm_pop_bnr_p">
											<c:choose>
												<c:when test="${list.popupTyCode ne 'SC00000415'}">
													<%-- <c:set var="popHref">javascript:$(this).click();</c:set> --%>
													<c:set var="popHref">javascript:fnPopupOpen('<c:out value="${list.popupSeq}" />', '<c:out value="${status.count }" />');</c:set>
													<c:set var="popClick">onclick="fnPopupOpen('<c:out value="${list.popupSeq}" />', '<c:out value="${status.count }" />', this);"</c:set>
												</c:when>
												<c:otherwise>
													<c:set var="popHref">javascript:void(0);</c:set>
													<c:set var="popClick"></c:set>
												</c:otherwise>
											</c:choose>
											<a class="admdiv_wrap" href="<c:out value="${popHref }" />" id="popLink-<c:out value="${list.popupSeq }" />">
												<div class="admimg_404">
													<c:if test="${not empty list.thumbFileId}">
													<img  onerror="this.src='/images/wzwg/module/popup/404notfound.png'" src ="/module/upload/file/selectImageView.do?atchFileId=<c:out value="${list.thumbFileId}" />&fileSn=0"  alt="<c:out value="${list.thumbReplcText }" />">
													</c:if>
												</div>
												<div class="admtext_wrap">
													<h1><c:out value="${list.popupSj}" /></h1>
													<p><c:out value="${list.popupSjCn}" /></p>
													<span><c:out value="${status.count }" /></span>
												</div>
											</a>
										</div>
									</div> 
								</c:if>
							</c:forEach>
							</div>
							
							
						
						</div>	
						<span style="left: 8%; bottom: 10px; position: absolute; z-index: 1;">
						<input type="checkbox" name="popupCloseDay" id="popupCloseDay" style="margin-right:5px; "/>
						<label for="popupCloseDay"><spring:message code="wzwg.cmm.msg.wa.MSG005" /></label>
						</span>
						<a href="javascript:void(0);" onclick="fnPopupCheck();" class="admclose_btn" title="<spring:message code="wzwg.module.word.popupznclose" />"><spring:message code="wzwg.cmm.word.close" /></a>   <!-- 팝업이 슈욱 위로 사라지거나... 오늘하루동안 보지않기로.... -->

					</div>
     <div id="popupZone">
     </div>

    <script type="text/javascript">
	    
	    $(document).ready(function(){
	    	
	    	
			if($('.wzwgPopupList .popup-slide').length > 1){
				var ele = $('.wzwgPopupList');
				var slickOpt = {}; // 옵션 기본설정
				/* slickObj 선언 */
				var slickObj = $('.wzwg-popup-slide-data');
				try{
					 //console.log(slickObj.slick('getSlick').unslicked);
					 if(slickObj.slick('getSlick').unslicked == false){
						 //if 구문에서 에러가 발생하면 한번도 생성되지 않은상태
						 //false 이면 이미 slick이 실행되어 있기 때문에 destory 후 진행
						 slickObj.slick('unslick');
					 }
				 }catch(e){console.log(e.message);}
				

				// auto play 옵션 설정
				//var autoPlayTime = 3800;
				//var speed = 2500;
				slickOpt.autoplaySpeed = 3800;
				slickOpt.speed = 2500;
				 
				//slickOpt.autoplay = true;
				slickOpt.autoplay= true;
				slickOpt.pauseOnDotsHover=false;
				slickOpt.slidesToShow= 1;
				slickOpt.slidesToScroll= 1;
				slickOpt.touchThreshold = 30; //스와이프 민감도 (1 / touchThreshold) * 넓이
				slickOpt.infinite= true;
				slickOpt.focusOnSelect = true;
				slickOpt.accessibility = true; //방향키 조작

				//기본값이 자동재생 이므로 stop 버튼이 노출되도록
				//$(ele).find('.indicator .play').click();
				$(ele).find('.indicator .play').hide();
				$(ele).find('.indicator .stop').show();
				
				
				
				//페이지네이션 설정
				slickOpt.dots = true; //슬릭의 기본 도트는 무조건 노출(위젯CSS에서 컨트롤)
				

				// slick 이벤트 세팅
				$(ele).on('init', function(event, slick){
					//console.log(event);
					//console.log(slick);
					//초기 수행시
					ele.find('.indecator_number .total_count').html(slick.slideCount); //전체 개수 세팅 
				});
				 
				
				$(ele).on('afterChange', function(event, slick, nextSlide){
					ele.find('.indecator_number .this_count').html(slick.currentSlide +1);
					ele.find('.indecator_number .total_count').html(slick.slideCount);
				});
				
				
				/* slick play */
				slickObj.slick(slickOpt);
				
				
				/* play 이후 버튼 및 기능 설정 */
				if($(ele).find('.indicator').length == 1){
					 // indicator 가 있는 위젯이라면 해당 기능으로 해제 가능
					//재생/정지 버튼 컨트롤
					 $(ele).find('.indicator .stop').click(function(){
							//console.log('stop'); 
							//console.log(mySwiper);
						 //console.log($(ele));
						 slickObj.slick('slickPause');
						 $(ele).find('.indicator .stop').hide();
						 $(ele).find('.indicator .play').show();
						 $(ele).find('.indicator .play').focus();
					 });
					 
					 $(ele).find('.indicator .play').click(function(){
							//console.log('play'); 
							//console.log(mySwiper);
						 //console.log($(ele));
						 slickObj.slick('slickPlay');
						 $(ele).find('.indicator .play').hide();
						 $(ele).find('.indicator .stop').show();
						 $(ele).find('.indicator .stop').focus();
					 });
				}
				
				/* 클릭 이벤트 처리 */
				//ele.find('a').off();
				var agent = navigator.userAgent.toLowerCase();
				ele.find('a').each(function(){
					//if ( (navigator.appName == 'Netscape' && agent.indexOf('trident') != -1) || (agent.indexOf("msie") != -1)) {
					//     // ie일 경우
					//     $(this).attr('href', 'javascript:void(0);');
					//}else{
					//     // ie가 아닐 경우
					//	$(this).attr('href', 'javascript:$(this).click();');
					//}
					var _onclick = $(this).attr('onclick');
					var actClick = false;
					if(_onclick != '' && _onclick != undefined){
						$(this).attr('data-click', _onclick);
						$(this).removeAttr('onclick');
						actClick = true;
					}
					
					//$(this).click(function(event){
					//	console.log(_mouseMove);
					//})
					var _mouseX = false;
					//console.log($(this));
					$(this).on({
						'mousedown' : function(event){
							//console.log('mousedown');
							_mouseX = event.pageX;
						}
						, 'mouseup' : function(event){
							//console.log('mouseup');
							  //console.log(event)
							  if(_mouseX == event.pageX){
								  //이동없이 클릭됨
								  if(actClick){
									  var _reClick = $(this).attr('data-click');
									  $(this).attr('onclick', _reClick);
									  $(this).click();
									  $(this).removeAttr('onclick');
								  }else{
									  $(this).click();
								  }
							  }
						}
						//, 'keyup' : function(event){
						//	console.log(event.keyCode);
						//	if(event.keyCode == 13){
						//		console.log('엔터키');
						//		if(actClick){
						//			  var _reClick = $(this).attr('data-click');
						//			  $(this).attr('onclick', _reClick);
						//			  $(this).click();
						//			  $(this).removeAttr('onclick');
						//		  }else{
						//			  $(this).click();
						//		  }
						//	}
						//}
					});
				});
				
				
				
			}// end if
	    });

    </script>
  
    </c:if>
      
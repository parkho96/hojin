<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link rel="stylesheet" href="/css/wzwg/module/sideQuick/sidequick.css" type="text/css" />
<c:choose>
	<c:when test="${quickVO.qmenuRelmCode eq 'all'}"><c:set var="isSideQuickView" value="true"></c:set></c:when>
	<c:when test="${fn:indexOf(param.callPath, '/index.do') > -1 and quickVO.qmenuRelmCode eq 'main'}"><c:set var="isSideQuickView" value="true"></c:set></c:when>
	<c:when test="${fn:indexOf(param.callPath, '/index.do') == -1 and quickVO.qmenuRelmCode eq 'sub'}"><c:set var="isSideQuickView" value="true"></c:set></c:when>
	<c:otherwise><c:set var="isSideQuickView" value="false"></c:set></c:otherwise>
</c:choose>

<c:if test="${quickVO.useAt eq 'Y' and isSideQuickView }">
<script>
var quickWidthCache = 0;
function subQuickToggle(command){
	var quick = $('.subQuickMenu .quick .menuContents');
	var toggleBtn = $('.subQuickMenu .toggle button'); 
//	var toggleAction = 'slide';
	//var toggleAction = 'left';
	var toggleAction = 'vertical';//default //'horizontal' 
	
	if($('.subQuickMenu').hasClass('horizontal')){
		toggleAction = 'horizontal';
	}
	
	
	
	//console.log(toggleAction);
	
	//if (wzQuickMobile.matches) { // If media query matches
	//	toggleAction = 'right';
	//}
	
	if(quick.css('display') == 'none' && command == 'show'){
		//quick.toggle(toggleAction);
		//quick.show("slide", {direction: toggleAction}, 500)
		//quick.show("slide", {direction: 'down'}, 500)
		if(toggleAction == 'vertical'){
			quick.slideDown(function(){
				wzSubQuickMatchHeight();
			});
		}
		if(toggleAction == 'horizontal'){
			//quick.toggle('slide');
			//quick.show("slide", {direction: 'left'}, 500)
			quick.show(function(){
				quick.animate({width: quickWidthCache}, function(){
						quick.css('width', '');
						wzSubQuickMatchHeight();
						});
				
			})
		}
		$('.subQuickMenu .toggleView').hide();
		$('.subQuickMenu .toggleHide').show();
		$('.subQuickMenu .quick').removeClass('close');
		
		return;
	}
	
	if(quick.css('display') != 'none' && command == 'hide'){
		//quick.toggle(toggleAction);
		//quick.hide("slide", {direction: toggleAction}, 500)
		//quick.hide("slide", {direction: 'down'}, 500)
		if(toggleAction == 'vertical'){
			quick.slideUp(function(){
				wzSubQuickMatchHeight();
			});
		}
		if(toggleAction == 'horizontal'){
			//quick.toggle('slide');
			//quick.hide("slide", {direction: 'right'}, 500)
			quickWidthCache = quick.css('width');
			//quick.animate({width: 0});
 			quick.animate({width: 0}, function(){
				quick.hide();
				wzSubQuickMatchHeight();
			});
		}
		$('.subQuickMenu .toggleView').show();
		$('.subQuickMenu .toggleHide').hide();
		$('.subQuickMenu .quick').addClass('close');
		return;
	}
	
	
}

var selectCssNm = '<c:out value="${quickVO.cssNm}" />';

var wzQuickMobile_1600 = window.matchMedia("(max-width: 1600px)"); 
function wzwgQuickSwitch_1600(wzQuickMobile_1600){
	//console.log('ddd');
		if (wzQuickMobile_1600.matches) { // If media query matches
			//모바일버전
			 $('.subQuickMenu .toggleHide button').click();
			//왼쪽메뉴 템플릿 포지션 이슈로 추가
		}else{
			//pc버전
		}
		
		//wzSubQuickMatchHeight();
 }
 
var wzQuickMobile_990 = window.matchMedia("(max-width: 990px)"); 
function wzwgQuickSwitch_990(wzQuickMobile_990){
	//console.log('ddd');
		if (wzQuickMobile_990.matches) { // If media query matches
			//모바일버전
			//console.log('990 사이즈 이하');
			//왼쪽메뉴 템플릿 포지션 이슈로 추가
			$('#subQuickMenu').removeClass(selectCssNm);
			$('#subQuickMenu').addClass('mobileQuick');
		}else{
			//pc버전
			//console.log('990 사이즈 이상');
			$('#subQuickMenu').addClass(selectCssNm);
			$('#subQuickMenu').removeClass('mobileQuick');
		}
		
 }
 
function fn_leftTempltQuickPos(){
	if($('.wrap_left_template').length == 0){
		return;
	}
	
	fn_leftTempltQuickCssRule();
	
	$( window ).resize( function() {
		fn_leftTempltQuickCssRule();
	});
}

function fn_leftTempltQuickCssRule(){
	var leftQickRight = $(window).width() - ( $('#subQuickMenu').offset().left + $('#subQuickMenu').outerWidth(true)  );
	leftQickRight += parseInt($('#subQuickMenu .floating').css('margin-right').replace('px',''));
	leftQickRight = Math.floor(leftQickRight);
	if(leftQickRight < 0){
		leftQickRight = 0;
	}
	//console.log('leftQickRight : ' + leftQickRight);
	//$('.wrap_left_template .subQuickMenu .quick.fixed').css('right', leftQickRight + 'px');
	var cssRule = '.wrap_left_template .subQuickMenu .quick.fixed {right : ' + leftQickRight + 'px}';
	$('#customSubQickStyle').text(cssRule);
}

function wzSubQuickTopPosition(){
	var top = 0;
	
	if($('.wrap_left_template').length == 0){
		top = $('.fixedhead').css('position') == 'fixed' ? $('.fixedhead .menu').outerHeight() : 0; 
	}
	return top;
}

function wzSubQuickMatchHeight(){
	if($('#subQuickMenu .moveTop').css('position') == 'fixed'){
		$('.subQuickWrap').css({'min-height': $('#subQuickMenu .menuContents').height()+'px'});
		//console.log('fixed height : ' + $('#subQuickMenu .menuContents').height());
	}else{
		$('.subQuickWrap').css({'min-height': $('#subQuickMenu .floating').height()+'px'});
		//console.log('none fixed height : ' + $('#subQuickMenu .floating').height());
	}
	
	if($('.subQuickWrap').height() > $('#mainContent').height()){
		//퀵메뉴보다 컨텐츠 길이가 작으면 최소한으로 맞춰줌
		$('#mainContent').css('min-height', ($('.subQuickWrap').height() + 1) + 'px' );
	}
	
	console.log('SubQuickMatchHeight');
}

$(document).ready(function(){
	//console.log('quick jsp load');
	if(location.pathname.indexOf('/index.do') > -1){
		//$('.subQuickPosition').css({'margin-top': $('.contents .inner #template00').offset().top+'px'});
	}else{
		if($('#submenu').attr('href').indexOf('leftmenu') == -1){
			//$('.subQuickPosition').css({'margin-top': $('.sub_div_wrap').offset().top+'px'});
			$('.subQuickPosition').css('margin-top', $('#sub_visual').height() + 'px');
		}else{
			$('.subQuickPosition').css({'margin-top': '0px'});
		}
	}
	wzwgQuickSwitch_1600(wzQuickMobile_1600);
	wzwgQuickSwitch_990(wzQuickMobile_990);
	wzQuickMobile_1600.addListener(wzwgQuickSwitch_1600);
	wzQuickMobile_990.addListener(wzwgQuickSwitch_990);
	fn_leftTempltQuickPos();
	
	/* $('.sub_div_wrap').css('min-height', ($('.wzAffix').outerHeight() + 15) + 'px'); */
	//wzSubQuickMatchHeight();
	console.log('side quick ready');
});

//$(document).on('load', function(){
	//wzwgQuickSwitch(wzQuickMobile);
	//wzQuickMobile.addListener(wzwgQuickSwitch);
	//fn_leftTempltQuickPos();
	
//	wzSubQuickMatchHeight();
	//console.log('side quick load');
	//wzAffixInit();
//});


function testAddSubQuickItem(){
	var itemList = $('.subQuickMenu .menuContents ul');
	var itemCnt = itemList.find('li').length + 1;
	var item = '<li><a href="javascript:void(0);" onclick="alert(' + itemCnt + ')"><span><spring:message code="wzwg.cmm.word.quikNavi" /></span>' + itemCnt + '</a></li>';
	itemList.append(item);
}

function testRemoveSubQuickItem(){
	var itemList = $('.subQuickMenu .menuContents ul');
	var itemCnt = itemList.find('li').length -1;
	itemList.find('li').eq(itemCnt).remove();
}


</script>

<div class="subQuickPosition" style="z-index: 10; position: absolute; width:100%; visibility: hidden;">
	<div class="subQuickWrap wzAffix" data-topSpace="wzSubQuickTopPosition()" data-bottom="#footer" data-fix-point="" data-load-function="wzSubQuickMatchHeight" style="visibility: hidden; z-index: 1;">
	<div id="subQuickMenu" class="subQuickMenu <c:out value="${quickVO.cssNm }" /> "><!-- 테마선택 클래스 값을 입력 -->
		<div class="position">
			<div class="floating">
				<div class="quick">
					<div class="toggleBtn toggle <c:out value="${quickVO.bgcolorVal }" />"><!-- 배경선택 클래스 값을 입력 -->
						<div class="quick-title"><c:out value="${quickVO.qmenuetNm }" /></div>
						<div class="toggleView" style="display: none;"><button type="button" onclick="subQuickToggle('show')" ><spring:message code="wzwg.module.word.quikNaviopen" /></button></div>
						<div class="toggleHide"><button type="button" onclick="subQuickToggle('hide')" ><spring:message code="wzwg.module.word.quikNaviclose" /></button></div>
					</div>
					<div class="menuContents">
						<ul>
							<c:forEach items="${linkList }" var="list">
								<c:if test="${list.menuSttusCode eq 'Y'}">
									<c:choose>
										<c:when test="${list.qmenuTySe eq 'L' }">
										<li>
											<a href="<c:out value="${list.qmenuLinkUrl }" />" <c:if test="${list.qmenuTyCode eq 'new' }"> target="_blank"</c:if>>
											<c:if test="${not empty list.menuImagePath }"><img src="<c:out value="${list.menuImagePath }" />" alt=""></c:if>
											<span><c:out value="${list.qmenuNm }" /></span>
											</a>
										</li>
										</c:when>
										<c:when test="${list.qmenuTySe eq 'D' }">
										<li class="division"><c:out value="${list.qmenuNm }" /></li>
										</c:when>
									</c:choose>
								</c:if>
							</c:forEach>
						</ul>
					</div>
					<div class="movBtn">
						<div id="topBtn" class="qscroll moveTop"><a href="#_top" title="<spring:message code="wzwg.module.word.totopmvmn" />" onclick="$('html, body').animate({scrollTop: '0'})">TOP</a></div>
						<div id="bottomBtn" class="qscroll moveBottom"><a href="#_bottom" title="<spring:message code="wzwg.module.word.tobottommvmn" />" onclick="$('html, body').animate({scrollTop: $(document).height()})">BOTTOM</a></div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</div>
</c:if>

<c:if test="${quickVO.useAt ne 'Y' or not isSideQuickView}">

<script>
$(document).scroll(function(){ 
	var movScrolpx = $(document).scrollTop();
	var innerHeight = $('.head-group').outerHeight(true) + $('#sub_visual').outerHeight(true) - 100;
	
	if(movScrolpx > innerHeight){     
		$('.quick').css('display', 'block');
		
		movScrolpx - $('#footer').outerHeight();
		$('.quick').css('position','fixed');
		$('.quick').css('bottom', '0');		
	}else{    
		$('.quick').css('display', 'none');
		$('.quick').css('position','relative');
		$('.quick').css('bottom', '');	
	}
	
	var endScroll = $(document).height() - $(window)[0].innerHeight;
	
	var footerTop = endScroll - $('#footer').outerHeight(true);
	if (footerTop <= movScrolpx){
		var bottomValChange = movScrolpx - footerTop; 
		$('.quick').css('bottom', bottomValChange);
	}    
})
</script>
<div id="topBtnDiv" class="subQuickMenu topBtnOnly" style="height:0; top:unset; bottom:0;">
	<div class="position">
		<div class="floating">
			<div class="quick" data-topspace="0" data-fix-point="" data-affix="off" data-affix-bottom="0" style="right: 0px; position: relative;">
				<div id="topBtn" class="moveTop">
					<a href="#_top" title="<spring:message code="wzwg.module.word.totopmvmn" />" onclick="$('html, body').animate({scrollTop: '0'})">TOP</a>
				</div>
				<div id="bottomBtn" class="moveTop">
					<a href="#_bottom" title="<spring:message code="wzwg.module.word.tobottommvmn" />" onclick="$('html, body').animate({scrollTop: $(document).height()})">BOTTOM</a>
				</div>
			</div>
		</div>
	</div>
</div>
</c:if>
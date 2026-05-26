<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%-- 위디자인 배경 컬러 세팅 --%>
<c:set var="pointColList">bg-red,bg-pink,bg-orange,bg-yellow,bg-green,bg-blue,bg-brown,bg-violet,bg-purple,bg-grey,bg-white,bg-black</c:set>
<c:set var="pointColStrList">bg-red-strong,bg-pink-strong,bg-orange-strong,bg-yellow-strong,bg-green-strong,bg-blue-strong,bg-brown-strong,bg-violet-strong,bg-purple-strong,bg-grey-strong,bg-navy</c:set>

<script>

$(document).ready(function(){
	qmenuStyleRefresh();
	
	fnAppendQuickLinkListAjax();
	
	setInterval(fnQuickPosition,0);
	
});

var quickCache;
var quickPosKey = true;

function fnQuickPosition(){
	//console.log($('.quick').css('position'));
	if($('.quick').css('position') == 'fixed'){
		//console.log('quick fix');
		//quickPosKey = false;
		//if($('.quick').css('right') == '0px'){
		//	$('.quick').css('right', quickCache + 'px');
		//}
		
	}else{
		quickCache = $(window).width() - ($('.quick').offset().left + $('.quick').outerWidth(true));
		//$('.quick').css('right', '0px');
		//quickPosKey = true;
	}
	
	/* if(quickPosKey == false){
		$('.quick').css('right', quickCache + 'px');
	} */
}

function fnAppendQuickLinkListAjax(){
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/selectSideQuickLinkListAjax.do'
		, data:{qmenuetSeq : $('#qmenuetSeq').val()}
		,success:function (result){ 
			//console.log(result.body.linkList);
			var linkListHtml = result.html.linkListJsp;
			$('#sideQuickLinkListArea').html(linkListHtml);
			
			$('#sideQuickLinkListArea .ordBtns:first button:first').css('color', '#ccc');
			$('#sideQuickLinkListArea .ordBtns:first button:first').attr('disabled', 'disabled');
			$('#sideQuickLinkListArea .ordBtns:last button:last').css('color', '#ccc');
			$('#sideQuickLinkListArea .ordBtns:last button:last').attr('disabled', 'disabled');
			
			var linkListJson = result.body.linkList;
			var linkList = $('#subQuickMenu .menuContents ul');
			linkList.empty();
			
			for(var i = 0 ; i < linkListJson.length ; i++){
				var linkData = linkListJson[i];
				
				if(linkData.menuSttusCode == 'N'){
					continue;
				}
				
				var listItem = $('<li></li>');//'<li><a href="javascript:void(0);" onclick="alert(1)"><span>퀵메뉴1</span></a></li>';
				
				
				if(linkData.qmenuTySe == 'L'){
					var link = $('<a></a>');
					if(linkData.menuImagePath){
						//console.log(linkData.menuImagePath);
						link.append('<img src="' + linkData.menuImagePath + '">')
					}
					link.append('<span>' + linkData.qmenuNm + '</span>');
					link.attr('href', linkData.qmenuLinkUrl);
					link.attr('title', linkData.qmenuDc);
					if(link.qmenuTyCode == 'new'){
						link.attr('target', '_blink');
					}
					
					listItem.html(link);
				}else if(linkData.qmenuTySe == 'D'){
					//var dvs = $('<div class="division"></div>');
					//dvs.html(linkData.qmenuNm);
					
					//listItem.append(dvs);
					listItem.addClass('division');
					listItem.html(linkData.qmenuNm);
				}
				
				linkList.append(listItem);
			}
			//console.log(linkListJson.length);
			
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}

function fnQuickLinkRegistForm(){
	
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/selectSideQuickRegistFormAjax.do'
		, data:{qmenuetSeq : $('#qmenuetSeq').val()}
		,success:function (data){ 
			wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.menulinkregist"/>', data);
			
			/* $('.wzpopup .close').click(function(){
				//$('.linkMenuList').off();
				$('.linkMenuList').tendina('destroy')
				console.log('tendina destroy');
			}) */
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}

function fnQuickLinkModifyForm(qmenuSeq){
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/selectSideQuickModifyFormAjax.do'
		, data:{
				qmenuetSeq : $('#qmenuetSeq').val()
				, qmenuSeq : qmenuSeq
				}
		,success:function (data){ 
			wzAjaxModal('popup_s', '<spring:message code="wzwg.module.word.menulinkupdt"/>', data);
			
			/* $('.wzpopup .close').click(function(){
				//$('.linkMenuList').off();
				$('.linkMenuList').tendina('destroy')
				console.log('tendina destroy');
			}) */
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}

function fnQuickLinkDelete(qmenuSeq, qmenuTySe, qmenuNm){
	var delMsg = '';
	if(qmenuTySe == 'D'){
		//delMsg = '구분선을 삭제 합니까?';
		delMsg = '<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.module.word.seline"/></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete"/></spring:argument></spring:message>';
	}else if(qmenuTySe == 'L'){
		//delMsg = '링크 [' + qmenuNm + '] 메뉴를 삭제 합니까?';
		delMsg = '<spring:message code="wzwg.cmm.word.link"/> [' + qmenuNm + '] <spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.menu"/></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>';
	}
	
	if(confirm(delMsg)){
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/deleteSideQuickLinkAjax.do'
			, data:{
					qmenuetSeq : $('#qmenuetSeq').val()
					, qmenuSeq : qmenuSeq
					}
			,success:function (data){ 
				if(data.head.result == 'success'){
					//alert('링크를 삭제 하였습니다.');
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.link"/></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete"/></spring:argument></spring:message>');
					fnAppendQuickLinkListAjax();
				}else{
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			}
			, error:function (request, status, error) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		});
	}
}

function fnQuickLinkOrdrChange(cmd, btn){
	//alert(command + '/' + $(btn).attr('data-qmenuSeq'));
	console.log(cmd + '/' + $(btn).attr('data-qmenuSeq'));
	$.ajax({
		type:'POST'
		, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/modifySideQuickLinkOrdrAjax.do'
		, cache : false
		, async : false
		, data:{
				qmenuetSeq : $('#qmenuetSeq').val()
				, qmenuSeq : $(btn).attr('data-qmenuSeq')
				, command : cmd
				}
		,success:function (data){ 
			if(data.head.result == 'success'){
				fnAppendQuickLinkListAjax();
			}else{
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}



/* 이하 기본 설정값 관련 */
var stbsType = '${empty quickStbsVO}' == 'true' ? 'regist' : 'modify';
function modifySideQuickStbs(){
	
	if($('input[name="useAt"]:checked').val() == 'Y'){
		//퀵메뉴 사용 일때만 체크		
		if($('#qmenuetNm').val() == ''){
			alert('[<spring:message code="wzwg.cmm.word.sj" />] <spring:message code="wzwg.cmm.msg.MSG036"/>');
			$('#qmenuetNm').focus();
			return;
		}
		
		//if($('#qmenuetDc').val() == ''){
		//	alert('[<spring:message code="wzwg.cmm.word.sj" /> <spring:message code="wzwg.cmm.word.dc" />] <spring:message code="wzwg.cmm.msg.MSG036"/>');
		//	$('#qmenuetDc').focus();
		//	return;
		//}
	}
	
	
	
	if($('#cssSeq').val() == ''){
		$('#cssSeq').val('<c:out value="${cssList[0].cssSeq}" />');//basic 기본값
	}
	if($('#bgcolorVal').val() == ''){
		$('#bgcolorVal').val('bg-white');// 기본값
		
	};
	
	var sendUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/modifySideQuickStbsAjax.do'
	
	if(stbsType == 'regist'){
		sendUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/sideQuick/registSideQuickStbsAjax.do'
	}
	
	$.ajax({
		type:'POST'
		, url:sendUrl
		, data:$("#sideQuickForm").serialize()
		,success:function (data){ 
			console.log(data);

			if(data.head.result == 'success'){
				$('#sideQuickInfoList').show();
				stbsType = 'modify';
				var qmenuetSeq = data.body.qmenuetSeq;
				if(qmenuetSeq){$('#qmenuetSeq').val(qmenuetSeq);}
				qmenuStyleRefresh();
				alert('<spring:message code="wzwg.cmm.msg.MSG080"/>');
			}else{
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		}
		, error:function (request, status, error) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	});
}

function selectCssStyle(cssSeq, cssNm, btn){
	$('.quickStyleList .styleBtn').removeClass('adm_active');
	$(btn).addClass('adm_active');
	$('#cssSeq').val(cssSeq);
	$('#cssNm').val(cssNm);
	
	qmenuStyleRefresh();
}

function selectPointCol(col){
	$('#bgcolorVal').val(col);
	
	qmenuStyleRefresh();
}

function qmenuStyleRefresh(){
	var selectStyle = $('#cssNm').val();
	var selectBgCss = $('#bgcolorVal').val();
	var selectTitle = $('#qmenuetNm').val();
	console.log(selectBgCss);
	$('.quickColList button').removeClass('ico-check');
	$('.quickColList button').removeClass('white');
	$('.quickColList button').each(function(){
		if($(this).hasClass(selectBgCss)){
			console.log($(this));
			$(this).addClass('ico-check');
			if($(this).attr('class').indexOf('strong') > -1
			 	|| $(this).attr('class').indexOf('bg-navy') > -1
			 	|| $(this).attr('class').indexOf('bg-black') > -1){
				$(this).addClass('white');
			}
		}
	});
	//var selectTitleDc = $('#qmenuetDc').val();
	if(selectTitle == ''){
		selectTitle = '<span class="gray">(<spring:message code="wzwg.cmm.word.untitle"/>)</span>';
	}
	
	if($('#btn_mobilePreview').hasClass('on')){
		selectStyle = 'mobileQuick';
	}
	
	$('#subQuickMenu').attr('class', 'subQuickMenu ' + selectStyle);
	$('#subQuickMenu .toggleBtn').attr('class', 'toggleBtn toggle ' + selectBgCss);
	
	$('#subQuickMenu .quick-title').html(selectTitle);
	//$('#subQuickMenu .toggleView button').attr('title', selectTitleDc + ' <spring:message code="wzwg.cmm.word.open01"/>');
	//$('#subQuickMenu .toggleHide button').attr('title', selectTitleDc + ' <spring:message code="wzwg.cmm.word.close"/>');
}

function fnPreviewMobile(){
	if($('#btn_mobilePreview').hasClass('on')){
		$('#btn_mobilePreview').removeClass('on');
		//$('#btn_mobilePreview').removeClass('ico-check_a');
		//off 상태
	}else{
		$('#btn_mobilePreview').addClass('on');
		//$('#btn_mobilePreview').addClass('ico-check_a');
		//on 상태
	}
	
	qmenuStyleRefresh();
}



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
				//wzSubQuickMatchHeight();
			});
		}
		if(toggleAction == 'horizontal'){
			//quick.toggle('slide');
			//quick.show("slide", {direction: 'left'}, 500)
			quick.show(function(){
				quick.animate({width: quickWidthCache}, function(){
						quick.css('width', '');
						//wzSubQuickMatchHeight();
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
				//wzSubQuickMatchHeight();
			});
		}
		if(toggleAction == 'horizontal'){
			//quick.toggle('slide');
			//quick.hide("slide", {direction: 'right'}, 500)
			quickWidthCache = quick.css('width');
			//quick.animate({width: 0});
 			quick.animate({width: 0}, function(){
				quick.hide();
				//wzSubQuickMatchHeight();
			});
		}
		$('.subQuickMenu .toggleView').show();
		$('.subQuickMenu .toggleHide').hide();
		$('.subQuickMenu .quick').addClass('close');
		return;
	}
	
	
}
</script>

<div class="wz_notice brbox bg-white br-blue-strong">	
   <ul class="wd100">
       <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG059" /> </li>
       <li class="admpg-subp wd100 mb0">· <spring:message code="wzwg.cmm.msg.tip.MSG060" /></li>
   </ul>
</div>

<div class="w80 i-block wm100">

	<form id="sideQuickForm" name="sideQuickForm" method="post" enctype="multipart/form-data">
		<input type="hidden" name="qmenuetSeq" id="qmenuetSeq" value="<c:out value="${quickStbsVO.qmenuetSeq }" />">
		<input type="hidden" name="cssSeq" id="cssSeq">
		<input type="hidden" name="cssNm" id="cssNm" value="<c:out value="${quickStbsVO.cssNm }" />">
		<input type="hidden" name="bgcolorVal" id="bgcolorVal" value="<c:out value="${quickStbsVO.bgcolorVal }" />">
		<input type="hidden" name="qmenuetDc" id="qmenuetDc" value="">
		<table class="basic">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
			<tbody>
			  	<tr class="">
			  		<th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.module.word.bassestbs" /></th>
			  	</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.useat" /></th>
					<td>
						<ul class="wzForm">
							<li><input type="radio" name="useAt" value="Y" id="useAtY" <c:if test="${quickStbsVO.useAt eq 'Y' }">checked="checked"</c:if>><label for="useAtY"><spring:message code="wzwg.cmm.word.use" /></label></li>
							<li><input type="radio" name="useAt" value="N" id="useAtN" <c:if test="${quickStbsVO.useAt eq 'N' or empty quickStbsVO}">checked="checked"</c:if>><label for="useAtN"><spring:message code="wzwg.cmm.word.unuse" /></label></li>
						</ul>
					</td>
				</tr>
				
				<tr>
					<th><spring:message code="wzwg.module.word.exposurerelm" /></th>
					<td>
						<select name="qmenuRelmCode">
							<option value="all" <c:if test="${quickStbsVO.qmenuRelmCode eq 'all' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
							<option value="main" <c:if test="${quickStbsVO.qmenuRelmCode eq 'main' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.main" /></option>
							<option value="sub" <c:if test="${quickStbsVO.qmenuRelmCode eq 'sub' }">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sub" /></option>
						</select>
					</td>
				</tr>
				
				<tr>
					<th><spring:message code="wzwg.cmm.word.sj" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td >
						<div>
							<input type="text" class="w50" id="qmenuetNm" name="qmenuetNm" value="<c:out value="${quickStbsVO.qmenuetNm }" />" placeholder="QUICK MENU">
						</div>
						<span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG061" /></span>
					</td>
				</tr>
				
				<tr>
					<th><spring:message code="wzwg.module.word.designchange"/></th>
					<td>
						<div class="fl wd100 mb20">
							<button type="button" id="btn_mobilePreview" class="wzbtn-table btn-basic fs16" onclick="fnPreviewMobile()"><spring:message code="wzwg.module.word.mobilepreview"/><i class=" ml5 fa fa-eye" aria-hidden="true"></i></button>
							<p class="admpg-subp w100 fl mt10 mb15"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG435"/></p>
						</div>
						<ul class="quickStyleList">
							<c:forEach var="list" items="${cssList }">
							<c:set var="selectStyleBg"></c:set>
							<c:if test="${quickStbsVO.cssSeq eq list.cssSeq }"><c:set var="selectStyleBg">adm_active</c:set></c:if>
							<li class="wm-auto">
								<button type="button" class="styleBtn <c:out value="${selectStyleBg }" />" onclick="selectCssStyle('<c:out value="${list.cssSeq}" />', '<c:out value="${list.cssNm}" />', this)">
									<img src="<c:out value="${list.prevewPath }" />">
									<div class="wz_tableguide pt10 fs18"><c:out value="${list.cssNm }" /></div>
								</button>
							</li>
							</c:forEach>						
						</ul>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.module.word.pointcolor"/></th>
					<td>
						<div class="quickColList">
							<ul>
								<c:forEach items="${fn:split(pointColList, ',') }" var="list">
								<li class="fn i-block mb10"><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
								</c:forEach>
								<c:forEach items="${fn:split(pointColStrList, ',') }" var="list">
								<li class="fn i-block mb10"><button type="button" class="<c:out value="${list }" />"  onclick="selectPointCol('<c:out value="${list }" />')"></button></li>
								</c:forEach>
							</ul>
						</div>
					</td>
				</tr>
				 <tr>
				 	<td colspan="2" style="text-align: right;"><button type="button" class="wzbtn btn-save" onclick="modifySideQuickStbs()"><spring:message code="wzwg.cmm.word.stre"/></button></td>
				 </tr>
			</tbody>
		</table>
	</form>




	
	<div id="sideQuickInfoList" <c:if test="${empty quickStbsVO }"> style="display:none;"</c:if>>
		<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.module.word.menulinkestbs"/></h3>

		<div id="sideQuickLinkListArea"></div>

		<div class="wz-box mb0 br-none bg-white txt-r">
			<button class="wzbtn btn-save" onclick="fnQuickLinkRegistForm()"><spring:message code="wzwg.cmm.word.regist"/></button>
		</div>
	</div>
</div>

	
<div class="w20 i-block fr pl10 mobile-none box-border txt-c" id="sideQuickMngrView" style="position: relative;">
	<span class="wzAdmSTit i-block wd100"><spring:message code="wzwg.cmm.word.preview"/></span>
	
	<link rel="stylesheet" href="/css/wzwg/module/sideQuick/sidequick.css" type="text/css" />
	
	<div class="subQuickWrap wzAffix" data-topSpace="0" data-bottom="#footer" data-fix-point="">
		<div id="subQuickMenu" class="subQuickMenu <c:out value="${quickVO.cssNm }" /> "><!-- 테마선택 클래스 값을 입력 -->
			<div class="position">
				<div class="floating">
					<div class="quick">
						<style>
							.mobileQuick .toggleBtn {right:-35px;}
							@media (min-width:1660px){.subQuickWrap .subQuickMenu:not(.flip_box) {width:100%;}}
						</style>
						<div class="toggleBtn toggle <c:out value="${quickVO.bgcolorVal }" />"><!-- 배경선택 클래스 값을 입력 -->
							<div class="quick-title"><c:out value="${quickVO.qmenuetNm }" /></div>
							<div class="toggleView" style="display: none;"><button type="button" onclick="subQuickToggle('show')" ><spring:message code="wzwg.module.word.quikNaviopen" /></button></div>
							<div class="toggleHide"><button type="button" onclick="subQuickToggle('hide')" ><spring:message code="wzwg.module.word.quikNaviclose" /></button></div>
						</div>
						<div class="menuContents">
							<ul>
							</ul>
						</div>
						<div class="movBtn">
							<div id="topBtn" class="qscroll moveTop"><a href="#_top" title="<spring:message code="wzwg.module.word.wa.totopmvmn" />" onclick="$('html, body').animate({scrollTop: '0'})">TOP</a></div>
							<div id="bottomBtn" class="qscroll moveBottom"><a href="#_bottom" title="<spring:message code="wzwg.module.word.wa.tobottommvmn" />" onclick="$('html, body').animate({scrollTop: $(document).height()})">BOTTOM</a></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
	

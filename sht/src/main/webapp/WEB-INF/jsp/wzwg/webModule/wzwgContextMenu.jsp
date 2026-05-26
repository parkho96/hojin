<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp"%>
<script>
/**
 * @author 위즈위그 dev_cwk
 * @since 2018.08.31
 * @version 1.0
 * @contact http://sr.wiz-builder.com
 * @latest 2020.01.22
 */

 
 /* global variable */
 var bgChangeMode = 'background'; //background : 배경색 변경, border : 테두리색 변경
 
 var subPageMode = false;
 
 
 /* local variable*/
 var logMode = true;

 
var isSysMngr = location.pathname.indexOf('/sysMngr/screen/selectSiteScreenTempIndexMngr.do') == 0;

var migrationSelectors = [ 
                           /* editMode_wzwg.js 파일에 정의되어 있는 selector*/
                           '.unityLink_one_001' ,'.unityLink_two_001' ,'.unityLink_two_002' ,'.unityLink_two_003' ,'.unityLink_three_001' ,'.unityLink_three_002'
                          ,'.unityLink_four_001' ,'.unityLink_four_002' ,'.unityLink_four_003' ,'.unityLink_four_004' ,'.unityLink_four_005' ,'.unityLink_five_001'
                          ,'.unityLink_five_002' ,'.unityLink_five_003' ,'.unityLink_five_004' ,'.unityLink_five_005' ,'.unityLink_five_006' ,'.unityLink_six_001'
                          ,'.unityLink_six_002' ,'.unityLink_six_003' ,'.unityLink_six_004' ,'.unityLink_six_005' ,'.unityLink_seven_001' ,'.unityLink_seven_002'
                          ,'.unityLink_seven_003' ,'.unityLink_seven_004' ,'.unityLink_eight_001' ,'.unityLink_eight_002' ,'.rolling_four_001' ,'.mainSlider_001'
                          ,'.mainSlider_txt_001' ,'.mainSlider_txt_002' ,'.mainSlider_txt_003' ,'.mainSlider_txt_004' ,'.mainSlider_txt_005' ,'.modifyMenuDc' ,'.modifyImg'
                          
                          /* editMode.js 파일에 정의되어 있는 selector 독립적인 callbackFunc 을 가지고 있음 */
                          ,'.imgContext', '.mainSlider', '.mainBootSlider', /* '.quickBannerConfZone', */ '.quickBannerConfZoneImg', '.quickBannerConfZoneNoBG'
                          ,/* '.changeBg' */, '.mainBanner', '.mainBanner2', '.mainBanner3', '.mainLink', '.mainTxtTitle', '.mainTxtContent', '.mainSliderTxt'
                          ,/* '.hdmenu', */ /* '.ftrmenu', */ 
                          
                          /* editMode.js 파일에 정의되어 있는 selector contextMenuFunc 으로 통합된 셀렉터 */
                          ,'.mainBanner4', '.banerCustom004', '.banerCustom005', '.shopCustom008', '.shopCustom005', '.banerCustom005_2'
                          ,'.bannerTxtImgTargetBG', '.bannerContentImgTargetBG', '.rollingTxtImgIcoBg', '.bannerContentImg', '.mainBanner5'
                          ,'.mainBanner9', '.quickTitleLink', '.mainBanner6', '.mainBanner7', '.mainBanner8', '.mainBannerFont1'
                          ,'.mainBannerTitleFont', '.changeImg', '.changeImgBg', '.imageLink', '.changeLink', '.changeColTxtBg'
                          ,'.contentsSlider', '.mainSliderContents', '.mainSliderContentsNoImg', '.contentsSlideTxtBanner', '.slideTxtBanner'
                          ,'.slideTxtBannerPositionTop', '.rollingTxtFntBG', '.rollingTxtFnt', '.rollingTitleFnt', '.rollImg009', '.rollImg011'
                          ,'.boardColTitleBG', '.boardChangeCol', '.boardChangeColBG', '.boardChangeColTitle', '.boardChangeColContent'
                          ,'.bannerTxt', '.bannerTxt2', '.bannerContentsBG', '.bannerTxtBG', '.bannerTxtBGLinktitle', '.bannerTxtTargetBG'
                          ,'.changeTargetBG', '.changeBgNTarget', '.tableBG', '.tableTrBG', '.bannerTxtImgLink', '.bannerTitleImg'
                          ,'.bannerTitleImgLink', '.bannerTitleImgLinkTargetBG', '.bannerTitleBG', '.quickTxtImgLink', '.quickTxtImgLinkBG'
                          ,'.quickTxtLinkBG', '.quickTitleImgLink', '.quickTitleImgLinkBG', '.quickTitleImgLinkTargetBG', '.bannerTitleImgLinkBG'
                          ,'.changeBgLink', '.EtcText003_1', '.gallery007_1', '.youtubeLink'
                          
                          ,'.wzwg-swiper', '.wzwg-slide-info', '.wzwg-banner-slide-info'
                          ,'.empty', '.layout_wrap'
                          ];


var subMenuPassList = [
                       'wzwg-tab-board',  'layout_wrap' , 'quickBannerConfZone'
                       ,'wzwg-tab-list'
                       ]
function testPassClassName(obj){
	
	for(var i = 0 ; i < subMenuPassList.length; i++){
		if(obj.hasClass(subMenuPassList[i])){
			return true;
		}
	}
	
	return false;
}
function wzwgCMSelectorInit(){
	if(logMode){
		console.log('wzwgCMSelector init::');
	}
	
	for(var i=0; i < migrationSelectors.length; i++){
		var oldSelector = migrationSelectors[i];
		
		$(oldSelector).each(function(){
			if($(this).hasClass('wzwgContextMenu') == false){
				$(this).addClass('wzwgContextMenu');
			}
			
			var notContext = $(this).hasClass('noneContextMenu');
			if(notContext == true){
				$(this).removeClass('wzwgContextMenu');
			}
		});
				
				
	}// end for
	
	$('.cntContextSGC0000027, .cntContext10000000204').each(function(){
		//게시판 모듈일 경우 슬라이드 위젯에서 컨텍스트 메뉴제거
		var _slide = $(this).find('.wzwg-slide-info');
		if(_slide.hasClass('wzwgContextMenu')){
			_slide.removeClass('wzwgContextMenu');
		}
	});
	
	$('#mainVisual00').find('.layout_wrap').removeClass('wzwgContextMenu');
	
	$('.quickBannerZone').each(function(){
		$(this).children().attr('data-type' ,'quick');
	});
	
//	$('.wzwgContextMenu').children().find('.wzwgContextMenu').addClass('cmlv2');
//	$('.cmlv2').children().find('.wzwgContextMenu').addClass('cmlv3');
	
/*		if($(oldSelector).hasClass('wzwgContextMenu') == false){
			$(oldSelector).addClass('wzwgContextMenu');
		}
*/	

	$('.head-group').addClass('wzwgHeadContextMenu');
	$('.footer').addClass('wzwgFooterContextMenu');
}


function wzwgCMBuilder(){
	wzwgCMSelectorInit();
	
	
	$.contextMenu({
		selector: '.wzwgContextMenu',
		build: function($triggerElement, e){
			//console.log($triggerElement);
			//console.log($triggerElement.attr('data-title'));
			
			 var options = { 
			            callback: wzwgCMFunc,
			            // start with an empty map
			            items: {}
			        };
			 
			 options.items = wzwgCMOptions($triggerElement);
			 
			 return options;
	    }
	,zIndex: 10
	});
	
	/* 통합 게시판 목록 */
	$.contextMenu({
		selector: '.cntContextSGC0000027',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgCMBoardOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	
	/* 일정메뉴 목록 */
	$.contextMenu({
		selector: '.cntContext10000000104',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgScheduleOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	
	/* 동영상 메뉴 목록 */
	$.contextMenu({
		selector: '.cntContext10000000204',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgMvpBoardOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	
	/* 지도모듈 메뉴 목록 */
	$.contextMenu({
		selector: '.cntContext10000000213',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgMapModuleOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	
	/**/
	$.contextMenu({
		selector: '.quickBannerConfZone',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgCMQuickConfOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/* 로그인 위젯 전용 메뉴 */
	$.contextMenu({
		selector: '.wzwgLoginContextMenu',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgLoginWidgetOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/* 서브컨텐츠 탭컨테이너 전용 */
	$.contextMenu({
		selector: '.wzwgTabContextMenu',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgTabContextOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/* 테이블위젯 전용 */
	$.contextMenu({
		selector: '.wzwgTableContextMenu',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgTableContextOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/* 레이아웃 설정 전용 */
	$.contextMenu({
		selector: '.wzwgLyotContextMenu',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgLayoutContextOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	// 왼쪽클릭도 지원하도록 두번 설정함
	$.contextMenu({
		selector: '.wzwgLyotContextMenu',
		trigger: 'left',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgLayoutContextOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/*과기대 전용 스크립트*/
	$.contextMenu({
		selector: '.cntContext20000000010',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = {
				  	//"skinReplace": {name: "스킨변경", icon: "edit"}, 
				  	"dataReplace" : {
				  					name: wz_msg('wzwg.cmm.word.scrin.timeChg'), icon: "link",
				  					items:{
				  						  
				  			              "timetable_20000000370":{name:wz_msg('wzwg.cmm.word.scrin.lctreTime'),icon:"edit", menuSeq : "20000000370"}
				  						  }
				  					}
				 				};
			
			options.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit"};
			
			options.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjColChg'), icon: "edit" , target: "tabletit"};
			
			options.items["modifyTHColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.tcketSjColChg'), icon: "edit" , target: "dataTitle"};
			options.items["modifyTHBg_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.tcketSjBgColChg'), icon: "edit" , target: "dataTitle"};

			options.items["modifyTDColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.tableFontColChg'), icon: "edit"};
			
			options.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "targetBG"};
			
			return options;
		}
	,zIndex: 10
	});
	
	function seoulTechFunc(key, opt){
		if(key.indexOf('timetable_') >= 0){
			var menuSeq = opt.commands[key].menuSeq;
			var name = opt.commands[key].name;
			
			if(logMode) console.log(menuSeq);
			
			//$(this).data("cntseq",boardSeq);
			$(this).attr("data-cntseq",menuSeq); 
			//if(logMode) console.log(this);
			getTimeTable($(this));
		}
	}
	/*과기대 전용 스크립트 끝*/
	
	/**
	$.contextMenu({
		selector: '.layout_wrap',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			//options.items = wzwgCMOptions($triggerElement);
			options.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "changeBg"};
			return options;
		}
	,zIndex: 10
	});
	/**/
	
	/* 헤더그룹 컨텍스트 메뉴 세팅 */
	$('.head-group .header').addClass('topMenu');
	$('.head-group .menu').addClass('headMenuBg');
	$('.head-group .menu .lnb').addClass('headMenuList');
	/* $('.wzwgHeadContextMenu').on('mousedown', function(e){
		if((e.button == 2) || (e.which == 3)) {
			//console.log('마우스 우클릭');
			//$('.context-menu-one').contextMenu();
			//$(this).contextMenu();
			cssMenuScreenX = e.pageX;
			cssMenuScreenY = e.pageY;
			//console.log(e);
			//console.log(cssMenuScreenX);
			//console.log(cssMenuScreenY);
			wzwgSelectCssCommand('head', this);
		}
	})
	$.contextMenu({
		selector: '.wzwgHeadContextMenu',
		build: function($triggerElement, e){
			var options = { 
					callback: wzwgCMFunc,
					items: {}
			};
			options.items = wzwgHeadmenuContextOptions($triggerElement);
			return options;
		}
	,zIndex: 10
	,trigger: 'none'
	,	position: function(opt, x, y){
		
	        opt.$menu.css({top: cssMenuScreenY, left: cssMenuScreenX});
	    } 
	}); */
	
	if(location.pathname.indexOf('/screen/subList/') == -1){
	
		$('.topMenu').on('mousedown', function(e){
			if((e.button == 2) || (e.which == 3)) {
				cssMenuScreenX = e.pageX;
				cssMenuScreenY = e.pageY;
				wzwgSelectCssCommand('head', this);
			}
		})
		$.contextMenu({
			selector: '.topMenu',
			build: function($triggerElement, e){
				var options = { 
						callback: wzwgCMFunc,
						items: {}
				};
				options.items = wzwgHeadmenuContextOptions($triggerElement);
				return options;
			}
		,zIndex: 10
		,trigger: 'none'
		,	position: function(opt, x, y){
			
		        opt.$menu.css({top: cssMenuScreenY, left: cssMenuScreenX});
		    } 
		});
		
		$('.headMenuBg').on('mousedown', function(e){
			if((e.button == 2) || (e.which == 3)) {
				cssMenuScreenX = e.pageX;
				cssMenuScreenY = e.pageY;
				wzwgSelectCssCommand('head', this);
			}
		})
		$.contextMenu({
			selector: '.headMenuBg',
			build: function($triggerElement, e){
				var options = { 
						callback: wzwgCMFunc,
						items: {}
				};
				options.items = wzwgHeadmenuContextOptions($triggerElement);
				return options;
			}
		,zIndex: 10
		,trigger: 'none'
		,	position: function(opt, x, y){
			
		        opt.$menu.css({top: cssMenuScreenY, left: cssMenuScreenX});
		    } 
		});
		
		
		
		
		/* 푸터그룹 컨텍스트 메뉴 세팅 */
		$('.wzwgFooterContextMenu').on('mousedown', function(e){
			if((e.button == 2) || (e.which == 3)) {
				cssMenuScreenX = e.pageX;
				cssMenuScreenY = e.pageY;
				//console.log(e);
				//console.log(cssMenuScreenX);
				//console.log(cssMenuScreenY);
				wzwgSelectCssCommand('foot', this);
			}
		})
		$.contextMenu({
			selector: '.wzwgFooterContextMenu',
			build: function($triggerElement, e){
				var options = { 
						callback: wzwgCMFunc,
						items: {}
				};
				options.items = wzwgFootermenuContextOptions($triggerElement);
				return options;
			}
		,zIndex: 10
		,trigger: 'none'
		,	position: function(opt, x, y){
			   var widthMax = $(window).width() - 220
				if(widthMax < cssMenuScreenX ){
					cssMenuScreenX = widthMax;
				}
		        opt.$menu.css({top: cssMenuScreenY-252, left: cssMenuScreenX});
		    } 
		});
	
	}//end if(location.pathname.indexOf('/screen/subList/') == -1){
	
}//end wzwgCMBuilder

var headCommandStr = '';
var footCommandStr = '';
var subCommandStr = '';
var cssMenuScreenX = 0;
var cssMenuScreenY = 0;
	
function wzwgSelectCssCommand(type, callObj){
   	var contents = $('<div/>');
   	
   	if(type == 'head'){
		var headCssLink = $('#headmenu').attr('href');
		contents.load(headCssLink , function(){
			/* 첫번째줄을 가져오게되면 웹표준 오류로 인해 두번째 줄에 넣도록 변경 21.05.25 dahee */
			headCommandStr = $(this).html().split('\n')[1];
			$(callObj).contextMenu();
		});
   		
   	}else if(type == 'foot'){
   		var footCssLink = $('#footmenu').attr('href');
		contents.load(footCssLink , function(){
			footCommandStr = $(this).html().split('\n')[1];
			$(callObj).contextMenu();
		});
		
   	}else if(type == 'sub'){
   		//var subCssLink = $('#submenu').attr('href');
		//contents.load(subCssLink + '?ran=' + Math.random(), function(){
		//	subCommandStr = $(this).html().split('\n')[1];
		//});
   	}
}

function wzwgCMQuickConfOptions(obj){
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	// 퀵배너 기본
	items["addQuickBanner"]= {name: wz_msg('wzwg.cmm.word.scrin.quickAdd'), icon: "edit"}; 
	if(obj.hasClass('noChangeBg') == false){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "quickBannerConfZone"};
	}
	
	// 퀵메뉴용 제목변경 (위젯배경과 퀵메뉴아이템의 bTitle이 겹칠때 사용)
	if(obj.find('.qTitle').length == 1 && isDisplay(obj.find('.qTitle'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjChg'), icon: "edit", target: "qTitle", multiLine: "false"}; 
	}
	
	if(obj.find('.qmTitle').length == 1 && isDisplay(obj.find('.qmTitle'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjChg'), icon: "edit", target: "qmTitle"};
	}
	
	if(obj.find('.qSubTitle').length == 1  && isDisplay(obj.find('.qSubTitle')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.subSjChg'), icon: "edit", target: "qSubTitle", multiLine: "false"}; 
	}
	
	if(obj.find('.qContent').length == 1 && isDisplay(obj.find('.qContent')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.cnChg'), icon: "edit", target: "qContent"};
	}
	
	if(obj.find('.qSubContent').length == 1 && isDisplay(obj.find('.qSubContent'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.adiCnChg'), icon: "edit", target: "qSubContent"};
	}
	
	if( (obj.find('.qChangeBg').length == 1  || obj.hasClass('qChangeBg')) && isDisplay(obj.find('.qChangeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "qChangeBg"};
	}
	
	if( (obj.find('.qTargetBG').length == 1  || obj.hasClass('qTargetBG')) && isDisplay(obj.find('.qTargetBG')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "qTargetBG"};
	}
	
	if(obj.find('.qTabBg').length == 1 && isDisplay(obj.find('.qTabBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.tabBcrnColChg'), icon: "edit", target: "qTabBg"};
	}
	
	if((obj.find('.qTargetCol').length == 1 || obj.hasClass('qTargetCol')) && isDisplay(obj.find('.qTargetCol'))){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnColChg'), icon: "edit", target: "qTargetCol"}; 
	}
	
	if((obj.find('.qBorderBg').length == 1 || obj.hasClass('qBorderBg')) && isDisplay(obj.find('.qBorderBg')) ){
		items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.borrColChg'), icon: "edit", target: "qBorderBg"};
	}
	
	if((obj.find('.qContentAlign').length == 1 || obj.hasClass('qContentAlign')) && isDisplay(obj.find('.qContentAlign'))){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cntntsLcChg'), icon: "edit", target: "qContentAlign"};
	}
	
	if((obj.find('.qTextAlign').length == 1 || obj.hasClass('qTextAlign')) && isDisplay(obj.find('.qTextAlign'))){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg'), icon: "edit", target: "qTextAlign"};
	}
	
	if(obj.find('.qImgBg').length == 1 && isDisplay(obj.find('.qImgBg')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrImageChange'), obj.find('.qImgBg'));
			items.changeImgPath_ = {name: imgtitle, icon: 'edit', target: 'qImgBg', isHtmlName: true};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.cmm.word.scrin.imgChg'), obj.find('.qImgBg'));
			items.changeImg_ = {name: imgtitle, icon: "edit", target: 'qImgBg', isHtmlName: true};
			items["imgClassCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.imageReplcTxtInput') , icon: "edit", target: 'qImgBg'};
		}
	}
	
	if(obj.find('.bIcon').length == 1 && isDisplay(obj.find('.bIcon')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrIconChg'), obj.find('.bIcon'));
			items['changeImgPath' + '_' + getMenuCnt()] = {name: imgtitle, icon: 'edit', isHtmlName: true, target: 'bIcon'};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.iconChng'), obj.find('.bIcon'));
			items['modifyIcon' + '_' + getMenuCnt()] = {name: imgtitle, icon: "edit", no: 0, isHtmlName: true, target: 'bIcon'};
		}
		items["imgClassCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconReplcTxtInput'), icon: "edit", target: 'bIcon'};
	}
	
	items["moreStyleOp"] = {name: wz_msg('wzwg.webModule.word.shrtcutStyleChg') ,
		 icon: "edit",
		 items : {}
	};
	
	if(obj.find('.qlinkTitle').length == 1 && isDisplay(obj.find('.qlinkTitle')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "qlinkTitle"};
	}

	if(obj.find('.qlinkCol').length == 1 && isDisplay(obj.find('.qlinkCol')) ){
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg') , icon: "edit", target: "qlinkCol"};
	}
	
	if(obj.find('.qlinkBg').length == 1 && isDisplay(obj.find('.qlinkBg')) ){
		items["moreStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "qlinkBg"}; 
	}
	
	if(obj.find('.qMoreBrCol').length == 1 && isDisplay(obj.find('.qMoreBrCol')) ){
		items["moreStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBorrColChg'), icon: "edit", target: "qMoreBrCol"};
	}
	
	if(Object.keys(items.moreStyleOp.items).length ==0){
		delete items.moreStyleOp;
	}
	
	wzwgCMEndOption(items);
	
	if(logMode)	console.log(items);
	
	return items;
}

function wzwgScheduleOptions(obj){
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(isSysMngr){
		items["sysMngrBoard"] = {name: wz_msg('wzwg.webModule.word.cnncSchdulChoise'),
								 icon: "edit",
								 items : {
									 	 "hint" : {html : "<span style='color:#999;'><spring:message code='wzwg.cmm.msg.screen.MSG041' /></span>", type : "html"}
								 		}
								};
	}else{
		//items.dataReplace = scheduleOpsions.dataReplace;
		items.dataReplace = {name: wz_msg('wzwg.webModule.word.cnncSchdulChoise'), icon: "edit", target: "module10000000104"};
	}
	
	items.modifyBgColor_schedule = {name: "<spring:message code="wzwg.webModule.word.bcrnclrChg" />", icon: "edit"};

	// 일정용 제목변경 (위젯배경과 퀵메뉴아이템의 bTitle이 겹칠때 사용)
	if(obj.find('.cTitle').length == 1 && isDisplay(obj.find('.cTitle'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.titleColChg'), icon: "edit" , target: "cTitle"};
	}

	if( (obj.find('.cTitleBG').length == 1  || obj.hasClass('cTitleBG')) && isDisplay(obj.find('.cTitleBG')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.titleBcrnColChg') , icon: "edit", target: "cTitleBG"};
	}
	
	
	if(obj.find('.cMonth').length == 1 && isDisplay(obj.find('.cMonth'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.schdulDateColChg'), icon: "edit" , target: "cMonth"};
	}

	if(obj.find('.cMonthY').length == 1 && isDisplay(obj.find('.cMonthY'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.yy02ColChg') , icon: "edit" , target: "cMonthY"};
	}

	if(obj.find('.cMonthM').length == 1 && isDisplay(obj.find('.cMonthM'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.mtColChg'), icon: "edit" , target: "cMonthM"};
	}
	
	if(obj.find('.cMonthD').length == 1 && isDisplay(obj.find('.cMonthD'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.deColChg'), icon: "edit" , target: "cMonthD"};
	}
	
	if(obj.find('.weekTitle').length == 1 && isDisplay(obj.find('.weekTitle'))){
    	items["modifyTHColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.day02ColChg'), icon: "edit" , target: "weekTitle"};
    	if(obj.find('.weekTitleBgNon').length != 1){
    		items["modifyTHBg_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.day02BcrnColChg'), icon: "edit" , target: "weekTitle"};
    	}
    	items["weekText"] = {name: wz_msg('wzwg.webModule.word.day02IndictChg'),
				 icon: "edit",
				 items : {
					 	 "modifyWeekText_ko" : {name : wz_msg('wzwg.cmm.word.korean'), icon: "edit" , target: "weekTitle"},
					 	 "modifyWeekText_eng" : {name : wz_msg('wzwg.cmm.word.eng'), icon: "edit" , target: "weekTitle"}
				 		}
				};
	}
	
	if(obj.find('.cDayCol').length == 1 && isDisplay(obj.find('.cDayCol'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cldrDe01ColChg'), icon: "edit" , target: "cDayCol"};
	}
	
	if(obj.find('.event_title').length >= 1 && isDisplay(obj.find('.event_title')) ){
		items["modifyAllTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.schdulTitleColChg'), icon: "edit", target: "event_title"}; 
	}
	
	if(obj.find('.event_date').length >= 1 && isDisplay(obj.find('.event_date')) ){
		items["modifyAllTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.schdulDateColChg'), icon: "edit", target: "event_date"}; 
	}
	
	if(obj.find('.event_date_bg').length >= 1 && isDisplay(obj.find('.event_date_bg')) ){
		items["modifyAllBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.schdulDateBgColChg'), icon: "edit", target: "event_date_bg"}; 
	}
	
	if(obj.find('.btnCol').length > 0 && isDisplay(obj.find('.btnCol')) ){
		items.modifyBtnColor = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg'), icon: "edit", target: "btnCol"};
	}
	
	if(obj.find('.btnBrCol').length > 0 && isDisplay(obj.find('.btnBrCol')) ){
		items.modifyBtnBrColor = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg') , icon: "edit", target: "btnBrCol"};
	}
	
		
	wzwgCMOptions(obj, items);

	wzwgCMEndOption(items);
	
	if(logMode) console.log(items);
	
	return items;
}

function wzwgMvpBoardOptions(obj){
	var items = {};

	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(isSysMngr){
		items["sysMngrBoard"] = {name: wz_msg('wzwg.webModule.word.cnncBbsChoise'),
								 icon: "edit",
								 items : {
									 	 "hint" : {html : "<span style='color:#999;'><spring:message code='wzwg.cmm.msg.screen.MSG041' /></span>", type : "html"}
								 		}
								};
	}else{
		//items.dataReplace = mvpBoardOpsions.dataReplace;
		items.dataReplace = {name: wz_msg('wzwg.webModule.word.cnncBbsChoise'), icon: "edit", target: "module10000000204"};
	}
	
	items["bbsStyleOp"] = {name: wz_msg('wzwg.webModule.word.bbsStyleChg') ,
			 icon: "edit",
			 items : {}
			};
  	
	if(obj.hasClass('noChangeBg') == false){
		items["bbsStyleOp"].items.modifyBgColor_board = {name: wz_msg('wzwg.webModule.word.bbsBcrnColChg'), icon: "edit"};
	}
   	
	if((obj.find('.btargetBG').length == 1  || obj.hasClass('btargetBG')) && isDisplay(obj.find('.btargetBG')) ){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsAppnBcrnColChg'), icon: "edit", target: "btargetBG"};
	}
	
	if(obj.find('.slick-progress-bar').length == 1 && isDisplay(obj.find('.slick-progress-bar'))){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.prgresBarColChg'), icon: "edit", target: "slick-progress-bar"};
	}
	
   	if(obj.hasClass('menuNm') || obj.find('.menuNm').length == 1){
		items["bbsStyleOp"].items.modifyBoardTitleColor = {name: wz_msg('wzwg.webModule.word.bbsTitleColChg'), icon: "edit"};
	}
	
	if(obj.hasClass('menuNmBg') || obj.find('.menuNmBg').length >= 1){
		items["bbsStyleOp"].items.modifyBoardBgColor = {name: wz_msg('wzwg.webModule.word.bbsTitleBcrnColChg'), icon: "edit"};
	}
	
	if((obj.find('.menuNmBrdrBg').length == 1 || obj.hasClass('menuNmBrdrBg')) && isDisplay(obj.find('.menuNmBrdrBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsTitleBorrColChg01'), icon: "edit", target: "menuNmBrdrBg"};
	}
	
	if(obj.hasClass('subMenuNm') || obj.find('.subMenuNm').length >= 1){
		items["bbsStyleOp"].items.modifyBoardSubTitleColor = {name: wz_msg('wzwg.webModule.word.bbsSubtitleColChg'), icon: "edit"};
	}
	
	if(obj.hasClass('subMenuNmBg') || obj.find('.subMenuNmBg').length >= 1){
		items["bbsStyleOp"].items.modifySubBoardBgColor = {name: wz_msg('wzwg.webModule.word.bbsSubtitleBcrnColChg'), icon: "edit"};
	}
	
	if((obj.find('.subBorderBg').length >= 1 || obj.hasClass('subBorderBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsSubtitleBorrColChg01') , icon: "edit", target: "subBorderBg"};
	}

	if((obj.find('.bBorderBg').length == 1 || obj.hasClass('bBorderBg')) && isDisplay(obj.find('.bBorderBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsBorrColChg01'), icon: "edit", target: "bBorderBg"};
	}
	
	if(obj.hasClass('boardTabBg') || obj.find('.boardTabBg').length > 0){
		items["bbsStyleOp"].items.modifyBoardTabBg = {name: wz_msg('wzwg.webModule.word.bbsTabBcrnColChg'), icon: "edit", target: "boardTabBg"};
	}
   	
	if(obj.find('.bTabBg').length == 1 && isDisplay(obj.find('.bTabBg')) ){
		items["bbsStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.tabBcrnColChg') , icon: "edit", target: "bTabBg"};
	}

	if(obj.find('.bSubTitle').length == 1 && isDisplay(obj.find('.bSubTitle')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.subtitleChg'), icon: "edit", target: "bSubTitle", multiLine: "false"};
	}
	
	if(obj.find('.bSubMTitle').length == 1 && isDisplay(obj.find('.bSubMTitle')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.subtitleChg'), icon: "edit", target: "bSubMTitle", multiLine: "true"};
	}
	
	if(obj.find('.bContent').length == 1 && isDisplay(obj.find('.bContent')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsIntrcnChg') , icon: "edit", target: "bContent"};
	}
	
	if(obj.find('.bContentAlign').length == 1){
		items["bbsStyleOp"].items["modifyContentAlign_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cntntsLcChg'), icon: "edit", target: "bContentAlign"};
	}
	
	if((obj.find('.bTextAlign').length > 0 || obj.hasClass('bTextAlign')) && isDisplay(obj.find('.bTextAlign'))){
		items["bbsStyleOp"].items["modifyContentAlign_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg'), icon: "edit", target: "bTextAlign"};
	}
	
	if((obj.find('.bIconCol').length == 1 || obj.hasClass('bIconCol')) && isDisplay(obj.find('.bIconCol'))){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsIconColChg'), icon: "edit", target: "bIconCol"}; 
	}
	
	if(obj.find('.bDecoIcon').length == 1 && isDisplay(obj.find('.bDecoIcon')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrIconChg'), obj.find('.bDecoIcon'));
			items["bbsStyleOp"].items.changeImgPath_ = {name: imgtitle, icon: "edit", isHtmlName: true};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.bbsIconChg'), obj.find('.bDecoIcon'));
			items["bbsStyleOp"].items["modifyIcon_"+getMenuCnt()] = {name: imgtitle, icon: "edit", target: "bDecoIcon", isHtmlName: true};
		}
		
		items["bbsStyleOp"].items["imgClassCaption_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconReplcTxtInput'), icon: "edit", target: "bDecoIcon"};
	}
	
	if(obj.find('.bDecoImg').length == 1 && isDisplay(obj.find('.bDecoImg')) ){
		var img = obj.find('img')[0] 
		if($(img).hasClass('bIcon') == false){
			if(isSysMngr){
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrImageChange') , obj.find('.bDecoImg'));
				items["bbsStyleOp"].items.changeImgPath_ = {name: imgtitle, icon: "edit", isHtmlName: true};
			}else{
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.bbsImageChg') , obj.find('.bDecoImg'));
				items["bbsStyleOp"].items.uploadImg = {name: imgtitle, icon: "edit", isHtmlName: true};
				items["bbsStyleOp"].items["imgClassCaption_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.imageReplcTxtInput'), icon: "edit", target: "bDecoImg"};
			}
			
		}
	}
	
	if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1){
		items["bbsStyleOp"].items.changeArrowBg = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg'), icon: "edit"};
		items["bbsStyleOp"].items.changeArrowBd = {name: wz_msg('wzwg.webModule.word.prev/nextBoorColChg01'), icon: "edit"};
	}
	
	items["nttStyleOp"] = {name: wz_msg('wzwg.webModule.word.postStyleChg'),
			 icon: "edit",
			 items : {}
			};
 	
	if(obj.hasClass('boardBg') || obj.find('.boardBg').length > 0){
		items["nttStyleOp"].items.modifyBoardColor = {name: wz_msg('wzwg.webModule.word.postBcrnColChg'), icon: "edit", target: "subBorderBg"};
	}
	
	if(obj.hasClass('boardBrdrBg') || obj.find('.boardBrdrBg').length > 0){
		items["nttStyleOp"].items.modifyBoardBrdrColor = {name: wz_msg('wzwg.webModule.word.postBoorColChg01'), icon: "edit", target: "boardBrdrBg"};
	}
	
	if(obj.hasClass('btargetBrCol') || obj.find('.btargetBrCol').length > 0){
		items["nttStyleOp"].items.modifybtargetBrColor = {name: wz_msg('wzwg.webModule.word.postAppnBorrColChg01'), icon: "edit", target: "btargetBrCol"};
	}
	
	if(obj.find('[data-attr="nttSj"]').length > 0){
		items["nttStyleOp"].items.modifyBoardCnTitleColor = {name: wz_msg('wzwg.webModule.word.postsTitleColChg'), icon: "edit"};
	}
	
	if(obj.find('[data-attr="nttCnChrctr"]').length > 0){
		items["nttStyleOp"].items.modifyBoardCnColor = {name: wz_msg('wzwg.webModule.word.postsCnColChg'), icon: "edit"};
	}
	
	if(obj.find('[data-attr="frstRegistPnttm"]').length > 0){
		items["nttStyleOp"].items.modifyBoardDateColor = {name: wz_msg('wzwg.webModule.word.rgsde02ColChg'), icon: "edit"};
	}
	
	if(obj.find('.bTargetCol').length > 0 && isDisplay(obj.find('.bTargetCol')) ){
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnColChg'), icon: "edit", target: "bTargetCol"};
	}
	
	if(obj.find('.bTargetBgCol').length > 0 && isDisplay(obj.find('.bTargetBgCol')) ){
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnColChg'), icon: "edit", target: "bTargetBgCol"};
	}
	
	if(obj.find('.bDetailTextColOnly').length > 0 && isDisplay(obj.find('.bDetailTextColOnly')) ){
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg'), icon: "edit", target: "bDetailTextColOnly"};
	}
	
	if(obj.find('.bDetailChangelBg').length > 0 && isDisplay(obj.find('.bDetailChangelBg')) ){
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBcrnColChg'), icon: "edit", target: "bDetailChangelBg"};
	}
	
	if(obj.find('.bDetailTextCol').length > 0 && isDisplay(obj.find('.bDetailTextCol')) ){
		items["nttStyleOp"].items["modifyAllText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkWordsChg'), icon: "edit", target: "bDetailTextCol"};
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg') , icon: "edit", target: "bDetailTextCol"};
	}
	
	if(obj.find('.bDetailTextColBg').length > 0 && isDisplay(obj.find('.bDetailTextColBg')) ){
		items["nttStyleOp"].items["modifyAllText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkWordsChg'), icon: "edit", target: "bDetailTextColBg"};
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg'), icon: "edit", target: "bDetailTextColBg"};
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBcrnColChg'), icon: "edit", target: "bDetailTextColBg"};
	}
	
	if(obj.find('.bDetailBorderBg').length > 0 && isDisplay(obj.find('.bDetailBorderBg'))){
		items["nttStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBorrColChg01'), icon: "edit", target: "bDetailBorderBg"};
	}
	
	
 	items["moreStyleOp"] = {name: wz_msg('wzwg.webModule.word.shrtcutStyleChg') ,
			 icon: "edit",
			 items : {}
			};
	
 	if(obj.find('.bMoreTextColOnly').length == 1 && isDisplay(obj.find('.bMoreTextColOnly')) ){
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bMoreTextColOnly"};
	}
	
	if(obj.find('.bMoreBg').length == 1 && isDisplay(obj.find('.bMoreBg')) ){
		items["moreStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bMoreBg"};
	}
	
	if(obj.find('.bMoreTextCol').length == 1 && isDisplay(obj.find('.bMoreTextCol')) ){
		items["moreStyleOp"].items["modifyText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bMoreTextCol"};
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bMoreTextCol"};
	}
	
	if(obj.find('.bMoreTextColBg').length == 1 && isDisplay(obj.find('.bMoreTextColBg')) ){
		items["moreStyleOp"].items["modifyText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bMoreTextColBg"};
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg') , icon: "edit", target: "bMoreTextColBg"};
		items["moreStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bMoreTextColBg"};
	}
	
	if(obj.find('.bMoreIconCol').length == 1 && isDisplay(obj.find('.bMoreIconCol')) ){
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutIconColChg'), icon: "edit", target: "bMoreIconCol"};
	}
	
	if(obj.find('.bMoreBrCol').length == 1 && isDisplay(obj.find('.bMoreBrCol')) ){
		items["moreStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBorrColChg01'), icon: "edit", target: "bMoreBrCol"};
	}

	if(Object.keys(items.bbsStyleOp.items).length ==0){
		delete items.bbsStyleOp;
	}
	if(Object.keys(items.nttStyleOp.items).length ==0){
		delete items.nttStyleOp;
	}
	if(Object.keys(items.moreStyleOp.items).length ==0){
		delete items.moreStyleOp;
	}
	
	/* 슬라이드 게시판일 경우 기능 추가 */
	if(obj.hasClass('wzwg-slide-info') || obj.find('.wzwg-slide-info').length == 1){
		
		var perviewCnt = obj.find('.wzwg-slide-info').attr('data-slidesPerView');
		var directionVal = obj.find('.wzwg-slide-info').attr('data-direction');

		items.addBoardSlide = {name: wz_msg('wzwg.webModule.word.postCountIncrs') , icon: "edit"}; 
		items.delBoardSlide = {name: wz_msg('wzwg.webModule.word.postCountDcrs'), icon: "edit"}; 
		
		items.ef = {
    		name: wz_msg('wzwg.webModule.word.effectChg'),
    		icon: "edit",
    		items : {}
		};
		
		items.ef.items["effecSlide"] = {name: wz_msg('wzwg.cmm.word.wa.slide')};
		if(perviewCnt == undefined || perviewCnt == '1' ){
			if(directionVal != 'vertical'){
				items.ef.items["effecFade"] = {name: wz_msg('wzwg.cmm.word.wa.fade')};
			}
		}
		items.ef.items["divide"] = "---------";
		items.ef.items["slideAuto"] = {name: wz_msg('wzwg.cmm.word.scrin.autoSlide')};
		items.ef.items["slideStop"] = {name: wz_msg('wzwg.cmm.word.scrin.passivSlide')};
		items.ef.items["divideRoop"] = "---------";
		items.ef.items["slideRoop"] = {name: wz_msg('wzwg.webModule.word.reptitSlide')};
		items.ef.items["slideRoopNone"] = {name: wz_msg('wzwg.cmm.word.scrin.stopTheEnd')};
		items.ef.items["divide2"] = "---------";
		items.ef.items["speed_vslow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeVerySlow02')};
		items.ef.items["speed_slow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeSlow02')};
		items.ef.items["speed_nomal"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeNormal02')};
		items.ef.items["speed_fast"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeFast02')};
		items.ef.items["hint"] = {html : "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG040' /></span>", type : "html"};
		    		
	}else {
		if(obj.parents('.wzwgWidget').parent().attr('data-h') == 'A' || obj.parent().attr('data-h') == 'A'){
			items.addNtt = {name: wz_msg('wzwg.cmm.word.post') + " " + wz_msg('wzwg.cmm.word.count') + " " + wz_msg('wzwg.cmm.word.incrs'), icon: "edit"}; 
			items.delNtt = {name: wz_msg('wzwg.cmm.word.post') + " " + wz_msg('wzwg.cmm.word.count') + " " + wz_msg('wzwg.cmm.word.dcrs'), icon: "edit"};
		}
	}
	
	wzwgCMEndOption(items);
	
	if(logMode)	console.log(items);
	
	return items;
}

function wzwgCMBoardOptions(obj){
	var items = {};

	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(isSysMngr){
		items["sysMngrBoard"] = {name: wz_msg('wzwg.webModule.word.cnncBbsChoise'),
								 icon: "edit",
								 items : {
									 	 "hint" : {html : "<span style='color:#999;'><spring:message code='wzwg.cmm.msg.screen.MSG041' /></span>", type : "html"}
								 		}
								};
	}else{
		//items.dataReplace = boardOpsions.dataReplace;
		items.dataReplace = {name: wz_msg('wzwg.webModule.word.cnncBbsChoise'), icon: "edit", target: "moduleSGC0000027"};
	}
	
   	items["bbsStyleOp"] = {name: wz_msg('wzwg.webModule.word.bbsStyleChg'),
			 icon: "edit",
			 items : {}
			};
   	
	if(obj.hasClass('noChangeBg') == false){
		items["bbsStyleOp"].items.modifyBgColor_board = {name: wz_msg('wzwg.webModule.word.bbsBcrnColChg'), icon: "edit"};
	}
   	
	if((obj.find('.btargetBG').length == 1  || obj.hasClass('btargetBG')) && isDisplay(obj.find('.btargetBG')) ){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsAppnBcrnColChg'), icon: "edit", target: "btargetBG"};
	}
	
	if(obj.find('.slick-progress-bar').length == 1 && isDisplay(obj.find('.slick-progress-bar'))){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.prgresBarColChg'), icon: "edit", target: "slick-progress-bar"};
	}
	
   	if(obj.hasClass('menuNm') || obj.find('.menuNm').length == 1){
		items["bbsStyleOp"].items.modifyBoardTitleColor = {name: wz_msg('wzwg.webModule.word.bbsTitleColChg'), icon: "edit"};
	}
	
	if(obj.hasClass('menuNmBg') || obj.find('.menuNmBg').length >= 1){
		items["bbsStyleOp"].items.modifyBoardBgColor = {name: wz_msg('wzwg.webModule.word.bbsTitleBcrnColChg'), icon: "edit"};
	}
	
	if((obj.find('.menuNmBrdrBg').length == 1 || obj.hasClass('menuNmBrdrBg')) && isDisplay(obj.find('.menuNmBrdrBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsTitleBorrColChg01'), icon: "edit", target: "menuNmBrdrBg"};
	}
	
	if(obj.hasClass('subMenuNm') || obj.find('.subMenuNm').length >= 1){
		items["bbsStyleOp"].items.modifyBoardSubTitleColor = {name: wz_msg('wzwg.webModule.word.bbsSubtitleColChg'), icon: "edit"};
	}
	
	if(obj.hasClass('subMenuNmBg') || obj.find('.subMenuNmBg').length >= 1){
		items["bbsStyleOp"].items.modifySubBoardBgColor = {name: wz_msg('wzwg.webModule.word.bbsSubtitleBcrnColChg'), icon: "edit"};
	}
	
	if((obj.find('.subBorderBg').length >= 1 || obj.hasClass('subBorderBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsSubtitleBorrColChg01'), icon: "edit", target: "subBorderBg"};
	}

	if((obj.find('.bBorderBg').length == 1 || obj.hasClass('bBorderBg')) && isDisplay(obj.find('.bBorderBg'))){
		items["bbsStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsBorrColChg01'), icon: "edit", target: "bBorderBg"};
	}
	
	if(obj.hasClass('boardTabBg') || obj.find('.boardTabBg').length > 0){
		items["bbsStyleOp"].items.modifyBoardTabBg = {name: wz_msg('wzwg.webModule.word.bbsTabBcrnColChg'), icon: "edit", target: "boardTabBg"};
	}
   	
	if(obj.find('.bTabBg').length == 1 && isDisplay(obj.find('.bTabBg')) ){
		items["bbsStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.tabBcrnColChg'), icon: "edit", target: "bTabBg"};
	}

	if(obj.find('.bSubTitle').length == 1 && isDisplay(obj.find('.bSubTitle')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.subtitleChg'), icon: "edit", target: "bSubTitle", multiLine: "false"};
	}
	
	if(obj.find('.bSubMTitle').length == 1 && isDisplay(obj.find('.bSubMTitle')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.subtitleChg'), icon: "edit", target: "bSubMTitle", multiLine: "true"};
	}
	
	if(obj.find('.bContent').length == 1 && isDisplay(obj.find('.bContent')) ){
		items["bbsStyleOp"].items["basicEditor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsIntrcnChg'), icon: "edit", target: "bContent"};
	}
	
	if(obj.find('.bContentAlign').length == 1){
		items["bbsStyleOp"].items["modifyContentAlign_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cntntsLcChg'), icon: "edit", target: "bContentAlign"};
	}
	
	if((obj.find('.bTextAlign').length > 0 || obj.hasClass('bTextAlign')) && isDisplay(obj.find('.bTextAlign'))){
		items["bbsStyleOp"].items["modifyContentAlign_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg'), icon: "edit", target: "bTextAlign"};
	}
	
	if((obj.find('.bIconCol').length == 1 || obj.hasClass('bIconCol')) && isDisplay(obj.find('.bIconCol'))){
		items["bbsStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bbsIconColChg'), icon: "edit", target: "bIconCol"}; 
	}
	
	if(obj.find('.bDecoIcon').length == 1 && isDisplay(obj.find('.bDecoIcon')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrIconChg'), obj.find('.bDecoIcon'));
			items["bbsStyleOp"].items.changeImgPath_ = {name: imgtitle, icon: "edit", isHtmlName: true};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.bbsIconChg'), obj.find('.bDecoIcon'));
			items["bbsStyleOp"].items["modifyIcon_"+getMenuCnt()] = {name: imgtitle, icon: "edit", target: "bDecoIcon", isHtmlName: true};
		}
		
		items["bbsStyleOp"].items["imgClassCaption_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconReplcTxtInput'), icon: "edit", target: "bDecoIcon"};
	}
	
	if(obj.find('.bDecoImg').length == 1 && isDisplay(obj.find('.bDecoImg')) ){
		var img = obj.find('img')[0] 
		if($(img).hasClass('bIcon') == false){
			if(isSysMngr){
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrImageChange') , obj.find('.bDecoImg'));
				items["bbsStyleOp"].items.changeImgPath_ = {name: imgtitle, icon: "edit", isHtmlName: true};
			}else{
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.bbsImageChg'), obj.find('.bDecoImg'));
				items["bbsStyleOp"].items.uploadImg = {name: imgtitle, icon: "edit", isHtmlName: true};
				items["bbsStyleOp"].items["imgClassCaption_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.imageReplcTxtInput'), icon: "edit", target: "bDecoImg"};
			}
			
		}
	}
	
	if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1){
		items["bbsStyleOp"].items.changeArrowBg = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg'), icon: "edit"};
		items["bbsStyleOp"].items.changeArrowBd = {name: wz_msg('wzwg.webModule.word.prev/nextBoorColChg01'), icon: "edit"};
	}
	
	items["nttStyleOp"] = {name: wz_msg('wzwg.webModule.word.postStyleChg'),
			 icon: "edit",
			 items : {}
			};
 	
	if(obj.hasClass('boardBg') || obj.find('.boardBg').length > 0){
		items["nttStyleOp"].items.modifyBoardColor = {name: wz_msg('wzwg.webModule.word.postBcrnColChg'), icon: "edit", target: "subBorderBg"};
	}
	
	if(obj.hasClass('boardBrdrBg') || obj.find('.boardBrdrBg').length > 0){
		items["nttStyleOp"].items.modifyBoardBrdrColor = {name: wz_msg('wzwg.webModule.word.postBoorColChg01'), icon: "edit", target: "boardBrdrBg"};
	}
	
	if(obj.hasClass('btargetBrCol') || obj.find('.btargetBrCol').length > 0){
		items["nttStyleOp"].items.modifybtargetBrColor = {name: wz_msg('wzwg.webModule.word.postAppnBorrColChg01'), icon: "edit", target: "btargetBrCol"};
	}
	
	if(obj.find('[data-attr="nttSj"]').length > 0){
		items["nttStyleOp"].items.modifyBoardCnTitleColor = {name: wz_msg('wzwg.webModule.word.postsTitleColChg'), icon: "edit"};
	}
	
	if(obj.find('[data-attr="nttCnChrctr"]').length > 0){
		items["nttStyleOp"].items.modifyBoardCnColor = {name: wz_msg('wzwg.webModule.word.postsCnColChg'), icon: "edit"};
	}
	
	if(obj.find('[data-attr="frstRegistPnttm"]').length > 0){
		items["nttStyleOp"].items.modifyBoardDateColor = {name: wz_msg('wzwg.webModule.word.rgsde02ColChg'), icon: "edit"};
	}
	
	if(obj.find('.bTargetCol').length > 0 && isDisplay(obj.find('.bTargetCol')) ){
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnColChg'), icon: "edit", target: "bTargetCol"};
	}
	
	if(obj.find('.bTargetBgCol').length > 0 && isDisplay(obj.find('.bTargetBgCol')) ){
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnColChg'), icon: "edit", target: "bTargetBgCol"};
	}
	
	if(obj.find('.bDetailTextColOnly').length > 0 && isDisplay(obj.find('.bDetailTextColOnly')) ){
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg'), icon: "edit", target: "bDetailTextColOnly"};
	}
	
	if(obj.find('.bDetailChangelBg').length > 0 && isDisplay(obj.find('.bDetailChangelBg')) ){
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBcrnColChg'), icon: "edit", target: "bDetailChangelBg"};
	}
	
	if(obj.find('.bDetailTextCol').length > 0 && isDisplay(obj.find('.bDetailTextCol')) ){
		items["nttStyleOp"].items["modifyAllText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkWordsChg'), icon: "edit", target: "bDetailTextCol"};
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg'), icon: "edit", target: "bDetailTextCol"};
	}
	
	if(obj.find('.bDetailTextColBg').length > 0 && isDisplay(obj.find('.bDetailTextColBg')) ){
		items["nttStyleOp"].items["modifyAllText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkWordsChg'), icon: "edit", target: "bDetailTextColBg"};
		items["nttStyleOp"].items["modifyAllTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkColChg'), icon: "edit", target: "bDetailTextColBg"};
		items["nttStyleOp"].items["modifyAllBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBcrnColChg'), icon: "edit", target: "bDetailTextColBg"};
	}
	
	if(obj.find('.bDetailBorderBg').length > 0 && isDisplay(obj.find('.bDetailBorderBg'))){
		items["nttStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.detailLinkBorrColChg01'), icon: "edit", target: "bDetailBorderBg"};
	}
	
	
 	items["moreStyleOp"] = {name: wz_msg('wzwg.webModule.word.shrtcutStyleChg'),
			 icon: "edit",
			 items : {}
			};
	
 	if(obj.find('.bMoreTextColOnly').length == 1 && isDisplay(obj.find('.bMoreTextColOnly')) ){
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bMoreTextColOnly"};
	}
	
	if(obj.find('.bMoreBg').length == 1 && isDisplay(obj.find('.bMoreBg')) ){
		items["moreStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bMoreBg"};
	}
	
	if(obj.find('.bMoreTextCol').length == 1 && isDisplay(obj.find('.bMoreTextCol')) ){
		items["moreStyleOp"].items["modifyText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bMoreTextCol"};
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg') , icon: "edit", target: "bMoreTextCol"};
	}
	
	if(obj.find('.bMoreTextColBg').length == 1 && isDisplay(obj.find('.bMoreTextColBg')) ){
		items["moreStyleOp"].items["modifyText_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bMoreTextColBg"};
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bMoreTextColBg"};
		items["moreStyleOp"].items["modifyBgColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bMoreTextColBg"};
	}
	
	if(obj.find('.bMoreIconCol').length == 1 && isDisplay(obj.find('.bMoreIconCol')) ){
		items["moreStyleOp"].items["modifyTextColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutIconColChg'), icon: "edit", target: "bMoreIconCol"};
	}
	
	if(obj.find('.bMoreBrCol').length == 1 && isDisplay(obj.find('.bMoreBrCol')) ){
		items["moreStyleOp"].items["modifyBorderColor_"+getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBorrColChg01'), icon: "edit", target: "bMoreBrCol"};
	}

	if(Object.keys(items.bbsStyleOp.items).length ==0){
		delete items.bbsStyleOp;
	}
	if(Object.keys(items.nttStyleOp.items).length ==0){
		delete items.nttStyleOp;
	}
	if(Object.keys(items.moreStyleOp.items).length ==0){
		delete items.moreStyleOp;
	}
	
	/* 슬라이드 게시판일 경우 기능 추가 */
	if(obj.hasClass('wzwg-slide-info') || obj.find('.wzwg-slide-info').length == 1){
		
		var perviewCnt = obj.find('.wzwg-slide-info').attr('data-slidesPerView');
		var directionVal = obj.find('.wzwg-slide-info').attr('data-direction');

		items.addBoardSlide = {name: wz_msg('wzwg.webModule.word.postCountIncrs') , icon: "edit"}; 
		items.delBoardSlide = {name: wz_msg('wzwg.webModule.word.postCountDcrs'), icon: "edit"}; 
		
		items.ef = {
    		name: wz_msg('wzwg.webModule.word.effectChg'),
    		icon: "edit",
    		items : {}
		};
		
		items.ef.items["effecSlide"] = {name: wz_msg('wzwg.cmm.word.wa.slide')};
		if(perviewCnt == undefined || perviewCnt == '1' ){
			if(directionVal != 'vertical'){
				items.ef.items["effecFade"] = {name: wz_msg('wzwg.cmm.word.wa.fade')};
			}
		}
		items.ef.items["divide"] = "---------";
		items.ef.items["slideAuto"] = {name: wz_msg('wzwg.cmm.word.scrin.autoSlide')};
		items.ef.items["slideStop"] = {name: wz_msg('wzwg.cmm.word.scrin.passivSlide')};
		items.ef.items["divideRoop"] = "---------";
		items.ef.items["slideRoop"] = {name: wz_msg('wzwg.webModule.word.reptitSlide')};
		items.ef.items["slideRoopNone"] = {name: wz_msg('wzwg.cmm.word.scrin.stopTheEnd')};
		items.ef.items["divide2"] = "---------";
		items.ef.items["speed_vslow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeVerySlow')};
		items.ef.items["speed_slow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeSlow')};
		items.ef.items["speed_nomal"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeNormal')};
		items.ef.items["speed_fast"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeFast')};
		items.ef.items["hint"] = {html : "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG040' /></span>", type : "html"};
		    		
	}else {
		if(obj.parents('.wzwgWidget').parent().attr('data-h') == 'A' || obj.parent().attr('data-h') == 'A'){
			items.addNtt = {name: wz_msg('wzwg.webModule.word.postCountIncrs'), icon: "edit"}; 
			items.delNtt = {name: wz_msg('wzwg.webModule.word.postCountDcrs'), icon: "edit"};
		}
	}
	
	
	
	if( $(obj).parents().filter('.wzwg-tab-board').length == 1 && $(obj).parents('.wzwg-tab-board').find('.boardTab_sample').length == 1 ){
		items.sep1 = "---------";
		items.bbsAddTab = {name: wz_msg('wzwg.cmm.word.scrin.tabPlus'), icon: "edit"};
		items.bbsDelTab = {name: wz_msg('wzwg.cmm.word.scrin.tabDelete'), icon: "edit"};
	}
	
	
	wzwgCMEndOption(items);
	
	if(logMode)	console.log(items);
	
	return items;
}

function wzwgMapModuleOptions(obj){
	var items = {};

	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(isSysMngr){
		items["sysMngrBoard"] = {name: wz_msg('wzwg.webModule.word.cnncMapChoise'),
								 icon: "edit",
								 items : {
									 	 "hint" : {html : "<span style='color:#999;'><spring:message code='wzwg.cmm.msg.screen.MSG041' /></span>", type : "html"}
								 		}
								};
	}else{
		//items.dataReplace = mapModuleOpsions.dataReplace;
		items.dataReplace = {name: wz_msg('wzwg.webModule.word.cnncMapChoise'), icon: "edit", target: "module10000000213"};
	}
	
	if( (obj.find('.changeBg').length == 1  || obj.hasClass('changeBg')) && isDisplay(obj.find('.changeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "changeBg"};
	}
	
	// 지도모듈 제목변경 (위젯배경과 퀵메뉴아이템의 bTitle이 겹칠때 사용)
	if(obj.find('.mapTitle').length == 1 && isDisplay(obj.find('.mapTitle'))){
    	items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.mapTitleColChg'), icon: "edit" , target: "mapTitle"};
	}
	
	if( (obj.find('.mAddrTitle').length == 1 || obj.hasClass('mAddrTitle')) && isDisplay(obj.find('.mAddrTitle')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.adresTitleColChg'), icon: "edit", target: "mAddrTitle"};
	}
	
	if( (obj.find('.mAddrContent').length == 1 || obj.hasClass('mAddrContent')) && isDisplay(obj.find('.mAddrContent')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.adresCnColChg'), icon: "edit", target: "mAddrContent"};
	}
	
	if(obj.find('.bSubTitle').length == 1  && isDisplay(obj.find('.bSubTitle')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.subtitleChg'), icon: "edit", target: "bSubTitle", multiLine: "false"};
	}
	
	if(obj.find('.bSubConTit').length == 1 && isDisplay(obj.find('.bSubConTit'))){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cnTitleChg'), icon: "edit", target: "bSubConTit"}; 
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cnTitleColChg'), icon: "edit", target: "bSubConTit"}; 
	}
	
	if(obj.find('.bContent').length == 1 && isDisplay(obj.find('.bContent')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cnChg'), icon: "edit", target: "bContent"};
	}
	
	if(obj.find('.bSubContent').length == 1 && isDisplay(obj.find('.bSubContent'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.adiCnChg'), icon: "edit", target: "bSubContent", multiLine: "false"}; 
	}
	
	if(obj.find('.linkTitle').length == 1 && isDisplay(obj.find('.linkTitle')) ){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "linkTitle"};
	}
	
	if(obj.find('.bLinkTitleText').length == 1 && isDisplay(obj.find('.bLinkTitleText')) ){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitleText"}; 
	}
	
	if(obj.find('.linkCol').length == 1 && isDisplay(obj.find('.linkCol')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "linkCol"};
	}
	
	if(obj.find('.bLinkCol').length == 1 && isDisplay(obj.find('.bLinkCol')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkCol"}; 
	}
	
	if(obj.find('.bLinkBg').length == 1 && isDisplay(obj.find('.bLinkBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg') , icon: "edit", target: "bLinkBg"}; 
	}
	
	if(obj.find('.bLinkTitle').length == 1 && isDisplay(obj.find('.bLinkTitle')) ){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitle"}; 
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkTitle"}; 
	}
	
	if(obj.find('.bLinkTitleCol').length == 1 && isDisplay(obj.find('.bLinkTitleCol')) ){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitleCol"}; 
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg') , icon: "edit", target: "bLinkTitleCol"}; 
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bLinkTitleCol"}; 
	}
	
	if(obj.find('.bContentAlign').length == 1){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cntntsLcChg'), icon: "edit", target: "bContentAlign"};
	}
	
	if(obj.find('bTextAlign').length == 1){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg') , icon: "edit", target: "bTextAlign"};
	}
	
	wzwgCMEndOption(items);
	
	if(logMode)	console.log(items);
	
	return items;
}

var menuMnCnt = 0;

function getMenuCnt(){
	menuMnCnt++;
	return menuMnCnt;
}
function resetMuneCnt(){
	menuMnCnt = 0;
}

//자기자신과 부모가 display:none 조건일 경우는 메뉴를 생성하지 못하도록 공통 규칙 추가
function isDisplay(selector){
	if($(selector).css('display') == 'none'){
		return false;
	}
	
	if($(selector).parent().css('display') == 'none'){
		return false;
	}
	
	return true;
}

function wzwgHeadmenuContextOptions(obj, paramItems){
	//obj = obj.not('.wzwgContextMenu>.wzwgContextMenu');
	//console.log(obj.attr('data-title'));
	//console.log(headCommandStr);
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.headerMenuSet" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	//console.log(obj.find('.bContent'));
	
	
	
   	if($(obj).hasClass('topMenu')){
		/* 상단메뉴 상태확인 */
		items.headMenuLgnAtN = {name: wz_msg('wzwg.cmm.word.beforlogn'), icon: "edit"};  
	   	items.headMenuLgnAtY = {name: wz_msg('wzwg.cmm.word.afterlogn'), icon: "edit"};
	   	
   		/* 상단메뉴 기능 구분 */
   		items.divideTopmenu = "---------";

   		/* 상단메뉴 스타일변경 */
   		items.topmenu = {
   	    		name: wz_msg('wzwg.webModule.word.topMenuStyleChg') ,
   	    		icon: "edit",
   	    		items : {}
   	    		};

   				if(headCommandStr.indexOf('TM001') == -1){
   					items.topmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", mode: "topMenuBg"};				//비활성코드 TM001
   				}
   				if(headCommandStr.indexOf('TM002') == -1){
   					items.topmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.listBcrnColChg'), icon: "edit", mode: "topMenuListBg"};      //비활성코드 TM002
   				}
   				if(headCommandStr.indexOf('TM003') == -1){
   					items.topmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseListBcrnColChg'), icon: "edit", mode: "topMenuBgHover"};//비활성코드 TM003
   				}
   				if(headCommandStr.indexOf('TM004') == -1){
   					items.topmenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "topMenuLink"};             //비활성코드 TM004
   				}
   				if(headCommandStr.indexOf('TM005') == -1){
   					items.topmenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseColChg'), icon: "edit", mode: "topMenuHover"};       //비활성코드 TM005
   				}
   				/* if(headCommandStr.indexOf('TM008') == -1){
   					items.topmenu.items["modifyContentAlign_" + getMenuCnt()] = {name: "목록 위치변경", icon: "edit", mode: "topMenuListAlign"}; //비활성코드 TM008
   				} */
   				
   				if(obj.find('.all_menu').css('display') != 'none') {
   					if(headCommandStr.indexOf('TM006') == -1){
   						items.topmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.allMenuButtonBcrnColChg'), icon: "edit", mode: "topAllMenuBg"}; //비활성코드 TM006
   					}
   					if(headCommandStr.indexOf('TM007') == -1){
   						items.topmenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.allMenuButtonColChg'), icon: "edit", mode: "topAllMenuLink"}; //비활성코드 TM007
   					}
   				}
   		/* 상단메뉴 폰트변경 */
   		items["modifyFont_" + getMenuCnt()] = {name : wz_msg('wzwg.webModule.word.topMenuFontChg'), icon: "edit", mode : 'topMenuFont'};
   				
		/* 전체메뉴버튼 삭제 구분 */
		items.divideAllMenuDel = "---------";
		if(obj.find('.all_menu').css('display') == 'none') {
			items.allMenuDel = {name: wz_msg('wzwg.webModule.word.allMenuButtonExposure'), icon: "edit", mode:"allMenuDelN"};  
		}else {
			items.allMenuDel = {name: wz_msg('wzwg.webModule.word.allMenuButtonUnexposure'), icon: "edit", mode:"allMenuDelY"};
		}
		
		items.divideTopMenuClear = "--------";
		items.menustyleTopClear = {name: wz_msg('wzwg.webModule.word.topMenuStyleDelete02'), icon: "edit"};
   	}
	
   	if($(obj).hasClass('headMenuBg')){
   		/* 메인메뉴 기능 구분 */
   		items.divideHeadmenu = "---------";
   		
   		items.headmenu = {
   	    		name: wz_msg('wzwg.webModule.word.mainMenuStylechg'),
   	    		icon: "edit",
   	    		items : {}
   	    		};
   		
   				if(headCommandStr.indexOf('MM001') == -1){
   					items.headmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", mode: "headMenuBg"};                  //비활성코드 MM001
   				}
   				if(headCommandStr.indexOf('MM002') == -1){
   					items.headmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.listBcrnColChg'), icon: "edit", mode: "headMenuListBg"};         //비활성코드 MM002
   				}
   				if(headCommandStr.indexOf('MM003') == -1){
   					items.headmenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseListBcrnColChg'), icon: "edit", mode: "headMenuBgHover"};   //비활성코드 MM003     
   				}
   				if(headCommandStr.indexOf('MM004') == -1){
   					items.headmenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "headMenuLink"};                //비활성코드 MM004
   				}
   				if(headCommandStr.indexOf('MM005') == -1){
   					items.headmenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseColChg'), icon: "edit", mode: "headMenuHover"};          //비활성코드 MM005
   				}
   		
   		/* 2차메뉴 기능 구분 */
   		items.divideHeadmenu = "---------";
   		
   		items.headSemenu = {
   	    		name: wz_msg('wzwg.webModule.word.lwprtMenuStyleChg'),
   	    		icon: "edit",
   	    		items : {}
   	    		};
   		
   				if(headCommandStr.indexOf('MS001') == -1){
   					items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.secondBcrnColChg'), icon: "edit", mode: "headMenuBg_se_basic"};                //비활성코드 MS001
   				}
   				if(headCommandStr.indexOf('MS002') == -1){
   					items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.secondChoiseBcrnColChg'), icon: "edit", mode: "headMenuBgHover_se_basic"};      //비활성코드 MS002
   				}
   				if(headCommandStr.indexOf('MS003') == -1){
   					items.headSemenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.secondColChg'), icon: "edit", mode: "headMenuLink_se_basic"};              //비활성코드 MS003
   				}
   				if(headCommandStr.indexOf('MS004') == -1){
   					items.headSemenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.secondChoiseColChg'), icon: "edit", mode: "headMenuHover_se_basic"};        //비활성코드 MS004
   				}
   				
   				items.headSemenu.items.divideHeadSubmenu = "----------";
   				
   				if(headCommandStr.indexOf('MT001') == -1){
   					items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.thirdBcrnColChg'), icon: "edit", mode: "headMenuBg_thr_basic"};               //비활성코드 MT001
   				}
   				if(headCommandStr.indexOf('MT002') == -1){
   					items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.thirdChoiseBcrnColChg'), icon: "edit", mode: "headMenuBgHover_thr_basic"};     //비활성코드 MT002
   				}
   				if(headCommandStr.indexOf('MT003') == -1){
   					items.headSemenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.thirdColChg'), icon: "edit", mode: "headMenuLink_thr_basic"};             //비활성코드 MT003
   				}
   				if(headCommandStr.indexOf('MT004') == -1){
   					items.headSemenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.thirdChoiseColChg'), icon: "edit", mode: "headMenuHover_thr_basic"};       //비활성코드 MT004
   				}
   				
   		/* 2차메뉴 추가 기능  */
   		var menuCssPath = $('#headmenu').attr('href').toLowerCase();
   		var pathSplit = menuCssPath.split('/');
   		
   		var menuCssFileName = pathSplit[pathSplit.length-1];
   		var headMenuAction = '';
   		
   		
   		if(menuCssFileName.indexOf('pulldown') >= 0){
   			headMenuAction = 'pullDown';
   			
   		
   		}else if(menuCssFileName.indexOf('wide') >= 0){
   			headMenuAction = 'wide';
   			items.headSemenu.items.divideHeadmenuWideMode = "---------";
   			
   			if(headCommandStr.indexOf('MW001') == -1){
   				items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.extsnPan1BcrnColChg'), icon: "edit", mode: "lnbBg"};				//비활성코드 MW001
   			}
   			if(headCommandStr.indexOf('MW002') == -1){
   				items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.extsnPan1SecondListBcrnColChg'), icon: "edit", mode: "selnbBg"};		//비활성코드 MW002
   			}
   			if(headCommandStr.indexOf('MW003') == -1){
   				items.headSemenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.extsnPan1TitleBcrnColChg'), icon: "edit", mode: "oneDepth_menuBg"};	//비활성코드 MW003
   			}
   			if(headCommandStr.indexOf('MW004') == -1){
   				items.headSemenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.extsnPan1TitleColChg'), icon: "edit", mode: "oneDepth_menuNm"};//비활성코드 MW004
   			}
   			
   			
   		}else{
   			
   		}
   		
   		/* 메뉴 폰트변경 */
   		items["modifyFont_" + getMenuCnt()] = {name : wz_msg('wzwg.webModule.word.menuFontChg'), icon: "edit", mode : 'headMenuFont'};
   		
   		items.divideHeadMenuClear = "--------";
   		items.menustyleHeadClear = {name: wz_msg('wzwg.webModule.word.mainMenuStyleDelete02'), icon: "edit"};
   	}
	
	/* 삭제 기능 구분 */
	/*
	items.divideClear = "--------";
	
	items.styleClear = {
    		name: "스타일 제거",
    		icon: "edit",
    		items : {}
    		}; 
	
	items.styleClear.name = "스타일 제거";
	items.styleClear.icon = "edit";
			items.styleClear.items["menustyleTopClear_" + getMenuCnt()] = {name: "상단메뉴 스타일 제거", icon: "edit"};
			items.styleClear.items["menustyleHeadClear_" + getMenuCnt()] = {name: "메인메뉴 스타일 제거", icon: "edit"};
			items.styleClear.items["menustyleAllClear_" + getMenuCnt()] = {name: "모든 스타일 제거", icon: "edit"};
	*/
			
			
	wzwgCMEndOption(items);
	
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}

function wzwgFootermenuContextOptions(obj, paramItems){
	
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.footerMenuSet" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	
	/* 하단메뉴 상태확인 */
	items.footerMenuLgnAtN = {name: wz_msg('wzwg.cmm.word.beforlogn'), icon: "edit"};  
   	items.footerMenuLgnAtY = {name: wz_msg('wzwg.cmm.word.afterlogn'), icon: "edit"};
	
   	/* 하단전체 기능 구분 */
   	items.divideBottom = "---------";
   	
   	items.bottom = {
    		name: wz_msg('wzwg.webModule.word.botomAllStyleChange'),
    		icon: "edit",
    		items : {}
    		};
   	
	   	if(footCommandStr.indexOf('BA001') == -1){
			items.bottom.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", mode: "bottomBg"};				//비활성코드 BA001
		}
	   	/* if(footCommandStr.indexOf('BA002') == -1){
			items.bottom.items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.borr') + " " + wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "bottomBorderBg"};				//비활성코드 BA002
		} */
   	
	/* 하단메뉴 기능 구분 */
	items.divideBottomMenu = "---------";

	items.bottomMenu = {
    		name: wz_msg('wzwg.webModule.word.botomMenuStyleChg'),
    		icon: "edit",
    		items : {}
    		};

			if(footCommandStr.indexOf('BM001') == -1){
				items.bottomMenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", mode: "bottomMenuBg"};				//비활성코드 BM001
			}
			/* if(footCommandStr.indexOf('BM002') == -1){
				items.bottomMenu.items["modifyBgColor_" + getMenuCnt()] = {name: "목록 wz_msg('wzwg.cmm.word.scrin.bcrnColChg')", icon: "edit", mode: "bottomMenuListBg"};//비활성코드 BM002
			}*/
			if(footCommandStr.indexOf('BM003') == -1){
				items.bottomMenu.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseListBcrnColChg'), icon: "edit", mode: "bottomMenuBgHover"};//비활성코드 BM003
			}
			if(footCommandStr.indexOf('BM004') == -1){
				items.bottomMenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "bottomMenuLink"};             //비활성코드 BM004
			}
			if(footCommandStr.indexOf('BM005') == -1){
				items.bottomMenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.choiseColChg'), icon: "edit", mode: "bottomMenuHover"};       //비활성코드 BM005
			}
			if(footCommandStr.indexOf('BM006') == -1){
				items.bottomMenu.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.menuSebarColChg'), icon: "edit", mode: "bottomMenuSe"};       //비활성코드 BM006
			}
			/* if(footCommandStr.indexOf('BM007') == -1){
				items.bottomMenu.items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.borr') + " " + wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "bottomCopyritBorderBg"};       //비활성코드 BM007
			} */
			if(footCommandStr.indexOf('BM008') == -1){
				items.bottomMenu.items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.menuLcChg'), icon: "edit", mode: "bottomMenuAlign"};       //비활성코드 BM008
			}
	
	/* 하단 메뉴 폰트변경 */
	items["modifyFont_" + getMenuCnt()] = {name : wz_msg('wzwg.webModule.word.botomMenuFontChg'), icon: "edit", mode : 'bottomMenuFont'};
			
			
	/* 하단정보영역 기능 구분 */
	items.footinfo = {
    		name: wz_msg('wzwg.webModule.word.botomInfoStyleChg'),
    		icon: "edit",
    		items : {}
    		};
	
			if(footCommandStr.indexOf('FI001') == -1){
				items.footinfo.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", mode: "footInfoBg"};                  //비활성코드 FI001
			}
			if(footCommandStr.indexOf('FI002') == -1){
				items.footinfo.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "footInfoLink"};             //비활성코드 FI002
			}
			if(footCommandStr.indexOf('FI003') == -1){
				items.footinfo.items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg'), icon: "edit", mode: "footInfoAlign"};       //비활성코드 FI003
			}
			
			items.footinfo.items.divideCopyright  = "----------";
			
			if(footCommandStr.indexOf('FC001') == -1){
				items.footinfo.items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.copyrightBcrnColChg'), icon: "edit", mode: "footCopyritBg"};       //비활성코드 FC001
			}
			if(footCommandStr.indexOf('FC002') == -1){
				items.footinfo.items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.scrin.copyrightColChg'), icon: "edit", mode: "footCopyritLink"};       //비활성코드 FC002
			}
			/* if(footCommandStr.indexOf('FC003') == -1){
				items.footinfo.items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.copyright') + " " + wz_msg('wzwg.cmm.word.borr') + " " + wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit", mode: "footCopyritBorderBg"};       //비활성코드 FC003
			} */
			if(footCommandStr.indexOf('FC004') == -1){
				items.footinfo.items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.copyrightWordsLcChg'), icon: "edit", mode: "footCopyritAlign"};       //비활성코드 FC004
			}
			
	/* 하단 정보 폰트변경 */
	items["modifyFont_" + getMenuCnt()] = {name : wz_msg('wzwg.webModule.word.botomInfoFontChg'), icon: "edit", mode : 'footInfoFont'};

	
			
	/* 삭제 기능 구분 */
	items.divideClear = "--------";
	
	items.styleClear = {
    		name: wz_msg('wzwg.cmm.word.style') + " " + wz_msg('wzwg.cmm.word.delete02'),
    		icon: "edit",
    		items : {}
    		}; 
			items.styleClear.items["menustyleBottomClear_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.botomMenuStyleDelete02'), icon: "edit"};
			items.styleClear.items["stylefootinfoClear_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.botomInfoStyleDelete02'), icon: "edit"};
			items.styleClear.items["footerStyleAllClear_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.all03StyleDelete02'), icon: "edit"};
	
	wzwgCMEndOption(items);
	
	resetMuneCnt();
	return items;
}

function wzwgLoginWidgetOptions(obj, paramItems){
	
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	
	/* 로그인위젯상태확인 */
	items.loginWidgetLgnAtN = {name: wz_msg('wzwg.cmm.word.beforlogn'), icon: "edit"};  
   	items.loginWidgetLgnAtY = {name: wz_msg('wzwg.cmm.word.afterlogn'), icon: "edit"};
   	
   	
   	if( (obj.find('.changeBg').length == 1  || obj.hasClass('changeBg')) && isDisplay(obj.find('.changeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "changeBg"};
	}
	
   	if( (obj.find('.lgnNchangeBg').length == 1  || obj.hasClass('lgnNchangeBg')) && isDisplay(obj.find('.lgnNchangeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.beforlognBcrnColChg'), icon: "edit", target: "lgnNchangeBg"};
	}
   	
   	if( (obj.find('.lgnYchangeBg').length == 1  || obj.hasClass('lgnYchangeBg')) && isDisplay(obj.find('.lgnYchangeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.afterlognBcrnColChg'), icon: "edit", target: "lgnYchangeBg"};
	}
	
   	wzwgCMEndOption(items);
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}

function wzwgCMOptions(obj, paramItems){
	
	var items = {};
	if(paramItems){
		items = paramItems;
	}

	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	// 기본만 가지는 메뉴들
	if(obj.hasClass('layout_wrap') || obj.hasClass('empty')){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit"};
		/* if(obj.hasClass('layout_wrap') || obj.hasClass('empty')){
			items["modifyAttr_" + getMenuCnt()] = {name: "메뉴 아이디변경", icon: "edit", attrId: "role-scroll"};
		} */
		if(obj.hasClass('targetLayoutBd') || (obj.find('.targetLayoutBd').length == 1 && isDisplay(obj.find('.targetLayoutBd')))){
			items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "targetLayoutBd"};
		}
		
		if(obj.find('.layoutBgImg').length == 1 && isDisplay(obj.find('.layoutBgImg')) ){
			if(isSysMngr){
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrBcrnImgChg'), obj.find('.layoutBgImg'));
				items['changeImgPath' + '_' + getMenuCnt()] = {name: imgtitle, icon: 'edit', isHtmlName: true, target: 'layoutBgImg'};
			}else{
				var imgtitle = getImageHintTitle(wz_msg('wzwg.cmm.word.scrin.bcrnImgChg'), obj.find('.layoutBgImg'));
				items.uploadImg = {name: imgtitle, icon: "edit", isHtmlName: true, target: 'layoutBgImg'};
				items["imgClassCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bcrnImgReplcTxtInput'), icon: "edit", target: 'layoutBgImg'};
			}
			
		}else if(testPassClassName(obj)){
			//아무것도 하지 말아라
		}
		wzwgCMEndOption(items);
		return items;
	}
	
	// banner126 전용 2019-05-14 hekim
	if(obj.hasClass('banner126') && obj.find('.bnr_wrap').length == 1 && obj.parent().attr("data-w") == "100" ){
		items["changeViewBanner126"] = {name: wz_msg('wzwg.webModule.word.imageLcChg'), icon: "edit"};
	}
	
	if(obj.find('.bTitle').length == 1 && isDisplay(obj.find('.bTitle'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjChg'), icon: "edit", target: "bTitle", multiLine: "false"}; 
	}
	
	if(obj.find('.mTitle').length == 1 && isDisplay(obj.find('.mTitle'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjChg'), icon: "edit", target: "mTitle"};
	}
	
	if(obj.find('.bSubTitle').length == 1  && isDisplay(obj.find('.bSubTitle')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.subSjChg'), icon: "edit", target: "bSubTitle", multiLine: "false"};
	}
	
	if(obj.find('.bSubMTitle').length == 1 && isDisplay(obj.find('.bSubMTitle')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.subSjChg'), icon: "edit", target: "bSubMTitle"};
	}
	
	if(obj.find('.bContent').length == 1 && isDisplay(obj.find('.bContent')) ){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.cnChg'), icon: "edit", target: "bContent"}; 
	}
	
	if(obj.find('.bSubContent').length == 1 && isDisplay(obj.find('.bSubContent'))){
		items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.adiCnChg'), icon: "edit", target: "bSubContent"};
	}
	
	if( (obj.find('.changeBg').length == 1  || obj.hasClass('changeBg')) && isDisplay(obj.find('.changeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "changeBg"};
	}
	
	if( (obj.find('.sChangeBg').length == 1  || obj.hasClass('sChangeBg')) && isDisplay(obj.find('.sChangeBg')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "sChangeBg"};
	}
	
	if( (obj.find('.changeTxtCol').length == 1 || obj.hasClass('changeTxtCol')) && isDisplay(obj.find('.changeTxtCol')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.fontColChg'), icon: "edit", target: "changeTxtCol"};
	}
	
	if( (obj.find('.changeColTxtBg').length == 1 || obj.hasClass('changeColTxtBg')) &&isDisplay(obj.find('.changeColTxtBg')) ){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.fontColChg'), icon: "edit", target: "changeColTxtBg"};
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit", target: "changeColTxtBg"};
	}
	
	if( (obj.find('.targetBG').length == 1  || obj.hasClass('targetBG')) && isDisplay(obj.find('.targetBG')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "targetBG"};
	}
	
	if( (obj.find('.sTargetBG').length == 1  || obj.hasClass('sTargetBG')) && isDisplay(obj.find('.sTargetBG')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "sTargetBG"};
	}
	
	if(obj.hasClass('targetLayoutBd') || (obj.find('.targetLayoutBd').length == 1 && isDisplay(obj.find('.targetLayoutBd')))){
		items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "targetLayoutBd"};
	}
	
	if( (obj.find('.bBorderBg').length == 1  || obj.hasClass('bBorderBg')) && isDisplay(obj.find('.bBorderBg')) ){
		items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.borrColChg'), icon: "edit", target: "bBorderBg"};
	}
	
	if( (obj.find('.targetBoardBg').length == 1  || obj.hasClass('targetBoardBg')) && isDisplay(obj.find('.targetBoardBg')) ){
		items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.appnBorrColChg'), icon: "edit", target: "targetBoardBg"};
	}

	if((obj.find('.bIconCol').length == 1 || obj.hasClass('bIconCol')) && isDisplay(obj.find('.bIconCol'))){
		items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconColChg'), icon: "edit", target: "bIconCol"}; 
	}
	
	if((obj.find('.bIconBgCol').length == 1 || obj.hasClass('bIconBgCol')) && isDisplay(obj.find('.bIconBgCol'))){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconColChg'), icon: "edit", target: "bIconBgCol"}; 
	}
	
	if( (obj.find('.bContentAlign').length == 1 || obj.hasClass('bContentAlign')) && isDisplay(obj.find('.bContentAlign'))){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.cntntsLcChg'), icon: "edit", target: "bContentAlign"};
	}
	
	if( (obj.find('.bTextAlign').length == 1 || obj.hasClass('bTextAlign')) && isDisplay(obj.find('.bTextAlign'))){
		items["modifyContentAlign_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.wordsLcChg'), icon: "edit", target: "bTextAlign"};
	}
	
	if(obj.parent().attr('id') == 'data'){
		// 게시판 하위에 붙을경우 작업하지 않는다
	}else if(obj.find('img').length == 1 && isDisplay(obj.find('img')) ){
		var img = obj.find('img')[0] ;
		if($(img).hasClass('bIcon') == false && $(img).hasClass('bgImg') == false){
			if(isSysMngr){
				var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrImageChange'), img);
				items.changeImgPath_ = {name: imgtitle, icon: 'edit', isHtmlName: true};
			}else{
				
				var imgtitle = getImageHintTitle(wz_msg('wzwg.cmm.word.scrin.imgChg'), img);
				items.uploadImg = {name: imgtitle, icon: "edit", isHtmlName: true};
				items["imgCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.imageReplcTxtInput'), icon: "edit"};
			}
			
		}
	}
	
	if(obj.find('.bgImg').length == 1 && isDisplay(obj.find('.bgImg')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrBcrnImgChg'), obj.find('.bgImg'));
			items['changeImgPath' + '_' + getMenuCnt()] = {name: imgtitle, icon: 'edit', isHtmlName: true, target: 'bgImg'};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.cmm.word.scrin.bcrnImgChg'), obj.find('.bgImg'));
			items.uploadImg = {name: imgtitle, icon: "edit", isHtmlName: true, target: 'bgImg'};
			items["imgClassCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.bcrnImgReplcTxtInput'), icon: "edit", target: 'bgImg'};
		}
		
	}else if(testPassClassName(obj)){
		//아무것도 하지 말아라
	}
	
	if(obj.find('.bIcon').length == 1 && isDisplay(obj.find('.bIcon')) ){
		if(isSysMngr){
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.mngrIconChg'), obj.find('.bIcon'));
			items['changeImgPath' + '_' + getMenuCnt()] = {name: imgtitle, icon: 'edit', isHtmlName: true, target: 'bIcon'};
		}else{
			var imgtitle = getImageHintTitle(wz_msg('wzwg.webModule.word.iconChng') , obj.find('.bIcon'));
			items['modifyIcon' + '_' + getMenuCnt()] = {name: imgtitle, icon: "edit", no: 0, isHtmlName: true, target: 'bIcon'};
		}
		
		items["imgClassCaption_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.iconReplcTxtInput') , icon: "edit", target: 'bIcon'};
	}else if(testPassClassName(obj)){
		//아무것도 하지 말아라
	}
	
	items["moreStyleOp"] = {name: wz_msg('wzwg.webModule.word.shrtcutStyleChg'),
			 icon: "edit",
			 items : {}
			};
	
	if(obj.find('.linkTitle').length == 1 && isDisplay(obj.find('.linkTitle')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "linkTitle"};
	}
	
	if(obj.find('.bLinkTitleText').length == 1 && isDisplay(obj.find('.bLinkTitleText')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitleText"}; 
	}
	
	if(obj.find('.linkCol').length == 1 && isDisplay(obj.find('.linkCol')) ){
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "linkCol"};
	}
	
	if(obj.find('.bLinkCol').length == 1 && isDisplay(obj.find('.bLinkCol')) ){
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkCol"}; 
	}
	
	if(obj.find('.blinkIconCol').length == 1 && isDisplay(obj.find('.blinkIconCol')) ){
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutIconColChg'), icon: "edit", target: "blinkIconCol"}; 
	}
	
	if(obj.find('.bLinkBg').length == 1 && isDisplay(obj.find('.bLinkBg')) ){
		items["moreStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bLinkBg"}; 
	}
	
	if( (obj.find('.bLinkBoardCol').length == 1  || obj.hasClass('bLinkBoardCol')) && isDisplay(obj.find('.bLinkBoardCol')) ){
		items["moreStyleOp"].items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBorrColChg'), icon: "edit", target: "bLinkBoardCol"};
	}
	
	if(obj.find('.bLinkTitle').length == 1 && isDisplay(obj.find('.bLinkTitle')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitle"}; 
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkTitle"}; 
	}
	
	if(obj.find('.bLinkTitleCol').length == 1 && isDisplay(obj.find('.bLinkTitleCol')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitleCol"}; 
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkTitleCol"}; 
		items["moreStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg'), icon: "edit", target: "bLinkTitleCol"}; 
	}
	
	if(obj.find('.bLinkTitleBrCol').length == 1 && isDisplay(obj.find('.bLinkTitleBrCol')) ){
		items["moreStyleOp"].items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutWordsChg'), icon: "edit", target: "bLinkTitleBrCol"}; 
		items["moreStyleOp"].items["modifyTextColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutColChg'), icon: "edit", target: "bLinkTitleBrCol"}; 
		items["moreStyleOp"].items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBcrnColChg') , icon: "edit", target: "bLinkTitleBrCol"};
		items["moreStyleOp"].items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.shrtcutBorrColChg'), icon: "edit", target: "bLinkTitleBrCol"};
	}
	
	items["linkOp"] = {name: wz_msg('wzwg.webModule.word.linkCnnc'),
			 icon: "edit",
			 items : {}
		};
	
	if(obj.parent().attr('id') == 'data'){
		// 게시판 하위에 붙을경우 작업하지 않는다
	}else if(testPassClassName(obj)){
		//아무것도 하지 말아라
	
	}else if(obj.find('a').length == 1 && isDisplay(obj.find('a')) ){
		
		if(obj.find('a').hasClass('nolink') == false){
			items["linkOp"].items.modifyLink = {name: wz_msg('wzwg.cmm.word.scrin.shortcutChg'), icon: "edit"};
			items["linkOp"].items.addFilestore = {name: wz_msg('wzwg.webModule.word.fileStoreCnnc'), icon: "file"};
		}
		
	}
	
	if(  (obj.find('.txtPosition').length == 1  || obj.hasClass('txtPosition'))  && isDisplay(obj.find('.txtPosition')) ){
		items.modifyTxtPosition = {name: wz_msg('wzwg.cmm.word.scrin.lcChg'), icon: "edit"};
		items.txtanimation = {
	    		name: wz_msg('wzwg.webModule.word.fontEffectChg'),
	    		icon: "edit",
	    		items : {
	    				"txtEF_scalefx" : {name: wz_msg('wzwg.webModule.word.scaleChg'), effect : 'scalefx'},
	    				"txtEF_totop" : {name: wz_msg('wzwg.cmm.word.scrin.upFlowEffect'), effect : 'totop'},
	    				"txtEF_toright" : {name: wz_msg('wzwg.cmm.word.scrin.rightFlowEffect'), effect : 'toright'},
	    				"txtEF_toleft" : {name: wz_msg('wzwg.cmm.word.scrin.leftFlowEffect'), effect : 'toleft'},
	    				"txtEF_delete" : {name: wz_msg('wzwg.webModule.word.effectDelete'), effect : 'delete'},
	    			}
	    		};
	}
	
	if(  (obj.find('.txtPositionTop').length == 1 || obj.hasClass('txtPositionTop')) && isDisplay(obj.find('.txtPositionTop')) ){
		items.modifyTxtPositionTop = {name: wz_msg('wzwg.cmm.word.scrin.lcChg'), icon: "edit"};
		items.txtanimation = {
	    		name: wz_msg('wzwg.webModule.word.fontEffectChg'),
	    		icon: "edit",
	    		items : {
	    				"txtEF_scalefx" : {name: wz_msg('wzwg.webModule.word.scaleChg') , effect : 'scalefx'},
	    				"txtEF_totop" : {name: wz_msg('wzwg.cmm.word.scrin.upFlowEffect'), effect : 'totop'},
	    				"txtEF_toright" : {name: wz_msg('wzwg.cmm.word.scrin.rightFlowEffect'), effect : 'toright'},
	    				"txtEF_toleft" : {name: wz_msg('wzwg.cmm.word.scrin.leftFlowEffect'), effect : 'toleft'},
	    				"txtEF_delete" : {name: wz_msg('wzwg.webModule.word.effectDelete'), effect : 'delete'},
	    			}
	    		};
	}
	
	if(obj.hasClass('boardSlide')){
		items.ef = {
	    		name: wz_msg('wzwg.webModule.word.effectChg'),
	    		icon: "edit",
	    		items : {
	    				"slideAuto" : {name: wz_msg('wzwg.cmm.word.scrin.autoSlide')},
	    				"slideStop" : {name: wz_msg('wzwg.cmm.word.scrin.passivSlide')},
	    				"hint": {html : "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG040' /></span>", type : "html"},
	    			}
	    		};
	}else if(obj.hasClass('wzwg-swiper') || obj.hasClass('wzwg-slide-info')){
		items.addSliderContents = {name: wz_msg('wzwg.cmm.word.scrin.sliderAdd'), icon: "edit"}; 
	
		items.moveForward = {name: wz_msg('wzwg.cmm.word.scrin.moveForward') , icon: "edit"};
		items.moveBackward = {name: wz_msg('wzwg.cmm.word.scrin.moveBackward') , icon: "edit"};
		
		
		
		if(obj.hasClass('wzwg-slide-info') == false){
			items.delSlider = {name: wz_msg('wzwg.cmm.word.scrin.sliderDel'), icon: "edit"}; 
		}
		
		if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1){
			items.changeArrowBg = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg') , icon: "edit"}; 
			items.changeArrowBd = {name: wz_msg('wzwg.webModule.word.prev/nextBorrColChg') , icon: "edit"};
		}
		
		if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1 && obj.find('.play').length == 1 && obj.find('.stop').length == 1){
			delete items.changeArrowBg;
			delete items.changeArrowBd;
			items.changeBnrArrowBg = {name: wz_msg('wzwg.webModule.word.buttonBcrnColChg'), icon: "edit"};
			items.changeBnrArrowBd = {name: wz_msg('wzwg.webModule.word.buttonBorrColChg'), icon: "edit"};
		}
		
		items.ef = {
	    		name: wz_msg('wzwg.webModule.word.effectChg'),
	    		icon: "edit",
	    		items : {}
			};
			
			items.ef.items["effecSlide"] = {name: wz_msg('wzwg.cmm.word.wa.slide')};
			items.ef.items["effecFade"] = {name: wz_msg('wzwg.cmm.word.wa.fade')};
			items.ef.items["divide"] = "---------";
			items.ef.items["slideAuto"] = {name: wz_msg('wzwg.cmm.word.scrin.autoSlide')};
			items.ef.items["slideStop"] = {name: wz_msg('wzwg.cmm.word.scrin.passivSlide')};
			
			if(obj.find('.wzwg-slide-info').length == 1 || obj.hasClass('wzwg-slide-info')){
				items.ef.items["divideRoop"] = "---------";
				items.ef.items["slideRoop"] = {name: wz_msg('wzwg.webModule.word.reptitSlide')};
				items.ef.items["slideRoopNone"] = {name: wz_msg('wzwg.cmm.word.scrin.stopTheEnd')};
			}
			
			items.ef.items["divide2"] = "---------";
			items.ef.items["speed_vslow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeVerySlow')};
			items.ef.items["speed_slow"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeSlow')};
			items.ef.items["speed_nomal"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeNormal')};
			items.ef.items["speed_fast"] = {name: wz_msg('wzwg.cmm.word.scrin.cnvrsVeFast')};
			items.ef.items["hint"] = {html : "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG040' /></span>", type : "html"};
			
	}else if(obj.hasClass('wzwg-banner-slide-info')){
		
		if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1){
			items.changeArrowBg = {name: wz_msg('wzwg.webModule.word.prev/nextButtonColChg01'), icon: "edit"};
			items.changeArrowBd = {name: wz_msg('wzwg.webModule.word.prev/nextBorrColChg'), icon: "edit"};
		}
		
		if(obj.find('.arrow-prev').length == 1 && obj.find('.arrow-next').length == 1 && obj.find('.play').length == 1 && obj.find('.stop').length == 1){
			delete items.changeArrowBg;
			delete items.changeArrowBd;
			items.changeBnrArrowBg = {name: wz_msg('wzwg.webModule.word.buttonBcrnColChg'), icon: "edit"};
			items.changeBnrArrowBd = {name: wz_msg('wzwg.webModule.word.buttonBorrColChg'), icon: "edit"};
		}
		
		if(obj.find('.brnBtnBg').length == 1 || obj.find('.brnBtnBg').length == 1){
			items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.buttonBcrnColChg'), icon: "edit", target: "brnBtnBg"};
		}
	
		if(obj.find('.brnBtnBd').length == 1 || obj.find('.brnBtnBd').length == 1){
			items["modifyBorderColor_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.buttonBorrColChg'), icon: "edit", target: "brnBtnBd"};
		}
		
		if(obj.hasClass('.brnBd') || obj.find('.brnBd').length > 0){
			items.changeBnrBdColor = {name: wz_msg('wzwg.webModule.word.bannerBorrColChg'), icon: "edit", target: "brnBd"};
		}
		
		if(obj.hasClass('.brnBg') || obj.find('.brnBg').length > 0){
			items.changeBnrBgColor = {name: wz_msg('wzwg.webModule.word.bannerBcrnColChg'), icon: "edit", target: "brnBg"};
		}
		
		items.ef = {
    		name: wz_msg('wzwg.webModule.word.effectChg'),
    		icon: "edit",
    		items : {
    				"slideAuto" : {name: wz_msg('wzwg.cmm.word.scrin.autoSlide')},
    				"slideStop" : {name: wz_msg('wzwg.cmm.word.scrin.passivSlide')},
    				"hint": {html : "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG040' /></span>", type : "html"},
    			}
    		};
	}
	
	if(obj.attr('data-type') == 'quick'){
		//items.delete = {name: "배너삭제", icon: "edit"};
		var del = {"delete": {name: wz_msg('wzwg.cmm.word.scrin.quickDel'), icon: "edit", target: "quick"}};
		$.extend(items, del);
	}
	
	if(obj.attr('data-type') == 'slide'){
		//items.delete = {name: "배너삭제", icon: "edit"};
		var del = {"delSlider": {name: wz_msg('wzwg.cmm.word.scrin.sliderDel'), icon: "edit"}};
		$.extend(items, del);
	}
	
	console.log(items);
	
	if(Object.keys(items.moreStyleOp.items).length ==0){
		delete items.moreStyleOp;
	}
	if(Object.keys(items.linkOp.items).length ==0){
		delete items.linkOp;
	}
	
	if(! paramItems){
		wzwgCMEndOption(items);
	}
	
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}

/* 탭 컨텐츠 옵션 */
function wzwgTabContextOptions(obj, paramItems){
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	
	
	if(obj.hasClass('cntnts-tabs')){
		items["addTabMenu_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.newTabAdd'), icon: "edit"};
		
		items.tabStyle = {
	    		name: wz_msg('wzwg.cmm.word.tab') + " " + wz_msg('wzwg.cmm.word.style') + " " + wz_msg('wzwg.cmm.word.change'),
	    		icon: "edit",
	    		items : {
	    				"tabstyle_basic" : {name: wz_msg('wzwg.cmm.word.gnrl'), tabtype : "basic"},
	    				"tabstyle_basicWide" : {name: wz_msg('wzwg.cmm.word.gnrl') + "(" + wz_msg('wzwg.cmm.word.wide') + ")", tabtype : "basic-wide"},
	    				"tabstyle_button" : {name: wz_msg('wzwg.cmm.word.button'), tabtype : "button"},
	    				"tabstyle_buttonWide" : {name: wz_msg('wzwg.cmm.word.button') + "(" + wz_msg('wzwg.cmm.word.wide') + ")", tabtype : "button-wide"},
	    			}
	    		};
		
		items.tabColor = {
	    		name: wz_msg('wzwg.cmm.word.tab') + wz_msg('wzwg.cmm.word.color') + " " + wz_msg('wzwg.cmm.word.change'),
	    		icon: "edit",
	    		items : {
	    				"tabcolor_red" 	  : {name: "red", tabcolor : "red"},
	    				"tabcolor_pink"   : {name: "pink", tabcolor : "pink"},
	    				"tabcolor_orange" : {name: "orange", tabcolor : "orange"},
	    				"tabcolor_yellow" : {name: "yellow", tabcolor : "yellow"},
	    				"tabcolor_green"  : {name: "green", tabcolor : "green"},
	    				"tabcolor_blue"   : {name: "blue", tabcolor : "blue"},
	    				"tabcolor_brown"  : {name: "brown", tabcolor : "brown"},
	    				"tabcolor_violet" : {name: "violet", tabcolor : "violet"},
	    				"tabcolor_purple" : {name: "purple", tabcolor : "purple"},
	    				"tabcolor_white"  : {name: "white", tabcolor : "white"},
	    				"tabcolor_grey"   : {name: "grey", tabcolor : "grey"},
	    				"tabcolor_black"  : {name: "black", tabcolor : "black"},
	    			}
	    		};
	}
	
	
	if(obj.find('.tabTitle').length == 1 && isDisplay(obj.find('.tabTitle'))){
		items["modifyText_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.menuNm01Chg'), icon: "edit", target: "tabTitle"};
		items["deleteTabMenu_" + getMenuCnt()] = {name: wz_msg('wzwg.webModule.word.tabDelete'), icon: "edit", target: "tabTitle"};
    	//items["modifyTextColor_" + getMenuCnt()] = {name: "메뉴명 " + " " + wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit" , target: "tabTitle"};
	}
	
	
	wzwgCMEndOption(items);
	
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}

/* 테이블 컨텐츠 옵션 */
function wzwgTableContextOptions(obj, paramItems){
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.widgEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	
	items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.bcrnColChg'), icon: "edit"};
	
	items["modifyTable"] = {name: wz_msg('wzwg.webModule.word.tableFrameEdit'), icon: "edit"};
	
	items["modifyTableSkin"] = {name: wz_msg('wzwg.webModule.word.tableSkinChg'), icon: "edit"};
	
	if(obj.find('.tableTitle').length == 1 && isDisplay(obj.find('.tableTitle'))){
		/* items["modifyText_" + getMenuCnt()] = {name: "제목 변경", icon: "edit", target: "tableTitle"};
    	items["modifyTextColor_" + getMenuCnt()] = {name: "제목 " + " " + wz_msg('wzwg.cmm.word.scrin.colChg'), icon: "edit" , target: "tableTitle"}; */
    	
    	items["basicEditor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.sjChg'), icon: "edit", target: "tableTitle", multiLine: "false"};
	}
	
	
	
	if( (obj.find('.targetBG').length == 1  || obj.hasClass('targetBG')) && isDisplay(obj.find('.targetBG')) ){
		items["modifyBgColor_" + getMenuCnt()] = {name: wz_msg('wzwg.cmm.word.scrin.appnBgColChg'), icon: "edit", target: "targetBG"};
	}
	
	wzwgCMEndOption(items);
	
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}

/* 레이아웃 설정 옵션 */
function wzwgLayoutContextOptions(obj, paramItems){
	var items = {};
	
	items["context_title"] = {html : "<span><spring:message code="wzwg.webModule.word.layoutEstbs" /></span>", icon: function(){return 'context-menu-title'}, type: 'html'};
	
	if(paramItems){
		items = paramItems;
	}
	
	//console.log(obj);
	var layout = $(obj).parent();
	
	if(layout.attr('data-anchor') == undefined || layout.attr('data-anchor') == ''){
		items["anchorHandler"] = {name: wz_msg('wzwg.webModule.word.anchorMenuCnnc'), icon: "edit"};
	}else{
		items["anchorHandler_clear"] = {name: wz_msg('wzwg.webModule.word.anchorMenuRelis'), icon: "edit"};
	}
	
	items.divideClear1 = "--------";
	
	items["modifyLayoutBorder_clear"] = {name: wz_msg('wzwg.webModule.word.borrDelete02'), icon: "edit"};
	
	if(layout.find('.div_wrap').hasClass('border-radius')) {
		items["modifyLayoutBorder_radius"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyRoundBorr'), icon: function(){return 'context-menu-icon ico-check_b'}};
	}else {
		items["modifyLayoutBorder_radius"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyRoundBorr'), icon: "edit"};
	}
	
	if(layout.find('.div_wrap').hasClass('borderbox')) {
		items["modifyLayoutBorder_box"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyBorr'), icon: function(){return 'context-menu-icon ico-check_b'}};
	}else {
		items["modifyLayoutBorder_box"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyBorr'), icon: "edit"};
	}
	
	if(!layout.find('.div_wrap').hasClass('layout_padding')){
		if(layout.find('.div_wrap').hasClass('borderbox')) {
			items["modifyLayoutBorder_between"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyBorrLine'), icon: function(){return 'context-menu-icon ico-check_b'}};
		}else {
			items["modifyLayoutBorder_between"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyBorrLine'), icon: "edit"};
		}
	}
	
	items.divideClear2 = "--------";
	items["modifyLayoutEffec_clear"] = {name: wz_msg('wzwg.cmm.word.scrin.offLayoutEffect'), icon: "edit"};
	items["modifyLayoutEffec_fade"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyFadeEffect'), icon: "edit"};
	items["modifyLayoutEffec_slide"] = {name: wz_msg('wzwg.cmm.word.scrin.aplySlideEffect'), icon: "edit"};
	items["modifyLayoutEffec_fadeNslide"] = {name: wz_msg('wzwg.cmm.word.scrin.aplyFadeSlideEffect'), icon: "edit"};
	var hintMsg = "<span style='color:#999;'>※<spring:message code='wzwg.cmm.msg.screen.MSG046' /></span>";
	items["hint"] = {html : hintMsg, type : "html"};
	
	
	wzwgCMEndOption(items);
	
	
	if(logMode) console.log(items);
	
	resetMuneCnt();
	return items;
}


function wzwgCMEndOption(items){
	//공통
	//items.divide = "---------",
	items.quit = {name: wz_msg('wzwg.cmm.word.close'), icon: function(){
		return 'context-menu-icon context-menu-icon-close';
	}}
}



/* moo0506 contextMenu callback function */
function wzwgCMFunc(key, opt){
	
	/* 삭제기능 */
	if(key =='delete')
	{
		if(opt.commands[key].target == 'quick'){
			delQuick($(this));
		} else {
			$(this).remove();
		}
	}
	
	/* 객체속성 변경 attr */
	if(key.indexOf('modifyAttr_') == 0 ){
		 
		 bannerMdMode = "attr[" + opt.commands[key].attrId + "]";
		 selectDiv=$(this);	 
		 
		 $("#txtBannerDiv").dialog("open");
		 $("#txtBanner").val(selectDiv.attr(opt.commands[key].attrId));
	}
	
	/* 객체속성 변경 attr */
	if(key.indexOf('modifyData_') == 0 ){
		 
		 bannerMdMode = "data[" + opt.commands[key].dataId + "]";
		 selectDiv=$(this);	 
		 
		 $( "#txtBannerDiv" ).dialog("open");
		 $("#txtBanner").val(selectDiv.html());
	}
	
	/* 한줄 텍스트 변경 */
	if(key.indexOf('modifyText_') == 0 ){
		 
		 bannerMdMode = "custom";
		 var className = opt.commands[key].target;
		 var target = $($(this).find('.' + className)[0]);
		 var no = opt.commands[key].no;
		 
		 if(logMode) console.log(target);
		 if(no >= 0){
			 selectDiv = $($(this).find('.' + className)[no]);
		 }
		 if($(this).hasClass(className)){
			 selectDiv=$(this);
		 	
		 }else if(target.length > 0){
			 selectDiv = target;
			 
		 }else{
			 selectDiv=$(this);	 
		 }
		 
		 $( "#txtBannerDiv" ).dialog("open");
		 $("#txtBanner").val(selectDiv.html());
	}
	
	/* 한줄 텍스트 변경 (모든객체) */
	if(key.indexOf('modifyAllText_') == 0 ){
		 
		 bannerMdMode = "custom";
		 var className = opt.commands[key].target;
		 var target = $(this).find('.' + className);
		 
		 selectDiv = target;
		 
		 $( "#txtBannerDiv" ).dialog("open");
		 $("#txtBanner").val(selectDiv.html());
	}
	
	/* 여러줄 텍스트 변경 */
	if(key.indexOf('modifyMultiText_') == 0 ){
		 
		 bannerMdMode = "custom";
		 var className = opt.commands[key].target;
		 var target = $($(this).find('.' + className)[0]);
		 
		 if($(this).hasClass(className)){
			 selectDiv=$(this);
		 	
		 }else if(target.length > 0){
			 selectDiv = target;
			 
		 }else{
			 selectDiv=$(this);	 
		 }
		 
		 $( "#txtareaContentDiv" ).dialog("open");
		 $("#txtareaContent").val(convertBRtoLINE(selectDiv.html()));
	}
	
	/* 텍스트 색상 변경 */
	if(key.indexOf('modifyTextColor_') == 0 ){
		
		 var className = opt.commands[key].target;
		 var target = $($(this).find('.' + className)[0]);
		 
		 if($(this).hasClass(className)){
			 selectDiv=$(this);
		 	
		 }else if(target.length > 0){
			 selectDiv = target;
			 
		 }else{
			 selectDiv=$(this);	 
		 }
		 
		 var mode = opt.commands[key].mode;
			//console.log(mode);
		 if(mode){
			 txtChangeMode = mode;
		 }
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	/* 텍스트 색상 변경 (모든객체) */
	if(key.indexOf('modifyAllTextColor_') == 0 ){
		
		var className = opt.commands[key].target;
		var target = $(this).find('.' + className);
		 
		selectDiv = target;
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	/* 베이직 에디터 */
	if(key.indexOf('basicEditor_') == 0){
		var className = opt.commands[key].target;
		var multiLine = opt.commands[key].multiLine;
		var target = $(this).find('.' + className);
		
		//console.log(target);
		//console.log(opt.commands[key].name);
		
		selectDiv = target;
		
		if(multiLine == "false"){
			$("#basicTextValue").attr("data-multiLine", multiLine);
			$('#basicEditorLineHint').show();
		}else{
			$("#basicTextValue").attr("data-multiLine", "true");
			$('#basicEditorLineHint').hide();
		}
		
		
		var findMainVisual = selectDiv.parents().filter('.mainVisual, #templateFix');
		var dialogWidth = 300;
		//메인비주얼에서 호출할 경우 폰트변경 기능 활성화
		if(findMainVisual.length == 1){
			//console.log(findMainVisual);
			$("#basicTextEditor").find('.btn_tit_wrap').addClass('addFont');
			$("#basicTextEditor").find('.fontFamily').show();
			dialogWidth = 400;
		}else{
			$("#basicTextEditor").find('.btn_tit_wrap').removeClass('addFont');
			$("#basicTextEditor").find('.fontFamily').hide();
		}
		
		
		// 타이틀 변경
		$("#basicTextEditor").dialog("open");
		$("#basicTextEditor").dialog({title: opt.commands[key].name, width : dialogWidth});
		//basicEditorBtnAction();
		$("#basicTextValue").html(selectDiv.html());
		
		
		
		
		
	/* 	if(multiLine == "false"){
			$("#basicTextValue").keydown(function( event ) {
			 	if (event.keyCode == '13') { return false; }
			});
		} */
	}
	
	/* 배경색 변경 */
	if(key.indexOf('modifyBgColor_') == 0 ){
		if($(this).hasClass('layout_wrap') || $(this).hasClass('empty')){
			selectDiv=$(this);	 
		}else{
			 var className = opt.commands[key].target;
			 var target = $($(this).find('.' + className)[0]);
			 var changeBg = $(this).find('.changeBg');
			 if($(this).hasClass(className)){
				 selectDiv=$(this);
			 	
			 }else if(target.length > 0){
				 selectDiv = target;
				 
			 }else if(changeBg.length > 0){
				 selectDiv = changeBg;
			 }else{
				 selectDiv=$(this);	 
			 }
			
		}
		
		 bgChangeMode = 'background';

		 var mode = opt.commands[key].mode;
		 //console.log(mode);
		 if(mode){
			 bgChangeMode = mode;
		 }
		 
		 $( "#pickerBgDiv" ).dialog("open");
		 $( "#pickerBgDiv" ).dialog({title: opt.commands[key].name, width : 300});
	}
	
	/* 배경색 변경 */
	if(key.indexOf('modifyBorderColor_') == 0 ){
		 
		 var className = opt.commands[key].target;
		 var target = $(this).find('.' + className);
		 
		 if($(this).hasClass(className)){
			 selectDiv=$(this);
		 	
		 }else if(target.length > 0){
			 selectDiv = target;
			 
		 }else{
			 selectDiv=$(this);	 
		 }
		
		 bgChangeMode = 'border';
		 
		 var mode = opt.commands[key].mode;
		 if(mode){
			 bgChangeMode = mode;
		 }
		 
		 $( "#pickerBgDiv" ).dialog("open");
		 $( "#pickerBgDiv" ).dialog({title: opt.commands[key].name, width : 300});
	}
	
	/* 배경색 변경 (모든객체) */
	if(key.indexOf('modifyAllBgColor_') == 0 ){
		 
		var className = opt.commands[key].target;
		var target = $(this).find('.' + className);
		 
		selectDiv = target;
		
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
	}
	
	/* 폰트 변경 */
	if(key.indexOf('modifyFont_') == 0 ){
		console.log(opt.commands[key].mode);
		
		
		
		var mode = opt.commands[key].mode;
		if(mode){
			bgChangeMode = mode;
		}
		
		if(mode == 'headMenuFont'){
			$( "#menuFontModifyDiv" ).find('.subMenuInfo').show();
		}else{
			$( "#menuFontModifyDiv" ).find('.subMenuInfo').hide();
		}
		 
		$( "#menuFontModifyDiv" ).dialog("open");
	}
	
	/* 링크변경 */
	if(key.indexOf('modifyLink') == 0 ){
		var no = opt.commands[key].no;
		if(logMode)console.log(no);
		
		if(no > -1){
			//if(logMode) console.log('asdfasdf');
		 	selectDiv=$($(this).find('a')[no]); 
		}else{
			//if(logMode) console.log('bbbbbbb');
			selectDiv=$(this).find('a');
		}
		
		var linkValue = selectDiv.attr('href');
		if(linkValue == 'javascript:void(0);' || linkValue == '#'){
			linkValue = '';
		}
		
		var linkTitle = selectDiv.attr('title');
				
		var optValue = selectDiv.attr('target');
		$('#bannerLinkTarget').val(optValue);
		
		$( "#bannerLinkUrlDiv" ).dialog("open");
		$('#bannerLinkUrl').val(linkValue);
		$('#bannerLinkTitle').val(linkTitle);
		
		 
		if(logMode)console.log(selectDiv);
	}
	
	/* 파일스토어 연결 */
	if(key.indexOf('addFilestore') == 0 ){
		var no = opt.commands[key].no;
		if(logMode)console.log(no);
		
		if(no > -1){
			//if(logMode) console.log('asdfasdf');
		 	selectDiv=$($(this).find('a')[no]); 
		}else{
			//if(logMode) console.log('bbbbbbb');
			selectDiv=$(this).find('a');
		}
		
		fnFileStorePop();
	}
	
	
	if(key =='uploadImg'){
		//addImg();
		selectDiv=$(this);  
		uploadImg(6);
	}
	
	if(key.indexOf('changeImg_') == 0 ){
		var no = opt.commands[key].no;
		var className = opt.commands[key].target;
		var target = $($(this).find('.' + className));
		if(logMode) console.log(no);
		if(logMode) console.log(target);
		
		if(no >= 0){
		 	selectDiv=$($(this).find('img')[no]);
		}else if(target.length == 1){
			selectDiv = target;
		}else{
			selectDiv=$(this).find('img');
		}
		
		if(logMode) console.log(selectDiv);
		
		uploadImg(990);
	}
	
	/* 단순 컨텐츠 위치 변경 */
	if(key.indexOf('modifyContentAlign_') == 0 ){
		var className = opt.commands[key].target;
		var t = $(this).filter('.' + className);
		if(t.length == 0){
			selectDiv = $(this).find('.' + className);
		}else{
			selectDiv = $(this).filter('.' + className);
		}
		
		if($(this).hasClass("wzwgFooterContextMenu") || $(this).hasClass("wzwgHeadContextMenu")){
			var mode = opt.commands[key].mode;
			 if(mode){
				 txtChangeMode = mode;
			 }			
		}else {
			txtChangeMode = '';
		}
		$( "#contentsAlignDiv" ).dialog("open");
	}
	
	if(key.indexOf('changeImgPath_') == 0 ){
		var no = opt.commands[key].no;
		var className = opt.commands[key].target;
		var target = $($(this).find('.' + className));
		if(logMode) console.log(no);
		
		if(no >= 0){
		 	selectDiv=$($(this).find('img')[no]);
		}else if(target.length == 1){
			selectDiv = target;
		}else{
			selectDiv=$(this).find('img');
		}
		
		if(logMode) console.log(selectDiv);
		
		 $( "#dialog_changeImgPath" ).dialog("open");
		 $("#inp_changeImgPath").val(selectDiv.attr('src'));
	}
	
	if(key == 'changeSlideImgPath'){
		$( "#dialog_changeImgPath" ).dialog("open");
		var activeIndex = $(this)[0].swiper.activeIndex;
		selectDiv=$($(this)[0].swiper.slides[activeIndex]).find('img'); 
		$("#inp_changeImgPath").val(selectDiv.attr('src'));
	}
	
	if(key == 'modifyTxtPosition'){
		 $( "#slideTxtPositionDiv" ).dialog("open");
		 selectDiv=$(this);  
		 
	}
	
	if(key == 'modifyTxtPositionTop'){
		 $( "#slideTxtPositionTopDiv" ).dialog("open");
		 selectDiv=$(this);  
		 
	}
	
	
	if(key =='headMenuLgnAtN')
	{
		topHdMenuParsing("N");
	}	
	if(key =='headMenuLgnAtY')
	{
		topHdMenuParsing("Y");
	}	 
	
	if(key =='footerMenuLgnAtN')
	{
		footerFtrMenuParsing("N");
	}	
	if(key =='footerMenuLgnAtY')
	{
		footerFtrMenuParsing("Y");
	}	 
	
	if(key == 'allMenuDel'){
		var mode = opt.commands[key].mode;
		if(mode){
			 allMenuDelAt = mode;
		 }
		changeMenuCss(allMenuDelAt);
	}
	
	
	if(key.indexOf('modifyIcon') == 0){
		//addImg();
		var no = opt.commands[key].no;
		var className = opt.commands[key].target;
		var target = $($(this).find('.' + className)[0]);
		
		if(logMode) console.log(no);
		if(logMode) console.log(className);
		if(logMode) console.log(target);
		
		if(no >= 0){
			selectDiv=$(this).find('.bIcon')[no];  
		}else if(target){
			selectDiv = target;
		}
		uploadImg(990);
	}
	
	/* if(key == 'modifyLinkTitle'){
		$( "#txtBannerDiv" ).dialog("open");
		bannerMdMode = "custom";
		selectDiv=$(this).find('.bLinkTitle');
		$("#txtBanner").val(selectDiv.html());
	} */
	
	/* if(key == 'modifyLinkTitleColor'){
		$( "#pickerBorderDiv" ).dialog("open");
		selectDiv=$(this).find('.bLinkTitle'); 
	} */
	
	
	
	//퀵배너용
	if(key =='addQuickBanner'){
		
		bannerMdMode = "title";
		selectDiv=$(this);
		addQuickBanner($(this));
		//	addSilder($(this))
	}	 
	
	
	
	/* 이미지 대체 텍스트 입력 */
	if(key.indexOf('imgCaption_') == 0 ){
		 selectDiv=$(this).find('img')[0] ;	 
		 var caption = $(selectDiv).attr('alt');
		 $( "#imgCaptionDiv" ).dialog("open");
		 $("#imgCaption").attr('placeholder', wz_msg('wzwg.cmm.msg.screen.MSG039'));
		 $("#imgCaption").val(caption);
	}
	
	/* 이미지 대체 텍스트 입력 */
	if(key.indexOf('imgClassCaption_') == 0 ){
		var className = opt.commands[key].target;
		var target = $($(this).find('.' + className)[0]);
		
		selectDiv = target;
		//selectDiv=$(this).find('img')[0] ;
		
		var caption = $(selectDiv).attr('alt');
		$( "#imgCaptionDiv" ).dialog("open");
		$("#imgCaption").attr('placeholder', wz_msg('wzwg.cmm.msg.screen.MSG039'));
		$("#imgCaption").val(caption);
	}
	
	
	
	
	
	
	
	
	// 게시판용
	if(key =='modifyBoardTitleColor'){
		if($(this).hasClass('menuNm')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.menuNm');
		}
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardSubTitleColor'){
		if($(this).hasClass('subMenuNm')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.subMenuNm');
		}
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardColor'){
		if($(this).hasClass('boardBg')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.boardBg'); 
		}
		
		//$( "#pickerBorderDiv" ).dialog("open");
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardBrdrColor'){
		if($(this).hasClass('boardBrdrBg')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.boardBrdrBg'); 
		}
		bgChangeMode = 'border';
		$( "#pickerBgDiv" ).dialog("open");
	}
	
	if(key =='modifybtargetBrColor'){
		if($(this).hasClass('btargetBrCol')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.btargetBrCol'); 
		}
		bgChangeMode = 'border';
		$( "#pickerBgDiv" ).dialog("open");
	}
	
	if(key =='modifyBoardTabBg'){
		if($(this).hasClass('boardTabBg')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.boardTabBg'); 
		}
		
		//$( "#pickerBorderDiv" ).dialog("open");
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardBgColor'){
		if($(this).hasClass('menuNmBg')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.menuNmBg'); 
		}
		
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
	}
	
	if(key =='modifySubBoardBgColor'){
		if($(this).hasClass('subMenuNmBg')){
			selectDiv = $(this);
		}else{
			selectDiv=$(this).find('.subMenuNmBg'); 
		}
		
		//$( "#pickerBorderDiv" ).dialog("open");
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardCnTitleColor'){
		selectDiv=$(this).find('[data-attr="nttSj"]'); 
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardCnColor'){
		selectDiv=$(this).find('[data-attr="nttCnChrctr"]'); 
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	if(key =='modifyBoardDateColor'){
		selectDiv=$(this).find('[data-attr="frstRegistPnttm"]'); 
		
		$( "#pickerBorderDiv" ).dialog("open");
		//selectDiv=$(this).find('.bTitle'); 
	}
	
	/* if(key.indexOf('changeBoard_') == 0){
		var boardSeq = opt.commands[key].boardSeq;
		
		if(logMode) console.log(boardSeq);
		
		$(this).data("cntseq",boardSeq);
		$(this).attr("data-cntseq",boardSeq); 
		sThis = $(this);
		if($(this).parent().data("tab") =='Y'){
			 $(this).parent().children("ul:first").children("li").each(function(){
				if($(this).children("a").attr("href")=="#"+sThis.attr("id")){
					$(this).children("a").html("<h3>"+opt.items.dataReplace.items[key].name+"</h3>");
				} 
			 }); 
		}  
		fnDivJsonDataRead();
	} */
	
	if(key.indexOf('dataReplace') == 0 ){
		var moduleTy = opt.commands[key].target;
		var mdSeq;
		
		mdSeq = moduleTy.replace('module', '');
		
		fnModuleMenuList(mdSeq , $(this));
	}
	
	if(key == 'bbsAddTab'){
		//탭 게시판에 탭 추가
		var tabBoard = $(this).parents().filter('.wzwg-tab-board');
		
		fnBbsAddTab(tabBoard);
	}
	
	if(key == 'bbsDelTab'){
		//탭 게시판에 현재 탭 삭제
		var tabBoard = $(this).parents().filter('.wzwg-tab-board');
		
		fnBbsDelTab(tabBoard);
	}
	
	
	
	/* 슬라이드 관련 */
	if(key =='addSliderContents'){
		 addSliderContents($(this));
	}
	
	if(key =='delSlider'){
		delSlider($(this));
	}	
	 if(key =='uploadImgSlide'){
			//addImg();
			selectDiv=$(this);  
			uploadImg(5);
	}
	
	 if(key == 'effecSlide'){
		 //console.log('effecSlide');
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info');
		 }
		 $(_slide).attr('data-effect', 'slide');
		 swiperPlay($(this));
	 }
	 
	 if(key == 'effecFade'){
		 //console.log($(this));
		 //console.log('effecFade');
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info');
		 }
		 $(_slide).attr('data-effect', 'fade');
		 swiperPlay($(this));
	 }
	
	 if(key == 'slideAuto'){
		 //console.log('effecFade');
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info, .wzwg-banner-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info, .wzwg-banner-slide-info');
		 }
		 $(_slide).attr('data-autoplay', 'auto');
		 console.log(_slide);
		 swiperPlay($(this));
	 }

	 if(key == 'slideStop'){
		 //console.log('effecFade');
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info, .wzwg-banner-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info, .wzwg-banner-slide-info');
		 }
		 $(_slide).attr('data-autoplay', 'none');
		 swiperPlay($(this));
	 }
	 
	 if(key == 'moveForward') {
		
		 var _this = $(this);

		 moveForward(_this);
		 
	 }
	 
	 if(key == 'moveBackward') {
			
		 var _this = $(this);	

		 moveBackward(_this);
		 
	 }
	 
	 
	 if(key.indexOf('speed') >= 0){
		 //console.log('effecFade');
		 var speed = key.split('_')[1];
		 //console.log(speed);
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info');
		 }
		 $(_slide).attr('data-speed', speed);
		 swiperPlay($(this));
	 }
	
	 if(key.indexOf('slideRoop') >= 0){
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info');
		 }
		 $(_slide).attr('data-loop', 'true');
		 swiperPlay($(this));
	 }
	 
	 if(key.indexOf('slideRoopNone') >= 0){
		 var _slide = $(this).filter('.wzwg-swiper, .wzwg-slide-info');
		 if(_slide.length == 0){
			 _slide = $(this).find('.wzwg-swiper, .wzwg-slide-info');
		 }
		 $(_slide).attr('data-loop', 'false');
		 swiperPlay($(this));
	 }
	 
	 
	 if(key.indexOf('addBoardSlide') >= 0){
		 selectDiv = $(this);
		 fnModuleSlickAdd(selectDiv, 1);
	 }
	 
	 if(key.indexOf('delBoardSlide') >= 0){
		 selectDiv = $(this);
		 fnModuleSlickAdd(selectDiv, -1);
	 }
	
	 if(key.indexOf('addNtt') >= 0){
		 selectDiv = $(this);
		 fnModuleNttAdd(selectDiv, 1);
	 }
	 
	 if(key.indexOf('delNtt') >= 0){
		 selectDiv = $(this);
		 fnModuleNttAdd(selectDiv, -1);
	 }
	 
	 if(key.indexOf('changeArrowBg') >= 0){
		 selectDiv = $(this);
		 bgChangeMode = 'slideArrowBg'; //슬라이드 버튼색
		 $( "#pickerBgDiv" ).dialog("open");
	 }
	 
	 if(key.indexOf('changeArrowBd') >= 0){
		 selectDiv = $(this);
		 bgChangeMode = 'slideArrowBd'; //슬라이드 버튼 테두리색
		 $( "#pickerBgDiv" ).dialog("open");
	 }
	
	 if(key.indexOf('changeBnrArrowBg') >= 0){
		 selectDiv = $(this);
		 bgChangeMode = 'bnrSlideArrowBg'; //배너슬라이드 버튼색
		 $( "#pickerBgDiv" ).dialog("open");
	 }
	 
	 if(key.indexOf('changeBnrArrowBd') >= 0){
		 selectDiv = $(this);
		 bgChangeMode = 'bnrSlideArrowBd'; ////슬라이드 버튼 테두리색
		 $( "#pickerBgDiv" ).dialog("open");
	 }
	 
	 if(key =='changeBnrBdColor'){
			if($(this).hasClass('brnBd')){
				selectDiv = $(this);
			}else{
				selectDiv=$(this).find('.brnBd'); 
			}
			bgChangeMode = 'border';
			$( "#pickerBgDiv" ).dialog("open");
		}

	 if(key =='changeBnrBgColor'){
			if($(this).hasClass('brnBg')){
				selectDiv = $(this);
			}else{
				selectDiv=$(this).find('.brnBg'); 
			}
			bgChangeMode = 'background';
			$( "#pickerBgDiv" ).dialog("open");
		}

	 
	 /* 일정 게시판용 */
	 
	 /* 
	 if(key.indexOf('changeSchedule_') == 0){
			var menuSeq = opt.commands[key].menuSeq;
			var name = opt.commands[key].name;
			
			if(logMode) console.log(menuSeq);
			
			//$(this).data("cntseq",boardSeq);
			$(this).attr("data-cntseq",menuSeq); 
			//if(logMode) console.log(this);
			getCalendar(this, menuSeq);
		}
	 */
 	
	if(key =='modifyBtnColor'){
	 	selectDiv = $(this).find('.' + opt.commands[key].target);
		
		$( "#pickerBorderDiv" ).dialog("open");
	}
	 
 	if(key.indexOf('modifyTHColor_') == 0){
 		selectDiv = $(this).find('.' + opt.commands[key].target).find('th');

		$( "#pickerBorderDiv" ).dialog("open");
 	}
 	
 	if(key.indexOf('modifyTHBg_') == 0){
		selectDiv = $(this).find('.' + opt.commands[key].target).find('th');
		
		//$( "#pickerBorderDiv" ).dialog("open");
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
 	}
 	
 	if(key.indexOf('modifyTDColor_') == 0){
 		selectDiv = $(this).find('table.tdCol').find('td');

		$( "#pickerBorderDiv" ).dialog("open");
 	}
 	
 	if(key.indexOf('modifyTDBg_') == 0){
 		selectDiv = $(this).find('table.tdCol').find('td');
		
		//$( "#pickerBorderDiv" ).dialog("open");
		bgChangeMode = 'background';
		$( "#pickerBgDiv" ).dialog("open");
 	}
	
 	if(key =='modifyBtnBrColor'){
	 	selectDiv = $(this).find('.' + opt.commands[key].target);
		
	 	bgChangeMode = 'border';
		$( "#pickerBgDiv" ).dialog("open");
	}
 	
 	if(key == 'modifyWeekText_ko'){
 		$(this).find('.' + opt.commands[key].target).find('th').each(function(idx){
 			if(idx == 0) $(this).html('일');
 			if(idx == 1) $(this).html('월');
 			if(idx == 2) $(this).html('화');
 			if(idx == 3) $(this).html('수');
 			if(idx == 4) $(this).html('목');
 			if(idx == 5) $(this).html('금');
 			if(idx == 6) $(this).html('토');
 		});
 	}
 	
 	if(key == 'modifyWeekText_eng'){
 		$(this).find('.' + opt.commands[key].target).find('th').each(function(idx){
 			if(idx == 0) $(this).html('Sun');
 			if(idx == 1) $(this).html('Mon');
 			if(idx == 2) $(this).html('Tue');
 			if(idx == 3) $(this).html('Wed');
 			if(idx == 4) $(this).html('Thu');
 			if(idx == 5) $(this).html('Fri');
 			if(idx == 6) $(this).html('Sat');
 		});
 	}
 	
 	
 	
 	
 	
 	/* 지도 모듈 용 */
 	/* if(key.indexOf('changeMap_') == 0){
		var menuSeq = opt.commands[key].menuSeq;
		var name = opt.commands[key].name;
		
		if(logMode) console.log(menuSeq);
		
		//$(this).data("cntseq",boardSeq);
		$(this).attr("data-cntseq",menuSeq); 
		//if(logMode) console.log(this);
		//getCalendar(this, menuSeq);
		getMapData(this);
	} */
	 
 	
 	 /* 메인슬라이드 메인 효과 변경 */
	 if(key.indexOf('txtEF') >= 0){
		 //console.log('effecFade');
		 var effect = opt.commands[key].effect;
		 var efs = ['totop','scalefx','toright','toleft'];
		 
		 for(var i = 0 ; i < efs.length ; i++){
			 $(this).removeClass(efs[i]);
		 }
		 
		 if(effect != 'delete'){
			 $(this).addClass(effect);
		 }
	 }
 	 
	/* console.log(key);
	 console.log(opt);
	 console.log(opt.commands[key].target);*/
	 
	 /* 헤더메뉴 스타일 관련 기능 */
	 if(key.indexOf('menustyleAllClear') >= 0){
		 //console.log('effecFade');
		 clearMenuCss('all');
	 }
	 
	 if(key.indexOf('menustyleTopClear') >= 0){
		 //console.log('effecFade');
		 clearMenuCss('top');
	 }
	 
	 if(key.indexOf('menustyleHeadClear') >= 0){
		 //console.log('effecFade');
		 clearMenuCss('head');
	 }
	 
	 /* 푸터메뉴 스타일 관련 기능 */
	 if(key.indexOf('footerStyleAllClear') >= 0){
		 clearMenuCss('footAll');
	 }
	 
	 if(key.indexOf('menustyleBottomClear') >= 0){
		 clearMenuCss('bottom');
	 }
	 
	 if(key.indexOf('stylefootinfoClear') >= 0){
		 clearMenuCss('footinfo');
	 }
	 
	 
	 
	 /* 로그인 위젯용 */
	 
	 if(key == 'loginWidgetLgnAtN'){
		 $(this).find('.loginAtN').show();
		 $(this).find('.loginAtY').hide();
	 }
	 
	 if(key == 'loginWidgetLgnAtY'){
		 $(this).find('.loginAtY').show();
		 $(this).find('.loginAtN').hide();
	 }
	 
	 
	 
	 /* 서브 컨텐츠용 스크립트 */
	if(subPageMode){
		if(key.indexOf('addTabMenu_') >= 0){
			addTabMenu($(this));
		}
		
		if(key.indexOf('deleteTabMenu_') >= 0){
			deleteTabMenu($(this));
		}
		
		if(key.indexOf('tabstyle_') >= 0 ){
			var selectType = opt.commands[key].tabtype;
			
			$(this).removeClass('ts-basic');
			$(this).removeClass('ts-basic-wide');
			$(this).removeClass('ts-button');
			$(this).removeClass('ts-button-wide');
			
			$(this).addClass('ts-' + selectType);
		}
		
		
		if(key.indexOf('tabcolor_') >= 0){
			var selectColor = opt.commands[key].tabcolor;
			
			$(this).removeClass('tc-red');
			$(this).removeClass('tc-pink');
			$(this).removeClass('tc-orange');
			$(this).removeClass('tc-yellow');
			$(this).removeClass('tc-green');
			$(this).removeClass('tc-blue');
			$(this).removeClass('tc-brown');
			$(this).removeClass('tc-violet');
			$(this).removeClass('tc-purple');
			$(this).removeClass('tc-white');
			$(this).removeClass('tc-grey');
			$(this).removeClass('tc-black');
			
			$(this).addClass('tc-' + selectColor);
		}
	}
	 
	 
	 
	 
	 /* 과기대 전용 스크립트 */
 	if(key.indexOf('timetable_') >= 0){
		var menuSeq = opt.commands[key].menuSeq;
		var name = opt.commands[key].name;
		
		if(logMode) console.log(menuSeq);
		
		//$(this).data("cntseq",boardSeq);
		$(this).attr("data-cntseq",menuSeq); 
		//if(logMode) console.log(this);
		getTimeTable($(this));
	}
	
	 
	 /* banner126 전용 */
	 if(key == "changeViewBanner126" ){
		 var obj = $(this).find('.bnr_wrap');
		 
		 if(obj.hasClass("ver_right")){
			obj.removeClass("ver_right");
		 }else{
		 	obj.addClass("ver_right");
		 }
	 }
	 
	 
	 /* 이하 표관련 기능 */
	 if(key == 'modifyTable'){
		 //var tableZone = $(this).find('.tableZone');
		 selectDiv = $(this).find('.tableZone');
		 tableEditPopup(selectDiv);
	 }
	 
	 if(key == 'modifyTableSkin'){
		 selectDiv = $(this).find('.tableZone');
		 $.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" />/module/cntnts/screen/selectTableSkinAjax.do'
				, dataType : 'html'
				, success : function (data) {
					//$("#imgDiv").html(data);
					//$("#imgDiv").show();
					wzAjaxModal('popup_l', wz_msg('wzwg.cmm.word.skin') + " " + wz_msg('wzwg.cmm.word.change'), data);
				}
				, error : function (request, status, error) {
					alert('error');
				}
			}); 
	 }
	 
	 
	 
	 /* 이하 레이아웃 설정 관련 */
	 if(key == 'anchorHandler'){
		 selectDiv = $(this).parent();
		 $( "#anchorMenuLinkDiv" ).dialog("open");
	 }
	 if(key == 'anchorHandler_clear'){
		 selectDiv = $(this).parent();
		 var ancId = selectDiv.attr('data-anchor');
		 removeAnchor(ancId);
	 }
	 
	 if(key == 'modifyLayoutEffec_clear'){
		 selectDiv = $(this).parent();
		 layoutEffecClear();
	 }
	 if(key == 'modifyLayoutEffec_fade'){
		 selectDiv = $(this).parent();
		 layoutEffecClear();
		 addLayoutEffect('FXarea_Fade');
	 }
	 if(key == 'modifyLayoutEffec_slide'){
		 selectDiv = $(this).parent();
		 layoutEffecClear();
		 addLayoutEffect('FXarea_slideUp');
	 }
	 if(key == 'modifyLayoutEffec_fadeNslide'){
		 selectDiv = $(this).parent();
		 layoutEffecClear();
		 addLayoutEffect('FXarea_slideNfade');
	 }
	 
	
	 if(key == 'modifyLayoutBorder_clear'){
		 selectDiv = $(this).parent().find('.div_wrap');
		 layoutBorderClear();
	 }
	 if(key == 'modifyLayoutBorder_radius'){
		 selectDiv = $(this).parent().find('.div_wrap');
		 if(selectDiv.hasClass('border-radius')) {
			 selectDiv.removeClass('border-radius');
		 }else {
		 	addLayoutBorder('border-radius');
		 }
	 }
	 if(key == 'modifyLayoutBorder_box'){
		 selectDiv = $(this).parent().find('.div_wrap');
		 if(selectDiv.hasClass('borderbox')) {
			 selectDiv.removeClass('borderbox');
		 }else {
		 	addLayoutBorder('borderbox');
		 }
	 }
	 if(key == 'modifyLayoutBorder_between'){
		 selectDiv = $(this).parent().find('.div_wrap');
		 if(selectDiv.hasClass('between_border')) {
			 selectDiv.removeClass('between_border');
		 }else {
		 	addLayoutBorder('between_border');
		 }
	 }

	 
}


function setImageSizeItems(img, items, isIcon){
	var imgsize = getImageRealSize(img);
	if(isIcon){
		items["imghint_" + getMenuCnt()] = {html : "<span style='color:#0000ff;'><spring:message code='wzwg.webModule.word.iconMg02' />  (" + imgsize.w + " x " + imgsize.h + ")</span>", type : "html"};
	}else{
		items["imghint_" + getMenuCnt()] = {html : "<span style='color:#0000ff;'><spring:message code='wzwg.webModule.word.iconMg02' /> (" + imgsize.w + " x " + imgsize.h + ")</span>", type : "html"};
	}
}


function getImageHintTitle(prefix, img){
	var imgsize = getImageRealSize(img);
	var hintPop = '<div class=\"hint_pop\"><img src=\"/images/wzwg/site/mngr/ico_help_mngr.png\" alt=\"<spring:message code="wzwg.webModule.word.menuHelp" />\"><spring:message code="wzwg.cmm.msg.screen.MSG042" /><br><spring:message code="wzwg.cmm.msg.screen.MSG047" /></div>';
	var result = prefix + "<span class='menuImgHint'>(W:" + imgsize.w + " H:" + imgsize.h + ")" + hintPop + "</span>";
	
	return result;
	//items.uploadImg = {name: "이미지변경 <span class='menuImgHint'>(W:" + imgsize.w + "/H:" + imgsize.h + ")</span>", icon: "edit", isHtmlName: true};
}

function getImageRealSize(img){
	var width = $(img)[0].width;
	var height = $(img)[0].height;
	
	var result = {h:0,w:0};
	result.h = height;
	result.w = width;
	
	return result;
}


 
function backSpaceKey() {  
     if(event.keyCode==46){
		if(par.attr("contenteditable") !="true"){
			if(deleteYn =='Y'){
		 		par.remove();
			}
		 }
       }  
     if(event.keyCode==37){ 
    	// par.css("left",Number(par.css("left").replace("px",""))-1+"px");
     }
     if(event.keyCode==38){
    //	 par.css("top",Number(par.css("top").replace("px",""))-1+"px");
     }
     if(event.keyCode==39){
    	// par.css("left",Number(par.css("left").replace("px",""))+1+"px");
     }
     if(event.keyCode==40){
    //	 par.css("top",Number(par.css("top").replace("px",""))+1+"px");
     }
      if(event.keyCode == 8){
           return event.keyCode = 17;
      }
 }  
 
 
function editInit(){  
	 if(subPageMode){
		 subEditInit();
	 }
	 
	 contentsSortable();
	 try{writeContentTxt();}catch(e){console.log(e.message);}
	 contentsHandler();
	 
	 $('.contents a').off();
	 $('.contents a').click(function(e){
	   e.preventDefault(); 
	   var href = $(this).attr('href');
	   if(href){
		   if(href.indexOf('javascript') > -1 || href == '' || href == '#' ){
			   href = wz_msg('wzwg.cmm.msg.screen.MSG043');
		   }
		   var alertMsg = wz_msg('wzwg.cmm.msg.screen.MSG044') + ' : ' + href;
		   var title = $(this).attr('title');
		   if(title && title.length > 0){
			   alertMsg += '\r\n' + wz_msg('wzwg.cmm.word.menu') + " " + wz_msg('wzwg.cmm.word.nm02') + ' : ' + title;
		   }
		   alert(alertMsg);
		   
	   }
	 });
	 //console.log("$('#template00').children().length : " + $('#template00').children().length);
	 if($('#template00').children().length == 0){
		 //console.log('아무것도 없죠?');
		 var addLayoutBtn = '';
		 	 addLayoutBtn +='	<div class="addLayout" id="btn-newLayout">                                 ';
             addLayoutBtn +=	'	<button type="button"  onclick="addLayout()">                              ';
             addLayoutBtn +='           <img src="/images/wzwg/site/mngr/btn_addLayout.png" alt="">        ';
             addLayoutBtn +='                                                                              ';
             addLayoutBtn +='           <span>                                                             ';
             addLayoutBtn +='           	<spring:message code="wzwg.webModule.word.layoutAdd" /> ';
             addLayoutBtn +='           </span>                                                            ';
             addLayoutBtn +='       </button>                                                              ';
             addLayoutBtn +='                                                                              ';
             addLayoutBtn +='       <p>                                                                    ';
             addLayoutBtn +='           <em class="circle_no bg-blue-strong2">!</em>                       ';
             addLayoutBtn +='           <strong class="fs12">                                              ';
             addLayoutBtn +='               <spring:message code="wzwg.cmm.msg.screen.MSG045" />           ';
             addLayoutBtn +='           </strong>                                                          ';
             addLayoutBtn +='       </p>                                                                   ';
             addLayoutBtn +='   </div>                                                                     ';
		 $('#template00').append(addLayoutBtn);
	 }else{
		 $('#btn-newLayout').remove();
	 }
	 
	 
}


function fnFileStorePop(idx){
	
	if(idx){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectFileEditorListAjax.do?id=<c:out value="${param.id}" />'
			, dataType : 'html'
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				$('.pop-container').html(data);
			}
			, error : function (request, status, error) {
				alert('error');
			}
		}); 
	}else {
		$.ajax({
		    type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectFileEditorListAjax.do?id=fileLink'
			, data : {pageIndex: idx}
			, dataType : 'html'
			, success : function (data) {
				//$("#imgDiv").html(data);
				//$("#imgDiv").show();
				wzAjaxModal('popup_s wd50', '<spring:message code="wzwg.cmm.cntnts.filestore" />', data);
			}
			, error : function (request, status, error) {
				alert('error');
			}
		});
	}
	
}
</script>



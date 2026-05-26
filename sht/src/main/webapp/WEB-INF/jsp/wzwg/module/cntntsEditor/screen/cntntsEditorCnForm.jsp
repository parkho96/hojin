<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%-- <jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include> --%>

<!-- <script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script> -->
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
<script src="/js/wzwg/cmm/jquery-ui.js"></script>

<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>

<link rel="stylesheet" href="/design/module/sample/css/swiper.min.css" type="text/css">
<script src="/design/module/sample/js/swiper.jquery.min.js"></script>
<!-- <script src="/js/wzwg/cmm/swiper.jquery.min.js"></script> -->

<!-- 테이블편집 a-table 라이브러리 -->
<script src="/js/wzwg/cmm/atable/a-table.min.js"></script>
<link rel="stylesheet" type="text/css" href="/js/wzwg/cmm/atable/a-table.css">
<link rel="stylesheet" type="text/css" href="/js/wzwg/cmm/atable/a-table-icon.css">


<script src="/js/wzwg/cmm/tendina.min.js"></script>


<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>

<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">

<c:import url="/WEB-INF/jsp/wzwg/webModule/wzwgContextMenu.jsp"></c:import>

<%-- 코드에디터 (codemirror) 로드 --%>
<c:import url="/WEB-INF/jsp/wzwg/webModule/codemirrorInc.jsp"></c:import>
 
<script type="text/javascript">
	/* 컨텐츠 내용 등록 */
	function fnCntntsCnRegist(){
	    
	    //oEditors.getById["cntntsCn"].exec("UPDATE_CONTENTS_FIELD", []);

	    /* if(!Validator.validate(document.cntntsCnListFrm)){
			return;
		} */
		
		//console.log($('#cntntsEdit').html());
	    saveDataReady();
		//console.log($('#cntntsEdit').html());
//	    $('#cntntsCn').val($('#cntntsEdit').html().replace(/\/con tents/g, '/contents'));
	    $('#cntntsCn').val($('#cntntsEdit').html());
		 
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/registModuleCntntsCnAjax.do'
			, data : $("#cntntsCnListFrm").serialize()
			, success : function (result) {
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						fn_init();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});

	}
	
	function saveDataReady(){
		console.log("saveDataReady");
		
		contentsSortableDestroy();

		$('.swiper-slide').css('width', 'auto');
	    $('.swiper-wrapper').removeAttr('style');
	    
	    
		$('.add_div').remove();  /* moo0506 레이아웃 영역 [클릭하세요...] 내용 삭제*/
		$(".axebox").remove();  /* moo0506 삭제버튼은 editFunc.js 파일의 contentsSortable() 에서 추가되기 때문에 삭제*/
		$(".axeboxboot").html("");
		$(".sortWrapAll").children().unwrap();

		$('.addContainer').remove(); // 레이아웃 추가 버튼 모두 삭제

		//$("#content").wrap("<div id='contentsWrap'>");
		//$("#contents").val($("#contentsWrap").html());
		$('#template00').find('.wzEditZone').removeAttr('contenteditable');
		$('.tableEditZone').removeAttr('contenteditable');
		$('.wzEditTarget').removeClass('wzEditTarget');
		$('.wzEditBtnTarget').removeClass('wzEditBtnTarget');
		$('.wzEditBoxTarget').removeClass('wzEditBoxTarget');
		
		$(".ui-dialog-content").dialog("close"); // 모든 모달창 닫기
	}
	
	/** 템플릿 리스트 조회 */
	function fn_tmplatSearch(){
    	$.ajax({
    		   type:'POST'
    		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/selectCntntsTmplatListSearchAjax.do'
    		 , data : $("#cntntsCnListFrm").serialize()
    		 , success:function (data) {
    			 	//$("#divLayerPopup").html(data);
    	    	  	//$("#divLayerPopup").show();
    	    	  	var title = '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.estbs" />';
    			 wzAjaxModal('popup_l', title, data);
    			}
    		 , dataType: 'html'
    	});
	}
	
	/* 레이아웃 추가 */
	 function addLayout(layBtnArea){
		 $('#workArea').find('.addContentZone').removeClass('addContentZone');
		 //$('#' + parentId).parent().addClass('addContentZone');
		 $(layBtnArea).parent().addClass('addContentZone');
		 //console.log($(layBtnArea).parent().attr('class'));
		 var containerClass = $(layBtnArea).parent().attr('class');
		 
		 var formData = {};
		 
		 if(containerClass.search('varLayout') >= 0){
			 // 가변컨테이너 에서 호출
			 formData.callType = 'varLayout';
			 if(containerClass.search('layout_06') >= 0){
				 formData.width = '66';
			 }else if(containerClass.search('layout_04') >= 0){
				 formData.width = '25';
			 }else if(containerClass.search('layout_03') >= 0){
				 formData.width = '33';
			 }else if(containerClass.search('layout_02') >= 0){
				 formData.width = '50';
			 }
		 }else if(containerClass.search('tabContainer') >= 0){
			 //탭 컨테이너 에서 호출
			 formData.callType = 'tabContainer';
		 }else{
			 //template00 에서 호출
		 }
		 
			$.ajax({
				   type:'POST'
				 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/screen/selectSiteLayoutAjax.do'
				 , data:formData
				 , success:function (data) {
					 
					 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.word.layout" /> <spring:message code="wzwg.cmm.word.add02" />', data);
					 	//$("#divLayerPopup").html(data);
			    	  	//$("#divLayerPopup").show();
			    	  	//$(".pop-box").toggle();
							 // 부모코드 셋팅 
							// fnGetMenuList();
							 
						//	 document.getElementById("menuNm").focus();
						   }
				 , dataType: 'html'
			});
		}
	
	 /* 탭 컨테이너 추가 */
	 function addTabContainer(){
		 
 		var addTabZone = $('#md_tabContainer').html();
		var emptyLine30 = '<div class="empty empty_30 wzwgContextMenu layout_line_border" ></div>';
		
 		$('#template00').append(addTabZone);
 		$('#template00').append(emptyLine30);
 		
 		editInit();
	 }
	 

	 /* moo0506 레이아웃 컨텐츠 팝업창 열기*/
	 function addContentsPopup(contentsZone){
	 	 
	 	 //console.log(contentsZone);
	 	 $('.addLayoutContentsZone').removeClass('addLayoutContentsZone');
	 	 
	 	 $(contentsZone).parent().addClass('addLayoutContentsZone');
	 	 
	 	 //console.log($(contentsZone).parent().attr('data-w'));
	 	 
	 	 var form = new FormData();
	 	 form.append('width', $(contentsZone).parent().attr('data-w'));
	 	 form.append('height', $(contentsZone).parent().attr('data-h'));
	 	 
	 	 //console.log(frm);
	 	 
	 	 $.ajax({
	 		   type:'POST'
	 		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/screen/selectLayoutContentsPopupAjax.do'
	 		 , cache : false
	 		 , async : false
	 		 , processData: false
	 		 , contentType: false
	 		 , data : form
	 		 , success:function (data) {
	 			 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.add02" />', data);
	 			 	//$("#divLayerPopup").html(data);
	 	    	  	//$("#divLayerPopup").show();
	 	    	  	//$(".pop-box").toggle();
	 					 // 부모코드 셋팅 
	 					// fnGetMenuList();
	 					 
	 				//	 document.getElementById("menuNm").focus();
	 				   }
	 		 , dataType: 'html'
	 	});
	 }
		function secureRandom(wordCount){
			   var randomWords;
			 
			   if( window.crypto && window.crypto.getRandomValues){
			       // 크롬 등에서 지원
			       randomWords = new Int32Array(wordCount);
			       window.crypto.getRandomValues(randomWords);
			   }else if(window.msCrypto && window.msCrypto.getRandomValues){
			       // Internet Explorer 11에서 지원
			       randomWords = new Int32Array(wordCount);
			       window.msCrypto.getRandomValues(randomWords);
			   }else{
			       // Internet Explorer 10 이하의 버전
			       return 0.9959054245998751;  // 아무값이나 리턴
			       /* 또는 그냥 
			         return Math.random(); 
			        */
			   }
			   
			   var result = randomWords[0] * Math.pow(2, -32);
			   result = Math.abs(result);
			   return result;
			}
	 
	 /* moo0506 레이아웃 영역에 컨텐츠 추가*/
	 function addLayoutContents(_html, _css, _cssId){
	 	 $('#tmpReciveContents').html('');
	 	 
	 	 if($('#' + _cssId).length == 0){
	 		 $('#content').append('<link rel="stylesheet" href="' + _css + '" type="text/css" id="' + _cssId + '"/>' );
	 	 }
	 	 
	 	 $('.addLayoutContentsZone').find('.add_div').remove();
	 	 
	 	 var contents = $('<div/>');
	 	 contents.load(_html + '?ran=' + secureRandom(), function(){
	 		 //console.log($(this).html());
	 		 var htmlContents = $(this).html();
	 		 
	 		 $('.addLayoutContentsZone').append(htmlContents);
	 	
	 		 editInit();
	 		 //wzwgSwiper();
	 		 var findSwiper = $('.addLayoutContentsZone').find('.wzwg-swiper');
	 		 //console.log(findSwiper.length);
	 		 
	 		 if(findSwiper.length == 1){
	 			swiperPlay(findSwiper);
	 		 }
	 		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.cntnts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.add" /></spring:argument></spring:message>');
	 		 wzModalClose();
	 	 	 wzwgCMSelectorInit();
	 	 	 
	 		 /* if($(".wzwg-swiper").size() >0){
	 	 	 	wzwgSwiperCall();
	 	 	 } */ 
	 	 	 
	 	 	 /* 가변 레이아웃에 추가될 경우 구분선을 추가해 준다 */
	 	 	 /* if( $('.addLayoutContentsZone').hasClass('varLayout') ){
	 	 		var emptyLine10 = '<div class="empty empty_10 wzwgContextMenu layout_line_border" ></div>';
	 	 		$('.addLayoutContentsZone').append(emptyLine10);
	 	 		editInit();
	 	 	 } */
	 	 });
	 	 
	 	
	 }
	 
	 
	 function addVarContentsPopup(btnContoller){
		 $('.addLayoutContentsZone').removeClass('addLayoutContentsZone');
	 	 
	 	 $(btnContoller).parent().addClass('addLayoutContentsZone');
	 	 
	 	 //console.log($(contentsZone).parent().attr('data-w'));
	 	 
	 	 var form = new FormData();
	 	/*
	 	 form.append('width', $(contentsZone).parent().attr('data-w'));
	 	 form.append('height', $(contentsZone).parent().attr('data-h')); */
	 	 
	 	 //console.log(frm);
	 	 
	 	 $.ajax({
	 		   type:'POST'
	 		 , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/cntntsEditor/screen/selectVariableContentsPopup.do'
	 		 , cache : false
	 		 , async : false
	 		 , processData: false
	 		 , contentType: false
	 		 , data : form
	 		 , success:function (data) {
	 			 wzAjaxModal('popup_l', '<spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.add02" />', data);
	 			 	//$("#divLayerPopup").html(data);
	 	    	  	//$("#divLayerPopup").show();
	 	    	  	//$(".pop-box").toggle();
	 					 // 부모코드 셋팅 
	 					// fnGetMenuList();
	 					 
	 				//	 document.getElementById("menuNm").focus();
	 				   }
	 		 , dataType: 'html'
	 	});
	 }
	 
	 
	 function uploadImg(mode){
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}"/>/module/upload/image/imageForm.do?mode='+mode
				, dataType : 'html'
				, success : function (data) {
					//$("#imgDiv").html(data);
					//$("#imgDiv").show();
					wzAjaxModal('popup_s wd50', '<spring:message code="wzwg.cmm.word.image" />', data);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			}); 
	 }
	 
	 function screenScrolView(){
		 var screen = $('#screen');
		 var scrollView = screen.attr('data-scroll');
		 if(scrollView == 'true'){
			 screen.css('overflow-x', 'hidden');
			 screen.css('overflow-y', '');
			 var contentsHeight = $('#cntntsEdit').height();
			 var scrollAttr = { height: contentsHeight + 'px'
			 }; 
			 screen.animate(scrollAttr , function(){
				 screen.css('height', '');
			 });
			 //screen.css('max-height', '');
			 screen.css('border', '');
			 //$(document).scrollTop($(document).height());
			 screen.attr('data-scroll', 'false');
		 }else{
			 screen.css('overflow-x', 'hidden');
			 screen.css('overflow-y', 'auto');
			 
			 var scrollAttr = { height: '600px'
			 }; 
			 screen.animate(scrollAttr);
			 
			 //screen.css('max-height', '600px');
			 screen.css('border', 'solid 1px #999');
			 //screen.scrollTop(screen.height());
			 screen.attr('data-scroll', 'true');
		 }
	 }
	 
	 function screenReset(){
		 if(confirm('컨텐츠 내용을 전부 삭제 합니까?')){
			 
			 screenModeRefresh(true)
		 }
	 }
	 
	 function screenModeRefresh(formCommand){
		 if(formCommand == true){
			 $('#cntntsEdit').empty();
			 $('#cntntsEdit').html($('#cntntsEditFrame').html());
		 }
		 subPageMode = true;
		 editInit(); //화면구성에 필요한 객체 추가 
		 wzwgSwiperAll(); //공용 스와이퍼 스크립트 자동
		 //writeContentTxt(); // 직접입력 객체 활성화
		 editDialog(); // 다이얼로그 준비
		 wzwgCMBuilder(); // 컨텍스트 메뉴 준비
		 fnGridBtnText();
		 $('div[role=dialog]').css('position', 'absolute'); // 꼭 이렇게 해야되나 ㅠ ㅜ
		 wzEditorInit();
		 
		 linkDialogInit();
	 }
	 
	 var cssCm;
	 function editContentCss(){
		 if($('#cntntsEdit #contentCss').length == 0){
			 $('#cntntsEdit #content').after($('<style id="contentCss"></style>'));
		 }
		 
		 var cssEdit = '';
		 	 cssEdit += '<div class="cssEditForm">';
		 	 cssEdit += '	<textarea id="cssEdit" style="min-height: 70%;"></textarea>';
		 	 cssEdit += '	<div class="mt10">';
		 	 cssEdit += '		<button type="button" class="wzbtn btn-save fr" onclick="saveContentCss()"><spring:message code="wzwg.cmm.word.stre" /></button>';
		 	 cssEdit += '	</div>';
		 	 cssEdit += '</div>';
		 wzAjaxModal('popup_l', 'CSS 편집', cssEdit);
		 
		 cssCM = cmStart('cssEdit', 'css');
		 
		 cssCM.setOption("theme", 'material');
		 
		 var loadText = $('#cntntsEdit #contentCss').html();
		 loadText = cmConvertXmlExprToText(loadText);
		 cmSetSorceText(cssCM, loadText);
	 }
	 
	 function saveContentCss(){
		 var loadText = cmGetText(cssCM);
		 $('#cntntsEdit #contentCss').html(loadText);
		 wzModalClose();
	 }
	 
	 /* moo0506 그리드토글 noneborder CSS 파일 삽입/제거 */
	 function fnGridToggle(){
		 if($('#styleGridNone').length == 0){
			 var gridCss = '<link id="styleGridNone" href="/css/wzwg/site/mngr/screenMngrNoneBorder.css" rel="stylesheet"	type="text/css" />'
			 $('#cntnts_area').append(gridCss);
		 }else{
			 $('#styleGridNone').remove();
		 }
		 
		 fnGridBtnText();
	 }
	 
	 function fnGridBtnText(){
		if($('#styleGridNone').length == 0){
			$('#GridToggleBtn').html('<spring:message code="wzwg.cmm.word.guidance" /><spring:message code="wzwg.cmm.word.line03" /> <spring:message code="wzwg.cmm.word.hide" />');
		}else{
			$('#GridToggleBtn').html('<spring:message code="wzwg.cmm.word.guidance" /><spring:message code="wzwg.cmm.word.line03" /> <spring:message code="wzwg.cmm.word.ex" />');
		}
	 }
	 
	
	 
	 function subEditInit(){
		 var addContainerZone = $('#md_addContainer').html();
		 //var addLayoutZone = $('#md_addLayout').html();
		 
		 $('#workArea').find('.addContainer').remove();
		 
		 $('#template00').append(addContainerZone);
		 /* $('.tabs-contents div').each(function(){
			 $(this).append(addLayoutZone);
		 }) */
		 
		 tabContainerReset();
		 
		 $('.varLayout>.add_div').remove();
		 
		 $('#template00 .varLayout').each(function(){
			 
			 var addLayoutZone = $('#md_addLayout').html();
			 
			 if($(this).find('.addContainer').length == 0){
					$(this).append(addLayoutZone);
			 }
		 });
		 
		 //위디자인 코어 스크립트 실행
		 wzCollapseInit()
	 }
	 
	 /* 이하 탭관련 스크립트 */
	 function tabContainerReset(){
		 //console.log(1);
		 
		 var addLayoutZone = $('#md_addLayout').html();
		 
		 $('#workArea').find('.cntnts-tabs').each(function(){
			 var contentsActive = 0;
			 var menuList = $(this).find('.tabs-menu').children();
			 var contentsList = $(this).find('.tabs-contents').children();
			 //console.log(menuList.length);
			 // 메뉴 매핑작업
			 menuList.each(function(idx){
				 if($(this).hasClass('active')){
					 contentsActive = idx;
				 }
				 
				 $(this).off();//우선 모든 이벤트 삭제
				 
				 $(this).on('click',function(){
					 //console.log(idx);
					 menuList.select('.active').removeClass('active');
					 menuList.eq(idx).addClass('active');

					 contentsList.select('.active').hide();
					 
					 contentsList.eq(idx).fadeIn();
					 contentsList.eq(idx).addClass('active');
				 });
			 });
			 //console.log(contentsActive);
			 //console.log(contentsList.eq(contentsActive));
			 menuList.eq(contentsActive).addClass('active');
			 contentsList.eq(contentsActive).addClass('active');
			 
			 //컨텐츠에 레이어 추가 버튼 추가
			 contentsList.each(function(idx){
				if($(this).find('.addContainer').length == 0){
					$(this).append(addLayoutZone);
				}
			 });
		 });
		 
		 /* 
		 $('#workArea').find('.tabs-contents').children().each(function(idx){
			 $(this).append(addLayoutZone);
			 if($(this).hasClass('active')){
				 contentsActive = idx;
			 }

			 $(this).off();
			 $(this).on('click', function(){
				 
			 })
			 $(this).removeClass('active');
		 })
		 
		 $('#workArea').find('.tabs-contents').children().eq(contentsActive).addClass('active');
		  */
	 }
	 
	 function addTabMenu(cntntsTabs){
		 var tabMenuList = cntntsTabs.find('.tabs-menu');
		 var tabContentsList = cntntsTabs.find('.tabs-contents');
		 
		 tabMenuList.append('<li class="wzwgTabContextMenu"><span class="tabTitle">New MENU</span></li>');
		 tabContentsList.append('<div class="tabContainer"></div>');
		 
		 tabContainerReset();
	 }
	 
	 function deleteTabMenu(cntntsTabs){
		 if(confirm('탭삭제시 작성된 내용은 모두 삭제 됩니다.\n\n탭을 삭제 합니까?')){
			 var idx = $(cntntsTabs).index();
//			 var tabContainer = $(cntntsTabs).parents().find('.cntnts-tabs').eq(0);
			 var tabContainer = $(cntntsTabs).parent().parent();
			 
			 console.log(tabContainer.find('.tabs-menu').children().eq(idx));
			 console.log(tabContainer.find('.tabs-contents').children().eq(idx));
			 tabContainer.find('.tabs-menu').children().eq(idx).remove();
			 tabContainer.find('.tabs-contents').children().eq(idx).remove();
			 
		 }
	 }
	 
	 
	 
	 
	 /* moo0506 퀵배너 추가시 퀵배너 html에서 샘플 코드를 복사해서 퀵배너 영역에 바로 추가 */
	 function addQuickBanner(qContents){

			var maxitem = $(qContents).attr('data-maxitem');
			var itemLength = $(qContents).find('.quickBannerZone').children().length;
			//console.log(maxitem + '/' + itemLength);
			 
			maxitem = parseInt(maxitem);
			itemLength = parseInt(itemLength);
			
			if(maxitem <= itemLength){
				alert('<spring:message code="wzwg.cmm.msg.MSG177"><spring:argument>'+maxitem+'</spring:argument></spring:message>');
				return;
			}
			 
			var quickItem = $(qContents).find('.quick_sample').html();
			$(qContents).find('.quickBannerZone').append(quickItem);
			
			$(qContents).find('.quickBannerZone').each(function(){
				$(this).children().attr('data-type' ,'quick');
			});
		}
	 
	 /* 퀵메뉴 추가 */
	 function addQuickMenu(qContents){

			var maxitem = $(qContents).attr('data-maxitem');
			var itemLength = $(qContents).find('.quickBannerZone').children().length;
			 
			maxitem = parseInt(maxitem);
			itemLength = parseInt(itemLength);
			
			if(maxitem <= itemLength){
				alert('<spring:message code="wzwg.cmm.msg.MSG177"><spring:argument>'+maxitem+'</spring:argument></spring:message>');
				return;
			}
			 
			var quickItem = $(qContents).find('.quick_sample').html();
			$(qContents).find('.quickBannerZone').append(quickItem);
			
			$(qContents).find('.quickBannerZone').each(function(){
				$(this).children().attr('data-type' ,'quick');
			});
		}
	 
	 
	 function tableEditPopup($tableZone){
		 console.log($tableZone);
		 console.log($tableZone[0]);
//		 var table = $('.tableTest').html();
		 var table = '<div class="tableEdit" >' + $tableZone[0].outerHTML + '<div>';
		 wzAjaxModal('popup_l', '테이블 편집', table);
		 
		 var atableOpt = {
	    		  showBtnList: true,
	    		  lang: 'en',
	    		  mark: {
	    		    align: {
	    		      default: 'left',
	    		      left: 'left',
	    		      center: 'center',
	    		      right: 'right'
	    		    },
	    		    btn: {
	    		      group: 'a-table-btn-list',
	    		      item: 'a-table-btn',
	    		      itemActive: 'a-table-btn-active'
	    		    },
	    		    icon: {
	    		      alignLeft: 'a-table-icon a-table-icon-left',
	    		      alignCenter: 'a-table-icon a-table-icon-center',
	    		      alignRight: 'a-table-icon a-table-icon-right',
	    		      undo: 'a-table-icon a-table-icon-undo',
	    		      merge: 'a-table-icon a-table-icon-merge02',
	    		      split: 'a-table-icon a-table-icon-split02',
	    		      table: 'a-table-icon a-table-icon-th02',
	    		      source: 'a-table-icon a-table-icon-source01',
	    		      td: 'a-table-icon a-table-icon-td03',
	    		      th: 'a-table-icon a-table-icon-th02'
	    		    }
	    		    
	    		  }
					  ,selector:{
							option:[
								{label:'bg-red',value:'bg-red'},
								{label:'bg-blue',value:'bg-blue'},
								{label:'bg-brown',value:'bg-brown'},
								{label:'bg-grey',value:'bg-grey'},
								{label:'text-left',value:'txt-l'},
								{label:'text-center',value:'txt-c'},
								{label:'text-right',value:'txt-r'}
							]
						} 
					/* 	,tableOption: [
							{label:'위즈테이블',value:'wztable'}
						] */
	    			,message: {
	    			    mergeCells: '셀 병합',
	    			    splitCell: 'split cell',
	    			    changeToTh: 'change to th',
	    			    changeToTd: 'change to td',
	    			    alignLeft: 'align left',
	    			    alignCenter: 'align center',
	    			    alignRight: 'align right',
	    			    addColumnLeft: 'insert column on the left',
	    			    addColumnRight: 'insert column on the right',
	    			    removeColumn: 'remove column',
	    			    addRowTop: 'insert row above',
	    			    addRowBottom: 'insert row below',
	    			    removeRow: 'remove row',
	    			    source: 'Source',
	    			    mergeCellError1: 'All possible cells should be selected so to merge cells into one',
	    			    mergeCellConfirm1: 'The top left cell\'s value of the selected range will only be saved. Are you sure you want to continue?',
	    			    pasteError1: 'You can\'t paste here',
	    			    splitError1: 'Cell is not selected',
	    			    splitError2: 'Only one cell should be selected',
	    			    splitError3: 'You can\'t split the cell anymore'
	    			  }
	    		}
	    
	    atable = new aTable('.pop-container table', atableOpt);
		 
		var saveBtn = '<div class="tableEdit-btn"><button type="button" class="wzbtn btn-save" onclick="editTableSave();">저장하기</button></div>'
		$('.pop-container').append(saveBtn);
	 }
	 
	 var atable;
	 
	 function editTableSave(){
		 selectDiv.find('.tableEditZone').html(atable.getTable());
		 var tableZone = selectDiv.find('.tableEditZone');
		 tableZone.find('tr').each(function(idx){
			if($(this).find('th').length > 0 && $(this).find('td').length == 0){
				$(this).addClass('thead');
			}else{
				$(this).removeClass('thead');
			}
		 });
		 wzModalClose();
	 }
	 
	 function wzEditorInit(){
		 /* $('#template00').keypress(function(event){
			 //console.log(event);
			 var target = $(event.target);
			 var keyCode = event.keyCode;
			 
			 if( keyCode == 13 && (target.hasClass('wzbtn') || target.hasClass('wzbtn-table')) ){ //target.parents().find('wzbtn') || target.parents().find('wzbtn-table')  && 
				 //console.log('dd');
				 //console.log(event);
				 console.log(target);
				 target.append('<br>');
				 event.preventDefault();
			 } 
		 }); */
		 $('#template00').off();
		 
		 $('#template00').click(function(event){
			 
			/* step1 : 기존에 정의된 클래스 제거 */
			//$('#template00').find('.wzEditTarget').removeAttr('contenteditable');
			$('#template00').find('.wzEditTarget').removeClass('wzEditTarget'); //먼저 이전 선택자를 삭제하고 시작한다
			$('#template00').find('.wzEditZone').attr('contenteditable','true'); //모든 텍스트 편집 대상을 활성화
			
			$('#template00').find('.wzEditBtnTarget').removeClass('wzEditBtnTarget'); //먼저 이전 선택자를 삭제하고 시작한다(버튼용)
			$('#template00').find('.wzEditBoxTarget').removeClass('wzEditBoxTarget'); //먼저 이전 선택자를 삭제하고 시작한다(이미지용)
			$('#template00').find('.wzEditCellTarget').removeClass('wzEditCellTarget'); //먼저 이전 선택자를 삭제하고 시작한다(테이블셀)
			
			
			var target = $(event.target);
			//console.log(target);
			
			
			
			
			/* step 2 : target 클래스 정의 */
			// 테이블 편집 영역 설정
			if(target.parents().find('.tableEditZone').length > 0){
				if(target.is('th') || target.is('td')){
				
					if(target.html() == ''){
						var paragraph = '<div class="wzContentText wzEditZone" id="newParagraph">&nbsp;</div>';
						target.html(paragraph);
						 $('#newParagraph').addClass('wzEditTarget');
						 $('.wzEditTarget').focus();
						 $('#newParagraph').removeAttr('id');
					}
				}
				
				var parents = target.parents();
			  	
			  	for(var i = 0 ; i < parents.length ; i++){
			  		if( $(parents[i]).is('th') || $(parents[i]).is('td') ){
			  		
					  	$(parents[i]).addClass('wzEditCellTarget');
					  	break;
			  		} 
			  		
			  	}
			}
			/*
			if(target.parents().find('.tableEditZone').length > 0){
			  	//console.log($(event.target));
			  	$('.tableEditZone').attr('contenteditable','true');
				
				
			  	//target.attr('contenteditable','true');

			  	if( target.is('th') || target.is('td') ){
			  		target.addClass('wzEditTarget');
			  	}else{
				  	var parents = target.parents();
				  	
				  	for(var i = 0 ; i < parents.length ; i++){
				  		if( $(parents[i]).is('th') || $(parents[i]).is('td') ){
				  		
						  	$(parents[i]).addClass('wzEditTarget');
						  	break;
				  		} 
				  		
				  	}
			  	}
			  	
			  	
			  	
			}// end 테이블 편집 영역 설정
			*/
			
			// 텍스트 편집 영역 설정
			if(target.hasClass('wzEditZone')){
				target.addClass('wzEditTarget');
			}else{
				var parents = target.parents();
			  	
			  	for(var i = 0 ; i < parents.length ; i++){
			  		if( $(parents[i]).hasClass('wzEditZone') ){
			  		
					  	$(parents[i]).addClass('wzEditTarget');
					  	break;
			  		} 
			  		
			  	}
			}// end 텍스트 편집 영역 설정
			
			
			// 이미지 편집 영역 설정
			if(target.hasClass('wzwgBoxContextMenu')){
				target.addClass('wzEditBoxTarget');
			}else{
				var parents = target.parents();
			  	
			  	for(var i = 0 ; i < parents.length ; i++){
			  		if( $(parents[i]).hasClass('wzwgBoxContextMenu') ){
			  		
					  	$(parents[i]).addClass('wzEditBoxTarget');
					  	break;
			  		} 
			  		
			  	}
			}// end 텍스트 편집 영역 설정
			
			
			// 버튼 영역 설정 (단일 태그라 한번에 가능)
			if(target.hasClass('wzwgBtnContextMenu')){
				$(target).addClass('wzEditBtnTarget');
			}
			
			
			
			
			
			/* step3 : target 클래스에 맞는 에디터 다이얼로그 호출 */
			// 위즈에디터 오픈
			if($('#template00').find('.wzEditTarget').length == 1){
				
				$( "#wzEditorBtnDialog" ).dialog('close');
				$( "#wzEditorBoxDialog" ).dialog('close');
				
				//console.log(target);
				if($('.wzEditTarget').html() == ''){
					$('.wzEditTarget').append('<br>');
				}
				
				
				if(target.parents().find('.tableEditZone').length > 0){
				//테이블에 포함된 텍스트 편집일 경우 테이블 관련 버튼과 기능을 활성화
				
				//if(target.parent().is('th') || target.parent().is('td')){
					if($('#tableCtrlGrp').css('display') == 'none'){
						$('#tableCtrlGrp').show();
						$('.wzEditor-contents .wzEditor-func').hide();
					}
					
				}else{
				//테이블이 아니라면 테이블 관련 버튼과 기능 비활성화	
				
					if($('#tableCtrlGrp').css('display') != 'none'){
						$('#tableCtrlGrp').hide();
						$('.wzEditor-contents .tableCellWidth').hide();
						$('.wzEditor-contents .wzEditor-func').hide();
					}
				}
				
				$('.wzEditor-contents .bgColor').append($('#wzEditorBGControll'));//배경 콤포넌트 이동
				$('.wzEditor-contents .menuLink').prepend($('#wzEditorLinkSelector'));//링크연결 콤포넌트 이동
				$('#wzEditorBGControll').show();
				$( "#wzEditorDialog" ).dialog('open');
				
				//wzEditorDialogOpen('text', target);
			}else
			
			// 이미지 편집 팝업
			if($('#template00').find('.wzEditBoxTarget').length == 1){
				
				$( "#wzEditorDialog" ).dialog('close');
				$( "#wzEditorBtnDialog" ).dialog('close');
				
				$('.wzEditor-img-contents .imgBorderBgCol').append($('#wzEditorBGControll'));//배경 콤포넌트 이동
				$('.wzEditor-img-contents .menuLink').prepend($('#wzEditorLinkSelector'));//링크연결 콤포넌트 이동
				wzEditorChangeBgMode('imgBorder');//배경 콤포넌트 명령어 변경
				
				$( "#wzEditorBoxDialog" ).dialog('open');
				
				wzEditorBoxChangeMode();
				
				//wzEditorDialogOpen('image');
			}
			
			// 버튼 영역 설정및 팝업 (단일 태그라 한번에 가능)
			if(target.hasClass('wzwgBtnContextMenu')){
				
				
				$(".ui-dialog-content").dialog("close"); // 모든 모달창 닫기
				$( "#wzEditorDialog" ).dialog('close');
				$( "#wzEditorBoxDialog" ).dialog('close');
				
				$('.wzEditor-btn-contents .menuLink').prepend($('#wzEditorLinkSelector'));//링크연결 콤포넌트 이동
				
				$( "#wzEditorBtnDialog" ).dialog('open');
				//wzEditorDialogOpen('button');
			}
			
			
			
			
			/* step4 : 기타 */

			if(target.hasClass('fa')){
				//아이콘을 클릭하면 앞뒤에 span 태그가 있는지 검사하고 없으면 넣어준다
				//그리고 뒤에있는 span 태그에 포커스를 넣어준다?? 해보지뭐;;
				if(target.prev().length == 0){
					target.before('<span>&nbsp;</span>');
				}
			}
			
			target.focus();
			
			
			
		 });//end template00 click
		 
		
	 }
	 
	//function wzEditorDialogOpen(mode, target){
	//	 $( "#wzEditorDialog" ).dialog('close');
	//	 $( "#wzEditorBoxDialog" ).dialog('close');
	//	 $( "#wzEditorBtnDialog" ).dialog('close');
	//	 
	//	 if(mode == 'text'){
	//		 if($('.wzEditTarget').html() == ''){
	//		 	$('.wzEditTarget').append('<br>');
	//		 }
	//		 
	//		 if(target.is('th') || target.is('td')){
	//		 	$('#tableCtrlGrp').show();
	//		 }else{
	//		 	$('#tableCtrlGrp').hide();
	//		 	$('.wzEditor-contents .tableCellWidth').hide();
	//		 }
	//		 
	//		 $('.wzEditor-contents .bgColor').append($('#wzEditorBGControll'));//배경 콤포넌트 이동
	//		 $('#wzEditorBGControll').show();
	//		 $( "#wzEditorDialog" ).dialog('open', {
	//		 	open: function( event, ui ) {target.focus();}
	//		 });
	//	 }else if(mode == 'tableText'){
	//		 
	//	 }else if(mode == 'image'){
	//		 $('.wzEditor-img-contents .imgBorderBgCol').append($('#wzEditorBGControll'));//배경 콤포넌트 이동
	//		 wzEditorChangeBgMode('imgBorder');//배경 콤포넌트 명령어 변경
	//		 
	//		 $( "#wzEditorBoxDialog" ).dialog('open', {
	//				open: function( event, ui ) {target.focus();}
	//			
	//			});
	//		 
	//	 }else if(mode == 'button'){
	//		 $( "#wzEditorBtnDialog" ).dialog('open', {
	//				open: function( event, ui ) {
	//									target.focus();
	//									$('.wzEditor-func.textEdit').hide();
	//									}
	//			});
	//	 }
	//	 
	//	 
	//	 if($('.wzEditBoxTarget').find('.tableZone').length == 1){
	//			//테이블 컨텐츠 박스 편집 에디터 호출
	//			$( "#wzEditorBoxDialog" ).dialog({title : 'WIZWIG - EDITOR (TABLE FRAME)'});
	//			//$('.wzEditor-img-contents .wzEditor-func').hide()
	//			
	//			$('#wzEditor-cntl-imgBorderRound').find('.imgEdge').hide();
	//			$('#wzEditorBtn-boxCover').hide();
	//			$('#wzEditorBtn-boxLink').hide();
	//			$('#wzEditorBtn-boxUnLink').hide();
	//			$('#wzEditorBtn-boxFile').hide();
	//			$('#wzEditorBtn-boxImgHint').hide();
	//			
	//		}else{
	//			//이미지 컨텐츠 박스 편집 에디터 호출(기본값)
	//			$( "#wzEditorBoxDialog" ).dialog({title : 'WIZWIG - EDITOR (IMAGE FRAME)'});
	//			console.log('dd');
	//			$('#cellBgTargetBox').hide();
	//			//$('.wzEditor-img-contents .wzEditor-func').hide()
	//			
	//			$('#wzEditor-cntl-imgBorderRound').find('.imgEdge').show();
	//			$('#wzEditorBtn-boxCover').show();
	//			$('#wzEditorBtn-boxLink').show();
	//			$('#wzEditorBtn-boxUnLink').show();
	//			$('#wzEditorBtn-boxFile').show();
	//			$('#wzEditorBtn-boxImgHint').show();
	//			
	//		}
	//	 
	//}
	 
	 function setSelectionRange(input, selectionStart, selectionEnd) {
		  if (input.setSelectionRange) {
			  console.log('1');
		    input.focus();
		    input.setSelectionRange(selectionStart, selectionEnd);
		  } else if (input.createTextRange) {
			  console.log('2');
		    var range = input.createTextRange();
		    range.collapse(true);
		    range.moveEnd('character', selectionEnd);
		    range.moveStart('character', selectionStart);
		    range.select();
		  }else{
			  console.log('3');
		  }
		}

	 function setCaretToPos(input, pos) {
	  	setSelectionRange(input, pos, pos);
	 }
	 
	 
	 function linkDialogInit(){
		 $('.linkMenuList').tendina({
				animate: true,
				speed: 300,
				onHover: false,
				hoverDelay: 100,
				activeMenu: $('#deepest'),
				openCallback: function(clickedEl) {
				  console.log('Hey dude!');
				},
				closeCallback: function(clickedEl) {
				  console.log('Bye dude!');
				}
			 }); //lnb메뉴
	 }
	 
	 $(document).ready(function(){
		 screenModeRefresh();
	 })// end ready
</script>

	<!-- 레이어팝업 영역 Start -->
	<!-- <div id="divLayerPopup" class="pop-box" style="display: ;"></div> -->
	<!-- 레이어팝업 영역 End -->
	
		<form:form modelAttribute="paramVO" path="cntntsCnListFrm" name="cntntsCnListFrm" id="cntntsCnListFrm" method="post">
			<form:hidden path="cntntsSeq"/>
			<input type="hidden" name="target" value="cnDetail"/>
			
			<div class="mg_t20">
				<table class="basic">
					<colgroup>
						<col width="15%"/>
						<col width="*"/>
					</colgroup>
					<tbody>
						<tr>
							<td colspan="2" class="rt-box">
								<div class="rt-box">
									<a href="javascript:void(0);" onclick="fnCntntsCnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
									<a href="javascript:void(0);" onclick="fn_init();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
								</div>
							</td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.cmm.word.template" /></th>
							<td>
							
		 						<select name="searchCondition" id="searchCondition" class="w30">
		 							<option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
									<c:forEach items="${codeList }" var="codeList">
										<option value="<c:out value='${codeList.code }'/>" <c:if test="${resultVO.tmplatClSeq eq codeList.code }">selected="selected"</c:if>>
											<c:out value="<c:out value='${codeList.codeNm }'/>"/>
										</option> 
									</c:forEach>
		 						</select>
								<input type="text" name="searchKeyword" id="searchKeyword" class="w30" />
								<a class="wzbtn-table btn-srch" href="javascript:void(0);" onclick="fn_tmplatSearch();"><spring:message code="wzwg.cmm.word.search01" /></a>
								
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<input type="hidden" name="cntntsCn" id="cntntsCn"/>
			<div class="mt5 mb5">
				<div id="screen">
					<div class="mg5" id="workArea">
						<div class="contents" id="cntntsEdit" style="min-height: 200px; border: dashed 1px black;">
							<c:if test="${not empty resultVO.cntntsCn  }"><c:out value='${resultVO.cntntsCn }' escapeXml="false"/></c:if>

							<c:if test="${empty resultVO.cntntsCn  }">
								<script>screenModeRefresh(true)</script>
							</c:if>
							
						</div>
					</div>
				</div>
				<div class="dgnControll">
					<div class="btnbox-c txt-r">
						<button type="button" class="wzbtn btn-del" onclick="screenReset()">전체삭제</button>
						<button type="button" class="wzbtn btn-basic" onclick="" >지도 관리자</button>
						<button type="button" class="wzbtn btn-basic" onclick="editContentCss()" >CSS 편집</button>
						<button type="button" class="wzbtn btn-basic" onclick="fnGridToggle()" id="GridToggleBtn">그리드토글</button>
						<button type="button" class="wzbtn btn-basic" onclick="screenScrolView()">스크롤뷰</button>
					</div>
				</div>
				
			</div>
		</form:form>
			
		
		<!-- 게시물 목록 -->
		<table class="basic-table">
			<colgroup>
				<col width="80%"/>
				<col width="*"/>
			</colgroup>
			<thead>
				<tr>
					<th>작성일시</th>
					<th><spring:message code="wzwg.cmm.word.rm" /></th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty cntntsCnList }">
						<c:forEach items="${cntntsCnList }" var="cntntsCnList" varStatus="status">
							<tr>
								<td><c:out value="${cntntsCnList.frstRegistPnttm }"/></td>
								<td>
									<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.recovry" /></a>
									<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<td colspan="2"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		
		
		<div style="display:none"><%-- 화면편집 모듈 --%>
			<div id="cntntsEditFrame">
				<div id="content" style="display: none;"></div>
				<style id="contentCss"></style>
				<script>
					$('link[href="/smartEditorCustom/css/editorTool.css"]').remove();
					$('link[href="/smartEditorCustom/css/subcon_common.css"]').remove();
					$('link[href="/smartEditorCustom/css/subcon_tamplate.css"]').remove();
				</script>
				<div id="template00" class="addContentZone"></div>
			</div>
			
			
			<div id="md_tabContainer" style="display: none;">
				<div class="tabLayer cntnts-tabs ts-basic wzwgTabContextMenu">
					<div class="wigetController" style="display: none; right:60px !important;top:0;">+<span class="help" style="top:0px !important; height: 80px;"><spring:message code="wzwg.cmm.msg.screen.MSG086" /><p class="slideInfo"><spring:message code="wzwg.cmm.word.scrin.scrinCnvrsFade" /></p></span></div>
					<ul class="tabs-menu">
						<li class="wzwgTabContextMenu"><span class="tabTitle">TAB MENU</span></li>
					</ul>
					<div class="tabs-contentBox">
						<div class="tabs-contents">
							<div class="tabContainer"></div>
						</div>
					</div>
				</div>
			</div>
			
			<div id="md_addContainer" style="display: none;">
				<div class="addContainer" id="addContainerZone">
					<div>
						<span class="wzbtn-group w100">
							<button type="button" class="wzbtn wzbtn-block btn-blue w40" style="padding: 6px;" onclick="addLayout($(this).parent().parent().parent())">레이아웃추가</button>
							<button type="button" class="wzbtn wzbtn-block btn-orange w40" style="padding: 6px;" onclick="addTabContainer()">탭영역추가</button>
							<!-- <button type="button" class="wzbtn wzbtn-block btn-black-bg w30" onclick="addLayout($(this).parent().parent().parent())">컨텐츠추가</button> -->
						</span>
					</div>
				</div>
			</div>
			
			<div id="md_addLayout" style="display: none;">
				<div class="addContainer" id="addLayoutZone">
					<div>
						<span class="wzbtn-group w100">
							<button type="button" class="wzbtn wzbtn-block btn-blue w40" style="padding: 6px;" onclick="addLayout($(this).parent().parent().parent())">레이아웃추가</button>
							<button type="button" class="wzbtn wzbtn-block btn-black-bg w40" style="padding: 6px;" onclick="addVarContentsPopup($(this).parent().parent().parent())">컨텐츠추가</button>
						</span>
					</div>
				</div>
			</div>
		</div>
		
		<%-- 팝업 다이얼로그 로드 --%>
		<jsp:include page="/WEB-INF/jsp/wzwg/site/mngr/screen/siteScreenTempltDialogImp.jsp"></jsp:include>
			
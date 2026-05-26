<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<!doctype html>
<html lang="ko">
	<head>
		<title<spring:message code="wzwg.sysMngr.word.wizwigWidgEdit" /></title>  
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		
		<link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
		
		<!-- 젤 중요한거 -->
		<script src="/js/wzwg/cmm/jquery-2.0.0.min.js"></script>
		<script src="/js/wzwg/cmm/jquery.form.min.js"></script> 
		
		<!-- 다이얼로그 용 리소스 -->
		<link rel="stylesheet" href="/css/wzwg/cmm/jquery-ui.css">
		<script src="/js/wzwg/cmm/jquery-ui.js"></script>
		<script src="/js/wzwg/cmm/jquery.ui.position.min.js" type="text/javascript"></script>

		<!-- 컨텍스트 메뉴용 리소스 -->
		<link href="/css/wzwg/cmm/jquery.contextMenu.css" rel="stylesheet" type="text/css" />
		<script src="/js/wzwg/cmm/jquery.contextMenu.js" type="text/javascript"></script>
		
		<!-- 슬라이더 라이브러리 -->
		<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
		<script src="/js/wzwg/cmm/slick/slick.js"></script> 
    	<script src="/design/module/sample/js/swiper.jquery.min.js"></script>

		<!-- widesign 파일 로드 -->
		<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
		<script src="/widesign/widesign.js"></script>
		
		<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
		
		<!-- 템플릿 레이아웃 리소스 -->
		<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 		<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 		<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

    	
    	<!-- 화면편집용 스타일시트 -->
    	<link rel="stylesheet" href="/css/wzwg/site/mngr/screenMngr.css" type="text/css">
    	<link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css">
		<link rel="stylesheet" href="/css/wzwg/sysMngr/screen/widgetMngr.css" type="text/css" />
    	
    	<!-- 템플릿 공용 스타일시트 -->
    	<link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
    	
    	<!-- 화면편집 기능 스크립트 -->
    	<script src="/js/wzwg/site/editFunc.js" type="text/javascript"></script>
    	
    	<!-- 위즈위그 메시지 로드 -->
	  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
	  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	  	
		<jsp:include page="/WEB-INF/jsp/wzwg/webModule/codemirrorInc.jsp"></jsp:include>

		<script>
		var htmlCM;
		var cssCM;
		linkBannerList=[];
		
		$(document).ready(function(){
			
			/* 위즈위그 메시지 로드 */
			onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
			
			htmlCM = cmStart('htmlArea', 'htmlmixed');
			cssCM = cmStart('cssArea', 'css');
			
			makeCodemirrorThemeOption($('#select')); 
			
			selectTheme();
			
			setCmContents();
			
			widgetLoad();
			
			editDialog(); // 다이얼로그 준비
			wzwgCMBuilder(); // 컨텍스트 메뉴 준비
			
			isSysMngr = true; //컨텍스트 메뉴 팝업 모드를 수퍼관리자로 변경한다
			
			
			htmlCM.on('mousedown', function(cm, ev) {
				var evTarget = ev.target;
				//선택된 곳
				//console.log(ev.target.offsetParent);
				
				var fnMenuClass = ['wzwgContextMenu', 'cntContextSGC0000027', 'cntContext10000000104', 'cntContext10000000204', 'cntContext10000000213', 'quickBannerConfZone', 'wzwgLoginContextMenu', 'wzwgTabContextMenu'];
				
				for(var i = 0; i < fnMenuClass.length; i++) {
					$(evTarget).parents('.CodeMirror-code').find('.cm-string').each(function(idx, el){
						if($(el).html().indexOf(fnMenuClass[i]) > -1) {
							console.log(fnMenuClass[i]);
						} 
					});
				}
				
			});
			
			
			// bind-06. workPannel 리자이즈 바인딩
			$('#htmlSrcBox').resizable({
			//$('#' + wizonId).find( this.workPannel ).resizable({
				  handles : "s"
				, stop : function( event, ui ) {
					//console.log(ui);
				}
			});
			$('#cssSrcBox').resizable({
			//$('#' + wizonId).find( this.workPannel ).resizable({
				  handles : "s"
				, stop : function( event, ui ) {
					//console.log(ui);
				}
			});
			
		});//end ready
		 
		 function selectTheme(){
			 htmlCM.setOption("theme", 'material');
			 cssCM.setOption("theme", 'material');
			 //cmSetTheme(htmlCM, $('#select'));
			 //cmSetTheme(cssCM, $('#select'));
		 }
		
		 function setCmContents(){
			 var htmlPath = $('#widgetCours').val() + $('#widgetHtmlNm').val();
			 var cssPath = $('#widgetCours').val() + $('#widgetCssNm').val(); 
			 cmSetWebSorceText(htmlCM, htmlPath);
			 cmSetWebSorceText(cssCM, cssPath); 
		 }
		 
		 function widgetLoad(){
			 var htmlFile = $('#widgetCours').val() + $('#widgetHtmlNm').val()
			 var cssFile = $('#widgetCours').val() + $('#widgetCssNm').val()
			 
			 //$('#widgetCSS').attr('href', cssFile);
			 var tmpSrc = $('<div id="srcEditor"></div>');
			 var dummy = '?d=' + Math.random();
			 $(tmpSrc).load(cssFile + dummy, function(){
				 //codeMirror.doc.setValue($(this).html());
				 var webPath = $('#widgetCours').val();
				 var thisPath = new RegExp(/\.\.\//, "g"); // [../] 를 찾아라
				 /* html 내용 업데이트 */
				 //var htmlText = cmGetText(htmlCM);
				 //console.log(htmlText);
				 //$('#preview').html(htmlText);
	
				 /* CSS 내용 업데이트 */
				 var cssText = $(this).html();
				 cssText = cssText.replace(thisPath, webPath);
				 cssText = cmConvertXmlExprToText(cssText);
				 $('#previewCSS').html(cssText);
				 $(this).remove();
			 });	
			 
			 getWebSorce(htmlFile, $('#preview'), widgetInit); 
			 
			 
			 //wzwgCMBuilder(); // 컨텍스트 메뉴 준비
			 
		 }
		 
		 function getWebSorce(filePath, jobj, callback){
			 var webSrc = $('<div id="srcEditor"></div>');
			 var dummy = '?d=' + Math.random();
			 $(webSrc).load(filePath + dummy, function(){
				 jobj.empty();
				 jobj.append($(this).html());
				 callback();
			 });
		 }
		 
		 function widgetInit(){
			 
			 var findSwiper = $('#preview').find('.wzwg-swiper');
			 //console.log(findSwiper.length);
			 
			 if(findSwiper.length == 1){
				 swiperPlay(findSwiper, _mobileCheck.matches);
			 }
			 
			 findSwiper = $('#preview').find('.wzwg-slide-info');
			 //console.log(findSwiper.length);
			 
			 if(findSwiper.length == 1){
				 playSlideSlick(findSwiper, _mobileCheck.matches);
			 }
			 
			 findSwiper = $('#preview').find('.wzwg-banner-slide-info');
			 //console.log(findSwiper.length);
			 
			 if(findSwiper.length == 1){
				 playBannerSlideSlick(findSwiper, _mobileCheck.matches);
			 }
			 
			 var findRespTab = $('#preview').find('.wzwg-resp-tab');
			 if(findRespTab.length == 1){
				 responsiveTabActive(findRespTab);
			 }
			  
			 /* if($('#wigetController').length == 0){
				 var wigetControll = '<div class="wigetController" style="display: none;" id="wigetController">+<span class="help">(오른쪽 클릭해 주세요)</span></div>'
				 $('#preview').prepend(wigetControll); 
			 } */
			 contentsHandler()
			 wzwgCMSelectorInit();
			 contentsSortable();
		 }
		 
		 function addQuickBanner(qContents){

				var maxitem = $(qContents).attr('data-maxitem');
				var itemLength = $(qContents).find('.quickBannerZone').children().length;
				
				//퀵메뉴131 에서 높이가 중간일때와 높음일때 maxitem 개수를 다르게하기위해 추가 dahee 201125
				var maxUseAt = $(qContents).attr('data-maxUseAt');
				var hMaxItem = $(qContents).attr('data-hMaxItem'); // 높음
				var mMaxItem = $(qContents).attr('data-mMaxItem'); // 중간
				var lMaxItem = $(qContents).attr('data-lMaxItem'); // 낮음
				var wMaxItem = $(qContents).attr('data-wMaxItem');
				var parentH = $(qContents).parent().attr('data-h');
				var parentW = $(qContents).parent().attr('data-w');
				
				//퀵메뉴133 때문에 수정 (여러개의 퀵존이 존재)
				if(!parentH) {
					parentH = $(qContents).parents().closest('.layout_contents_border').attr('data-h');
					parentW = $(qContents).parents().closest('.layout_contents_border').attr('data-w');
				}
				
				if(maxUseAt != '' && maxUseAt == 'Y') {
					if(parentH == 'H') {
						maxitem = hMaxItem;
					}else if(parentH == 'M') {
						if(wMaxItem && parentW == '100') {
							maxitem = wMaxItem;
						}else {
							maxitem = mMaxItem;					
						}
					}else if(parentH == 'L') {
						maxitem = lMaxItem;
					}
				}
				
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
		 
		 function previewChange(value, btn){
			 
			 if(value == '100'){
				 previewRemoveWidth()
				 $('#preview').addClass('layout_01');
				 $('#preview').attr('data-w', '100');
				 
			 }else if(value == '66'){
				 previewRemoveWidth()
				 $('#preview').addClass('layout_06');
				 $('#preview').attr('data-w', '66');
				 
			 }else if(value == '50'){
				 previewRemoveWidth()
				 $('#preview').addClass('layout_02');
				 $('#preview').attr('data-w', '50');
				 
			 }else if(value == '33'){
				 previewRemoveWidth()
				 $('#preview').addClass('layout_03');
				 $('#preview').attr('data-w', '33');
				 
			 }else if(value == '25'){
				 previewRemoveWidth()
				 $('#preview').addClass('layout_04');
				 $('#preview').attr('data-w', '25');
				 
			 }else if(value == 'L'){
				 previewRemoveHeight()
				 $('#preview').addClass('layout_height_L');
				 $('#preview').attr('data-h', 'L');
			 
			 }else if(value == 'M'){
				 previewRemoveHeight()
				 $('#preview').addClass('layout_height_M');
				 $('#preview').attr('data-h', 'M');
			 
			 }else if(value == 'H'){
				 previewRemoveHeight()
				 $('#preview').addClass('layout_height_H');
				 $('#preview').attr('data-h', 'H'); 
				 
			 }
			 $(btn).parent().parent().find('button').removeClass("on");
			 $(btn).addClass("on")
			 //widgetInit();
		 }
		 
		 function previewRemoveWidth(){
			 $('#preview').removeClass('layout_01');
			 $('#preview').removeClass('layout_02');
			 $('#preview').removeClass('layout_03');
			 $('#preview').removeClass('layout_04');
			 $('#preview').removeClass('layout_06');
		 }
		 
		 function previewRemoveHeight(){
			 $('#preview').removeClass('layout_height_M');  
			 $('#preview').removeClass('layout_height_L');  
			 $('#preview').removeClass('layout_height_H');  
   		  
   		  	 //$(this).addClass('layout_height_' + hmode);  
   		  	 //$(this).attr('data-h', hmode); 
		 }
		 
		 
		 function previewSrcUpload(){
			 var webPath = $('#widgetCours').val();
			 var thisPath = new RegExp(/\.\.\//, "g"); // [../] 를 찾아라
			 /* html 내용 업데이트 */
			 var htmlText = cmGetText(htmlCM);
			 //console.log(htmlText);
			 $('#preview').html(htmlText);

			 /* CSS 내용 업데이트 */
			 var cssText = cmGetText(cssCM);
			 cssText = cssText.replace(thisPath, webPath);
			 cssText = cmConvertXmlExprToText(cssText);
			 $('#previewCSS').html(cssText);
			
			 widgetInit();
		 }
		 
		 function previewSrcDown(){
			 /* html 내용 가져오기 */
			 var previewSrc =  $('#preview').html();
			 var tag = $('<div/>');
			 
			 tag.html(previewSrc);
			 tag.find('.wigetController').remove();
			 tag.find('.itemSortHandler').remove();
			 tag.find('.axeboxContents').remove();
			 tag.find('.axeboxContents').remove();
			 tag.find('.swiper-slide').attr('style', null); 
			 
			 cmSetSorceText(htmlCM, tag.html());
			 tag.remove();
			 
			 /* css 내용 가져오기 */
			 var previewSrc =  $('#previewCSS').html();
			 var css = $('<div/>');
			 
			 css.html(previewSrc);
			 //css.find('.wigetController').remove();
			 
			 cmSetSorceText(cssCM, css.html());
			 css.remove();
		 }
		 
		 
		 
		 function fnCssEditViewToggle(){
			 if($('#cssFileName').val() == ''){
				 alert(wz_msg('wzwg.sysMngr.msg.MSG002'));
				 return;
			 }	
			
			 if($('#cssEditView').css('position') == 'fixed'){
				 $('#cssEditView').css('position', 'unset');
				 /*$('#editArea').css('height', '300px');*/
				 mEditor.doc.cm.setSize('100%','300px')
				 $('body').css('overflow', '');
			 }else{
				 /* var h = $(window).height() - 78; */
				 $('#cssEditView').css('position', 'fixed');
				 var h = $(window).height();
				 var cmTop = $('.CodeMirror').offset().top;
				 console.log(h + '/' + cmTop);
				 console.log(h-cmTop);
				 /* $('#editArea').css('height', h + 'px'); */
				 mEditor.doc.cm.setSize('100%', h-cmTop + 'px');
				 $('body').css('overflow', 'hidden');
			 }
		 }
			
			
		 function fnLoadTempltCss(cssPath, fileName){
			 var tmpCss = $('<div id="srcEditor"></div>');
			 var dummy = '?d=' + Math.random();
			 $(tmpCss).load(cssPath + dummy, function(){
				 //$('#srcEditor').html($(this).html());
				 $('#cssFileName').val(fileName);
				 //aceEditorInit($(this));
				 mEditor.doc.setValue($(this).html());
				 
				 $(this).remove();
			 });
			 
			 
		 }
	/* 		
		function selectTheme() {
		    var theme = $("#select option:selected").text();
		    //console.log(theme);
		    //var theme = $("#select").options[$("#select").selectedIndex].textContent;
		    mEditor.setOption("theme", theme);
		    //location.hash = "#" + theme;
		} */
		 
			
		/*  var aceEditor; 
		 function aceEditorInit(loadCss){
			 aceEditor.setValue("");
			 aceEditor.setValue(loadCss.html());
			 //aceEditor = ace.edit("srcEditor");
		 } */
			
		 
		 
		 
		 
		 
		 function fnCssSave(){
			 $('#cssEdit').val(mEditor.doc.getValue());
			 
			 var formData = $("#mngrCssForm").serialize();
			 
			
			 $.ajax({
				   type:'POST'
				 , url:'/wizmaker/widesign/registCssAjax.do'
				 , cache : false
				 , async : false
				 , data : formData
				 , success:function (data) { 
					 if(data.head.result == 'success'){
						 alert(wz_msg('wzwg.sysMngr.msg.MSG003'));
					 }else{
						 alert(wz_msg('wzwg.sysMngr.msg.MSG004'));
					 }
				 }
				 , dataType: 'json'
			});
		 }
		 
		 /*
		 function getWidgetList(category){
			 $.ajax({
				   type:'POST'
				 , url:'/wizmaker/selectWidgetListAjax.do'
				 , cache : false
				 , async : false
				 , data : {category: category, pageIndex: $('#pageIndex').val()}
				 , success:function (data) { 
					 $('#item-list').html(data);

					 $('#selectCategory').val(category);
					 $('#pageIndex').val(1);
					 
					 if(_id){
						 $('#list-'+ category).addClass("active").siblings().removeClass("active");
					 }
				 }
				 , dataType: 'html'
			});
		 }
		 
		 function fnPage(no){
			 $('#pageIndex').val(no);
			 getWidgetList($('#selectCategory').val());
		 }
		 */
		 
		function fnWidgetNewEdit() {
			
			var formData = $("#widgetInfoForm").serialize();
			 
			 $.ajax({
				   type:'POST'
				 , url:'/sysMngr/screenHidden/widget/registWidgetWorkInfo.do'
				 , cache : false
				 , async : false
				 , data : formData
				 , success:function (data) {
					    if(data.head.result == 'success'){
							var layoutcntntsworkSeq = data.body.layoutcntntsworkSeq;
							
							$('input[name=layoutcntntsworkSeq]').val(layoutcntntsworkSeq);
							$('#widgetInfoForm').attr('action', '/sysMngr/screenHidden/widget/widgetEditor.do');
							$('#widgetInfoForm').attr('target', '_blank');
							$('#widgetInfoForm').submit();
							
						}else{
							var failMsg = data.body.failMsg;
							if(failMsg) {
								if(failMsg == 'nameFail') {
									alert(wz_msg('wzwg.sysMngr.msg.MSG005'));
									$('input[name=layoutcntntsNm]').focus();
									return;
								}else if(failMsg == 'fileCoursFail') {
									alert(wz_msg('wzwg.sysMngr.msg.MSG006'));
									$('input[name=sampleFileCours]').focus();
									return;
								}else if(failMsg == 'htmlCoursFail') {
									alert(wz_msg('wzwg.sysMngr.msg.MSG007'));
									$('input[name=sampleFileNm]').focus();
									return;
								}
								
							}else {
								alert(wz_msg('fail.common.msg'));
							}
						}
				 }
				 , dataType: 'JSON'
			});
			
		 }
		 
		 function fnWidgetInfoModify() {
			 
			 var formData = $("#widgetInfoForm").serialize();
			 
			 $.ajax({
				   type:'POST'
				 , url:'/sysMngr/screenHidden/widget/modifyWidgetInfoAjax.do'
				 , cache : false
				 , async : false
				 , data : formData
				 , success:function (data) {
					if(data.head.result == 'success'){
						alert(wz_msg('success.common.update'));
					}else{
						alert(wz_msg('fail.common.msg'));
					}
				 }
				 , dataType: 'JSON'
			});
		 }
		 
		 function fnFileNmChange(fileNm) {
			 var sampleFileCours = $('input[name=sampleFileCours]').val().split('/');
			 var sampleCssNm = $('input[name=sampleCssNm]').val();
			 var sampleFileNm = $('input[name=sampleFileNm]').val();
			 var category = $('select[name=category]').val();

			 $('input[name=sampleFileCours]').val('/sample/layout/contents/'+sampleFileCours[sampleFileCours.length-3]+'/'+fileNm+'/');
			 $('input[name=sampleCssNm]').val('css/'+fileNm+'.css');
			 $('input[name=sampleFileNm]').val(fileNm+'.html');
		 }
		 
		 
		 $(function() {
			 
			 //지원 레이아웃 width
			 <c:if test="${empty widget.layoutcntntsworkSeq }">
			 <c:set var="widthList" value="${fn:split(widget.width, ',')}"/>
			 </c:if>
			 <c:if test="${not empty widget.layoutcntntsworkSeq }">
			 <c:set var="widthList" value="${fn:split(widget.width, ',')}"/>
			 </c:if>
			 
			 $('input[name=width]').each(function(){
				 <c:forEach items="${widthList}" var="width">
				 	if($(this).val() == '<c:out value="${width}" />') {
				 		$(this).attr('checked',true);
				 	}
				 </c:forEach>
			 });
			 
			 //지원 레이아웃 height
			 <c:if test="${empty widget.layoutcntntsworkSeq }">
			 <c:set var="heightList" value="${fn:split(widget.height, ',')}"/>
			 </c:if>
			 <c:if test="${not empty widget.layoutcntntsworkSeq }">
			 <c:set var="heightList" value="${fn:split(widget.height, ',')}"/>
			 </c:if>
			 
			 $('input[name=height]').each(function(){
				 <c:forEach items="${heightList}" var="height">

				 	if($(this).val() == '<c:out value="${height}" />') {
				 		$(this).attr('checked',true);
				 	}
				 </c:forEach>
			 });
			 
			 previewBtnLoad();
			 
			 $('.chckBox input[type=checkbox]').on('click', function() {
				 previewBtnLoad();
			 });
			 
		 });
		 
		 function previewBtnLoad() {
			 
			 $('.inBlock button').css('display', 'none');
			 
			 $('.chckBox input[type=checkbox]').each(function(id, el){
				if($(el).is(':checked')){
					 $('.inBlock button').each(function(idx, elm) {
						 if($(el).val() == $(elm).attr('attr-val')) {
							 $(elm).css('display', '');
						 }
					 });
				 }
			 });
			 
			 $('.inBlock button').each(function(id, el) {
				 if($(el).css('display') != 'none'){
					 $(el).click();
				 }
			 });
		 }
		 
		 
		 function fnWidgetThumbUpload(el){
				var uploadFile = el;
				 if(typeof uploadFile != "undefind" && uploadFile != null) {
					 uploadFile = uploadFile.value;
				    	
					 uploadFile = uploadFile.slice(uploadFile.indexOf(".") + 1).toLowerCase(); //파일 확장자를 잘라내고, 비교를 위해 소문자로 만듭니다.
	
				        if(uploadFile != "jpg" && uploadFile != "png" && uploadFile != "gif"){ //확장자를 확인합니다.
				            alert(wz_msg('wzwg.cmm.msg.MSG126'));
				            return;
				        }else{
				        	
				        	var formData = new FormData();
				        	formData.append("thumbFile", $(el)[0].files[0]);
				        	formData.append("name", $(el).attr("id"));
				        	<c:if test="${empty widget.layoutcntntsworkSeq }">
				        	formData.append("layoutcntntsSeq", '<c:out value="${widget.layoutcntntsSeq }" />');
				        	</c:if>
				        	<c:if test="${not empty widget.layoutcntntsworkSeq }">
				        	formData.append("layoutcntntsworkSeq", '<c:out value="${widget.layoutcntntsworkSeq }" />');
				        	</c:if>
				        	
				        	$.ajax({
				                type:'POST'
				              , url:'/sysMngr/screenHidden/registWidgetThumbAjax.do'
				              , processData: false
				              , contentType: false
				              , data:formData
				              , success:function (data) {
				            	  if(data.head.result == 'success'){
				            		    var parentDiv = $(el).parent('.thum-contents');
				       					var btnHtml = '<button type="button" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetThumbDel(this, \''+$(el).attr("id")+'\')">삭제</button>';
				       					$(parentDiv).empty();
				       					$(parentDiv).append('<img src="" class="mxwd100">');
				       					$(parentDiv).find('img').attr('src', data.body.imgPath);
				       					$(parentDiv).append(btnHtml);
				       			  }else {
				       				alert(wz_msg('fail.common.msg'));
				       			  }
				                }
				              , dataType: 'json'
				          });
				        }
				    }
			}
		 
		 
		 function fnWidgetThumbDel(el, thumbFileNm){
			 if(confirm(wz_msg('wzwg.sysMngr.msg.MSG008'))) {
		        	var formData = new FormData();
		        	formData.append("thumbFileNm", thumbFileNm);
		        	<c:if test="${empty widget.layoutcntntsworkSeq }">
		        	formData.append("layoutcntntsSeq", '<c:out value="${widget.layoutcntntsSeq }" />');
		        	</c:if>
		        	<c:if test="${not empty widget.layoutcntntsworkSeq }">
		        	formData.append("layoutcntntsworkSeq", '<c:out value="${widget.layoutcntntsworkSeq }" />');
		        	</c:if>
		        	
		        	$.ajax({
		                type:'POST'
		              , url:'/sysMngr/screenHidden/deleteWidgetThumbAjax.do'
		           	  , processData: false
		              , contentType: false
		              , data:formData
		              , success:function (data) {
		            	  if(data.head.result == 'success'){
		            		 var parentDiv = $(el).parent('.thum-contents');
		            		 var inputHtml = '<input type="file" id="'+thumbFileNm+'" name="'+thumbFileNm+'" onchange="fnWidgetThumbUpload(this)">'; 
		            		 $(parentDiv).empty();
		            		 $(parentDiv).append(inputHtml);
		       			  }else {
		       				alert(wz_msg('fail.common.msg'));
		       			  }
		                }
		              , dataType: 'json'
		          });
		  	}
		 }
		 
		 function fnWidgetFileSave() {
			 
			 var htmlText = cmGetText(htmlCM);
			 var cssText = cmGetText(cssCM);
			 $("#htmlArea").html( btoa(unescape(encodeURIComponent( htmlText ))) );
			 $("#cssArea").html( btoa(unescape(encodeURIComponent( cssText ))) );
			 //$('#htmlArea').html(htmlText);
			 //$('#cssArea').html(cssText);
			 
			 var formData = $("#widgetFileForm").serialize();
			 
			 $.ajax({
	                type:'POST'
	              , url:'/sysMngr/screenHidden/widgetFileSaveAjax.do'
	              , cache : false
	         	  , async : false
	         	  , data : formData
	              , success:function (data) {
	            	  if(data.head.result == 'success'){
	            		  alert(wz_msg('wzwg.sysMngr.msg.MSG003'));
	       			  }else {
	       				alert(wz_msg('fail.common.msg'));
	       			  }
	                }
	              , dataType: 'json'
	          });
		 }
		 
		 function fnRegistWidget() {
			 if(confirm(wz_msg('wzwg.sysMngr.msg.MSG009'))) {
				 $.ajax({
		                type:'POST'
		              , url:'/sysMngr/screenHidden/registWidgetAjax.do'
		              , cache : false
		         	  , async : false
		         	  , data : $("#widgetInfoForm").serialize()
		              , success:function (data) {
		            	  if(data.head.result == 'success'){
		            		  alert(wz_msg('wzwg.sysMngr.msg.MSG010'));
		       			  }else {
		       				alert(wz_msg('fail.common.msg'));
		       			  }
		                }
		              , dataType: 'json'
		          });
			 }
		}
		 
		function fnWidgetFileMngr(){
			 $.ajax({
	                type:'POST'
	              , url:'/sysMngr/screenHidden/selectWidgetFileMngrAjax.do'
	              , cache : false
	         	  , async : false
	         	  , data : $("#widgetInfoForm").serialize()
	              , success:function (data) {
	            	  wzAjaxModal('popup_l', wz_msg('wzwg.sysMngr.word.widgImgMngr'), data);
	                }
	              , dataType: 'html'
	          });
		}
		 
		</script>
		
		
		<link rel="stylesheet" href="" id="widgetCSS">
		<style id="previewCSS"></style>
		<style>
		/* #template00>*:hover{background: rgba(200,200,200,0.5);} */
		.div_wrap > div {outline:none !important; border:1px dashed #121212; animation:none !important;}
		#widgetInfoForm + div .horizontalMoveHandler, 
		#widgetInfoForm + div .axeboxContents {opacity:0.1;}
		.addLyot, .axebox, .contentsSortHandler, .tabContentsSortHandler, .anchorHandler {display:none !important;}
		
		@media (max-width:991px){
			.sourceEditTBL th {width:100%; float:left; box-sizing:border-box; text-align: left !important; line-height: 120% !important; padding-bottom: 0 !important;}
			.sourceEditTBL td {width:100%; float:left; box-sizing:border-box; border-bottom:1px solid #ccc;}
			table.basic td>ul.inBlock li.category {width:auto;}
		}
		</style>
	</head>
	<body>
	<div class="wd100 box-border">
	<form id="widgetInfoForm" method="post">
		
		<input type="hidden" id="widgetCssNm" value="<c:out value="${widget.sampleCssNm}" />">
		<input type="hidden" id="widgetHtmlNm" value="<c:out value="${widget.sampleFileNm}" />">
		<input type="hidden" id="widgetCours" value="<c:out value="${widget.sampleFileCours}" />">
	
		<h2 class="wzAdmTit box-border p20"><spring:message code="wzwg.sysMngr.word.widgEdit" /></h2>
		<div class="p20 box-border">
			<p class="wzAdmSTit"><b><spring:message code="wzwg.sysMngr.word.widgInfo" /></b></p>
				<input type="hidden" name="layoutcntntsSeq" value="<c:out value="${widget.layoutcntntsSeq }" />">
				<input type="hidden" name="layoutcntntsworkSeq" value="<c:out value="${widget.layoutcntntsworkSeq }" />">
				
				<table summary="<spring:message code="wzwg.sysMngr.word.widgInfo" />" class="basic">
					<tbody>
						<tr>
							<th><spring:message code="wzwg.cmm.word.ctgry02" /></th>
							<td><select name="category">
									<c:forEach items="${widgetCategoryList }" var="list">
										<option value="<c:out value="${list.codeNm}" />"<c:if test="${list.codeNm eq widget.category}"> selected</c:if>><c:out value="${list.codeAbrvNm }" /></option>
									</c:forEach>
								</select>
								<p class="grey mt10">* <spring:message code="wzwg.sysMngr.msg.MSG011" /></p>
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.widgNm02" /></th>
							<td><input type="text" name="layoutcntntsNm" value="<c:out value="${widget.layoutcntntsNm}" />"></td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.widgFileNm02" /></th>
							<td>
								<input id="fileNm" type="text" value="${fn:replace(widget.sampleFileNm,'.html','')}" onkeyup="fnFileNmChange(this.value)"> 
								<span class="grey"><spring:message code="wzwg.sysMngr.msg.MSG012" /></span>
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.widgDc" /></th>
							<td>
								<input type="text" class="wd80" name="layoutcntntsDc" value="<c:out value="${widget.layoutcntntsDc}" />">
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.widgFileCours" /></th>
							<td>
								<input type="text" class="wd80" name="sampleFileCours" value="<c:out value="${widget.sampleFileCours}" />">
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.cssFileCours" /></th>
							<td>
                    			<input type="text" name="sampleCssNm" value="<c:out value="${widget.sampleCssNm}" />>
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.htmlFileCours" /></th>
							<td>
                    			<input type="text" name="sampleFileNm" value="<c:out value="${widget.sampleFileNm}" />">
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.suportLayout" />(WIDTH)</th>
							<td>
								<ul class="wzForm chckBox">
									<li><label><input type="checkbox" name="width" value="25" /> <span class="spanLabel">25</span></label></li>
									<li><label><input type="checkbox" name="width" value="33" /> <span class="spanLabel">33</span></label></li>
									<li><label><input type="checkbox" name="width" value="50" /> <span class="spanLabel">50</span></label></li>
									<li><label><input type="checkbox" name="width" value="66" /> <span class="spanLabel">66</span></label></li>
									<li><label><input type="checkbox" name="width" value="100" /> <span class="spanLabel">100</span></label></li>
								</ul>
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.suportLayout" />(HEIGHT)</th>
							<td>
								<ul class="wzForm chckBox">
									<li><label><input type="checkbox" name="height" value="L" /> <span class="spanLabel">L</span></label></li>
									<li><label><input type="checkbox" name="height" value="M" /> <span class="spanLabel">M</span></label></li>
									<li><label><input type="checkbox" name="height" value="H" /> <span class="spanLabel">H</span></label></li>
								</ul>
							</td>
						<tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
							<td>
								<ul class="wzForm">
									<li><label><input type="radio" name="useAt"<c:if test="${widget.useAt eq 'Y'}"> checked</c:if> value="Y"> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
									<li><label><input type="radio" name="useAt"<c:if test="${widget.useAt eq 'N'}"> checked</c:if> value="N"> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
									<li><span class="grey"><spring:message code="wzwg.sysMngr.msg.MSG013" /></span></li>
								</ul>
							</td>
						<tr>
					</tbody>
				</table>
				<div class="rt-box">
					<button type="button" class="wzbtn btn-save" onclick="fnWidgetInfoModify()"><spring:message code="wzwg.sysMngr.word.widgInfoUpdt" /></button>
					<c:if test="${empty widget.layoutcntntsworkSeq }">
						<button type="button" class="wzbtn btn-basic" onclick="fnWidgetNewEdit()"><spring:message code="wzwg.sysMngr.word.newWidgCreate" /></button>
					</c:if>
				</div>
		</div>
		
		
		<br><br>
		<div class="p20 box-border">
			<p class="wzAdmSTit wd100"><b><spring:message code="wzwg.cmm.word.thumb" /></b></p>
			<div class="widgetThumb wd100 pl20 pr20 box-border">
				<p class="admpg-subp w100 fl txt-l mb15">
					<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.sysMngr.msg.MSG014" />
				</p>
				<table class="basic-table" style="table-layout:fixed;">
					<thead>
						<tr>
							<th><spring:message code="wzwg.cmm.word.low" /></th>
							<th><spring:message code="wzwg.cmm.word.middle" /></th>
							<th><spring:message code="wzwg.cmm.word.high" /></th>
							<th><spring:message code="wzwg.cmm.word.wide" /></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="padding:12px 10px;" class="thum-contents">
								<c:choose>
									<c:when test="${not empty widget.thumbLPath}">
                                		<img src="<c:out value="${widget.thumbLPath}" />" class="mxwd100">
										<button type="button" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetThumbDel(this, 'thumbLPath')"><spring:message code="wzwg.cmm.word.delete" /></button>
									</c:when>
									<c:otherwise>
										<input type="file" id="thumbLPath" name="thumbLPath" onchange="fnWidgetThumbUpload(this)" class="wd100">
									</c:otherwise>
								</c:choose>
							</td>
							<td style="padding:12px 10px;" class="thum-contents">
								<c:choose>
									<c:when test="${not empty widget.thumbMPath}">
                                	<img src="<c:out value="${widget.thumbMPath}" />" class="mxwd100">
									<button type="button" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetThumbDel(this, 'thumbMPath')"><spring:message code="wzwg.cmm.word.delete" /></button>
									</c:when>
									<c:otherwise>
										<input type="file" id="thumbMPath" name="thumbMPath" onchange="fnWidgetThumbUpload(this)" class="wd100">
									</c:otherwise>
								</c:choose>
							</td>
							<td style="padding:12px 10px;" class="thum-contents">
								<c:choose>
									<c:when test="${not empty widget.thumbHPath}">
                                		<img src="<c:out value="${widget.thumbHPath}" />" class="mxwd100">
										<button type="button" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetThumbDel(this, 'thumbHPath')"><spring:message code="wzwg.cmm.word.delete" /></button>
									</c:when>
									<c:otherwise>
										<input type="file" id="thumbHPath" name="thumbHPath" onchange="fnWidgetThumbUpload(this)" class="wd100">
									</c:otherwise>
								</c:choose>
							</td>
							<td style="padding:12px 10px;" class="thum-contents">
								<c:choose>
									<c:when test="${not empty widget.thumbWPath}">
                               			<img src="<c:out value="${widget.thumbWPath}" />" class="mxwd100">
										<button type="button" class="btn-delete iconOnlyBtn btn-basic" onclick="fnWidgetThumbDel(this, 'thumbWPath')"><spring:message code="wzwg.cmm.word.delete" /></button>
									</c:when>
									<c:otherwise>
										<input type="file" id="thumbWPath" name="thumbWPath" onchange="fnWidgetThumbUpload(this)" class="wd100">
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		
		
		</form>
		<div class="mt50 mb50">
			<div class="p20 box-border">
				<p class="wzAdmSTit"><b>Preview</b></p>
				<p class="admpg-subp w100 fl txt-l mb15 pl20 linehgt25">
					<span class="circle_no bg-green-strong">i</span>
					<span><spring:message code="wzwg.sysMngr.msg.MSG015" /></span><br>
					<span class="ml25"><spring:message code="wzwg.sysMngr.msg.MSG016" /></span><br>
					<span class="ml25"><spring:message code="wzwg.sysMngr.msg.MSG017" /></span>
				</p>
				<table summary="<spring:message code="wzwg.sysMngr.word.widgPreview" />" class="basic">
						<tbody>
							<tr>
								<th><spring:message code="wzwg.cmm.word.ar" /></th>
								<td>
									<ul class="inBlock">
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('100', this)" attr-val="100"><span>100%</span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('66', this)" attr-val="66"><span>66%</span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('50', this)" attr-val="50"><span>50%</span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic on" onclick="previewChange('33', this)" attr-val="33"><span>33%</span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('25', this)" attr-val="25"><span>25%</span></button>
										</li> 
									</ul>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.hg" /></th>
								<td>
									<ul class="inBlock">
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('L', this)" attr-val="L"><span><spring:message code="wzwg.cmm.word.low" /></span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic on" onclick="previewChange('M', this)" attr-val="M"><span><spring:message code="wzwg.cmm.word.middle" /></span></button>
										</li> 
										<li class="category" style="margin-right:10px;">
											<button type="button" class="wzbtn btn-basic" onclick="previewChange('H', this)" attr-val="H"><span><spring:message code="wzwg.cmm.word.high" /></span></button>
										</li> 
									</ul>
								</td>
							</tr>
							<tr>
								<td colspan="2"><button type="button" class="wzbtn btn-basic" onclick="widgetLoad()"><spring:message code="wzwg.sysMngr.word.widgRefresh" /></button></td>
							</tr>
						</tbody>
				</table>
			</div>
			
			<div class="contents">
				<div class="inner">
					<div id="template00">
						<div class="layout_wrap wzwgContextMenu layout_wrap_border" style="padding-top:0 !important;">
							<div class="div_wrap layout_block1">
								<div class="layout_03 layout_height_M layout_contents_border" data-w="33" data-h="M" id="preview">
								<spring:message code="wzwg.sysMngr.word.widgRelm" />
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
		
		<div class="mt50 fl box-border p20 wd100">
		<form id="widgetFileForm">
			<input type="hidden" name="layoutcntntsSeq" value="<c:out value="${widget.layoutcntntsSeq}" />">
			<input type="hidden" name="layoutcntntsworkSeq" value="<c:out value="${widget.layoutcntntsworkSeq}" />">

			<p class="wzAdmSTit"><b><spring:message code="wzwg.sysMngr.word.srcEditRelm" /></b></p>
			<div class="widgerCnrlBx pl20">
				<button type="button" class="wzbtn btn-basic" onclick="previewSrcUpload()"><spring:message code="wzwg.sysMngr.word.previewUpload" /></button>
				<button type="button" class="wzbtn btn-basic" onclick="previewSrcDown();"><spring:message code="wzwg.sysMngr.word.previewDwld" /></button>
				<button type="button" class="wzbtn btn-save" onclick="fnWidgetFileSave()"><spring:message code="wzwg.sysMngr.word.fileStre" /></button>
				<a href="https://docs.google.com/spreadsheets/d/1bASbASP2PxJzShA8f5dFoodKUysMB6bz/edit#gid=514230686" target="_blank" class="wzbtn btn-green-bg"><spring:message code="wzwg.sysMngr.word.widgPrgm02Rule" /></a>
				
				<button type="button" class="wzbtn btn-green fr" onclick="fnWidgetFileMngr()"><spring:message code="wzwg.sysMngr.word.widgImgMngr" /></button>
			</div>
			<p class="admpg-subp w100 fl txt-l mb15 mt15 pl20">
				<span class="circle_no bg-green-strong">i</span>
				<span><spring:message code="wzwg.sysMngr.msg.MSG018" /></span><br>
				<span class="circle_no bg-green-strong">i</span>
				<span><spring:message code="wzwg.sysMngr.msg.MSG019" /></span>
				<a></a>
			</p>
			<!-- 
			<p >
				<label for="select" title="클릭후 방향키(위/아래)를 이동하면 테마가 변경됩니다.">Select a theme: </label>
				<select onchange="selectTheme()" id="select"></select>
			</p>
			 -->
			 
			<table summary="<spring:message code="wzwg.sysMngr.word.srcEditRelm" />" class="basic mt20 sourceEditTBL">
					<tbody>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.htmlEditRelm" /></th>
							<td><div id="htmlSrcBox" style="height: 500px;"><textarea id="htmlArea" name="htmlCn"></textarea></div></td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.sysMngr.word.cssEditRelm" /></th>
							<td><div id="cssSrcBox" style="height: 500px;"><textarea id="cssArea" name="cssCn"></textarea></div></td>
						</tr>
					</tbody>
			</table>
			 
			<c:if test="${not empty widget.layoutcntntsworkSeq }">
				<button type="button" class="wzbtn btn-basic" onclick="fnRegistWidget()"><spring:message code="wzwg.sysMngr.word.widgCreate" /></button>
			</c:if>
		</form>
		</div>
		
		<div style="height: 20px;"></div>
		<c:import url="/WEB-INF/jsp/wzwg/webModule/wzwgContextMenu.jsp"></c:import>
		<jsp:include page="/WEB-INF/jsp/wzwg/site/mngr/screen/siteScreenTempltDialogImp.jsp"></jsp:include>
		
		</div>
	</body>
</html>
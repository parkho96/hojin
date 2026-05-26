<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
		<!-- <script src="/assets/ace/src-noconflict/ace.js" type="text/javascript" charset="utf-8"></script> -->
		<!-- <script src="/assets/ace/theme/twilight.js" type="text/javascript" charset="utf-8"></script> -->
		
		<!-- 위즈위그 메시지 로드 -->
	  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
	  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
		
		<link rel="stylesheet" href="/css/wzwg/sysMngr/screen/widgetMngr.css" type="text/css" />
		
		<script>
			$(document).ready(function(){
				/* 위즈위그 메시지 로드 */
				onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
				
				getWidgetList('work');
			})
				
		 function fnSetCatrgoryCnt(){
				$.ajax({
					   type:'POST'
					 , url:'/sysMngr/screen/widget/widgetCategoryCntAjax.do'
					 , cache : false
					 , async : false
					 , data : {}
					 , success:function (data) { 
						 //console.log(data);
						 var widgetCategoryList = data.body.widgetCategoryCntList;
						 var sumCnt = 0;
						 for (var i = 0; i < widgetCategoryList.length; i++) {
							 var category = widgetCategoryList[i];
							 var widgetCnt = $('.widget-layout').find('.' + category.category);
							 if(widgetCnt.length > 0){
								 $(widgetCnt).find('span').remove();
								 widgetCnt.append($('<span class="circle_badge bg-grey-strong fs12">' + category.categoryCnt + '</span>'));
								 if(category.category != 'work'){
									 sumCnt += parseInt(category.categoryCnt);
								 }
								 
							 }
						 }
						 
						 $('#categoryCnt').html(sumCnt);
					 }
					 , dataType: 'json'
				});
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
			
		function selectTheme() {
		    var theme = $("#select option:selected").text();
		    //console.log(theme);
		    //var theme = $("#select").options[$("#select").selectedIndex].textContent;
		    mEditor.setOption("theme", theme);
		    //location.hash = "#" + theme;
		}
		 
			
		/*  var aceEditor; 
		 function aceEditorInit(loadCss){
			 aceEditor.setValue("");
			 aceEditor.setValue(loadCss.html());
			 //aceEditor = ace.edit("srcEditor");
		 } */
			

		 
		 function getWidgetList(_category){
			 	 $('#category').val(_category);
				 $.ajax({
					   type:'POST'
					 , url:'/sysMngr/screen/widget/selectWidgetListAjax.do'
					 , cache : false
					 , async : false
					 , data : $("#widgetForm").serialize()
					 , success:function (data) { 
						 $('#item-list').html(data);
						 
						 fnSetCatrgoryCnt();
						 if(_category){
							 $('#list-'+ _category).addClass("active").siblings().removeClass("active");
						 }
					 }
					 , dataType: 'html'
				});
		 }
		 
		 function fnPage(no){
			 
			 if(isNaN(no)){
				console.log('잘못된 페이지호출');
				return;
			}
			 
			 $('#widgetForm #pageIndex').val(no);
			 getWidgetList($('#category').val());
		 }
		 
		 function fnWidgetEdit(keyword, seq){
			 if(keyword == 'edit') {
				 $('#layoutcntntsworkSeq').val('');
				 $('#layoutcntntsSeq').val(seq);
			 }else if(keyword == 'work'){
				 $('#layoutcntntsSeq').val('');
				 $('#layoutcntntsworkSeq').val(seq);
			 }
			 
			 $('#widgetForm').attr('action', '/sysMngr/screenHidden/widget/widgetEditor.do');
			 $('#widgetForm').attr('target', '_blank');
			 $('#widgetForm').submit();
		 }
		 

		 function fnWidgetDel(keyword, seq) {
			 if(keyword == 'edit') {
				 $('#layoutcntntsSeq').val(seq);
			 }else if(keyword == 'work'){
				 $('#layoutcntntsworkSeq').val(seq);
			 }
			 
			 if(confirm(wz_msg('wzwg.sysMngr.msg.MSG032'))) {
				 $.ajax({
					   type:'POST'
					 , url:'/sysMngr/screenHidden/deleteWidgetAjax.do'
					 , cache : false
					 , async : false
					 , data : $("#widgetForm").serialize()
					 , success:function (data) {
						 if(data.head.result == 'success'){
							 alert(wz_msg('wzwg.sysMngr.msg.MSG028'));
							 fnPage(1);
							 fnSetCatrgoryCnt();
						 }else if(data.head.result == 'fail') {
							 alert(wz_msg('wzwg.sysMngr.msg.MSG033'));
							 return;
						 }
					 }
					 , dataType: 'json'
				});
			}
		 }
		</script>
		
		<h3 class="fs22 block mt20 mb30"><spring:message code="wzwg.sysMngr.word.widgMngr02" /></h3>
		<div class="wz_notice brbox bg-white br-blue-strong">	
		    <ul class="wd100">
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.sysMngr.msg.MSG034" /> <span class="gray fs14">(<spring:message code="wzwg.sysMngr.msg.MSG035" />)</span></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.sysMngr.msg.MSG036" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.sysMngr.msg.MSG037" /></li>
			    <li class="admpg-subp wd100">· <spring:message code="wzwg.sysMngr.msg.MSG038" /></li>
		    </ul>
		</div>
		<form id="widgetForm" method="post">
			<input type="hidden" id="pageIndex" name="pageIndex" value="1">
			<input type="hidden" id="category" name="category">
			<input type="hidden" id="layoutcntntsSeq" name="layoutcntntsSeq" >
			<input type="hidden" id="layoutcntntsworkSeq" name="layoutcntntsworkSeq" >
			
			<select name="useAt" id="useAt" class="w10" title="사용여부 구분"> 
				<option value="" <c:if test="${paramVO.useAt eq ''}"> selected</c:if>>사용여부 선택</option>
				<option value="Y" <c:if test="${paramVO.useAt eq 'Y'}"> selected</c:if>>사용</option>
				<option value="N" <c:if test="${paramVO.useAt eq 'N'}"> selected</c:if>>미사용</option>
			</select>
			
			<select name="searchCondition" id="searchCondition" class="w10" title="검색 구분"> 
				<option value="" <c:if test="${paramVO.searchCondition eq ''}"> selected</c:if>><spring:message code="wzwg.cmm.word.all" /></option>
				<option value="1" <c:if test="${paramVO.searchCondition eq '1'}"> selected</c:if>>위젯 <spring:message code="wzwg.cmm.word.nm01" /></option>
				<option value="2" <c:if test="${paramVO.searchCondition eq '2'}"> selected</c:if>>지원 레이아웃(WIDTH)</option>
				<option value="3" <c:if test="${paramVO.searchCondition eq '3'}"> selected</c:if>>지원 레이아웃(HEIGHT)</option>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>

			<input type="text" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />" title="검색어" class="txt w30" placeholder="<c:out value="${srchwrd}" />" onkeydown="if(event.keyCode == 13){fnPage('1');}" />
			<a href="javascript:void(0);" onclick="fnPage('1');" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>
			
			<select name="sortCondition" id="sortCondition" class="w5 fr" title="정렬 구분" onchange="fnPage('1');">
				<option value="" <c:if test="${paramVO.sortCondition eq ''}"> selected</c:if>>정렬순서</option> 
				<option value="1" <c:if test="${paramVO.sortCondition eq '1'}"> selected</c:if>>위젯명</option>
				<option value="2" <c:if test="${paramVO.sortCondition eq '2'}"> selected</c:if>>등록일</option>
			</select>
		</form>
		
		<div class="mb10 mt15"><span class="circle_no bg-green-strong">!</span>사용중인 위젯은 총 <b id="categoryCnt"></b>개 입니다.</div>
		<div class="widget-layout wztab wztabLine">
			<ul class="wztab-list">
				<li id="list-work" class="i-block wztab-item active">
					<button type="button" onclick="getWidgetList('work')">
					<span class="work">작업중</span>
					</button>
				</li>
				<c:forEach items="${widgetCategoryList }" var="list">
					<c:if test="${list.codeNm ne 'table' }">
						<li id="list-<c:out value='${list.codeNm}' />" class="i-block wztab-item">
							<button type="button" onclick="getWidgetList('<c:out value="${list.codeNm}" />')">
							<%-- <img src="/images/wzwg/wizmaker/widget_${list.codeAbrvNm }.png"> --%>
							<span class="<c:out value='${list.codeNm}' />"><c:out value="${list.codeAbrvNm}" /></span>
							</button>
						</li>
					</c:if>
				</c:forEach>
			</ul>
		
		</div>
		
		<!-- 
		<div class="mt20">
			<button type="button" class="wzbtn btn-basic">새로만들기</button> 
		</div>
		 -->
		 
		<div id="item-list"> 
		
		</div>

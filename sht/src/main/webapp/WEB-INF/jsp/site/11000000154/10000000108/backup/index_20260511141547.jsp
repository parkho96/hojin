<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:choose>                                                                                                       
	<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">                                         
		<c:import url="/subsite/${subsiteKey}/topMenu.do"></c:import>                                              
	</c:when>                                                                                                      
	<c:otherwise>                                                                                                  
		<c:import url="/site/${sessionScope.SITE_SEQ}/topMenu.do"></c:import>                                      
	</c:otherwise>                                                                                                 
</c:choose>                                                                                                      
<div class="content" id="content">  
	<link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet">
	<link type="text/css" href="/sample/template/wide/wide012/css/style.css" rel="stylesheet">
	<link rel="stylesheet" href="/sample/template/wide/wide012/css/swiper.min.css">
  
  	<script src="/sample/template/wide/wide012/js/tendina.min.js"></script>
  	<script src="/sample/template/wide/wide012/js/swiper.jquery.min.js"></script>
  	
	<script type="text/javascript">
		
		function templateReady(){
			 $('#templateFix .contentsSortHandler').remove();
			 $('#templateFix .itemSortHandler').remove();
			 $('#templateFix .axebox').remove();
			 
			 /* 레이아웃 내에서 컨텐츠 이동 */
			 $('#templateFix .layout_wrap .div_wrap').each(function(){
					$(this).children().each(function(){
						//console.log(this);
						//console.log($(this).html().replace(/<!--[^>](.*?)-->/g,"").trim());
						if($(this).html().replace(/<!--[^>](.*?)-->/g,"").trim() == ''){
							$(this).append(addDiv);
						}
						
						if(($(this).hasClass('axeboxContents') || $(this).hasClass('axebox_null')) == false){
							//console.log('add itemSortHandler');
							$(this).prepend('<div class="axeboxContents">x</div>')

							if($(this).hasClass('layout_01')){
								return;
							}else{
								$(this).prepend('<div class="itemSortHandler horizontalMoveHandler" style="z-index:2;">⇄</div>')
							}
						}
					});
					$(this).sortable({
						handle : '.itemSortHandler', 
						revert:false ,
				    	opacity :0.7,
				    	stop: function( event, ui ) {
				    		//console.log(event);
				    		//console.log(ui.item.context);
				    		var item = ui.item.context;
				    		$(item).css('position', '');
				    		$(item).css('top', '');
				    		$(item).css('left', '');
				    	}
					})
			  });
			 
			 /* 레이아웃 핸들러 추가 */
			 //$('#templateFix .layout_wrap').prepend('<div class="axebox">x</div>'); //레이아웃 삭제를 위한 핸들러
			 $('#templateFix .layout_wrap').prepend('<div class="contentsSortHandler">↕</div>'); //컨텐츠 이동을 위한 핸들러 추가
			 
			 /* 여백 핸들러 추가 */
			// $('#templateFix .empty').prepend('<div class="axebox">x</div>'); //레이아웃 삭제를 위한 핸들러
			// $('#templateFix .empty>.axebox').before('<div class="contentsSortHandler">↕</div>'); //컨텐츠 이동을 위한 핸들러 추가
			 
			 /* 라인 핸들러 추가 */
			 //$('#templateFix .between_line').prepend('<div class="axebox">라인삭제</div>'); //레이아웃 삭제를 위한 핸들러
			 //$('#templateFix .between_line>.axebox').before('<div class="contentsSortHandler">↕</div>'); //컨텐츠 이동을 위한 핸들러 추가
			 
			 
			 $('#templateFix .div_wrap').each(function(){
				 if($(this).parent().attr("id")=="templateFix"){
					 $(this).wrap("<div class='sortWrapAll' style='width:100%;float:left;'>");
				 }
			 });	 
			 
			 $('#templateFix').sortable({
			    	handle : '.contentsSortHandler', 
			    	revert:false ,
			    	opacity :0.7
			    });// 컨텐츠 이동 스크립트

			 /* 삭제버튼 기능 추가 */
			 $('#templateFix .div_wrap .axeboxContents').click(function(){
				 if(confirm('컨텐츠를 삭제합니까?\n\n컨텐츠는 다시 추가하실 수 있습니다.')){
					 $(this).parent().children().each(function(){
						 if($(this).hasClass('axeboxContents') || $(this).hasClass('itemSortHandler')){
							 
						 } else{
							 $(this).remove();
						 }
					 });
					 $(this).parent().append(addDiv);
				 }
			 });
			 
			/*  $('#templateFix .layout_wrap>.axebox').click(function(){
				 if(confirm('레이아웃을 삭제하면 안에 작업된 컨텐츠까지 삭제 됩니다.\n\n레이아웃을 삭제 합니까?')){
					 if($(this).parent().hasClass('layout_wrap')){
						 $(this).parent().remove();
					 }
				 }
			 });
			 $('#templateFix .empty>.axebox').click(function(){
				 if(confirm('레이아웃 간격을 삭제합니까?')){
					 if($(this).parent().hasClass('empty')){
						 $(this).parent().remove();
					 }
				 }
			 });
			 $('#templateFix .between_line>.axebox').click(function(){
				 if(confirm('구분선을 삭제합니까?')){
					 if($(this).parent().hasClass('between_line')){
						 $(this).parent().remove();
					 }
				 }
			 }); */
		}
		
		function templateSave(){
			 $('#templateFix .itemSortHandler').remove();
			 $('#templateFix .contentsSortHandler').remove();
			 $('#templateFix .axeboxContents').remove();
			 $('#templateFix .axebox').remove();
			 try{$('#templateFix').sortable('destroy');}catch(e){}
			 try{
				 $('#templateFix .div_wrap').each(function(){
					 $(this).sortable('destroy');
				 });
			 }catch(e){}
			 
			
		}
	</script>

	<div id="cssZone" style="display:none;"><link rel="stylesheet" href="/sample/layout/contents/board/board122/css/board122.css" type="text/css" id="CSS_10000000239"><link rel="stylesheet" href="/sample/layout/contents/quick/quick114/css/quick114.css" type="text/css" id="CSS_10000000168"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick128/css/widequick128.css" type="text/css" id="CSS_10000000240"><link rel="stylesheet" href="/sample/layout/contents/mvp/mvp113_2/css/mvp113_2.css" type="text/css" id="CSS_10000000241"><link rel="stylesheet" href="/sample/layout/contents/etc/etc114/css/etc114.css" type="text/css" id="CSS_10000000122"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_025/css/slide_bnr_025.css" type="text/css" id="CSS_10000000519"><link rel="stylesheet" href="/sample/layout/contents/quick/quick138/css/quick138.css" type="text/css" id="CSS_10000000351"><link rel="stylesheet" href="/sample/layout/contents/etc/bnrSlide007/css/bnrSlide007.css" type="text/css" id="CSS_10000000535"><link rel="stylesheet" href="/sample/layout/contents/etc/bnrSlide006/css/bnrSlide006.css" type="text/css" id="CSS_10000000486"></div>
	<div class="contents">
		<div class="wide12_mainbox wide012MV">
<div class="mainVisual">
			<div class="wzwg-slide-info mainSlider_001 wzwgContextMenu" data-autoplay="auto" data-effect="fade" data-slidecnt="2"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 자동<br>화면전환 : 페이드<br>반복재생 : 진행</p></span></div>
				<div class="wzwg-slide-data"><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0">
						
							<img src="/sample/template/wide/wide012/img/bg_banner.jpg" alt="" style="width: 100%; height: 100%;">
							
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="1">
						
							<img src="/sample/template/wide/wide012/img/img_main02.jpg" alt="" style="width: 100%; height: 100%;">
							
					</div></div>
				

				
				<div class="swiper-pagination-center">
					
					<div class="indicator" style="display: block;">
						<button class="play" style="display: none;" type="button">시작</button>		
						<button class="stop off" style="display: inline-block;" type="button">멈춤</button>				
					</div>
				</div>

				
				
								
						
				<div class="sampleSlide" style="display: none;">
					<div class="slide_wrap wzwgContextMenu" style="width: auto;">
						
							<img src="/sample/template/wide/wide012/img/main01.jpg" alt="">
							
					</div>
				</div>
			</div>	  
    </div><div id="templateFix" class="inner_layer">
			<!-- 간격없는 2단 -->
			
			
			<div class="layout_wrap wzwgContextMenu layout_wrap_border">
						<div class="div_wrap layout_block1 mxwd100" style="
    max-width: 100%;
">
							<div class="layout_01 layout_contents_border" data-w="100" data-h="M">

	

						
	

						
	


   
 

						
	

	

		
	


	


	<div class="slide_bnr_025 wzwgWidget" data-id="10000000519" data-nm="슬라이드배너025">
		<div class="wzwg-slide-info wzwgContextMenu" data-slidesperview="3" data-slidesperview-mobile="1" data-loop="false" data-slidecnt="5"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 안함</p></span></div>
			<div class="wzwg-slide-data changeBg"><a class="wzwgContextMenu" href="javascript:void(0);" data-type="slide" data-index="0" tabindex="0">
					<div class="imgbox"><!-- 이미지 변경 -->
						<img src="/sample/template/wide/wide012/img/01.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign" style="text-align: center;">
						<h3 class="tit fs16 bTitle">새내기 대학생활 팁</h3>
					</div>
				</a><a class="wzwgContextMenu" href="javascript:void(0);" data-type="slide" data-index="1" tabindex="0">
					<div class="imgbox">
						<img src="/sample/template/wide/wide012/img/02.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign" style="text-align: center;">
						<h3 class="tit fs16 bTitle">OOOO 입시설명회</h3>
					</div>
				</a><a class="wzwgContextMenu" href="javascript:void(0);" data-type="slide" data-index="2" tabindex="0">
					<div class="imgbox">
						<img src="/sample/template/wide/wide012/img/03.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign" style="text-align: center;">
						<h3 class="tit fs16 bTitle">OO대학 취업컨설팅</h3>
					</div>
				</a><a class="wzwgContextMenu" href="javascript:void(0);" data-type="slide" data-index="3" tabindex="-1">
					<div class="imgbox">
						<img src="/sample/template/wide/wide012/img/04.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign" style="text-align: center;">
						<h3 class="tit fs16 bTitle">글로벌 인턴사원 모집</h3>
					</div>
				</a><a class="wzwgContextMenu" href="javascript:void(0);" data-type="slide" data-index="4" tabindex="-1">
					<div class="imgbox">
						<img src="/sample/template/wide/wide012/img/05.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign" style="text-align: center;">
						<h3 class="tit fs16 bTitle">AI 탐구 동아리원 모집</h3>
					</div>
				</a></div>

			<div class="sampleSlide" style="display:none">
				<a class="wzwgContextMenu" href="javascript:void(0);">
					<div class="imgbox">
						<img src="/sample/layout/contents/slide/slide_bnr_025/img/01.jpg" alt="">
					</div>
					<div class="txtbox targetBG bTextAlign">
						<h3 class="tit fs16 bTitle">슬라이드 제목을 입력하세요</h3>
					</div>
				</a>
			</div>
		</div>
	</div>

</div>
						</div>
					</div>

		</div></div>  

		<!--  비쥬얼위 컨텐츠고정 영역  -->
		<!-- end templateFix -->
			
		<!--  -->
		<!--  -->
		<div class="inner">
			<div id="template00" class="removeAxeboxZone addContentZone">
				
				
				
 	
				
 	
				
 	
				
 				

		 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					<div class="layout_wrap wzwgContextMenu layout_wrap_border">
						<div class="div_wrap layout_block1" style="max-width: 100%;">
							<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
	<div class="widequick128 quickBannerConfZone noChangeBg wzwgWidget" data-maxitem="7" data-id="10000000240" data-nm="와이드퀵128-hexagon style">
    
    
    <div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>

		    <div class="wq123_cowrap">
		    	<div class="bgbox">  
			        <img class="qImgBg" src="/sample/layout/contents/quick/widequick128/img/bg.jpg" alt=""> <!-- 배경이미지 -->
			    </div>	
			    <div class="wq128_innerwrap qTargetBG" style="background-color: rgb(255, 255, 255);"> <!-- 배경색상 변경가능 -->
					<div class="wq128_innerbox quickBannerZone">
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(252, 173, 80);"> <!-- 동그라미 색상변경가능 -->
									<img class="bIcon" src="/sample/template/wide/wide012/img/01.png" alt=""> <!-- 아이콘 변경가능 -->
								</div>
								<h3 class="bTitle">학과안내</h3> <!-- 퀵메뉴 제목 (글자색상변경 가능)   -->
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(239, 99, 84);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/02.png" alt=""> 
								</div>
								<h3 class="bTitle">학교안내</h3> 
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(110, 104, 226);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/03.png" alt=""> 
								</div>
								<h3 class="bTitle">학교생활</h3> 
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(252, 173, 80);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/04.png" alt=""> 
								</div>
								<h3 class="bTitle">동아리안내</h3> 
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(252, 173, 80);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/05.png" alt=""> 
								</div>
								<h3 class="bTitle">행정지원</h3> 
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(252, 173, 80);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/06.png" alt=""> 
								</div>
								<h3 class="bTitle">취업센터</h3> 
							</a>
						</div>
						<div class="quickTxtLinkBG wzwgContextMenu" data-type="quick"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg" style="background-color: rgb(252, 173, 80);"> 
									<img class="bIcon" src="/sample/template/wide/wide012/img/07.png" alt=""> 
								</div>
								<h3 class="bTitle">커뮤니티</h3> 
							</a>
						</div>
						


					</div>
						
					<div class="quick_sample" style="display:none">
						<div class="quickTxtLinkBG wzwgContextMenu"> 
							<a href="javascript:void(0);">
								<div class="wq128_hexagon changeBg"> 
									<img class="bIcon" src="/sample/layout/contents/quick/widequick128/img/icon08.png" alt=""> 
								</div>
								<h3 class="bTitle">퀵메뉴 제목</h3> 
							</a>
						</div>
					</div>
					
					
				</div>

			</div>	

				
		
	</div>
</div>
						</div>
					</div>
						
				 	
			            		
								

			            	
			            		
								

			            	
 	
 					
 	
					<div class="layout_wrap wzwgContextMenu layout_wrap_border">
						
						<div class="div_wrap layout_block3 layout_block3_2 layout_padding">
							<div class="layout_02 layout_contents_border layout_height_M" data-w="50" data-h="M">
	

	

	<div class="board122 wzwg-tab-board wzwgContextMenu changeBg wzwgWidget" data-id="10000000239" data-nm="게시판122"> <!-- (배경색상 변경가능) -->
		<ul class="board_wrap wzwg-tab-list">
			<li class="li wzwg-tab"> <!-- 게시판 1개 -->
				<div class="cntContextSGC0000027 noChangeBg boardTabBg">
					<h3>
						<a href="javascript:;" class="board_name menuNm">공지사항</a> <!-- 게시판 탭부분 배경색상변경가능 (활성화탭은 흰색고정임) -->
					</h3>
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bMoreTextColOnly">+</a> <!-- 해당 게시판으로 넘어가는 링크 -->
					</div>

					<ul class="boardBg" id="data">  <!-- 게시글나오는 박스부분 배경색상 변경 -->
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox boardBrdrBg">
								<p class="tit" data-attr="nttSj">첫번째 탭의 게시판 글들이 노출됩니다.</p> <!-- (p:글자색상변경 가능) -->
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>

						<li class="no_data" style="display:none;"> <!-- 글 없을때 노출값 -->
							<div class="txtbox">
				            	<p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        	</div>
				        </li>
					</ul>
				</div>
			</li>


			<li class="li wzwg-tab"> <!-- 게시판 2개 -->
				<div class="cntContextSGC0000027 noChangeBg boardTabBg">
					<h3>
						<a href="javascript:;" class="board_name menuNm">언론보도</a> 
					</h3>
					
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bMoreTextColOnly">+</a> 
					</div>
					<ul class="boardBg" id="data">
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">두번째 탭의 게시판 글들이 노출됩니다.</p>
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>

						<li class="no_data" style="display:none;">
							<div class="txtbox">
				            	<p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        	</div>
				        </li>
					</ul>
				</div>
			</li>


			<li class="li wzwg-tab active"> <!-- 게시판 3개 -->
				<div class="cntContextSGC0000027 noChangeBg boardTabBg">
					<h3>
						<a href="javascript:;" class="board_name menuNm">질문답변</a> 
					</h3>
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bMoreTextColOnly">+</a> 
					</div>
					
					<ul class="boardBg" id="data">
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">세번째 탭의 게시판 글들이 노출됩니다.</p>
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>
						<li><a href="javascript:;" data-href="bbsViewLink">
							<div class="txtbox">
								<p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p> 
								<span class="date" data-attr="frstRegistPnttm">2020.00.00</span>
							</div></a>
						</li>

						<li class="no_data" style="display:none;">
							<div class="txtbox">
				            	<p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        	</div>
				        </li>
					</ul>
				</div>
			</li>
		</ul>
	</div>
</div>
							<div class="layout_04 layout_04ml layout_contents_border layout_height_M" data-w="25" data-h="M">

	

<div class="quick138 quickBannerConfZone qBorderBg wzwgWidget" data-maxuseat="Y" data-hmaxitem="12" data-mmaxitem="8" data-lmaxitem="4" data-wmaxitem="12" data-id="10000000351" data-nm="퀵메뉴138" style="background-color: rgb(255, 255, 255); border-color: rgba(0, 0, 0, 0.1);">
		<!-- 위젯 배경색 변경 가능 -->
		<div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span>
		</div>
		<div class="titlebox">
			<h3 class="qTitle qTextAlign fs22">바로가기 메뉴</h3> <!-- 퀵메뉴 제목변경 -->
		</div>
		<div class="q138_wrap quickBannerZone">
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<!-- 이미지 원 테두리,배경 색상변경 -->
						<img src="/sample/template/wide/wide012/img/icon01.png" alt="">
					</div>
					<p class="bTitle">바로가기 01</p> <!-- 제목변경-->
					<span class="arr linkCol"></span><!-- 바로가기 화살표 색상변경 -->
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon05.png" alt="">
					</div>
					<p class="bTitle">바로가기 02</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon02.png" alt="">
					</div>
					<p class="bTitle">바로가기 03</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon06.png" alt="">
					</div>
					<p class="bTitle">바로가기 04</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon03.png" alt="">
					</div>
					<p class="bTitle">바로가기 05</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon07.png" alt="">
					</div>
					<p class="bTitle">바로가기 06</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon04.png" alt="">
					</div>
					<p class="bTitle">바로가기 07</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/template/wide/wide012/img/icon08.png" alt="">
					</div>
					<p class="bTitle">바로가기 08</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
			
			
			
			
		</div>
		
		<!-- 샘플 -->
		<div class="quick_sample" style="display: none;">
			<div class="q138box wzwgContextMenu" data-type="quick">
				<a href="javascript:void(0);">
					<div class="icon targetBoardBg targetBG">
						<img src="/sample/layout/contents/quick/quick138/img/img01.png" alt="">
					</div>
					<p class="bTitle">바로가기 00</p>
					<span class="arr linkCol"></span>
				</a>
			</div>
		</div>
	</div></div>
							<div class="layout_04 layout_04mr layout_contents_border layout_height_M" data-w="25" data-h="M">	
	

	

	<div class="mvp113_2 cntContext10000000204 wzwgWidget" data-id="10000000241" data-nm="동영상게시판113_2" style="
    border: 1px solid rgba(0,0,0,0.1);
"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
		<h3 class="tit"><a href="#" class="mg0 menuNm menuSeq">홍보 동영상</a></h3>
		<ul id="data">
			<li>
				<div class="mvp113_box">
					<iframe src="https://www.youtube-nocookie.com/embed/7uuepDphc4I?showinfo=0&amp;rel=0&amp;controls=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen="" data-mvpplay="mvpId"></iframe>
				</div>
				
			</li> 
		</ul>
	</div>
</div>
						</div>
					</div>
						
				 	
						
				 	
 	
 					
 	
 					<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1 borderbox">
										<div class="layout_01 layout_contents_border addLayoutContentsZone" data-w="100" data-h="M">
										
	<div class="bnrSlide006 wzwgWidget" data-id="10000000486" data-nm="배너 슬라이드006">
		<div class="wzwg-banner-slide-info changeBg wzwgContextMenu" data-slidesperview="5" style="background-color: rgb(255, 255, 255);"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			<div class="wzwg-banner-slide-data"><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="0">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="0">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="0">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="0">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="0">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="-1">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="-1">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="-1">LOGO</a>
				</div><div>
					<a href="javascript:void(0);" class="bnrNm" tabindex="-1">LOGO</a>
				</div></div>
			
			<button class="arrow-prev slick-prev" type="button" style="">Previous</button>
			<button class="arrow-next slick-next" type="button" style="">Next</button>
			
			<!-- slide BTN -->
			<div class="btnbox">
				<div class="slide-controll">
					<div class="indicator">
						<button class="play" type="button" style="">슬라이드 시작</button>		
						<button class="stop off" type="button" style="display: none;">슬라이드 정지</button>				
					</div>
				</div>
			</div>
			
			<div class="sampleSlide" style="display: none">
				<div>
					<a href="javascript:void(0);" class="bnrNm">LOGO</a>
				</div>
			</div>
			
		</div>
	</div>	 
	
</div>
									</div>
								</div>
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 	

			            	
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	</div> <!--template00 끝. -->
		</div><!-- inner 끝 -->
	</div>
    
    
    
    
    
    
    
</div>
<c:import url="${footerUrl}"></c:import>

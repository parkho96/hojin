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
	<link href="/css/wzwg/cmm/common.css" rel="stylesheet" type="text/css">
	<link href="/sample/template/basic/basic026/css/style.css" rel="stylesheet" type="text/css">
	<link href="/sample/template/basic/basic026/css/swiper.min.css" rel="stylesheet" type="text/css">

	<script src="/sample/template/basic/basic026/js/tendina.min.js"></script>
	<script src="/sample/template/basic/basic026/js/swiper.jquery.min.js"></script>
	
	<script type="text/javascript">
		
	</script>
		 
	<div id="cssZone" style="display:none;"><link rel="stylesheet" href="/sample/layout/contents/quick/quick112/css/quick112.css" type="text/css" id="CSS_10000000064"><link rel="stylesheet" href="/sample/layout/contents/etc/etc117/css/etc117.css" type="text/css" id="CSS_10000000284"><link rel="stylesheet" href="/sample/layout/contents/board/board148/css/board148.css" type="text/css" id="CSS_10000000350"><link rel="stylesheet" href="/sample/layout/contents/etc/bnrSlide005/css/bnrSlide005.css" type="text/css" id="CSS_10000000485"><link rel="stylesheet" href="/sample/layout/contents/board/board141_slide/css/board141_slide.css" type="text/css" id="CSS_10000000523"><link rel="stylesheet" href="/sample/layout/contents/etc/etc002_text/css/etc002.css" type="text/css" id="CSS_10000000026"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery126_slide/css/gallery126_slide.css" type="text/css" id="CSS_10000000547"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick132/css/widequick132.css" type="text/css" id="CSS_10000000278"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery113/css/gallery113.css" type="text/css" id="CSS_10000000116"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery115/css/gallery115.css" type="text/css" id="CSS_10000000191"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_025/css/slide_bnr_025.css" type="text/css" id="CSS_10000000519"><link rel="stylesheet" href="/sample/layout/contents/banner/banner111/css/banner111.css" type="text/css" id="CSS_10000000093"><link rel="stylesheet" href="/sample/layout/contents/quick/quick138/css/quick138.css" type="text/css" id="CSS_10000000351"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_027/css/slide_bnr_027.css" type="text/css" id="CSS_10000000521"><link rel="stylesheet" href="/sample/layout/contents/mvp/mvp001/css/mvp001.css" type="text/css" id="CSS_10000000155"><link rel="stylesheet" href="/sample/layout/contents/banner/banner016/css/banner016.css" type="text/css" id="CSS_10000000067"><link rel="stylesheet" href="/sample/layout/contents/banner/banner137/css/banner137.css" type="text/css" id="CSS_10000000433"><link rel="stylesheet" href="/sample/layout/contents/banner/banner141/css/banner141.css" type="text/css" id="CSS_10000000543"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick118/css/widequick118.css" type="text/css" id="CSS_10000000128"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_024/css/slide_bnr_024.css" type="text/css" id="CSS_10000000518"><link rel="stylesheet" href="/sample/layout/contents/etc/etc012/css/etc012.css" type="text/css" id="CSS_10000000089"><link rel="stylesheet" href="/sample/layout/contents/board/board004_1/css/board004_1.css" type="text/css" id="CSS_10000000012"><link rel="stylesheet" href="/sample/layout/contents/board/board122/css/board122.css" type="text/css" id="CSS_10000000239"><link rel="stylesheet" href="/sample/layout/contents/board/board120/css/board120.css" type="text/css" id="CSS_10000000190"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_016/css/slide_bnr_016.css" type="text/css" id="CSS_10000000510"><link rel="stylesheet" href="/sample/layout/contents/quick/quick136/css/quick136.css" type="text/css" id="CSS_10000000333"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_030/css/slide_bnr_030.css" type="text/css" id="CSS_10000000526"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_026/css/slide_bnr_026.css" type="text/css" id="CSS_10000000520"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery125_slide/css/gallery125_slide.css" type="text/css" id="CSS_10000000530"><link rel="stylesheet" href="/sample/layout/contents/board/board016/css/board016.css" type="text/css" id="CSS_10000000292"><link rel="stylesheet" href="/sample/layout/contents/quick/quick132/css/quick132.css" type="text/css" id="CSS_10000000469"><link rel="stylesheet" href="/sample/layout/contents/board/board017/css/board017.css" type="text/css" id="CSS_10000000298"><link rel="stylesheet" href="/sample/layout/contents/board/board121_slide/css/board121_slide.css" type="text/css" id="CSS_10000000480"><link rel="stylesheet" href="/sample/layout/contents/board/board111_slide/css/board111_slide.css" type="text/css" id="CSS_10000000478"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery127_slide/css/gallery127_slide.css" type="text/css" id="CSS_10000000551"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_008/css/slide_bnr_008.css" type="text/css" id="CSS_10000000496"><link rel="stylesheet" href="/sample/layout/contents/board/board149/css/board149.css" type="text/css" id="CSS_10000000353"><link rel="stylesheet" href="/sample/layout/contents/calendar/calendar010/css/calendar010.css" type="text/css" id="CSS_10000000549"><link rel="stylesheet" href="/sample/layout/contents/calendar/calendar011/css/calendar011.css" type="text/css" id="CSS_10000000348"><link rel="stylesheet" href="/sample/layout/contents/map/map004/css/map004.css" type="text/css" id="CSS_10000000349"><link rel="stylesheet" href="/sample/layout/contents/quick/quick137/css/quick137.css" type="text/css" id="CSS_10000000346"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_032/css/slide_bnr_032.css" type="text/css" id="CSS_10000000548"><link rel="stylesheet" href="/sample/layout/contents/quick/quick003_1/css/quick003_1.css" type="text/css" id="CSS_10000000019"><link rel="stylesheet" href="/sample/layout/contents/board/board011/css/board011.css" type="text/css" id="CSS_10000000040"><link rel="stylesheet" href="/sample/layout/contents/board/board012/css/board012.css" type="text/css" id="CSS_10000000048"><link rel="stylesheet" href="/sample/layout/contents/board/board126_2/css/board126_2.css" type="text/css" id="CSS_10000000270"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick001/css/widequick001.css" type="text/css" id="CSS_10000000004"><link rel="stylesheet" href="/sample/layout/contents/img_board/board_gallery001/css/board_gallery001.css" type="text/css" id="CSS_10000000008"><link rel="stylesheet" href="/sample/layout/contents/img_mvp/img_mvp120/css/mvp120.css" type="text/css" id="CSS_10000000326"><link rel="stylesheet" href="/sample/layout/contents/img_mvp/img_mvp116/css/mvp116.css" type="text/css" id="CSS_10000000202"><link rel="stylesheet" href="/sample/layout/contents/banner/banner000/css/banner000.css" type="text/css" id="CSS_10000000562"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick003/css/widequick003.css" type="text/css" id="CSS_10000000028"><link rel="stylesheet" href="/sample/layout/contents/board/board132_slide/css/board132_slide.css" type="text/css" id="CSS_10000000331"><link rel="stylesheet" href="/sample/layout/contents/board/board129_slide/css/board129_slide.css" type="text/css" id="CSS_10000000330"><link rel="stylesheet" href="/sample/layout/contents/board/board145/css/board145.css" type="text/css" id="CSS_10000000553"><link rel="stylesheet" href="/sample/layout/contents/banner/banner140/css/banner140.css" type="text/css" id="CSS_10000000537"><link rel="stylesheet" href="/sample/layout/contents/etc/etc120/css/etc120.css" type="text/css" id="CSS_10000000539"><link rel="stylesheet" href="/sample/layout/contents/etc/etc014/css/etc014.css" type="text/css" id="CSS_10000000210"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick142_1/css/widequick142_1.css" type="text/css" id="CSS_10000000544"><link rel="stylesheet" href="/sample/layout/contents/board/board013/css/board013.css" type="text/css" id="CSS_10000000049"><link rel="stylesheet" href="/sample/layout/contents/board/board124/css/board124.css" type="text/css" id="CSS_10000000246"><link rel="stylesheet" href="/sample/layout/contents/board/board005_1/css/board005_1.css" type="text/css" id="CSS_10000000013"><link rel="stylesheet" href="/sample/layout/contents/board/board005_2/css/board005_2.css" type="text/css" id="CSS_10000000303"><link rel="stylesheet" href="/sample/layout/contents/board/board001/css/board001_1.css" type="text/css" id="CSS_10000000000"><link rel="stylesheet" href="/sample/layout/contents/board/board006_1/css/board006_1.css" type="text/css" id="CSS_10000000014"><link rel="stylesheet" href="/sample/layout/contents/board/board010/css/board010.css" type="text/css" id="CSS_10000000039"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_005/css/slide_bnr_005.css" type="text/css" id="CSS_10000000491"></div><div class="contents wzwgContextMenu sChangeBg" style="background-color: rgb(255, 255, 255);">
		<div class="mainVisual" style="
">
			<div class="wzwg-slide-info mainSlider_001 wzwgContextMenu" data-effect="fade" data-autoplay="auto" data-slidecnt="1"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 자동<br>화면전환 : 페이드<br>반복재생 : 진행</p></span></div>
				<div class="wzwg-slide-data"><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0">
						
							<div class="imgbox">
<img alt="" src="/sample/template/basic/basic026/img/main.jpg" class="bgImg"></div>
							<div class="copy copy_position_rh toleft" style="">
								<div class="inner blueBorder3px">
									

<div class="targetBG" style="background-color: rgb(4, 68, 55);"><div>
    <div><h2 class="mTitle tit fs60" style="">각자의 시선과 프레임<br>크리에이티브한 결과물<br><b>위즈 스튜디오</b></h2></div><div><p class="bContent smallp fs30">無에서 有를.<br>​창조와 가치를 넘어선 감동</p></div></div>
</div>

									
								</div>
							</div>

							
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="1">
						
							<div class="imgbox"><img alt="" src="/sample/template/basic/basic026/img/main02.jpg" class="bgImg"></div>
							<div class="copy copy_position_lh toright" style="">
								<div class="inner blueBorder3px">
									

<div class="targetBG" style="background-color: rgb(4, 68, 55);"><div>
    <div><h2 class="mTitle tit fs60" style="">각자의 시선과 프레임<br>크리에이티브한 결과물<br><b>위즈 스튜디오</b></h2></div><div><p class="bContent smallp fs30">無에서 有를.<br>​창조와 가치를 넘어선 감동</p></div></div>
</div>

									
								</div>
							</div>

							
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="2">
						
							<div class="imgbox"><img alt="" src="/sample/template/basic/basic026/img/main03.jpg" class="bgImg"></div>
							<div class="copy copy_position_ch scalefx" style="">
								<div class="inner blueBorder3px">
									

<div class="targetBG" style="background-color: rgb(4, 68, 55);"><div>
    <div><h2 class="mTitle tit fs60" style="">각자의 시선과 프레임<br>크리에이티브한 결과물<br><b>위즈 스튜디오</b></h2></div><div><p class="bContent smallp fs30">無에서 有를.<br>​창조와 가치를 넘어선 감동</p></div></div>
</div>

									
								</div>
							</div>

							
					</div></div>

				
				<div class="swiper-pagination-center">
					
					<div class="indicator">
						<button class="play" style="display: none;" type="button">시작</button>		
						<button class="stop off" style="" type="button">멈춤</button>				
					</div>
				</div>

				
				
								

				<div class="sampleSlide" style="display: none;">
					
				<div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0" style="width: 100%; display: inline-block;">
						
							<div class="imgbox"><img alt="" src="/sample/template/basic/basic026/img/main.jpg" class="bgImg"></div>
							<div class="copy mainSlider_txt_004 txtPositionTop copy_position_rh toleft wzwgContextMenu" style="">
								<div class="inner blueBorder3px">
									

<div class="targetBG" style="background-color: rgb(4, 68, 55);"><div>
    <div><h2 class="mTitle tit fs60" style="">슬라이드 제목을 입력하세요<br>슬라이드 제목을 입력하세요</h2></div><div><p class="bContent smallp fs30">슬라이드 내용을 입력하세요<br>슬라이드 내용을 입력하세요</p></div></div>
</div>

									
								</div>
							</div>

							
					</div></div>
			</div>	  
		</div>  


		<!--  -->
		<!--  -->
		<div class="inner">
			<div class="removeAxeboxZone addContentZone" id="template00">
 	
				
				
				
				
				
				

				
				
				
				
				
				
 	
				
				
				
				
				
				
				
				
				
 	
 				
 				
 				
 			
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
						
				 	


						
				 	


				 		
				 	


 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 			
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 		                                                                     
			            		
								
				 		
				 	
			            		
								
						
			            		
								
						
				 	

			            	
				 	
				 		
				 		
			            		
								

			            	
				 	
				 		
				 	
				 	
						
						
				 		
			            		
								
			            		
								

			            	
				 		
				 	

			            	
			            		
								
			            		
								
			            		
								

			            	
			            		
								

			            	
						
			            		
								

			            	
			            		
								

			            	
				 	
			            		
								

			            	
			            		
								

			            	
				 		
				 	
				 		
				 	
			            		
								<div class="empty empty_80 wzwgContextMenu layout_line_border" style="background-color: rgb(255, 255, 255); position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px;"></div>
			            		
								

			            	
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_slideNfade"><div class="layoutInfo" style="display:none"> <span>페이드+슬라이드 효과적용</span></div>
									<div class="div_wrap layout_block1 mxwd100">
										<div class="layout_01 layout_contents_border mobilepadding" data-w="100" data-h="M">
										
	



	


	
	


	<div class="mvp116 custom cntContextSGC0000027 wzwgWidget" data-id="10000000202" data-nm="이미지게시판116_IM" style="background-color: rgba(0, 0, 0, 0);"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="titbox">
			<h3 class="tit menuNm mb20">위즈스튜디오 갤러리</h3>
			
		</div>

		<ul class="dataList">
			
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd01.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.1</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd02.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.2</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd03.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.3</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li><li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd04.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd05.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.4</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>
   
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd06.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li><li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd07.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>

			<li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd08.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);">
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>

			
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd09.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);">
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li><li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd10.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);">
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>
   <li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd04.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li><li>
				<div class="imgbox">
					<span><img src="/sample/template/basic/basic026/img/brd03.jpg" data-src="bbsThumLink" data-mvponclick="mvpId"></span>
				</div>
				<a href="javascript:void(0);" data-href="bbsViewLink">
					<div class="cobox boardBg" style="background-color: rgb(74, 130, 5);"> <!-- 배경색 변경 -->
						<span class="gall_tit" data-attr="nttSj">게시글 제목이 노출됩니다. 게시판 미리보기 모습입니다.</span>
						<span class="gall_co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 
							게시글 내용이 노출됩니다. 게시글 내용 예시입니다.미리보기 모습입니다. 미리보기 모습입니다. 게시글 미리보기 모습입니다.</span> 
						<span class="date" data-attr="frstRegistPnttm">2020.01.01</span>
					</div>
				</a>
			</li>


			<li class="no_data" style="display:none;"> <!-- 게시물이 없을때! -->
				<span class="gall_tit">작성된 게시글이 없습니다.</span>
			</li>

		</ul>
	</div>

</div>
									</div>
								</div>
				 		<div class="empty empty_100 wzwgContextMenu layout_line_border"></div>
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 	
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border mobilepadding" data-w="100" data-h="M">
													<div style="height:100%;" class="wzwgWidget" data-id="10000000026" data-nm="기타002">
				<div class="etc002 custom unityLink_five_002 changeBg wzwgContextMenu">
					<div class="etc02wrap bTextAlign">
						<strong class="txttit lay05tit bTitle">위즈스튜디오 <b>소식</b></strong>
						
					</div>
				</div>
			</div></div>
									</div>
								</div>
				 		<div class="empty empty_30 wzwgContextMenu layout_line_border"></div>
				 	

			            	
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block2 layout_padding btw3">
								<div class="layout_02 layout_contents_border layout_height_H" data-w="50" data-h="H">
	


	

	
		
	

	<div class="board006_1 wzwgWidget" data-id="10000000014" data-nm="게시판006">
		<div class="innerbox cntContextSGC0000027"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			<h3 class="tit menuNm menuNmBrdrBg" style="border-color: rgb(11, 86, 167);">RESERVATION</h3>
			<ul class="dataList">
				<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
				
				
				
				
				
				<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
				<li class="no_data" style="display:none"><span class="board_co bTitle">작성된 게시글이 없습니다.</span></li>
			</ul>
			<a href="javascript:void(0);" class="menuSeq"><img src="/sample/layout/contents/board/board006_1/img/plus.png" alt=""></a>
		</div>
	</div>

</div>
								<div class="layout_02 layout_contents_border layout_height_H" data-w="50" data-h="H">
	
	
	



					
					
					<!-- board010 end -->

	<div class="board006_1 wzwgWidget" data-id="10000000014" data-nm="게시판006">
		<div class="innerbox cntContextSGC0000027"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			<h3 class="tit menuNm menuNmBrdrBg" style="border-color: rgb(57, 121, 85);">REVIEW</h3>
			<ul class="dataList">
				
				
				
				
				
				
				<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>
<li><a href="javascript:void(0);" data-href="bbsViewLink"><span class="board_co bTitle" data-attr="nttSj">게시글 제목이 노출됩니다. 미리보기 모습입니다.</span> <span class="board_date" data-attr="frstRegistPnttm">2023.00.00</span></a></li>

				<li class="no_data" style="display:none"><span class="board_co bTitle">작성된 게시글이 없습니다.</span></li>
			</ul>
			<a href="javascript:void(0);" class="menuSeq"><img src="/sample/layout/contents/board/board006_1/img/plus.png" alt=""></a>
		</div>
	</div>

</div>
							</div>
						</div><div class="layout_wrap wzwgContextMenu layout_wrap_border" style="position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px;"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border addLayoutContentsZone mobilepadding" data-w="100" data-h="M">
										
		 


	<div class="slide_bnr_005 wzwgWidget" data-id="10000000491" data-nm="슬라이드배너005"> 
		<div class="wzwg-slide-info wzwgContextMenu" data-loop="false" data-slidecnt="3"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 안함</p></span></div>
		    <div class="wzwg-slide-data"><div class="wzwgContextMenu" data-type="slide" data-index="0">
					<a href="javascript:void(0);" tabindex="0"> <!-- 바로가기 링크 변경 -->			
					<div class="innerbox changeBg" style="background-color: rgba(0, 0, 0, 0);">
						<div class="imgbox">
							<img src="/sample/template/basic/basic026/img/slidebnr01.jpg" alt=""> <!-- 이미지변경 -->
						</div>
						<div class="txtBox bTextAlign"> <!-- 문구 위치변경 -->
							<p class="tit fs20 mTitle"><span style="color: #343434;">RENTAL STUDIO A</span></p> <!-- 제목변경 -->
							<p class="co fs16 bContent"> <!-- 내용 변경 -->
                            	<span style="color: #212121;">각 슬라이드 이미지마다 제목과 내용을 입력하실 수 있습니다.<br>
                                레이아웃별로 노출되는 줄 수는 상이합니다.<br>
                                배경 이미지 교체가 가능하며 자동으로 어둡게 처리되어 노출됩니다.<span style="color: rgb(33, 33, 33);"></span></span>
                            </p> 
						</div>
                        <hr class="targetBG line" style="background-color: rgba(55, 86, 35, 0.8);"> <!-- 지정 배경색 변경 -->
					</div>
					</a>
				</div><div class="wzwgContextMenu" data-type="slide" data-index="1">
					<a href="javascript:void(0);" tabindex="-1"> <!-- 바로가기 링크 변경 -->			
					<div class="innerbox changeBg" style="background-color: rgba(255, 255, 255, 0.4);">
						<div class="imgbox">
							<img src="/sample/template/basic/basic026/img/slidebnr02.jpg" alt=""> <!-- 이미지변경 -->
						</div>
						<div class="txtBox bTextAlign"> <!-- 문구 위치변경 -->
							<p class="tit fs20 mTitle"><span style="color: #000000;">RENTAL STUDIO B</span></p> <!-- 제목변경 -->
							<p class="co fs16 bContent"> <!-- 내용 변경 -->
                            	<span style="color: #000000;">각 슬라이드 이미지마다 제목과 내용을 입력하실 수 있습니다.<br>
                                레이아웃별로 노출되는 줄 수는 상이합니다.<br>
                                배경 이미지 교체가 가능하며 자동으로 어둡게 처리되어 노출됩니다.<span style="color: rgb(0, 0, 0);"></span></span>
                            </p> 
						</div>
                        <hr class="targetBG line" style="background-color: rgba(0, 0, 0, 0);"> <!-- 지정 배경색 변경 -->
					</div>
					</a>
				</div></div>


			<!-- 슬라이드 추가시 - 추가되는 슬라이드 샘플 -->
			<div class="sampleSlide" style="display:none">

				<div class="wzwgContextMenu">
					<a href="javascript:void(0);"> <!-- 바로가기 링크 변경 -->			
					<div class="innerbox changeBg">
						<div class="imgbox">
							<img src="/sample/layout/contents/slide/slide_bnr_005/img/img01.jpg" alt=""> <!-- 이미지변경 -->
						</div>
						<div class="txtBox bTextAlign"> <!-- 문구 위치변경 -->
							<p class="tit fs20 mTitle">슬라이드 제목 입력</p> <!-- 제목변경 -->
							<p class="co fs16 bContent"> <!-- 내용 변경 -->
                            	각 슬라이드 이미지마다 제목과 내용을 입력하실 수 있습니다.<br>
                                레이아웃별로 노출되는 줄 수는 상이합니다.<br>
                                배경 이미지 교체가 가능하며 자동으로 어둡게 처리되어 노출됩니다.
                            </p> 
						</div>
                        <hr class="targetBG line"> <!-- 지정 배경색 변경 -->
					</div>
					</a>
				</div>
					
			</div>

		</div>
	</div>	 
	</div>
									</div>
								</div>
				 		<div class="empty empty_80 wzwgContextMenu layout_line_border"></div>
				 	
				 		
				 	
				 	
				 	

			            	
			            		
								
			            		
								
				 		
			            		
								
						
				 		
				 	
			            		
								
						
				 	

			            	
				 		
			            		
								
			            		
								
				 		
				 	

			            	<div class="empty empty_100 wzwgContextMenu layout_line_border FXarea_slideUp" style="position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px; background-color: rgb(6, 68, 55);"><div class="layoutInfo" style="display:none"> <span>슬라이드 효과적용</span></div></div>

			            	
				 	<div class="layout_wrap wzwgContextMenu layout_wrap_border" style="position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px; background-color: rgb(6, 68, 55);"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border mobilepadding" data-w="100" data-h="M">
										
	


	



	<!-- widget - board145 -->
    
    <!-- /widget - board145 -->

	<div class="banner140 wzwgContextMenu changeBg wzwgWidget" data-id="10000000537" data-nm="배너140"> <!-- 배경색 변경 -->
		<div class="bnr_wrap">
			<div class="txtbox">
				<h3 class="tit mTitle" style="
    font-family: Noto Sans KR;
"><span style="color: #ffffff;">ABOUT<br><b>WIZ&nbsp;STUDIO</b></span></h3> 
				<span class="co bContent fs40">
					<span style="color: #ffffff;">#남다른감성<br>#렌탈스튜디오<!--ㅠㄱ--></span></span>
				<div class="subcobox">
					<p class="bSubContent subco fs17">
						위즈스튜디오는 불가능해보이는 일이라도 무한한 잠재력을 이용하여<br>
						불굴의 투지와 강인한 추진력으로 도전한다면 반드시 이루어 낼 수 있다는<br>홍길동의 이념을 바탕으로 하고있습니다.
					</p>
				</div>
			</div>

			<div class="rbox">
				<div class="imgbox"> <!-- 이미지 변경 -->
					<img src="/sample/template/basic/basic026/img/01.jpg" alt="">
				</div>
				<div class="btnbox">
					<div class="targetBG" style="background-color: rgb(255, 255, 255);"> <!-- 배경색변경 -->
						<a href="javascript:void(0);" class="linkbtn bLinkTitle fs17 bLinkBoardCol" style="border-color: rgb(6, 68, 55); color: rgb(52, 52, 52);">CONTACT US</a> <!-- 바로가기 변경 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
									</div>
								</div>
				 	
						
				 	

			            	
						
				 	
			            		
								

			            	
				 	
			            		
								

			            	
				 		
						
				 	
				 	
			            		
								

			            	

			            	

			            	
				 		<div class="empty empty_30 wzwgContextMenu layout_line_border" style="background-color: rgb(6, 68, 55);"></div>
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border" style="background-color: rgb(6, 68, 55);"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border mobilepadding" data-w="100" data-h="M">
										
	<div class="etc120 changeBg wzwgContextMenu wzwgWidget" data-id="10000000539" data-nm="기타120"> 
		<div class="imgbox">
			<img class="qImgBg" src="/sample/template/basic/basic026/img/02.jpg" alt="">
		</div>
		<div class="txtbox bTextAlign">
			<div class="titlebox">
		 		<strong id="txtColor" class="txttit mTitle fs40 linehgt130">
					<span style="color: #ffffff;">
    호기심 가득한, 설레는 마음으로<br>
따뜻한 시선을 담아내는 이들이 모이는 곳<br>
    <b>위즈스튜디오</b>
</span></strong>
				<span class="txtco bContent fs17">
    꿈을 발견하고, 꿈을 디자인하고, 꿈을 추진하고, 꿈과 가치를 실현하는.<br>
				  위즈스튜디오는 꿈이 실현 가능하도록 세밀하게 디자인하고 도전합니다.</span>
		 	</div>
			<div class="bBorderBg borderBTM" style="border-color: rgb(255, 255, 255);"></div>
		</div>
		
	</div>
</div>
									</div>
								</div>

			            	
						
				 		<div class="empty empty_80 wzwgContextMenu layout_line_border" style="background-color: rgb(6, 68, 55);"></div>
				 		
				 	
			            		
								
				 		
				 	

			            	
						
				 	
				 	
						
						
				 	
				 	
				 		
				 	
						
						
				 	
				 		
				 	
			            		
								
						
				 		
				 	
			            		
								

			            	
				 	

			            	
				 	
			            		
								

			            	
				 	
						
				 	
				 	
				 		
				 	
			            		
								
			            		
								

			            	
				 		
				 	

			            	
				 		
				 	
						
				 	

			            	
			            		
								

			            	
				 		
				 		
				 	
				 	
			            		
								
				 		
				 	

			            	
			            		
								

			            	
			            		
								

			            	

			            	

			            	
				 	
						
				 	
				 	
				 		
						
				 	
			            		
								

			            	
						
				 	
				 					
				 	
			            		
								

			            	
				 	
				 	

			            	
				 		
				 	
				 		
				 	
				 		
				 	
						
			            		
								
				 		
				 	
						
				 	

			            	
						
						
				 	
				 	
			            		
								

			            	
						
				 		
			            		
								
				 		
				 		
			            		
								
			            		
								
						
						
						
				 	
				 	
				 	

			            	

			            	
				 	
				 	

			            	
				 	
						
				 	
			            		
								
				 		
				 	

			            	
			            		
								

			            	
				 	
						
				 	
				 	

			            	
				 		
				 	</div> <!--template00 끝. -->
		</div><!-- inner 끝 -->
	</div>
    
    
    
    
    
    
    

</div>
<c:import url="${footerUrl}"></c:import>

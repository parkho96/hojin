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
	<link href="/sample/template/basic/basic022/css/style.css" rel="stylesheet" type="text/css">
	<link href="/sample/template/basic/basic022/css/swiper.min.css" rel="stylesheet" type="text/css">

	<script src="/sample/template/basic/basic022/js/tendina.min.js"></script>
	<script src="/sample/template/basic/basic022/js/swiper.jquery.min.js"></script>
	
	<script type="text/javascript">
		
	</script>
		 
	<div id="cssZone" style="display:none;"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick123/css/widequick123.css" type="text/css" id="CSS_10000000205"><link rel="stylesheet" href="/sample/layout/contents/img_mvp/img_mvp013/css/mvp013.css" type="text/css" id="CSS_10000000162"><link rel="stylesheet" href="/sample/layout/contents/calendar/calendar003/css/calendar003.css" type="text/css" id="CSS_10000000152"><link rel="stylesheet" href="/sample/layout/contents/board/board124/css/board124.css" type="text/css" id="CSS_10000000246"><link rel="stylesheet" href="/sample/layout/contents/etc/logo_slide005/css/logo_slide005.css" type="text/css" id="CSS_10000000279"><link rel="stylesheet" href="/sample/layout/contents/etc/bnrSlide005/css/bnrSlide005.css" type="text/css" id="CSS_10000000485"><link rel="stylesheet" href="/sample/layout/contents/etc/etc002_text/css/etc002.css" type="text/css" id="CSS_10000000026"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick147/css/widequick147.css" type="text/css" id="CSS_10000000542"><link rel="stylesheet" href="/sample/layout/contents/banner/banner141/css/banner141.css" type="text/css" id="CSS_10000000543"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick142_1/css/widequick142_1.css" type="text/css" id="CSS_10000000544"><link rel="stylesheet" href="/sample/layout/contents/banner/banner113/css/banner113.css" type="text/css" id="CSS_10000000113"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick148/css/widequick148.css" type="text/css" id="CSS_10000000545"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick151/css/widequick151.css" type="text/css" id="CSS_10000000558"><link rel="stylesheet" href="/sample/layout/contents/board/board147/css/board147.css" type="text/css" id="CSS_10000000559"><link rel="stylesheet" href="/sample/layout/contents/board/board003_1_slide/css/board003_1_slide.css" type="text/css" id="CSS_10000000477"><link rel="stylesheet" href="/sample/layout/contents/board/board019/css/board019.css" type="text/css" id="CSS_10000000301"><link rel="stylesheet" href="/sample/layout/contents/board/board131/css/board131.css" type="text/css" id="CSS_10000000432"><link rel="stylesheet" href="/sample/layout/contents/img_board/gallery128/css/gallery128.css" type="text/css" id="CSS_10000000561"><link rel="stylesheet" href="/sample/layout/contents/banner/banner143/css/banner143.css" type="text/css" id="CSS_10000000560"></div><div class="contents wzwgContextMenu sChangeBg" style="background-color: rgb(255, 255, 255);">
		<div class="mainVisual" style="
    max-width: 1300px;
    margin: 0 auto;
    padding: 30px 0;
    box-sizing: border-box;
">
			<div class="wzwg-slide-info mainSlider_001 wzwgContextMenu" data-effect="fade" data-autoplay="auto" data-slidecnt="1"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 자동<br>화면전환 : 페이드<br>반복재생 : 진행</p></span></div>
				<div class="wzwg-slide-data"><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0">
						
							<img alt="" src="/sample/template/basic/basic022/img/mainbg.gif" class="bgImg">
							<div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_lh" style="">
								<div class="inner blueBorder3px">
									

<div><h2 class="mTitle tit fs40" style="">위즈시만의 진로진학상담센터<br><b>진로상담 플랫폼</b></h2><div class="targetBG" style=""></div></div>
									<div><p class="bContent smallp fs20" style=""><font color="#343434"><b>위즈시만의 진로진학 사업</b>을 한 눈에 확인 !<br>​
보다 다양하고 구체적인 <b>청소년 진로설계 지원</b> ! </font></p></div>
								</div>
							</div>

							
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="1">
						
							<img alt="" src="/sample/template/basic/basic022/img/bg02.gif" class="bgImg">
							<div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_lh" style="">
								<div class="inner blueBorder3px">
									

<div><h2 class="mTitle tit fs40" style="">위즈시만의 진로진학상담센터<br><b>진로상담 플랫폼</b></h2><div class="targetBG" style=""></div></div>
									<div><p class="bContent smallp fs20" style=""><font color="#343434"><b>위즈시만의 진로진학 사업</b>을 한 눈에 확인 !<br>​
보다 다양하고 구체적인 <b>청소년 진로설계 지원</b> ! </font></p></div>
								</div>
							</div>

							
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="2">
						
							<img alt="" src="/sample/template/basic/basic022/img/mainbg.gif" class="bgImg">
							<div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_lh" style="">
								<div class="inner blueBorder3px">
									

<div><h2 class="mTitle tit fs40" style="">위즈시만의 진로진학상담센터<br><b>진로상담 플랫폼</b></h2><div class="targetBG" style=""></div></div>
									<div><p class="bContent smallp fs20" style=""><font color="#343434"><b>위즈시만의 진로진학 사업</b>을 한 눈에 확인 !<br>​
보다 다양하고 구체적인 <b>청소년 진로설계 지원</b> ! </font></p></div>
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
						
							<img alt="" src="/sample/template/basic/basic022/img/mainbg.gif" class="bgImg">
							<div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_lh" style="">
								<div class="inner blueBorder3px">
									

<div><h2 class="mTitle tit fs40" style="">위즈시만의 진로진학상담센터<br><b>진로상담 플랫폼</b></h2><div class="targetBG" style=""></div></div>
									<div><p class="bContent smallp fs20" style=""><font color="#343434"><b>위즈시만의 진로진학 사업</b>을 한 눈에 확인 !<br>​
보다 다양하고 구체적인 <b>청소년 진로설계 지원</b> ! </font></p></div>
								</div>
							</div>

							
					</div></div>
			</div>	  
		</div>  


		<!--  -->
		<!--  -->
		<div class="inner">
			<div class="removeAxeboxZone addContentZone" id="template00">
 	
				
				
				
				
				
				

				
				
				
				
				
				
 	
				
				
				
				
				
				
				
				
				
 	
 				
 				
 				
 			
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
					
						
				 	


						
				 	


				 		
				 	


 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 			
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 	
 					
 		                                                                     
			            		
								
				 		
				 	<div class="layout_wrap wzwgContextMenu layout_wrap_border" style="position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px;">
									<div class="div_wrap layout_block1" style="
    max-width: 100%;
">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										
	
			
<div class="widequick151 quickBannerConfZone noChangeBg wzwgWidget" data-id="10000000558" data-nm="와이드퀵151"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div> 

	<div class="imgbox">
		<img class="qImgBg" src="/sample/template/basic/basic022/img/wqbg01.jpg" alt="">
	</div>

	<div class="qAllWrap pt50 pb30"> 
		<div class="innerbox">
			<div class="txtbox">
				<strong class="txttit qmTitle fs40 mb50 pt20"><b>통합 서비스</b></strong>
				
			</div>


			<ul class="quickBannerZone qWrap mt25">
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
						<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img01.png" alt=""></div>
						<div class="txtBox">
							<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(237, 22, 81);"><font color="#ffffff"><b>프로그램</b></font></p>
							<p class="qTxt fs24 linehgt130 bTitle">진로탐색01<br> 진로발표</p>
						</div>
					</a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img02.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(237, 22, 81);"><font color="#ffffff"><b>프로그램</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">진로체험01<br>시청방문</p>
					</div></a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img08.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(109, 184, 61);"><font color="#ffffff"><b>외부활동</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">진로<br> 강연듣기</p>
					</div></a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img07.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(44, 172, 224);"><font color="#ffffff"><b>단체 소속활동</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">등산<br> 동아리</p>
					</div></a>
				</li>

				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img03.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(237, 22, 81);"><font color="#ffffff"><b>프로그램</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">진로탐색02<br> 꿈 글짓기</p>
					</div></a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img04.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(237, 22, 81);"><font color="#ffffff"><b>프로그램</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">진로체험02<br> 소방훈련</p>
					</div></a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img05.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(109, 184, 61);"><font color="#ffffff"><b>외부활동</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">북한산<br>탐구활동</p>
					</div></a>
				</li>
				<li class="wzwgContextMenu changeBg" data-type="quick">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/template/basic/basic022/img/img06.png" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG" style="background-color: rgb(44, 172, 224);"><font color="#ffffff"><b>단체 소속활동</b></font></p>
						<p class="qTxt fs24 linehgt130 bTitle">과학<br> 탐구회</p>
					</div></a>
				</li>
			</ul>
			
			<ul class="quick_sample" style="display: none;">
				<li class="wzwgContextMenu changeBg">
					<a href="#">
					<div class="bgImgBox"><img src="/sample/layout/contents/quick/widequick151/img/qbg01.jpg" alt=""></div>
					<div class="txtBox">
						<p class="qTit fs16 mb20 bSubTitle targetBG"><b>부제목 입력</b></p>
						<p class="qTxt fs24 linehgt130 bTitle">제목을 입력하세요.<br> 제목을 입력하세요.</p>
					</div></a>
				</li>
			</ul>
		</div>
	</div>

</div>

</div>
									</div>
								</div>
			            		
								
						
			            		
								
						<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_slideNfade"><div class="layoutInfo" style="display:none"> <span>페이드+슬라이드 효과적용</span></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								
	<div class="widequick148 basic022Custom quickBannerConfZone noChangeBg wzwgWidget" data-id="10000000545" data-nm="와이드퀵148"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div> 

		<div class="imgbox">
			<img class="qImgBg" src="/sample/layout/contents/quick/widequick148/img/01.jpg" alt="">
		</div>

		<div class="et121 qChangeBg" style="background-color: rgb(235, 238, 240);"> <!-- 배경색변경 -->
            <div class="innerbox">
				<div class="txtbox">
					<strong class="txttit qmTitle fs40"><b><font color="#343434">주요 기관별 서비스</font></b></strong>
					
				</div>
				<ul class="quickBannerZone iconbox fixedclear mt25">
					<li class="wzwgContextMenu changeBg pb0" data-type="quick"><!-- 지정 배경색 변경 -->
    <a href="#">
						<div class="iconbox_img">
							<img class="bIcon" src="/sample/template/basic/basic022/img/architecture01.png" alt="">
						</div>
						<p class="iconbox_tit fs22 bTitle pt20"><font color="#000000"><b>위즈시 교육재단</b></font></p>
						<!-- 테두리 색상변경 -->
    </a>
					</li>
					<li class="wzwgContextMenu changeBg pb0" data-type="quick">
    <a href="#">
						<div class="iconbox_img">
							<img class="bIcon" src="/sample/template/basic/basic022/img/architecture02.png" alt="">
						</div>
						<p class="iconbox_tit fs22 bTitle pt20"><font color="#000000"><b>관내 사회복지관</b></font></p>
    </a>
						
					</li>
					<li class="wzwgContextMenu changeBg pb0" data-type="quick">
    <a href="#">
						<div class="iconbox_img">
							<img class="bIcon" src="/sample/template/basic/basic022/img/architecture03.png" alt="">
						</div>
						<p class="iconbox_tit fs22 bTitle pt20">
							<b><font color="#000000">관내 청소년 문화의 집</font></b></p>
    </a>
						
					</li>
					<li class="wzwgContextMenu changeBg pb0" data-type="quick">
    <a href="#">
						<div class="iconbox_img">
							<img class="bIcon" src="/sample/template/basic/basic022/img/architecture04.png" alt="">
						</div>
						<p class="iconbox_tit fs22 bTitle pt20"><font color="#000000"><b>기타기관</b></font></p>
    </a>
						
					</li>
				</ul>
            </div>

			<ul class="quick_sample" style="display: none;">
				<li class="wzwgContextMenu changeBg pb0">
    <a href="#">
					<div class="iconbox_img">
						<img class="bIcon" src="/sample/layout/contents/quick/widequick148/img/icon04.png" alt="">
					</div>
					<p class="iconbox_tit fs22 bTitle pt20">
						<b>제목 04</b>
					</p>
    </a>
					
				</li>
			</ul>
        </div>
	
	</div>

</div>
							</div>
						</div>
				 	

			            	
				 	
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border FXarea_slideNfade"><div class="layoutInfo" style="display:none"> <span>페이드+슬라이드 효과적용</span></div></div>
				 	
						
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block3 layout_block3_2 layout_padding btw3">
								<div class="layout_02 layout_contents_border layout_height_H" data-w="50" data-h="H">
	<div class="basic022Custom board147 cntContextSGC0000027 noChangeBg wzwgWidget" data-id="10000000559" data-nm="게시판147"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="innerbox">
			<div class="topBrdTit">
				<h3 class="menuNm title fs28">공지사항</h3>
				<a href="javascript:void(0);" class="menuSeq bMoreTextColOnly readmore" title="게시판으로 이동합니다">+</a>
			</div>
			<ul id="data">
				<!-- 가장 최근 글 2개만 보여집니다. -->
				<li class="boardBg boardBrdrBg">
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<span class="title bTitle fs20" data-attr="nttSj" style="color: rgb(37, 45, 70);">2022년 위즈교육재단 대학교 
진학 장학생 선발 공고</span> 
						<span class="co bContent fs16" data-attr="nttCnChrctr" style="color: rgb(37, 45, 70);">2022년 위즈교육재단 대학교 진학 장학생
을 모집, 선발하고자 합니다. 가. 선발대상: 관
내고등학교를 졸업하고 2022학년도 대학교
에 입학한 신입생 (상세내용: 붙임문서 참조)</span>
						<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
					</a>
				</li>
				<li class="boardBg boardBrdrBg">
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<span class="title bTitle fs20" data-attr="nttSj" style="color: rgb(37, 45, 70);">[마을강사 안전교육 수강] 아동
학대예방교육 이수 안내</span> 
						<span class="co bContent fs16" data-attr="nttCnChrctr" style="color: rgb(37, 45, 70);">마을강사 추가 안전교육 강좌 안내입니다.
아래 내용 확인하시고, 기간 내에 수료증 제
출해주세요~ [위즈평생학습포털 지식Gse
ek 사이트 기반 온라인 교육]</span>
						<span class="date" data-attr="frstRegistPnttm">0000.00.00</span>
					</a>
				</li>


				<li class="boardBrdrBg no_data" style="display: none;"> <!-- display:none 되어있는 상태 -->
					<h3 class="tit">작성된 게시글이 없습니다.</h3>
				</li>
			</ul>
		</div>
	</div>

</div>
								<div class="layout_04 layout_04ml layout_contents_border layout_height_H" data-w="25" data-h="H">
		


	
	
	


  
	
	<div class="gallery128 cntContextSGC0000027 wzwgWidget" data-id="10000000561" data-nm="이미지게시판128"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>  <!-- 게시판 전체부분 배경색변경가능 -->
		<div class="innerbox">
			<div class="topBrdTit">
				<h3 class="menuNm title fs28">포토앨범</h3>
				<a href="javascript:void(0);" class="menuSeq bMoreTextColOnly readmore" title="게시판으로 이동합니다">+</a>
			</div>
			<ul id="data">
				<li>
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<div class="imgbox">
							<img data-src="bbsThumLink" src="/sample/template/basic/basic022/img/brdImg01.jpg" alt="">
						</div>
						<div class="txtbox boardBg pl15 pt20 pb20" style="background-color: rgb(0, 101, 179);">
						<span class="title bTitle fs18" data-attr="nttSj">위즈교육재단 '꿈에 春(봄)을 
꽃피우는 버스' 운행</span> 
						<span class="date fs14" data-attr="frstRegistPnttm">0000.00.00</span>
					</div>
					</a>
				</li>


				<li class="no_data" style="display: none;"> <!-- display:none 되어있는 상태 -->
					<p class="tit">작성된 게시글이 없습니다.</p>
				</li>
			</ul>
		</div>
	</div>

</div>
								<div class="layout_04 layout_04mr layout_contents_border layout_height_H addLayoutContentsZone" data-w="25" data-h="H">	
	<div class="banner143 wzwgContextMenu changeBg wzwgWidget" data-id="10000000560" data-nm="배너143">
		<div class="innerbox">
			<a href="javascript:void(0);"> <!-- 바로가기 색상변경 -->
				<div class="topBrdTit">
					<h3 class="bTitle title fs28">홍보자료</h3>
					<span class="readmore linkCol">+</span>  
				</div>
				<div class="bnrimgbox bBorderBg"> <!-- 테두리색상변경 가능 -->
					<img src="/sample/template/basic/basic022/img/bnrImg02.jpg" alt="">
				</div>
			</a>
		</div>
	</div>
</div>
							</div>
						</div>
				 	
				 		<div class="empty empty_100 wzwgContextMenu layout_line_border"></div>
				 	
				 	

			            	
				 		
				 	
				 		
				 	
				 		
				 	
						
			            		
								
				 		
				 	
						
				 	

			            	
						
						
				 	
				 	
			            		
								

			            	
						
				 		
			            		
								
				 		
				 		
			            		
								
			            		
								
						
						
						
				 	
				 	
				 	

			            	

			            	
				 	
				 	

			            	
				 	
						
				 	
			            		
								
				 		
				 	

			            	
			            		
								

			            	
				 	
						
				 	
				 	

			            	
				 		
				 	</div> <!--template00 끝. -->
		</div><!-- inner 끝 -->
	</div>
    
    
    
    
    
    
    

</div>
<c:import url="${footerUrl}"></c:import>

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
  <link href="/sample/template/basic/basic033/css/style.css" rel="stylesheet" type="text/css">
  <link href="/sample/template/basic/basic033/css/swiper.min.css" rel="stylesheet" type="text/css">

  <script src="/sample/template/basic/basic033/js/tendina.min.js"></script>
  <script src="/sample/template/basic/basic033/js/swiper.jquery.min.js"></script>

  <script type="text/javascript"></script>

  <div id="cssZone" style="display: none">
    
  <link rel="stylesheet" href="/sample/layout/contents/quick/widequick115/css/widequick115.css" type="text/css" id="CSS_10000000098"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_037/css/slide_bnr_037.css" type="text/css" id="CSS_10000000584"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_038/css/slide_bnr_038.css" type="text/css" id="CSS_10000000585"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_036/css/slide_bnr_036.css" type="text/css" id="CSS_10000000583"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick155/css/widequick155.css" type="text/css" id="CSS_10000000366"><link rel="stylesheet" href="/sample/layout/contents/etc/etc010/css/etc010.css" type="text/css" id="CSS_10000000058"></div>
  <div class="contents">
    <div class="mainVisual" style="">
      <div class="wzwg-slide-info mainSlider_001 wzwgContextMenu" data-effect="fade" data-autoplay="none" data-slidecnt="2"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 페이드<br>반복재생 : 진행</p></span></div>
        
        <div class="wzwg-slide-data"><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0">
            <img alt="" src="/sample/template/basic/basic033/img/img_hospt04.jpg" style="
    filter: brightness(90%);
">
            <div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_ch" style="">
              <div class="inner blueBorder3px">
                <h2 class="mTitle fs50 tit" style="
    color: #fff;
">위즈메디칼의<br><b>​정확한 진단</b>과 <b>최선의 진료</b></h2>
                <p class="fs18 bContent smallp linehgt150" style="
    color: #fff;
">위즈메디칼은 전문의가 최선의 치료와 따뜻한<br>​마음으로 성심껏 환자분들을 모십니다.</p>
              </div>
            </div>
          </div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="1">
            <img alt="" src="/sample/template/basic/basic033/img/img_hospt06.jpg" style="
    filter: brightness(90%);
">
            <div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_ch" style="">
              <div class="inner blueBorder3px">
                <h2 class="mTitle fs50 tit" style="
    color: #fff;
">위즈메디칼의<br><b>​정확한 진단</b>과 <b>최선의 진료</b></h2>
                <p class="fs18 bContent smallp linehgt150" style="
    color: #fff;
">위즈메디칼은 전문의가 최선의 치료와 따뜻한<br>​마음으로 성심껏 환자분들을 모십니다.</p>
              </div>
            </div>
          </div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="2">
            <img alt="" src="/sample/template/basic/basic033/img/img_hospt07.jpg" style="
    filter: brightness(90%);
">
            <div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_ch" style="">
              <div class="inner blueBorder3px">
                <h2 class="mTitle fs50 tit" style="
    color: #fff;
">위즈메디칼의<br><b>​정확한 진단</b>과 <b>최선의 진료</b></h2>
                <p class="fs18 bContent smallp linehgt150" style="
    color: #fff;
">위즈메디칼은 전문의가 최선의 치료와 따뜻한<br>​마음으로 성심껏 환자분들을 모십니다.</p>
              </div>
            </div>
          </div></div>

        <!-- Add Pagination -->
        <div class="swiper-pagination-center">
          <div class="swiper-pagination swiper-pagination-clickable swiper-pagination-bullets">
            <span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span>
          </div>
          <div class="indicator">
            <button class="play" style="" type="button">시작</button>
            <button class="stop off" style="display: none;" type="button">멈춤</button>
          </div>
        </div>

        <!-- Add Arrows -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>

        <div class="sampleSlide" style="display: none">
          <div class="slide_wrap wzwgContextMenu" style="width: auto">
            <img alt="" src="/sample/template/basic/basic033/img/main_visual_01.jpg">
            <div class="copy mainSlider_txt_004 txtPositionTop wzwgContextMenu totop copy_position_ch" style="">
              <div class="inner blueBorder3px">
                                  <h2 class="mTitle fs50 tit" style="
    color: #fff;
">제목을<br>입력해 주세요.</h2>
                <p class="fs18 bContent smallp linehgt150" style="
    color: #fff;
">내용을 입력해 주세요.<br>내용을 입력해 주세요.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!--  -->
    <!--  -->
    <div class="inner" style="
    margin-top: -5px;
">
      <div class="removeAxeboxZone addContentZone" id="template00">
        <div class="layout_wrap wzwgContextMenu layout_wrap_border" style="position: relative;opacity: 1;z-index: 1!important;left: 0px;top: 0px;background-color: rgb(8, 7, 12);">
          <div class="layoutInfo" style="display: none"></div>
          <div class="div_wrap layout_block1 mxwd100">
            <div class="layout_01 layout_contents_border" data-w="100" data-h="M" style="
    z-index: 2;
">
              
            

	<div class="widequick115 quickBannerConfZone wzwgWidget" data-maxitem="10" data-id="10000000098" data-nm="와이드퀵115" style="
    border-bottom: 1px solid #eee;
"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="qlink_115 quickBannerZone">
			<div class="q115link00 qlink01 changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(26, 193, 193);"> <!-- (배경색상 변경가능) -->
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/basic/basic033/img/icon_hospt01.png" alt=""></div> <!-- 아이콘변경 -->
					<p><span class="bTitle"><span style="color: #ffffff;">초진 간편예약<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></span></p>                <!-- 메뉴제목변경(글자색상) -->
					<p style="
"><span class="bContent" style="
    color: #fff;
"><span>처음 진료하는 고객을 위한 예약서비스입니다.<br>​전문 상담원이 진료예약을 도와드립니다.<span style="color: rgb(255, 255, 255);"></span></span></span></p> <!-- 메뉴내용 변경(글자색상) -->
				</a>
			</div>
			<div class="q115link00 qlink02 changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(241, 241, 241);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/basic/basic033/img/icon_hospt02.png" alt=""></div>
					<p><span class="bTitle">건강증진센터</span></p>
					<p><span class="bContent">검사부터 수술까지 체계적인 협진시스템과<br>​One-Stop 진료를 진행합니다.</span></p>
				</a>
			</div>
			<div class="q115link00 qlink03 changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(228, 228, 228);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/basic/basic033/img/icon_hospt03.png" alt=""></div>
					<p><span class="bTitle">제증명발급</span></p>
					<p><span class="bContent">의무기록 및 인터넷 제증명 발급<br>​온/오프라인 발급 안내를 도와드립니다.</span></p>
				</a>
			</div>
			<div class="q115link00 qlink04 changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/basic/basic033/img/icon_hospt04.png" alt=""></div>
					<p><span class="bTitle">진료시간표</span></p>
					<p><span class="bContent">병원 사정에 의해 변경될 수 있으므로<br>​내원 전 반드시 확인해주세요.</span></p>
				</a>
			</div>

			<div class="q115link00 qlink05 changeBg wzwgContextMenu" data-type="quick" style="background-color: #1ac1c1;">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/basic/basic033/img/icon_hospt05.png" alt=""></div>
					<p><span class="bTitle"><span style="color: #ffffff;">진료상담<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></span></p>
					<p><span class="bContent" style="
    color: #fff;
"><span>상담내용을 남겨주시면<br>​전문상담원이 답변을 드립니다.<span style="color: rgb(255, 255, 255);"></span></span></span></p>
				</a>
			</div>

		</div>		
		<div class="quick_sample" style="display: none;">
			<div class="q115link00 qlink05 changeBg wzwgContextMenu">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/layout/contents/quick/widequick115/img/115_05.png" alt=""></div>
					<p><span class="bTitle">바로가기 제목</span></p>
					<p><span class="bContent">바로가기 메뉴에 대한<br>간략한 설명 기입.(두줄)</span></p>
				</a>
			</div>
		</div>			
	</div>


</div>
          </div>
        </div>
        <div class="empty empty_100 wzwgContextMenu layout_line_border FXarea_Fade"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div></div>

        
        
						<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_Fade"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								<div class="slide_bnr_037 wzwgWidget" data-id="10000000584" data-nm="슬라이드배너037" style="
">
      <div class="bnr_slide_wrap wzwg-slide-info wzwgContextMenu" data-slidesperview="2" data-slidesperview-mobile="1" data-loop="false" data-slidecnt="3"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 안함</p></span></div>

        <div class="barColor targetBG wzwgContextMenu"></div>

        <div class="title_wrap wzwgContextMenu">
          <div class="bnr_title">
            <h3 class="bnrName bTitle">WIZMEDICAL</h3>
            <p class="bnrTxt bSubMTitle">위즈메디칼은<br>고객 맞춤 진료로<br>건강을 책임집니다</p>
          </div>
        </div>

        <div class="inner_box wzwg-slide-data" id="data"><div class="slide_group wzwgContextMenu" data-type="slide" data-index="0">  
            <a href="javascript:void(0);" class="nolink" tabindex="0">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/layout/contents/slide/slide_bnr_037/img/sample01.jpg" alt="">
                </div>
              </div>
              <div class="text_box">
                <h4 class="tit fs24 bTitle">WIZ 검진센터</h4>
                <p class="txt fs17 bContent">최첨단 장비와 대규모 내시경까지 육안으로 놓칠 수 있는 미세한 부분도 확인 가능합니다.</p>
              </div>
            </a>
          </div><div class="slide_group wzwgContextMenu" data-type="slide" data-index="1">  
            <a href="javascript:void(0);" class="nolink" tabindex="0">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/layout/contents/slide/slide_bnr_037/img/sample02.jpg" alt="">
                </div>
              </div>
              <div class="text_box">
                <h4 class="tit fs24 bTitle">소아ㆍ면역ㆍ성장</h4>
                <p class="txt fs17 bContent">위즈메디칼은 꼼꼼한 상담과 진단 시스템을 통해 원인별 맞춤치료를 진행합니다.</p>
              </div>
            </a>
          </div><div class="slide_group wzwgContextMenu" data-type="slide" data-index="2">  
            <a href="javascript:void(0);" class="nolink" tabindex="-1">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/layout/contents/slide/slide_bnr_037/img/sample03.jpg" alt="">
                </div>
              </div>
              <div class="text_box">
                <h4 class="tit fs24 bTitle">인대손상ㆍ연골부상ㆍ탈골</h4>
                <p class="txt fs17 bContent">운동 중 반복되는 부상 비수술치료와 도수치료로 증상 개선을 도와드리겠습니다.</p>
              </div>
            </a>
          </div></div>

        <!-- sample -->
        <div class="sampleSlide" style="display:none;">
          <div class="slide_group wzwgContextMenu">  
            <a href="javascript:void(0);" class="nolink">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/layout/contents/slide/slide_bnr_037/img/sample01.jpg" alt="">
                </div>
              </div>
              <div class="text_box">
                <h4 class="tit fs24 bTitle">제목을 입력하세요.</h4>
                <p class="txt fs17 bContent">내용을 입력하세요.<br>내용을 입력하세요.</p>
              </div>
            </a>
          </div> 
        </div>

      </div>
    </div></div>
							</div>
						</div>
				 		
				 	
				 	<div class="empty empty_100 wzwgContextMenu layout_line_border FXarea_Fade"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div></div>
				 		
				 	
			            		
								

			            	
        

        
				 		
				 	
        
        
        

        
				 		<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_Fade" style="position: relative; opacity: 1; z-index: 3; left: 0px; top: 0px;"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										<div class="slide_bnr_038 wzwgWidget" data-id="10000000585" data-nm="슬라이드배너038" style="
">

      <div class="title_wrap wzwgContextMenu">
        <div class="bnr_title">
          <h3 class="bnrName bSubTitle">WIZMEDICAL</h3>
          <p class="bnrTxt mTitle">안녕하세요.<br>위즈메디칼<br>대표원장 홍길동입니다.</p>
        </div>
      </div>

      <div class="bnr_group boardBg">
        <div class="slide_imgwrap wzwgContextMenu">
          <div class="txt_box">
            <p class="txt_item bContent">
              - 대한약침학회<br>
              - 서울위즈고 수석졸업<br>
              - 대한통증학회<br>
              - 위즈대학교 의과대학 1기<br>
              - 대한희귀난치질환학회<br>
              - 강남위즈병원 객원 연구위원<br>
              - 대한한의영상학회<br>
              - 위즈대학교 의과대학 대학원<br>
              - 대한재활의학회<br>
              - 한방재활의학과 석박사 논문 중
            </p>
          </div>
          <div class="slide_item_wrap wzwg-slide-info wzwgContextMenu" data-slidesperview="3" data-slidesperview-mobile="1" data-loop="false" data-slidecnt="5"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 안함</p></span></div>
            <ul class="thumb_wrap wzwg-slide-data" id="data"><li class="slide_group wzwgContextMenu" data-type="slide" data-index="0">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb01.jpg" alt="">
                  </div>
                </div>
              </li><li class="slide_group wzwgContextMenu" data-type="slide" data-index="1">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb02.jpg" alt="">
                  </div>
                </div>
              </li><li class="slide_group wzwgContextMenu" data-type="slide" data-index="2">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb03.jpg" alt="">
                  </div>
                </div>
              </li><li class="slide_group wzwgContextMenu" data-type="slide" data-index="3">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb04.jpg" alt="">
                  </div>
                </div>
              </li><li class="slide_group wzwgContextMenu" data-type="slide" data-index="4">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb05.jpg" alt="">
                  </div>
                </div>
              </li></ul>

            <!-- sample -->
            <div class="sampleSlide" style="display:none;">
              <li class="slide_group wzwgContextMenu">
                <div class="slide_item">
                  <div class="img_box">
                    <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_thumb01.jpg" alt="">
                  </div>
                </div>
              </li>
            </div>
            <!-- // -->
          </div>
        </div>

        <div class="bnr_item wzwgContextMenu">
          <div class="img_box">
            <img src="/sample/layout/contents/slide/slide_bnr_038/img/img_ceo01.jpg" alt="">
          </div>
        </div>

      </div>
    </div></div>
									</div>
								</div><div class="empty empty_100 wzwgContextMenu layout_line_border FXarea_Fade" style="position: relative; opacity: 1; z-index: 3; left: 0px; top: 0px;"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div></div>
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block1">
								<div class="layout_01 layout_contents_border addLayoutContentsZone" data-w="100" data-h="M">
								<div class="slide_bnr_036 wzwgWidget" data-id="10000000583" data-nm="슬라이드배너036">
    <div class="wzwg-slide-info wzwgContextMenu" data-centermode="true" data-slidesperview="1" data-slidesperview-mobile="1" data-slidecnt="5"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 진행</p></span></div>
      
      <div class="wzwg-slide-data" id="data"><div class="slider_item wzwgContextMenu" data-type="slide" data-index="0">
          <a href="#" tabindex="0">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient01.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">WIZMEDICAL</span>
              <p class="subtxt bSubMTitle">위즈메디칼만의<br>최적의 치료 공간 및 시스템</p>
              <p class="place_name bContent changeBg">01 진료실</p>
            </div>
          </a>
        </div><div class="slider_item wzwgContextMenu" data-type="slide" data-index="1">
          <a href="#" tabindex="-1">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient02.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">WIZMEDICAL</span>
              <p class="subtxt bSubMTitle">프라이빗한 룸에서 받을 수 있는<br>물리치료실</p>
              <p class="place_name bContent changeBg">02 물리치료실</p>
            </div>
          </a>
        </div><div class="slider_item wzwgContextMenu" data-type="slide" data-index="2">
          <a href="#" tabindex="-1">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient03.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">WIZMEDICAL</span>
              <p class="subtxt bSubMTitle">오직 환자를 위한 공간<br>디테일로 완성된 시설</p>
              <p class="place_name bContent changeBg">03 의과진료실</p>
            </div>
          </a>
        </div><div class="slider_item wzwgContextMenu" data-type="slide" data-index="3">
          <a href="#" tabindex="-1">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient04.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">WIZMEDICAL</span>
              <p class="subtxt bSubMTitle">조용하고 깨끗한 인테리어로<br>편안하게 대기하실 수 있습니다</p>
              <p class="place_name bContent changeBg">04 대기실</p>
            </div>
          </a>
        </div><div class="slider_item wzwgContextMenu" data-type="slide" data-index="4">
          <a href="#" tabindex="-1">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient05.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">WIZMEDICAL</span>
              <p class="subtxt bSubMTitle">환자 중심으로 일대일 진료<br>최적의 치료 공간 및 시스템</p>
              <p class="place_name bContent changeBg">05 회복실</p>
            </div>
          </a>
        </div></div>

      <!-- sample -->
      <div class="sampleSlide" style="display:none">
        <div class="slider_item wzwgContextMenu">
          <a href="#">
            <div class="imgwrap">
              <div class="imgbox">
                <img src="/sample/layout/contents/slide/slide_bnr_036/img/img_patient01.jpg" alt="">
              </div>
            </div>
            <div class="txtlist">
              <span class="tittxt fs24 bTitle">제목 변경 입니다.</span>
              <p class="subtxt bSubMTitle">소제목 변경 입니다.</p>
              <p class="place_name bContent changeBg">내용 변경 입니다.</p>
            </div>
          </a>
        </div>
      </div>

    </div>
  </div></div>
							</div>
						</div>
				 		<div class="empty empty_100 wzwgContextMenu layout_line_border"></div>
				 	
				 	
			            		
								

			            	
						<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_Fade"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								<!-- widget - widequick155 -->
    <div class="widequick155 quickBannerConfZone noChangeBg wzwgWidget" data-id="10000000366" data-nm="와이드퀵155"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>

        <img class="bnrBg qImgBg" src="/sample/template/basic/basic033/img/img_hospt02.jpg" alt="">

        <div class="contWrap qChangeBg p50">

            <div class="titWrap wzwgContextMenu bTextAlign">
                <p class="qtit fs28 white mTitle"><b>특성화센터</b></p>
                <p class="qtxt fs18 white mt10 bSubMTitle">끊임없는 연구와 각 분야 전문의의 협진</p>
            </div>

            <ul class="wd100 bnrWrap quickBannerZone qContentAlign"> 

                <!-- 퀵메뉴 01 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(66,87,114,0.8)">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp14.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>심혈관센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 02 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(87,128,130,0.8)">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp03.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>뇌신경센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 03 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(0,0,0,0.7)">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp05.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>척추센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 04 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(66,87,114,0.7);">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp19.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>관절센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 05 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(87,128,130,0.7);">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp16.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>소화기센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 06 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(0,0,0,0.7);">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp18.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>호흡기센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 07 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(66,87,114,0.7)">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp08.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>인공신장센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

                <!-- 퀵메뉴 08 -->
                <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(0,0,0,0.75);">
                    <a href="javascript:void(0);" class="">
                        <span class="iconbox i-block">
                            <img class="bIcon" src="/sample/template/basic/basic033/img/icon_hosp10.png" alt="">
                        </span>
                        <span class="block fs22 tit white mTitle"><b>외과센터</b></span>
                        <span class="block fs15 txt white bContent">
                            퀵메뉴 설명을 입력합니다.<br>
                            레이아웃에 따라 노출되는 줄 수가 달라집니다.
                        </span>
                    </a>
                </li>

            </ul>

        </div>



        <!-- sample 퀵메뉴 추가 -->
        <ul class="quick_sample" style="display:none;">
            <li class="wzwgContextMenu changeBg" data-type="quick" style="background-color:rgba(0,0,0,0.7);">
                <a href="javascript:void(0);" class="">
                    <span class="iconbox i-block">
                        <img class="bIcon" src="/sample/layout/contents/quick/widequick155/img/icon01.png" alt="">
                    </span>
                    <span class="block fs22 tit white mTitle"><b>퀵메뉴 제목</b></span>
                    <span class="block fs15 txt white bContent">
                        퀵메뉴 설명을 입력합니다.<br>
                        레이아웃에 따라 노출되는 줄 수가 달라집니다.
                    </span>
                </a>
            </li>
        </ul>

    </div>
    <!-- /widget - widequick155 --></div>
							</div>
						</div>
				 	
				 		
						<div class="layout_wrap wzwgContextMenu layout_wrap_border FXarea_Fade" style="background-color: rgb(13, 50, 111);"><div class="layoutInfo" style="display:none"> <span>페이드 효과적용</span></div>
							<div class="div_wrap layout_block2">
								<div class="layout_02 layout_contents_border layout_height_H" data-w="50" data-h="H">
					<div class="etc010 wzwgContextMenu changeBg wzwgWidget" data-id="10000000058" data-nm="퀵메뉴006" style="background-color: rgb(13, 50, 111);">
						<div class="etc010div_wrap">
							 <div class="etc010conBox">
								<div class="etc010Block1">
									<p class="etc010title bTitle"><span style="color: #ffffff;">모바일 앱 이용안내<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></p>
									<span class="etc010subtitle bContent"><span style="color: #ffffff;">핸드폰 하나로 병원에 대한 다양한 정보를 확인할 수 있습니다.<span style="color: rgb(255, 255, 255);"></span></span></span>
									<ul class="etc010click">
										<li class="etc010clickleft unityLink_four_001 wzwgContextMenu"><a href="#" class="bSubTitle targetBG bBorderBg" style="border-color: rgb(255, 255, 255);"><span style="color: #ffffff;">안드로이드<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></a></li>
										<li class="etc010clickright unityLink_four_001 wzwgContextMenu"><a href="#" class="bSubTitle targetBG bBorderBg" style="border-color: rgb(255, 255, 255);"><span style="color: #ffffff;">IOS<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></a></li>
									</ul>
								</div>
							 </div>
						</div>
					</div></div>
								<div class="layout_02 layout_contents_border layout_height_H" data-w="50" data-h="H">
					<div class="etc010 wzwgContextMenu changeBg wzwgWidget" data-id="10000000058" data-nm="퀵메뉴006" style="background-color: rgb(13, 50, 111);">
						<div class="etc010div_wrap">
							 <div class="etc010conBox">
								<div class="etc010Block1">
									<p class="etc010title bTitle"><span style="color: #ffffff;">오시는 길<span style="color: rgb(255, 255, 255);"></span></span></p>
									<span class="etc010subtitle bContent"><span style="color: #ffffff;">서울시 동대문구 왕산로9길 위즈메디칼<span style="color: rgb(255, 255, 255);"></span></span></span>
									<ul class="etc010click">
										<li class="etc010clickleft unityLink_four_001 wzwgContextMenu"><a href="#" class="bSubTitle targetBG bBorderBg" style="border-color: rgb(255, 255, 255);"><span style="color: #ffffff;">카카오지도<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></a></li>
										<li class="etc010clickright unityLink_four_001 wzwgContextMenu"><a href="#" class="bSubTitle targetBG bBorderBg" style="border-color: rgb(255, 255, 255);"><span style="color: #ffffff;">주차안내<span style="color: rgb(255, 255, 255);"></span></span><span style="color: ffffff;"><span></span></span></a></li>
									</ul>
								</div>
							 </div>
						</div>
					</div></div>
							</div>
						</div>
				 	
						
				 	
				 	
			            		
								

			            	
			            		
								

			            	
						
				 		
				 		
				 	
				 	
				 		
				 	
				 		
				 	
				 		
			            		
								
				 		
				 	

			            	
				 	
						
				 		
				 	
				 		
				 	
				 	
				 		
			            		
								

			            	
						
				 		
				 	
				 	
				 	
				 	
				 		
				 	
				 		
				 	
				 		
				 	
				 	

        
			            		
								

			            	
				 		
				 	

        
        
        
			            		
								

			            	
				 		
				 	
        

        
				 		
				 	
				 		
				 	
				 		
				 	

        
      </div>
      <!--template00 끝. -->
    </div>
    <!-- inner 끝 -->
  </div>
</div>
<c:import url="${footerUrl}"></c:import>

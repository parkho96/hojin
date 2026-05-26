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
	<link type="text/css" href="/sample/template/wide/wide038/css/style.css" rel="stylesheet">
	<link rel="stylesheet" href="/sample/template/wide/wide038/css/swiper.min.css">
  
  	<script src="/sample/template/wide/wide038/js/tendina.min.js"></script>
  	<script src="/sample/template/wide/wide038/js/swiper.jquery.min.js"></script>
  	
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

	<div id="cssZone" style="display:none;"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_037/css/slide_bnr_037.css" type="text/css" id="CSS_10000000584"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick002/css/widequick002.css" type="text/css" id="CSS_10000000027"><link rel="stylesheet" href="/sample/layout/contents/banner/banner140/css/banner140.css" type="text/css" id="CSS_10000000537"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick136/css/widequick136.css" type="text/css" id="CSS_10000000308"><link rel="stylesheet" href="/sample/layout/contents/map/map013/css/map013.css" type="text/css" id="CSS_10000000582"><link rel="stylesheet" href="/sample/layout/contents/board/board018/css/board018.css" type="text/css" id="CSS_10000000299"><link rel="stylesheet" href="/sample/layout/contents/quick/quick005_mh/css/quick005.css" type="text/css" id="CSS_10000000029"><link rel="stylesheet" href="/sample/layout/contents/slide/slide_bnr_039/css/slide_bnr_039.css" type="text/css" id="CSS_10000000424"></div><div class="contents">
		
<div class="mainVisual">
			<div class="wzwg-slide-info mainSlider_001 wzwgContextMenu" data-autoplay="none" data-effect="fade" data-slidecnt="2" data-speed="nomal"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 페이드<br>반복재생 : 진행<br>전환속도 : 보통</p></span></div>
				<div class="wzwg-slide-data slick_slide"><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="0">
						
							<img src="/sample/template/wide/wide038/img/main_visual01.jpg" alt=""><div class="copy txtPositionTop mainSlider_txt_005 wzwgContextMenu toright copy_position_ch"><div class="inner blueBorder3px">
									<h2 class="mTitle slide_tit">
    위즈메디칼의 정확한 진단과<br><br></h2>
									<p class="bContent slide_txt">
    위즈메디칼은 전문의가 최선의 치료와 따뜻한 마음으로<br>
    ㅇㄹ</p>

								</div>
							</div>
							
						
					</div><div class="slide_wrap wzwgContextMenu" data-type="slide" data-index="1">
						
							<img src="/sample/template/wide/wide038/img/main_visual01.jpg" alt=""><div class="copy txtPositionTop mainSlider_txt_005 wzwgContextMenu toleft copy_position_ch"><div class="inner blueBorder3px">
									<h2 class="mTitle slide_tit">
메인 슬라이드 제목
</h2>
									<p class="bContent slide_txt">
    메인 슬라이드 설명을 입력해주세요
</p>

								</div>
							</div>
							
						
					</div></div>
				

				
				<div class="swiper-pagination-center">
					
					<div class="indicator" style="display: block;">
						<button class="play" style="" type="button">시작</button>		
						<button class="stop off" style="display: none;" type="button">멈춤</button>				
					</div>
				</div>

				
				
								
						
				<div class="sampleSlide" style="display: none;">
					<div class="slide_wrap wzwgContextMenu">
						
							<img src="/sample/template/wide/wide038/img/main_visual01.jpg" alt=""><div class="copy txtPositionTop mainSlider_txt_005 wzwgContextMenu toleft copy_position_lh"><div class="inner blueBorder3px">
									<h2 class="mTitle slide_tit">
메인 슬라이드 제목
</h2>
									<p class="bContent slide_txt">
    메인 슬라이드 설명을 입력해주세요
</p>

								</div>
							</div>
							
						
					</div>
				</div>
			</div>	  
    </div>  

		
		
			
		
		
		<div class="inner" style="
    overflow: visible;
">
			<div id="template00" class="removeAxeboxZone addContentZone">
				
				
				
 	
				
 	
				
 	
				
 				

		 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
				 		
				 	
			            		
								

			            	
			            		
								

			            	
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
			            		
								

			            	
			            		
								

			            	
 	
 					
 	
					
 	
 					
 	
 					
			            		
								

			            	
 	
 					
 	
					
						
				 	
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 		                                                                     	                                                                     	                                                                     	                                                                     	                                                                     
			            		
								<div class="wide038_custom layout_wrap wzwgContextMenu layout_wrap_border">
    
    <div class="layout_over layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap mxwd100 layout_block1">
								<div class="addlayout layout_01 layout_contents_border" data-w="100" data-h="M">
								
  

  






	<div class="addst widequick002 quickBannerConfZone wzwgWidget" data-maxitem="5" data-id="10000000027" data-nm="와이드퀵002"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="qlink_5 quickBannerZone">
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg" data-type="quick" style="background-color: rgba(0, 0, 0, 0);">
				<a class="qbnr_link" href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/main_icon01.png" alt=""></div>
					<p class="qbnr_txt bTitle">대상포진</p>
				</a>
			</div>
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg" data-type="quick" style="background-color: rgba(0, 0, 0, 0);">
				<a class="qbnr_link" href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/main_icon02.png" alt=""></div>
					<p class="qbnr_txt bTitle">기능의학센터</p>
				</a>
			</div>
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg" data-type="quick" style="background-color: rgba(0, 0, 0, 0);">
				<a class="qbnr_link" href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/main_icon03.png" alt=""></div>
					<p class="qbnr_txt bTitle">줄기세포크리닉</p>
				</a>
			</div>
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg" data-type="quick" style="background-color: rgba(0, 0, 0, 0);">
				<a class="qbnr_link" href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/main_icon04.png" alt=""></div>
					<p class="qbnr_txt bTitle">암 면역치료</p>
				</a>
			</div>
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg" data-type="quick" style="background-color: rgba(0, 0, 0, 0);">
				<a class="qbnr_link" href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/main_icon05.png" alt=""></div>
					<p class="qbnr_txt bTitle">만성난치성질환</p>
				</a>
			</div>
			
		</div>	
		
		<div class="quick_sample" style="display: none;">
			<div class="q5link00 wzwgContextMenu changeBg bBorderBg">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/layout/contents/quick/widequick002/img/icon5.png" alt=""></div>
					<p><span class="bTitle">바로가기</span></p>
				</a>
			</div>
		</div>				
	</div>

</div>
							</div>


<div class="over_bg wzwgContextMenu targetBG"></div>
						</div>
						
			            		
								
			            		
								

			            	
						
						
				 	
				 	

			            	
			            		
								

			            	
				 	
				 		
				 	
			            		
								
				 		
				 	

			            	
						
				 	
			            		
								

			            	
				 		
				 	
</div>
    
    
						
			            		
								
				 		
						
			            		
								
						
						
				 	
						
				 	
				 		
				 	
						
						
				 		
				 	
			            		
								
			            		
								
				 		
				 	
			            		
								
			            		
								
				 		
				 	
			            		
								

			            	
				 		
				 	
						
				 	

			            	

			            	
				 		
				 	
						
						
				 	
				 	

			            	

			            	
				 	
				 	
				 	

			            	
				 	
				 	

			            	
				 	

			            	
				 		
				 	<div class="layout_wrap wzwgContextMenu layout_wrap_border" style="background-color: rgb(216, 224, 220);"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1" style="
    max-width: none;
">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										
		


	<div class="addst banner140 wzwgContextMenu changeBg wzwgWidget" data-id="10000000537" data-nm="배너140" style="background-color: rgb(255, 255, 255);"> <!-- 배경색 변경 -->
    <div class="bnr_wrap">
        <div class="txtbox">
            <img class="bIcon icon_symbol" src="/sample/template/wide/wide038/img/icon_H.png" alt="">
            <p class="bSubTitle stit"><b>숲과 나무를 보는 의사</b></p> 
            <h3 class="mTitle tit"><b>불치·난치병에 도전하다</b></h3>
            <p class="bSubContent btxt"><b>기능의학의 선구자 위즈메디칼</b></p>
            <p class="bContent stxt">
                대한민국 보건의료대상 특화병원부문(항노화) 위즈메디칼 <br>
                끊임없이 연구하고 노력하는 위즈메디칼이 되겠습니다.
            </p>
    <div class="img_wrap">
        <div class="img_box wzwgContextMenu"><img class="img" src="/sample/template/wide/wide038/img/award01.jpg" alt=""></div>
        <div class="img_box wzwgContextMenu"><img class="img" src="/sample/template/wide/wide038/img/award02.jpg" alt=""></div>
    </div>
</div>

        <div class="rbox">
            <div class="imgbox wzwgContextMenu">
                <img class="img" src="/sample/template/wide/wide038/img/van_hexagone.png" alt="">
            </div>
        </div>
    </div>

    <div class="targetBG side_bg"></div>
    
</div>
</div>
									</div>
								</div>
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								
	<div class="addst widequick136 quickBannerConfZone noChangeBg wzwgWidget" data-maxitem="2" data-id="10000000308" data-nm="와이드퀵136"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		
        <div class="wq136bg_wrap">
			<img class="qImgBg" src="/sample/template/wide/wide038/img/bnr_bg01.jpg" alt=""> <!-- 배경이미지 (이미지 변경가능) -->
        </div>
            
        <div class="wq136 qChangeBg" style="background-color: rgba(0, 0, 0, 0);"> <!-- 배경색상 변경가능. -->
            
            <div class="innerbox quickBannerZone">

                <div class="titbox" data-type="quick"> 
                    <h3 class="qmTitle"><b>Before &amp; AFter</b></h3> 
                    <span class="qContent">위즈메디칼에서 놀라운 변화를 확인하세요.</span> 
                </div> 
                
	                <!-- LINK 1 -->
	                <div class="wq136link00 wzwgContextMenu" data-type="quick"> 
	                    <a class="thumbLink" href="javascript:void(0);">
	                        <div class="img">
	                            <img src="/sample/template/wide/wide038/img/bfat_img01.jpg"> <!-- 퀵메뉴 이미지 변경가능 -->
	                        </div>
	                        
	                    </a>
	                </div>
	
	                <!-- LINK 2 -->
	                <div class="wq136link00 wzwgContextMenu" data-type="quick"> 
	                    <a class="thumbLink" href="javascript:void(0);">
	                        <div class="img">
	                            <img src="/sample/template/wide/wide038/img/bfat_img02.jpg"> <!-- 퀵메뉴 이미지 변경가능 -->
	                        </div>
	                        
	                    </a>
	                </div>
	                
	                <!-- LINK 3 -->
	                
	                
	                <!-- LINK 4 -->
	                
	                
	                <!-- LINK 5 -->
	                
            </div>

        </div>	
        
        <div class="quick_sample" style="display: none;">
        	<div class="wq136link00 wzwgContextMenu" data-type="quick"> 
                 <a class="thumbLink" href="javascript:void(0);">
                     <div class="img">
                         <img src="/sample/layout/contents/quick/widequick136/img/thumb05.jpg"> <!-- 퀵메뉴 이미지 변경가능 -->
                     </div>
                     <div class="hoverLayer blck">
                         <span class="bLinkTitleCol">더 보기</span>
                     </div>
                 </a>
             </div>
        </div>
        			
	</div>

</div>
							</div>
						</div>
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
									<div class="addst slide_bnr_037 wzwgWidget" data-id="10000000584" data-nm="슬라이드배너037">
      <div class="bnr_slide_wrap wzwg-slide-info wzwgContextMenu" data-slidesperview="2.5" data-slidesperview-mobile="1" data-loop="false" data-slidecnt="3"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 안함</p></span></div>

        

        <div class="title_wrap wzwgContextMenu">
          <div class="bnr_title">
            <h3 class="bnrName bSubTitle">WIZMEDICAL</h3>
            <p class="bnrTxt mTitle">위즈메디칼은<br>고객 맞춤 진료로<br>건강을 책임집니다</p>
          </div>
        </div>

        <div class="inner_box wzwg-slide-data" id="data"><div class="slide_group wzwgContextMenu" data-type="slide" data-index="0">  
            <a href="javascript:void(0);" class="nolink" tabindex="0">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/template/wide/wide038/img/bnr_slide_img01.jpg" alt="">
                </div>
              </div>
              <div class="text_box targetBG">
                <h4 class="tit fs18 bSubTitle">Predictive</h4>
                <p class="txt fs40 bTitle">미병예측</p>
              </div>
            </a>
          </div><div class="slide_group wzwgContextMenu" data-type="slide" data-index="1">  
            <a href="javascript:void(0);" class="nolink" tabindex="0">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/template/wide/wide038/img/bnr_slide_img02.jpg" alt="">
                </div>
              </div>
              <div class="text_box targetBG">
                <h4 class="tit fs18 bSubTitle">Precision</h4>
                <p class="txt fs40 bTitle">정밀진단</p>
              </div>
            </a>
          </div><div class="slide_group wzwgContextMenu" data-type="slide" data-index="2">  
            <a href="javascript:void(0);" class="nolink" tabindex="-1">
              <div class="bnr_item">
                <div class="img_box">
                  <img src="/sample/template/wide/wide038/img/bnr_slide_img03.jpg" alt="">
                </div>
              </div>
              <div class="text_box targetBG">
                <h4 class="tit fs18 bSubTitle">Personalized</h4>
                <p class="txt fs40 bTitle">개별맞춤치료</p>
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
              <div class="text_box targetBG">
                <h4 class="tit fs18 bSubTitle">부제목</h4>
                <p class="txt fs40 bTitle">제목</p>
              </div>
            </a>
          </div> 
        </div>

      </div>
    </div></div>
							</div>
						</div>
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border addLayoutContentsZone" data-w="100" data-h="M">
								
	<div class="addst slide_bnr_039 wzwgContextMenu wzwgWidget" data-id="10000000424" data-nm="슬라이드배너039"> 
    
    <!-- Banner Contents -->
    <div class="bnr_wrap">

        <!-- Text -->
        <div class="txt_wrap wzwgContextMenu">
            <div class="bSubTitle stit">
                부제목을 변경합니다.
            </div>


            <div class="mTitle tit">
                <b>제목</b>을 변경합니다. <br>
                제목은 두 줄까지 노출됩니다.
            </div>


            <div class="bContent txt">
                내용을 변경해주세요. <br>
                내용을 변경해주세요. <br>
                내용은 세 줄까지 노출됩니다.
            </div>
        </div>
        <!-- /Text -->


        <!-- Slide -->
        <div class="slide_wrap wzwg-slide-info wzwg-banner-slide-info wzwgContextMenu" data-slidesperview="1" data-slidesperview-mobile="1" data-slidecnt="2"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 슬라이드<br>반복재생 : 진행</p></span></div>

            <div class="bnr_slide wzwg-slide-data"><div class="box_img wzwgContextMenu" data-type="slide" data-index="0">
                    <img class="img" src="/sample/template/wide/wide038/img/slide_photo01.jpg" alt="">
                </div><div class="box_img wzwgContextMenu" data-type="slide" data-index="1">
                    <img class="img" src="/sample/template/wide/wide038/img/slide_photo01.jpg" alt="">
                </div></div>



            <button class="btn-arrow arrow-prev slick-prev" type="button" style="background-color: rgba(0, 0, 0, 0);">Previous</button>
            <button class="btn-arrow arrow-next slick-next" type="button" style="background-color: rgba(0, 0, 0, 0);">Next</button>

            <div class="sampleSlide" style="display:none;">
                <div class="box_img wzwgContextMenu">
                    <img class="img" src="/sample/template/wide/wide038/img/slide_photo01.jpg" alt="">
                </div>
            </div>

        </div>  
        <!-- /Slide -->

    </div>
    <!-- Banner Contents -->


    <!-- Banner Background -->
    <div class="bg_wrap">
        <div class="bg_point_color wzwgContextMenu targetBG"></div>
        <div class="bg_color changeBg"></div>

        <div class="bg_img">
            <img class="bgImg" src="/sample/layout/contents/slide/slide_bnr_039/img/bg_H_big.png" alt="">
        </div>
    </div> 
    <!-- /Banner Background -->

</div></div>
							</div>
						</div>
						<div class="empty empty_100 wzwgContextMenu layout_line_border" style="position: relative; opacity: 1; z-index: 3; left: 0px; top: 0px;"></div>
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 	<div class="free_layout layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="mxwd1820 auto_layout div_wrap layout_block3 layout_padding btw4">
								<div class="layout_03 layout_contents_border layout_height_A" data-w="33" data-h="A">	
	<div class="addst board018 cntContextSGC0000027 wzwgWidget" data-id="10000000299" data-nm="게시판018"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			<div class="title">
			    <h3 class="menuNm boardtit">공지사항</h3>
			    <a href="javascript:void(0);" class="menuSeq bMoreBrCol morebtn" title="게시판으로 이동합니다">더 보기</a>
			</div>
			<ul class="dataList">
				<li>
					<p class="date">
    <span class="day" data-attr="frstRegistPnttm">0000.00.00</span>
    <span class="month" data-attr="frstRegistPnttm">0000.00.00</span>
</p>
					<a href="javascript:void(0);" class="link_txt" data-href="bbsViewLink">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				<li>
					<p class="date">
    <span class="day" data-attr="frstRegistPnttm">0000.00.00</span>
    <span class="month" data-attr="frstRegistPnttm">0000.00.00</span>
</p>
					<a href="javascript:void(0);" data-href="bbsViewLink" class="link_txt">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				<li>
					<p class="date">
    <span class="day" data-attr="frstRegistPnttm">0000.00.00</span>
    <span class="month" data-attr="frstRegistPnttm">0000.00.00</span>
</p>
					<a href="javascript:void(0);" data-href="bbsViewLink" class="link_txt">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				

				<li class="no_data" style="display:none;"> <!-- display:none 되어있는 상태 -->
					<strong class="tit">작성된 게시글이 없습니다.</strong>
				</li>
			</ul>
	</div></div>
								<div class="layout_03 layout_contents_border layout_height_A" data-w="33" data-h="A">	
	<div class="addst board018 date_color cntContextSGC0000027 wzwgWidget" data-id="10000000299" data-nm="게시판018"><div class="wigetController" style="display: none;">+<span class="help">게시판을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			<div class="title">
			    <h3 class="menuNm boardtit">온라인 상담</h3>
			    <a href="javascript:void(0);" class="menuSeq bMoreBrCol morebtn" title="게시판으로 이동합니다">더 보기</a>
			</div>
			<ul class="dataList">
				<li>
					<p class="date"><span data-attr="frstRegistPnttm">0000.00.00</span></p>
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				<li>
					<p class="date"><span data-attr="frstRegistPnttm">0000.00.00</span></p>
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				<li>
					<p class="date"><span data-attr="frstRegistPnttm">0000.00.00</span></p>
					<a href="javascript:void(0);" data-href="bbsViewLink">
						<p class="tit fs17" data-attr="nttSj">글제목이 노출됩니다. 게시판 미리보기 디자인입니다.</p>
						<p class="co" data-attr="nttCnChrctr">게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다. 게시글 내용 예시입니다. 최근 게시글의 내용이 노출됩니다.</p>
					</a>
				</li>
				

				<li class="no_data" style="display:none;"> <!-- display:none 되어있는 상태 -->
					<strong class="tit">작성된 게시글이 없습니다.</strong>
				</li>
			</ul>
	</div></div>
								<div class="layout_03 layout_contents_border layout_height_A" data-w="33" data-h="A">
	<div class="addst quick005 quickBannerConfZone wzwgWidget" data-maxitem="8" data-id="10000000029" data-nm="퀵메뉴005"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>

		<div class="qlink_5 quickBannerZone">
			<div class="q5link00 qlink01 wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(75, 101, 96);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/qbnr_icon01.png" alt=""></div>
					<p><span class="bTitle">바로가기 01</span></p>
				</a>
			</div>
			<div class="q5link00 qlink02 wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(47, 79, 79);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/qbnr_icon02.png" alt=""></div>
					<p><span class="bTitle">바로가기 02</span></p>
				</a>
			</div>
			<div class="q5link00 qlink03 wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(60, 81, 77);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/qbnr_icon03.png" alt=""></div>
					<p><span class="bTitle">바로가기 03</span></p>
				</a>
			</div>
			<div class="q5link00 qlink04 wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(45, 61, 58);">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/template/wide/wide038/img/qbnr_icon04.png" alt=""></div>
					<p><span class="bTitle">바로가기 04</span></p>
				</a>
			</div>

			
			
			
			
			
		</div>
				
		<div class="quick_sample" style="display: none;">
			<div class="q5link00 qlink04 wzwgContextMenu changeBg">
				<a href="javascript:void(0);">
					<div class="icon"><img class="bIcon" src="/sample/layout/contents/quick/quick005_mh/img/icon/icon4.png" alt=""></div>
					<p><span class="bTitle">바로가기</span></p>
				</a>
			</div>
		</div>			
	</div>
</div>
							</div>
						</div>
						
				 	
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 	
				 		<div class="empty empty_100 wzwgContextMenu layout_line_border"></div>
				 	
				 		
				 	
						<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								<div class="addst map013 cntContext10000000213 wzwgWidget" data-id="10000000582" data-nm="지도013">
	<div class="map_bgcolor changeBg" style="background-color: rgba(0, 0, 0, 0);">
    
</div>

<img class="map_bg bgImg" src="/sample/template/wide/wide038/img/map_bg.jpg" alt=""><div class="mxwd1820 map_wrap bContentAlign" style="text-align:left;">

		<div class="left_wrap">

			<ul class="cont_box">
				<li class="item wzwgContextMenu">
					<div class="icon">
						<img class="bIcon" src="/sample/layout/contents/map/map013/img/icon_01.png" alt="">
					</div>
					<div class="title bTitle">
						<b>전화상담</b>
					</div>
					<div class="num bContent">
						070-5129-2976
					</div>
				</li>

				<li class="item wzwgContextMenu">
					<div class="icon">
						<img class="bIcon" src="/sample/layout/contents/map/map013/img/icon_02.png" alt="">
					</div>
					<div class="title bTitle">
						<b>오시는길</b>
					</div>
					<div class="text bContent">
						서울특별시 동대문구 왕산로9길 8 충호빌딩 501호
					</div>
				</li>

				<li class="item wzwgContextMenu">
					<div class="icon">
						<img class="bIcon" src="/sample/layout/contents/map/map013/img/icon_03.png" alt="">
					</div>
					<div class="title bTitle">
						<b>진료시간</b>
					</div>

					<ul class="time">
						<li class="wzwgContextMenu">
							<strong class="cate bSubTitle">월 ~ 금</strong>
							<span class="c_text bContent">09:00 ~ 18:20</span>
						</li>
						<li class="wzwgContextMenu">
							<strong class="cate bSubTitle">토요일</strong>
							<span class="c_text bContent">09:00 ~ 13:00</span>
						</li>
						<li class="wzwgContextMenu">
							<strong class="cate bSubTitle">점&nbsp;&nbsp;&nbsp;&nbsp;심</strong>
							<span class="c_text bContent">12:30 ~ 13:30</span>
						</li>
					</ul>
				</li>
			</ul>

		</div>

		<div class="right_wrap">
			<a class="map" href="javascript:void(0);" title="">
				<img class="mapImg" src="/sample/layout/contents/map/map013/img/map_sample.jpg" alt="">
			</a>
		</div>

	</div>
</div></div>
							</div>
						</div>
				 	
				 	
						
				 	
				 	
				 	
				 	</div> <!--template00 끝. -->
		</div><!-- inner 끝 -->
	</div>
    
    
    
    
    
    
    
</div>
<c:import url="${footerUrl}"></c:import>

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
	<link type="text/css" href="/sample/template/wide/wide031/css/style.css" rel="stylesheet">
	<link rel="stylesheet" href="/sample/template/wide/wide031/css/swiper.min.css">
  
  	<script src="/sample/template/wide/wide031/js/tendina.min.js"></script>
  	<script src="/sample/template/wide/wide031/js/swiper.jquery.min.js"></script>
  	
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

	<div id="cssZone" style="display:none;"><link rel="stylesheet" href="/sample/layout/contents/quick/quick116/css/quick116.css" type="text/css" id="CSS_10000000197"><link rel="stylesheet" href="/sample/layout/contents/etc/logo_slide002/css/logo_slide002.css" type="text/css" id="CSS_10000000231"><link rel="stylesheet" href="/sample/layout/contents/rolling/roll_img123/css/roll_img123.css" type="text/css" id="CSS_10000000232"><link rel="stylesheet" href="/sample/layout/contents/quick/quick121/css/quick121.css" type="text/css" id="CSS_10000000283"><link rel="stylesheet" href="/sample/layout/contents/quick/quick125/css/quick125.css" type="text/css" id="CSS_10000000438"><link rel="stylesheet" href="/sample/layout/contents/quick/widequick140/css/widequick140.css" type="text/css" id="CSS_10000000439"><link rel="stylesheet" href="/sample/layout/contents/board/board116/css/board116.css" type="text/css" id="CSS_10000000164"><link rel="stylesheet" href="/sample/layout/contents/etc/bnrSlide002/css/bnrSlide002.css" type="text/css" id="CSS_10000000482"></div><div class="contents">
		<div class="wide025_mainbox">
<div class="mainVisual">
			<div class="wzwg-swiper swiper-container mainSlider_001 wzwgContextMenu" data-autoplay="auto" data-effect="fade"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 자동<br>화면전환 : 페이드</p></span></div>
				<div class="swiper-wrapper">
					<div class="swiper-slide" style="width: auto;">
						<a href="javascript:void(0);" class="wzwgContextMenu">
							<img src="/sample/template/wide/wide031/img/main01.jpg" alt="" style="width: 100%;/* height: 100%; */" class="bgImg"></a><div class="copy mainSlider_txt_005 txtPositionTop wzwgContextMenu copy_position_lh"><div class="inner blueBorder3px">
									<div><p class="bSubContent subtitp">WIZWIG OFFICE OF EDUCATION </p></div>

<div><h2 class="mTitle">미래를 함께 여는 학교<br>소통과 협력의 참여교육</h2></div>
									<div><p class="bContent smallp" style="">학습, 심리·정서, 사회성 등 결손을 적극적으로 극복하고<br>더 나은 미래교육 도약을 위해 종합적 지원에 나서겠습니다.</p></div>
								</div>
							</div>


<div class="popImgbox "><div class="imgbox wzwgContextMenu"><img class="bIcon" src="/sample/template/wide/wide031/img/popimg.png" alt=""></div></div>


							
						
					</div>

					
	
				
					
				
					
				
					
				
					
				
					
				
					
				</div>
				

				
				

				
				
								
						
				<div class="sampleSlide" style="display: none;">
					<div class="swiper-slide" style="width: auto;">
						<a href="javascript:void(0);" class="wzwgContextMenu">
							<img src="/sample/template/wide/wide031/img/main01.jpg" alt="" class="bgImg">
</a><div class="copy mainSlider_txt_005 txtPositionTop wzwgContextMenu copy_position_ch"><a href="javascript:void(0);">
								</a><div class="inner blueBorder3px"><a href="javascript:void(0);">
									<div><h3 class="mTitle" style="">희망과 함께 미래를 디자인하는<br>경기도교육청</h3></div>
									<div><p class="bContent smallp" style="">새로운 학교, 함께하는 경기교육<br>
누구나 참여하고 모두가 만족하는 경기교육</p></div></a>
								</div>
							</div><div class="popImgbox"><div class="imgbox wzwgContextMenu"><img class="bIcon" src="/sample/template/wide/wide031/img/popimg2.png" alt=""></div></div>

							
						
					</div>
				</div>
			</div>	  
    </div><div id="templateFix" class="inner_layer">
			<!-- 간격없는 2단 -->
			
			
			<div class="layout_wrap wzwgContextMenu layout_wrap_border">
						<div class="div_wrap layout_block4 layout_padding">
								<div class="layout_04 layout_contents_border layout_height_H" data-w="25" data-h="H">


	


	

	<div class="quick125 quickBannerConfZone noChangeBg" data-maxitem="8"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="bg">
			<img class="qImgBg" src="/sample/template/wide/wide031/img/qbg_01.jpg"> <!-- 배경이미지 교체가능(class네임을 상위 div에 두었어요!) -->
		</div>	

		<div class="textbox">
			<div class="titlebox">
				<strong class="qTitle">학부모</strong> <!-- 퀵메뉴 최고 대제목 -->
			</div>

			<div class="linkbox quickBannerZone"> 
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학구도안내서비스</p> <!-- 메뉴제목변경(글자색상) -->		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학부모서비스</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학교알리미</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">돌봄지원센터</p>		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">다문화교육지원센터</p>	
					</a>
				</div>
				

				

				
			</div>
		</div>
		
		
		<div class="iconbox">
			<img class="bIcon" src="/sample/template/wide/wide031/img/qicon_01.png" alt="">
		</div>
				
		<div class="quick_sample" style="display: none;">
			<div class="q111link wzwgContextMenu">
				<a href="javascript:void(0);">
					<p class="bTitle">바로가기 제목</p>
				</a>
			</div>
		</div>	
	</div>
</div>
								<div class="layout_04 layout_contents_border layout_height_H" data-w="25" data-h="H">
					<!-- quick012 end -->
	

	<div class="quick125 quickBannerConfZone noChangeBg" data-maxitem="8"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="bg">
			<img class="qImgBg" src="/sample/template/wide/wide031/img/qbg_02.jpg"> <!-- 배경이미지 교체가능(class네임을 상위 div에 두었어요!) -->
		</div>	

		<div class="textbox">
			<div class="titlebox">
				<strong class="qTitle">학생</strong> <!-- 퀵메뉴 최고 대제목 -->
			</div>

			<div class="linkbox quickBannerZone"> 
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">독서교육종합지원</p> <!-- 메뉴제목변경(글자색상) -->		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">진로진학지원센터</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">사이버학습</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학습종합클리닉센터</p>		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">수학체험센터</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">고교학점제지원센터</p>
					</a>
				</div>

				

				
			</div>
		</div>
		
		
		<div class="iconbox">
			<img class="bIcon" src="/sample/template/wide/wide031/img/qicon_02.png" alt="">
		</div>
				
		<div class="quick_sample" style="display: none;">
			<div class="q111link wzwgContextMenu">
				<a href="javascript:void(0);">
					<p class="bTitle">바로가기 제목</p>
				</a>
			</div>
		</div>	
	</div>
</div>
								<div class="layout_04 layout_contents_border layout_height_H" data-w="25" data-h="H">
	<div class="quick125 quickBannerConfZone noChangeBg" data-maxitem="8"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="bg">
			<img class="qImgBg" src="/sample/template/wide/wide031/img/qbg_03.jpg"> <!-- 배경이미지 교체가능(class네임을 상위 div에 두었어요!) -->
		</div>	

		<div class="textbox">
			<div class="titlebox">
				<strong class="qTitle">교육청특성화</strong> <!-- 퀵메뉴 최고 대제목 -->
			</div>

			<div class="linkbox quickBannerZone"> 
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">교육치유지원센터</p> <!-- 메뉴제목변경(글자색상) -->		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">교육감페이지</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">교육과정</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">에듀힐링센터</p>		
					</a>
				</div>
				
				

				

				
			</div>
		</div>
		
		
		<div class="iconbox">
			<img class="bIcon" src="/sample/template/wide/wide031/img/qicon_03.png" alt="">
		</div>
				
		<div class="quick_sample" style="display: none;">
			<div class="q111link wzwgContextMenu">
				<a href="javascript:void(0);">
					<p class="bTitle">바로가기 제목</p>
				</a>
			</div>
		</div>	
	</div>
</div>
								<div class="layout_04 layout_contents_border layout_height_H" data-w="25" data-h="H">
	<div class="quick125 quickBannerConfZone noChangeBg" data-maxitem="8"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="bg">
			<img class="qImgBg" src="/sample/template/wide/wide031/img/qbg_04.jpg"> <!-- 배경이미지 교체가능(class네임을 상위 div에 두었어요!) -->
		</div>	

		<div class="textbox">
			<div class="titlebox">
				<strong class="qTitle">일반</strong> <!-- 퀵메뉴 최고 대제목 -->
			</div>

			<div class="linkbox quickBannerZone"> 
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">감사결과공개</p> <!-- 메뉴제목변경(글자색상) -->		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">국민제안방</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">법무행정서비스</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">계약정보공개</p>		
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">도서요약서비스</p>	
					</a>
				</div>
				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">원격지원서비스</p>
					</a>
				</div>

				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학원/교습소 안내</p>
					</a>
				</div>

				<div class="q111link wzwgContextMenu" data-type="quick">
					<a href="javascript:void(0);">
						<p class="bTitle">학교폭력종합정보</p>
					</a>
				</div>
			</div>
		</div>
		
		
		<div class="iconbox">
			<img class="bIcon" src="/sample/template/wide/wide031/img/qicon_04.png" alt="">
		</div>
				
		<div class="quick_sample" style="display: none;">
			<div class="q111link wzwgContextMenu">
				<a href="javascript:void(0);">
					<p class="bTitle">바로가기 제목</p>
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
				
				
				
 	
				
 	
				
 	
				
 				

		 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 	
					
 	
 					
 	
					
 	
 					
 	
 					
 		                                                                     
						<div class="empty empty_50 wzwgContextMenu layout_line_border" style="position: relative; opacity: 1; z-index: 2; left: 0px; top: 0px;"></div>
						
				 	
				 		<div class="empty empty_20 wzwgContextMenu layout_line_border"></div>
				 	<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block2 layout_padding">
								<div class="layout_02 layout_contents_border layout_height_M" data-w="50" data-h="M">
  
	<div class="board116 customwidget wzwg-tab-board wzwgContextMenu changeBg"> <!-- (배경색상 변경가능) -->
		<ul class="board_wrap wzwg-tab-list">
			<li class="li wzwg-tab active"> <!-- 게시판 1개 -->
				<div class="cntContextSGC0000027 noChangeBg">
					<h2>
						<a href="javascript:;" class="board_name menuNm">공지사항</a> <!-- 게시판제목 연동 (a:글자색상변경 가능) -->
					</h2>
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bLinkCol">+</a> <!-- 해당 게시판으로 넘어가는 링크 -->
					</div>

					<ul class="dataList">
						<li><a href="javascript:;" data-href="bbsViewLink">
							<p class="tit" data-attr="nttSj">첫번째 탭의 게시판 글들이 노출됩니다.</p> <!-- (p:글자색상변경 가능) -->
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li> <!-- (span:글자색상변경 가능) -->
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						

						<li class="no_data" style="display:none;"> <!-- 글 없을때 노출값 -->
				            <p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        </li>
					</ul>
				</div>
			</li>


			<li class="li wzwg-tab"> <!-- 게시판 2개 -->
				<div class="cntContextSGC0000027 noChangeBg">
					<h2>
						<a href="javascript:;" class="board_name menuNm">보도자료</a> 
					</h2>
					
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bLinkCol">+</a> 
					</div>
					<ul class="dataList">

						<li><a href="javascript:;" data-href="bbsViewLink">
							<p class="tit" data-attr="nttSj">두번째 탭의 게시판 글들이 노출됩니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>

						<li class="no_data" style="display:none;">
				            <p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        </li>
					</ul>
				</div>
			</li>


			<li class="li wzwg-tab"> <!-- 게시판 3개 -->
				<div class="cntContextSGC0000027 noChangeBg">
					<h2>
						<a href="javascript:;" class="board_name menuNm">채용공고</a> 
					</h2>
					<div class="more_box">
						<a href="javascript:void(0);" class="more_btn menuSeq bLinkCol">+</a> 
					</div>
					
					<ul class="dataList">

						<li><a href="javascript:;" data-href="bbsViewLink">
							<p class="tit" data-attr="nttSj">세번째 탭의 게시판 글들이 노출됩니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>
						<li><a href="javascript:;" data-href="bbsViewLink"><p class="tit" data-attr="nttSj">선택한 게시판의글제목이 노출됩니다. 미리보기 예시입니다.</p>
							<span class="date" data-attr="frstRegistPnttm">2020.00.00</span></a></li>

						<li class="no_data" style="display:none;">
				            <p class="tit" data-attr="nttSj">작성된 게시글이 없습니다.</p>
				        </li>
					</ul>
				</div>
			</li>
		</ul>
	</div>

</div>
								<div class="layout_02 layout_contents_border layout_height_M" data-w="50" data-h="M"><div class="quickBannerConfZone" data-maxitem="4"><div class="wigetController" style="display: none;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
	<div class="quick121 quickBannerZone">
	    <div class="qbox changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(224, 242, 247);"> <!-- 배경색상변경/ 텍스트위치변경 -->
			<a href="#">
				<div class="iconbox">
					<img class="bIcon" src="/sample/template/wide/wide031/img/ico_earth.png" alt="">
				</div>
				<div class="txtbox">
					<p class="tit bTitle">WIZ센터</p>
					<span class="co bContent"><font color="#343434">신청-검토-지원<br>복지지원서비스</font></span>
				</div>
			</a>
	    </div>

	    <div class="qbox changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(248, 248, 248);">
			<a href="#">
				<div class="iconbox">
					<img class="bIcon" src="/sample/template/wide/wide031/img/ico_play.png" alt="">
				</div>
				<div class="txtbox">
					<p class="tit bTitle">위즈홍보영상</p>
					<span class="co bContent"><font color="#333333">관할홍보<br>캠페인영상</font></span>
				</div>
			</a>
	    </div>

	    <div class="qbox changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(231, 231, 231);">
			<a href="#">
				<div class="iconbox">
					<img class="bIcon" src="/sample/template/wide/wide031/img/ico_book.png" alt="">
				</div>
				<div class="txtbox">
					<p class="tit bTitle">위즈소식</p>
					<span class="co bContent"><font color="#333333">위즈소식<br>​알림공간</font></span>
				</div>
			</a>
	    </div>

	    <div class="qbox changeBg wzwgContextMenu" data-type="quick" style="background-color: rgb(248, 248, 248);">
			<a href="#">
				<div class="iconbox">
					<img class="bIcon" src="/sample/template/wide/wide031/img/ico_clock.png" alt="">
				</div>
				<div class="txtbox">
					<p class="tit bTitle">부조리신고<br>및 상담</p>
					<span class="co bContent"></span>
				</div>
			</a>
	    </div>



	</div>
	
	<div class="quick_sample" style="display: none;">
		<div class="qbox changeBg wzwgContextMenu">
			<a href="#">
				<div class="iconbox">
					<img class="bIcon" src="/sample/layout/contents/quick/quick121/img/icon02.png" alt="">
				</div>
				<div class="txtbox">
					<p class="tit bTitle">바로가기 제목</p>
					<span class="co bContent">링크에 대한 간략한<br>소개를 입력해주세요.</span>
				</div>
			</a>
	    </div>
	</div>
</div>
</div>
							</div>
						</div>
						
				 	
				 		
				 	
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border">
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										
	<div class="roll_img123 customwidget">
		<div class="wzwg-swiper swiper-container mainSliderContents wzwgContextMenu" data-effect="fade"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)<p class="slideInfo">슬라이드 : 수동<br>화면전환 : 페이드</p></span></div>
			<div class="swiper-wrapper">

				<div class="swiper-slide wzwgContextMenu" style="width: auto;">
					<div class="rol119_wrap">
						<img src="/sample/template/wide/wide031/img/wideslidebnr01.jpg" alt=""> <!-- 이미지변경 -->
			<div class="changeBg"><div class="txtBox bContentAlign">
								 <!-- 부 제목변경 -->
								<h2 class="tit mTitle"><font color="#ffffff">코로나19 관련 학원 등에 관한 휴원증명서 발급 안내</font></h2> <!-- 제목변경 -->
								<span class="co bContent"><font color="#ffffff">위즈위그시 내 학원, 교습소 중 정부의 휴원권고에 따라 2022.00.00.이후 휴원한 시설을 대상으로<br>
    시설의 설립운영자가 구비서류 작성 및 출력하여 교육지원청 직접 방문하여 신청할 수 있습니다.</font></span> <!-- 내용 변경 -->
				<a href="javascript:void(0);" class="linkbtn bLinkTitle fs15 white" style="width: auto;">자세히 보기</a></div>
						</div>
					</div>
					
				</div>

				<div class="swiper-slide wzwgContextMenu" style="width: auto;">
					<div class="rol119_wrap">
						<img src="/sample/template/wide/wide031/img/wideslidebnr01.jpg" alt="">
				<div class="changeBg"><div class="txtBox bContentAlign">
								 <!-- 부 제목변경 -->
								<h2 class="tit mTitle"><font color="#ffffff">코로나19 관련 학원 등에 관한 휴원증명서 발급 안내</font></h2> <!-- 제목변경 -->
								<span class="co bContent">
<font color="#ffffff">군포시 및 의왕시 내 학원, 교습소 중 정부의 휴원권고에 따라 2020.2.4.이후 휴원한 시설을 대상으로<br>
    시설의 설립운영자가 구비서류 작성 및 출력하여 교육지원청 직접 방문하여 신청할 수 있습니다.</font></span> <!-- 내용 변경 -->
<a href="javascript:void(0);" class="linkbtn bLinkTitle fs15 white">자세히 보기</a></div>
						</div>
					</div>
					
				</div>
			
				
			
				
			
				
			
				
			</div>



			<!-- Add Pagination -->
			<div class="wzwg-swiper-pagination swiper-pagination swiper-pagination-clickable swiper-pagination-bullets" style="display: none;"><span class="swiper-pagination-bullet"></span><span class="swiper-pagination-bullet"></span></div>

			<!-- controll buttons -->
			<div class="slide-controll">
				<!-- Add Arrows -->
				<div class="wzwg-swiper-pagination-prev swiper-button-prev"></div> 
				<!-- Add indicator -->
				<div class="indicator">
					<button class="play" type="button">시작</button>		
					<button class="stop off" type="button">멈춤</button>				
				</div>
				<div class="wzwg-swiper-pagination-next swiper-button-next"></div>
			</div>
			


			<div class="sampleSlide" style="display:none">
				<div class="swiper-slide wzwgContextMenu" style="width: auto;">
					<a href="javascript:void(0);">				
						</a><div class="rol119_wrap">
							<img src="/sample/template/wide/wide031/img/wideslidebnr01.jpg" alt="">
				<div class="changeBg"><div class="txtBox bContentAlign">
								 <!-- 부 제목변경 -->
								<h2 class="tit mTitle"><font color="#ffffff">코로나19 관련 학원 등에 관한 휴원증명서 발급 안내</font></h2> <!-- 제목변경 -->
								<span class="co bContent">
<font color="#ffffff">군포시 및 의왕시 내 학원, 교습소 중 정부의 휴원권고에 따라 2020.2.4.이후 휴원한 시설을 대상으로<br>
    시설의 설립운영자가 구비서류 작성 및 출력하여 교육지원청 직접 방문하여 신청할 수 있습니다.</font></span> <!-- 내용 변경 -->
						<a href="javascript:void(0);" class="linkbtn bLinkTitle fs15 white">자세히 보기</a></div>
							</div>
						</div>
					
				</div>
			</div>
			
		</div>	   
	</div>
</div>
									</div>
								</div>
				 		<div class="empty empty_50 wzwgContextMenu layout_line_border"></div>
				 		<div class="empty empty_10 wzwgContextMenu layout_line_border"></div>
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block1 mxwd100">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								

	


	<div class="widequick140 quickBannerConfZone noChangeBg" data-maxitem="6"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div>
		<div class="quickwrap">
			<div class="bgbox">
				<img class="qImgBg" src="/sample/template/wide/wide031/img/bnr_mainbg.jpg" alt=""> <!-- 배경이미지 (이미지변경 가능)   -->
			</div>
			

			<div class="innerbox quickBannerZone">
				<!-- LINK 1 -->
				<div class="wq140 wzwgContextMenu" data-type="quick"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">교육 서비스</strong> <!-- 메뉴 제목 (글자색상변경 가능)   -->
						<span class="qco bContent">아이와 부모 모두 핵복한 경험을 제공하도록 최선을 다합니다.</span> <!-- 메뉴 내용 (글자색상변경 가능)   -->
					</a>
				</div>

				<!-- LINK 2 -->
				<div class="wq140 wzwgContextMenu" data-type="quick"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">위즈 미디어</strong>
						<span class="qco bContent">위즈교육의 다양한<br>소식을 전해드립니다.</span>
					</a>
				</div>

				<!-- LINK 3 -->
				<div class="wq140 wzwgContextMenu" data-type="quick"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">진로심리 검사</strong>
						<span class="qco bContent">다양한 영역의 종합적성과<br>진로발달 수준 측정</span>
					</a>
				</div>

				<!-- LINK 4 -->
				<div class="wq140 wzwgContextMenu" data-type="quick"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">장학지원센터</strong>
						<span class="qco bContent">장학지원 현황 확인</span>
					</a>
				</div>

				<!-- LINK 5 -->
				<div class="wq140 wzwgContextMenu" data-type="quick"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">증명서 발급</strong>
						<span class="qco bContent">온라인 증명서 발급</span>
					</a>
				</div>
			</div>
			
			<div class="quick_sample" style="display: none;">
				<div class="wq140 wzwgContextMenu"> 
					<a href="javascript:void(0);">
						<strong class="qtit bTitle">바로가기 제목</strong>
						<span class="qco bContent">간략한 링크소개</span>
					</a>
				</div>
			</div>
		</div>					
		
	</div>

	</div>
							</div>
						</div>
			            		
								
			            		
								<div class="layout_wrap wzwgContextMenu layout_wrap_border"><div class="layoutInfo" style="display:none"></div>
									<div class="div_wrap layout_block1">
										<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
										
	<div class="bnrSlide002 wzwgWidget" data-id="10000000482" data-nm="배너 슬라이드002">
		
		<div class="wzwg-banner-slide-info changeBg wzwgContextMenu"><div class="wigetController" style="display: none;">+<span class="help">슬라이드 기능을 변경합니다 (오른쪽 클릭해 주세요)</span></div>
			
			<div class="titlebox">
				<p class="tit bTitle">유관기관</p>
				<span class="co bContent">유관/협력기관 안내</span>
			</div>
			
			<div class="wzwg-banner-slide-data"><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="0">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div><div>
					<a href="javascript:void(0);" tabindex="-1">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
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
					<a href="javascript:void(0);">		
						<div class="imgbox brnBd">
							<img src="/sample/layout/contents/etc/bnrSlide002/img/01.png" alt="">
						</div>
					</a>
				</div>
			</div>
			
		</div>

	</div>	 
	
	</div>
									</div>
								</div>
			            		
								

			            	

			            	
				 					<div class="between_line layout_line_border">
										<div class="div_wrap" style="
    max-width: 100%;
">
											<div class="line_prev04" style="
    border-color: #ddd;
"></div>
										</div>
									</div>
				 	
						<div class="layout_wrap wzwgContextMenu layout_wrap_border">
							<div class="div_wrap layout_block1 ui-sortable">
								<div class="layout_01 layout_contents_border" data-w="100" data-h="M">
								


	<div class="quick116 quickBannerConfZone" data-maxitem="16" style="
    border: 1px solid rgba(153,153,153,0.1);
    border-width: 0 1px;
"><div class="wigetController" style="display: none;bottom: 30px !important;">+<span class="help">퀵메뉴 아이템을 추가합니다 (오른쪽 클릭해 주세요)</span></div> 
		<div class="q112_wrap quickBannerZone"> 
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);"> <!-- 배경색 변경 가능 -->
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#343434">구인/구직</font></p> <!-- 메뉴제목변경(글자색상) -->		
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> <!-- 바로가기링크 (글자색상,배경색상) -->
				</a>
			</div>

			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">청소년활동 정보확인</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">부조리신고 및 상담</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">누리과정포털</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>


			
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">지식정보센터</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">학교안전정보센터</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">학생건강정보센터</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>

			
			
			
			

			<div class="q112box wzwgContextMenu changeBg" data-type="quick" style="background-color: rgb(255, 255, 255);">
				<a href="javascript:void(0);">
					<p class="bTitle"><font color="#333333">네이버블로그</font></p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
			
			
			
			
		</div>	
		
		<div class="quick_sample" style="display: none;">
			<div class="q112box wzwgContextMenu changeBg">
				<a href="javascript:void(0);">
					<p class="bTitle">바로가기 제목</p>
					<span class="more_btn bLinkCol bLinkBg">&gt;</span> 
				</a>
			</div>
		</div>
					
	</div>

</div>
							</div>
						</div>
				 	

			            	
				 	
				 	
				 	

			            	
				 	
				 	
				 		
				 	</div> <!--template00 끝. -->
		</div><!-- inner 끝 -->
	</div>
    
    
    
    
    
    
    
</div>
<c:import url="${footerUrl}"></c:import>

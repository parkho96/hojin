 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>

<link rel="stylesheet" href="/css/wzwg/module/cmm/sitemap.css"> 

<script language="javascript" type="text/javascript">
            $(function() { 
            	
            	$(".head-group ul, .subMenu ul").each(function(){
            	   	if($(this).children("li").size() ==0){
            	   	  $(this).remove();
            		}
            	});
            	
				$('.tab').children("div").eq(0).css('display','block');
				$('.tabmenu').children("li").children("a").each(function(index,child){
						$(child).click(function(){ 
						$('.tab').children("div").css('display','none'); 
						$('.tab').children("div").eq(index).css('display','block');
					});
				});


				var menuWidth = 100 / $('.lnb .topMenuItem').length;
				menuWidth = Math.floor(menuWidth * 100) / 100;
				$('.topMenuItem').css('width', menuWidth + '%');
				
				$('.topMenuItemSub').each(function(idx, el){
					var parent = $(el).parent();
					$(el).css('width', parent.width() + 'px');
				});
				
				$( window ).resize(function() {
					//console.log('resize');
					$('.topMenuItemSub').each(function(idx, el){
						var parent = $(el).parent();
						$(el).css('width', parent.width() + 'px');
					});
				});
				
				
				
				/* 메인메뉴 펼침 기능 컨트롤 */
				var menuCssPath = $('#headmenu').attr('href').toLowerCase();
				var pathSplit = menuCssPath.split('/');
				
				var menuCssFileName = pathSplit[pathSplit.length-1];
				var headMenuAction = '';;
				
				if(menuCssFileName.indexOf('pulldown') >= 0){
					headMenuAction = 'pullDown';
				}
				if(menuCssFileName.indexOf('wide') >= 0){
					headMenuAction = 'wide';
				}
				//console.log(headMenuAction + ':' + (headMenuAction == 'pullDown'));
				
				
				if(headMenuAction == 'pullDown'){
					
				
					
					
					/* 2차메뉴만 풀다운 되는 기능은 봉인  [해제]*/
					
					
					$('.lnb .topMenuItemSub ul').css('display', 'none');//우선 3차뎁스 메뉴들은 삭제한다
					
					//3뎁스의 메뉴링크를 상위 그룹 링크로 변경하고
					
					$('.lnb .topMenuItemSub .mnGroup').each(function(){
						var target = $(this).children().eq(0);
						var firstLink = $(this).find('li').eq(0).find('a').eq(0);
						//console.log(target);
						//console.log(firstLink);
						target.attr('href', firstLink.attr('href'));
						target.attr('target', firstLink.attr('target'));
					})
					
					//2뎁스의 메뉴르링크를 상위 그룹 링크로 변경한다 
					
					$('.lnb .topMenuItem.mnGroup').each(function(){
						var target = $(this).children().eq(0);
						var firstLink = $(this).find('li').eq(0).find('a').eq(0);
						//console.log(target);
						//console.log(firstLink);
						target.attr('href', firstLink.attr('href'));
						target.attr('target', firstLink.attr('target'));
					})
					
					
					var initCss = {'display': 'block', 'visibility': 'hidden', 'box-sizing': 'border-box'};
					$('.lnb .topMenuItemSub').css(initCss);
					
					
					$('.lnb .topMenuItemSub').css('display', '');
					$('.lnb .topMenuItemSub').css('visibility', '');
					
					//var menuBg = $('<div id="lnbBg"></div>');
					var menuBg = $('#lnbBg');
					//var menuBgHeight = maxSubMenuH;
					//$('.menu .inner').append(menuBg);
					menuBg.css({'position':'absolute', 'width': '100%', 'left': '0', 'z-index': '-1', 
								'background': 'white', 'display': 'none'}); 
					//var isTopMenuAction = false;
					$('.lnb').mouseover(function(e){
						//마우스 오버할때 마다 높이값을 다시 계산해준다
						var maxSubMenuH = 0;
						
						$('.lnb .topMenuItemSub').each(function(e){
							if($(this).outerHeight(true) > maxSubMenuH){
								maxSubMenuH = $(this).outerHeight(true);
							}
						});
						//$('.lnb .topMenuItemSub').css('height', maxSubMenuH + 'px');
						
						$('#lnbBg').css({'height' : maxSubMenuH+'px'});
						
						
						$('.lnb .topMenuItemSub').addClass('on');
						$('#lnbBg').addClass('on');
						//isTopMenuAction = true;
						//console.log('mousehover');
						//$('.lnb .topMenuItemSub').slideDown(120, function(){
							//isTopMenuAction = false;
						//});
						//$('#lnbBg').slideDown(120);
						return true;
					});
					
					$('.lnb, #lnbBg').mouseleave(function(e){
						//console.log('mouseleave');
						$('.lnb .topMenuItemSub').removeClass('on');
						$('#lnbBg').removeClass('on');
						//if(isTopMenuAction == false){
						//	$('.lnb .topMenuItemSub').slideUp(120);
						//	$('#lnbBg').slideUp(120);
						//}
					}); /**/
					
					
				}else if(headMenuAction == 'wide'){
					var menuBg = $('#lnbBg');
					menuBg.css({'position':'absolute', 'width': '100%', 'left': '0', 'z-index': '-1', 
								'background': 'white', /* 'display': 'none' */}); 
					
					//3뎁스의 메뉴링크를 상위 그룹 링크로 변경하고
					
					$('.lnb .topMenuItemSub .mnGroup').each(function(){
						var target = $(this).children().eq(0);
						var firstLink = $(this).find('li').eq(0).find('a').eq(0);
						//console.log(target);
						//console.log(firstLink);
						target.attr('href', firstLink.attr('href'));
						target.attr('target', firstLink.attr('target'));
					})
					
					//2뎁스의 메뉴르링크를 상위 그룹 링크로 변경한다 
					
					$('.lnb .topMenuItem.mnGroup').each(function(){
						var target = $(this).children().eq(0);
						var firstLink = $(this).find('li').eq(0).find('a').eq(0);
						//console.log(target);
						//console.log(firstLink);
						target.attr('href', firstLink.attr('href'));
						target.attr('target', firstLink.attr('target'));
					})
					
					/* $('.lnb .topMenuItemSub').each(function(e){
						var h = $(this).outerHeight(true);
						$(this).css('top', (-1*h) +'px');
					}); */
					
					
					//우선 각 메뉴별 레벨세팅
				      $('.lnb>li>a').attr('data-lv', '1');
				      $('.lnb>li>ul>li>a').attr('data-lv', '2');
				      $('.lnb>li>ul>li>ul>li>a').attr('data-lv', '3');
					
				      
				      $('.lnb a').on('mouseover', function(e){
				 		 //console.log(e);
				 		 if($('.lnb').hasClass('click') == false){
				 			 headMenuOpen(this, e);
				 		 }
				 	 });
				 	 
				 	 $('.lnb a').on('focus', function(e){
				 		 //console.log(e);
				 		 //console.log('focus');
				 		 if($('.lnb').hasClass('click') == false){
				 			 headMenuOpen(this, e);
				 		 }
				 	 });
				 	 
				 	 $('.lnb a').on('click', function(e){
				 		 //console.log(e);
				 		 
				 		 var subMenu = $(this).siblings().filter('ul');
				 	 	 //console.log(subMenu);
				 	 	 //var subMenuIsView = isView(subMenu); 
				 	 	 var subMenuIsView = $(subMenu).hasClass('on'); 
				 	 	 //console.log('click - subMenuisSubMenuView : ' + subMenuIsView);

				 	 	 var lnbHasClick = $('.lnb').hasClass('click');
				 	 	 
				 		 if(lnbHasClick){
				 			//클릭모드일때
				 			if(subMenuIsView){
				 				//메뉴가 뷰 on 상태라면
				 				//console.log('메뉴를 닫습니다');
				 				headMenuClose(this, e);
				 				if($(this).attr('data-lv') == '1'){
					 		 		headMenuClose(this, e);
					 		 		$('.lnb').removeClass('click');
					 		 		//console.log('1뎁스 메뉴를 클릭하셧군요 닫아버립니다.');
					 		 	}
				 			}else{
				 				//메뉴가 뷰 off 상태라면
				 				headMenuOpen(this, e);
					 			//console.log('메뉴를 열어재낍니다');
				 			}
				 		 }else{
				 			//클릭모드가 아닐때
				 			 if(subMenuIsView){
				 				//메뉴가 뷰 on 상태라면
						 			//focus가 먼저 수행되므로 click 추가없이 ul에 on 클래스가 생성됨
						 		 	//그러므로 view 가 열려 있다면 아무것도 하지말고
						 		 	//click 클래스만 추가한다
				 				$('.lnb').addClass('click');
				 			 }else{
				 				//메뉴가 뷰 off 상태라면
				 				$('.lnb').addClass('click');
				 				headMenuOpen(this, e);
					 			//console.log('메뉴를 열어재낍니다');
				 			 }
				 		 }
				 	 	 
				 	 	 
				 	 	 
				 		 if($('.lnb ul').filter('.on').length == 0){
				 			 $('.lnb').removeClass('click');
				 		 }
				 		 if(subMenu.length == 1){
				 			 return false;
				 		 }
				 	 });
				 	  
				 	 $('.lnb a').last().on('focusout', function(e){
				 		 //console.log(e);
				 		 //console.log('focus out');
				 		 if($('.lnb').hasClass('click') == false){
				 			$('.lnb').find('.on').removeClass('on');
				 			headMenuBgClose()
				 		 }
				 		 //$('.lnb .on').removeClass('on');
				 	 });
				 	 
				 	 $('.menu .logo a').on('focus', function(e){
				 		if($('.lnb').hasClass('click') == false){
				 			$('.lnb').find('.on').removeClass('on');
				 			headMenuBgClose()
				 		 }
				 	 })
				 	 
				 	 $('.lnb ').on('mouseleave', function(e){
				 		 //console.log(e);
				 		 if($('.lnb').hasClass('click') == false){
				 		 	$(this).find('.on').removeClass('on');
				 		 	headMenuBgClose()
				 		 }
				 		 //$('.lnb .on').removeClass('on');
				 	 });
					
					
				}else{
					$('.lnb').tendina({
						animate: true,
						speed: 500,
						onHover: false,
						hoverDelay: 300,
						activeMenu: $('#deepest'),
						openCallback: function(clickedEl) {
						  console.log('Hey dude!');
						},
						closeCallback: function(clickedEl) {
						  console.log('Bye dude!');
						}
					 }); //lnb메뉴
				} 
				

				/*
				$('.lnb').tendina({
					animate: true,
					speed: 500,
					onHover: false,
					hoverDelay: 300,
					activeMenu: $('#deepest'),
					openCallback: function(clickedEl) {
					  console.log('Hey dude!');
					},
					closeCallback: function(clickedEl) {
					  console.log('Bye dude!');
					}
				 }); //lnb메뉴
				 */
				
				
				$(".showMenu").click(function(){
					$("#m_nav").toggle();
					 $('#m_nav').tendina({
						animate: true,
						speed: 500,
						onHover: false,
						hoverDelay: 300,
						activeMenu: $('#deepest'),
						openCallback: function(clickedEl) {
						  console.log('Hey dude!');
						},
						closeCallback: function(clickedEl) {
						  console.log('Bye dude!');
						}
					  });//모바일메뉴
					 $(".m_navTop").css("display","block");
				});
				
				
				if('<c:out value="${sessionScope.rghtClickAt}"/>' == 'N'){
					if(location.pathname.indexOf('/mngr') == -1){
						document.oncontextmenu = function (){alert('<spring:message code="wzwg.cmm.msg.MSG460" />');return false;}
					}
				}
				 
				 
            });//end function()
            
            function fnTopSearchAction(){
            	var query = $('#searchQuery').val();
            	var isSearchBoxOPen = $('#searchPannel').hasClass('on');
            	
            	if(query == ''){
            		//검색어 입력이 없을때
            		if(isSearchBoxOPen){
            			$('#searchPannel').removeClass('on');
            			$('#searchPannel').hide();
            		}else{
            			$('#searchPannel').addClass('on');
            			$('#searchPannel').show();
            		}
            	}else{
            		//검색어 입력이 있을때
            		//$('#searchWord').val(query);
            		$('#gnbSearchForm').submit();
            		//alert('준비중입니다.');
            	}
            	//$('#lnbActBg').fadeIn();
            	//$('#lnbActBg').addClass('on');
            	//$('#searchPannel').addClass('on');
            	//$('#searchPannel').show();
            	
            }
				
            function fnLngReset(){
            	//$('#searchPannel').slideUp();
            	//$('#lnbActBg').fadeOut();
            	
            	//$('#lnbActBg').removeClass('on');
            	$('#searchPannel').removeClass('on');
            }
            
            function headMenuOpen(target, event){
	           	 //$('.lnb .on').removeClass('on');
	           	// console.log(target);
	           	 //console.log($(target).attr('data-lv'));
	           	 var mylv = $(target).attr('data-lv');
	           	 var siblingMenu = $('.lnb').find('a');
	           	 //console.log(siblingMenu);
	           	 siblingMenu.each(function(){
	           		//console.log($(this).is(target));
	           		var targetLv = $(this).attr('data-lv');
	        		if(mylv > targetLv){
	        			return;
	        		}
	           		if($(this).is(target) == false){
	           			$(this).siblings().filter('ul').removeClass('on');
	           			$(this).siblings().filter('ul').find('.on').removeClass('on');
	           		}else{
	           			$(this).siblings().filter('ul').addClass('on');
	           		}
	           	 });
	           	 
	           	 /* if(mylv == '2'){
	           		 $(target).addClass('on');
	           	 } */
	           	 
	           	 if(mylv == '1'){
		           	var maxSubMenuH = 0;
					
		           	maxSubMenuH = $(target).siblings().filter('ul').outerHeight(true);
					
					$('#lnbBg').css({'height' : maxSubMenuH+'px'});
					$('#lnbBg').addClass('on');
	           	 }
	           	 
	           
           	 
            }
            
            function headMenuClose(target, event){
	           	 var sibling = $(target).siblings();
	           	 if(sibling.length == 1){
	           		 sibling.removeClass('on');
	           		 sibling.find('.on').removeClass('on');
	           	 }
	           	 
	           	headMenuBgClose()
            }
            
            function headMenuBgClose(){
            	$('#lnbBg').css('height', '0px');
            	$('#lnbBg').removeClass('on');
            }
            
            function isSubMenuView(subMenu){
            	$(subMenu.css('top'));
            }
        </script>
 	<div  class="head-group" style="z-index: 2;">
		<div class="header">
			<div class="inner hdmenu">
				<ul class="gnb1">
					<%-- <li><a href="/">HOME</a></li>
					<li><a href="/sitemap.do"><spring:message code="wzwg.cmm.word.sitemap" /></a></li> --%>
				</ul>
				<ul class="gnb data" style="display:none;">
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
					<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
				</ul>	
				<div class="btn_wrap">
					<!--  전체메뉴(메인) -->
					<div class="all_menu">
	   					<button id="btn_allmenu" class="btn_allmenu" type="button" title="<spring:message code="wzwg.cmm.word.allmenu" />" onclick="wzHtmlModal('popup_l', '<spring:message code="wzwg.cmm.word.allmenu" />', 'sitemapAjax', 'false', $(this)  )"><spring:message code="wzwg.cmm.word.allmenu" /></button>
	   				</div> 
	   				<div style="display:none;">
	   					<div id="sitemapAjax">
							<ul class="allMenuContents">
								   <c:forEach items="${menuList}" var="oneDepth" varStatus="status">
								   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
									<li class="topMenuItem">
										<c:choose>
											<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
												<c:choose>
													<c:when test="${oneDepth.menuDivision eq 'anchor'}">
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${oneDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${oneDepth.menuDivision eq 'link'}">
														<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${oneDepth.menuDivision eq 'group'}">
														<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"  title="<spring:message code="wzwg.cmm.word.menugrouptitle" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when test="${oneDepth.sysmoduleSeq eq '888888888888' }">
														<a href="<c:out value="${oneDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${oneDepth.menuDivision eq 'link' }">
														<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${oneDepth.menuDivision eq 'group'}">
														<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"  title="<spring:message code="wzwg.cmm.word.menugrouptitle" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
															<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
										<ul class="topMenuItemSub">
										<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
										<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
											<li>
												<c:choose>
													<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
														<c:choose>
															<c:when test="${twoDepth.menuDivision eq 'anchor'}">
																<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${twoDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:when test="${twoDepth.menuDivision eq 'link'}">
																<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:when test="${twoDepth.menuDivision eq 'group'}">
																<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"  title="<spring:message code="wzwg.cmm.word.menugrouptitle" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:otherwise>
																<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:choose>
															<c:when test="${twoDepth.sysmoduleSeq eq '888888888888' }">
																<a href="<c:out value="${twoDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:when test="${twoDepth.menuDivision eq 'link' }">
																<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:when test="${twoDepth.menuDivision eq 'group'}">
																<a href="javascript:void(0);" data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"  title="<spring:message code="wzwg.cmm.word.menugrouptitle" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:when>
															<c:otherwise>
																	<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
															</c:otherwise>
														</c:choose>
													</c:otherwise>
												</c:choose>
												<ul>
												<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
												  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
													<li>
														<c:choose>
															<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite'}">
																<c:choose>
																	<c:when test="${threeDepth.menuDivision eq 'anchor'}">
																		<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${threeDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:when>
																	<c:when test="${threeDepth.menuDivision eq 'link'}">
																		<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:when>
																	<c:otherwise>
																		<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:otherwise>
																</c:choose>
															</c:when>
															<c:otherwise>
																<c:choose>
																	<c:when test="${threeDepth.sysmoduleSeq eq '888888888888' }">
																		<a href="<c:out value="${threeDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:when>
																	<c:when test="${threeDepth.menuDivision eq 'link' }">
																		<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />" class="outLink"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:when>
																	<c:otherwise>
																			<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
																	</c:otherwise>
																</c:choose>
															</c:otherwise>
														</c:choose>
													</li>
												</c:if>
												</c:forEach>
												</ul>
											</li>
										</c:if>
										</c:forEach>	 
										</ul>  
									</li>  
									</c:if>
									</c:forEach>
								 </ul>
							</div>
	   				</div>	
				</div>
			</div>
		
		</div> <!-- end header -->
		
		<div class="menu">
			<div class="showMenu">
				<button class="mobileMenu" type="button" title="<spring:message code="wzwg.cmm.word.allmenu" />"><spring:message code="wzwg.cmm.word.allmenu" /></button>
			</div>
			<div class="inner">
				<h1 class="logo">
					<c:if test="${empty sessionScope.topLogoReplcText }"><c:set var="topLogoReplcText" value="${sessionScope.SITE_NM }"/></c:if>
					<c:if test="${not empty sessionScope.topLogoReplcText }"><c:set var="topLogoReplcText" value="${sessionScope.topLogoReplcText }"/></c:if>
					<c:choose>
						<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
							<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />" title="<spring:message code="wzwg.cmm.word.homeshrtcut" />"> <img src="<c:out value="${topLogo}" />" id="img_topLogo" alt="<c:out value="${topLogoReplcText}" />" /></a>
						</c:when>
						<c:otherwise>
							<a href="<c:out value="${wzwg_contextPath}" />/index.do" title="<spring:message code="wzwg.cmm.word.homeshrtcut" />"> <img src="<c:out value="${topLogo}" />" id="img_topLogo" alt="<c:out value="${topLogoReplcText}" />" /></a>
						</c:otherwise>
					</c:choose>
				</h1>	
				
				<c:choose>
					<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
							<c:set var="menuLength">0</c:set>
							 <ul class="lnb">
							   <c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li class="topMenuItem <c:if test="${oneDepth.menuDivision eq 'group' }">mnGroup</c:if>" data-test="<c:out value="${oneDepth.menuDivision }"/>" tabindex="1">
									<c:choose>
										<c:when test="${oneDepth.menuDivision eq 'anchor'}">
											<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${oneDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:when test="${oneDepth.menuDivision eq 'link'}">
											<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}"> target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:otherwise>
											<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:otherwise>
									</c:choose>
									
									<ul class="topMenuItemSub">
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li class="<c:if test="${twoDepth.menuDivision eq 'group' }">mnGroup</c:if>" tabindex="1">
											<c:choose>
												<c:when test="${twoDepth.menuDivision eq 'anchor'}">
													<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${twoDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:when test="${twoDepth.menuDivision eq 'link'}">
													<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:otherwise>
											</c:choose>
											<ul>
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li class="<c:if test="${threeDepth.menuDivision eq 'group' }">mnGroup</c:if>" tabindex="1">
												<c:choose>
													<c:when test="${threeDepth.menuDivision eq 'anchor'}">
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${threeDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${threeDepth.menuDivision eq 'link'}">
														<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	 
									</ul>  
								</li>   
								<c:set var="menuLength" value="${menuLength + 1}" />
								</c:if>
								</c:forEach>
							 </ul>
					</c:when>
					<c:otherwise>
							<c:set var="menuLength">0</c:set>
							 <ul class="lnb">
							   <c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li class="topMenuItem <c:if test="${oneDepth.menuDivision eq 'group' }">mnGroup</c:if>">
									<c:choose>
										<c:when test="${oneDepth.sysmoduleSeq eq '888888888888' }">
										<a href="<c:out value="${oneDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:when test="${oneDepth.menuDivision eq 'link' }">
										<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:otherwise>
										<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:otherwise>
									</c:choose>
								 	
									<ul class="topMenuItemSub">
										<span class="oneDepth_menuNm" style="display: none;"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></span>
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li <c:if test="${twoDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
										
											<c:choose>
												<c:when test="${twoDepth.sysmoduleSeq eq '888888888888' }">
												<a href="<c:out value="${twoDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:when test="${twoDepth.menuDivision eq 'link' }">
												<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:otherwise>
												<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:otherwise>
											</c:choose>
											
											<ul>
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li <c:if test="${threeDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
												<c:choose>
													<c:when test="${threeDepth.sysmoduleSeq eq '888888888888' }">
													<a href="<c:out value="${threeDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${threeDepth.menuDivision eq 'link' }">
													<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
												
												
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	 
									</ul>  
								</li>   
								<c:set var="menuLength" value="${menuLength + 1}" />
								</c:if>
								</c:forEach>
							 </ul>
					</c:otherwise>
				</c:choose>
				
				
				
				
				</div><!--  // 메뉴(메인) End -->
   				
   				
   				
   				
				
				<ul id="m_nav">
					<c:choose>
						<c:when test="${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }">
							<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li>
									<c:choose>
										<c:when test="${oneDepth.menuDivision eq 'anchor'}">
											<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${oneDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:when test="${oneDepth.menuDivision eq 'link'}">
											<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:otherwise>
											<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:otherwise>
									</c:choose>
									
									<ul>
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li>
											<c:choose>
												<c:when test="${twoDepth.menuDivision eq 'anchor'}">
													<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${twoDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:when test="${twoDepth.menuDivision eq 'link'}">
													<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:otherwise>
											</c:choose>											
											<ul>
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li>
												<c:choose>
													<c:when test="${threeDepth.menuDivision eq 'anchor'}">
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />#.anc_<c:out value="${threeDepth.menuSeq}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${threeDepth.menuDivision eq 'link'}">
														<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
														<a href="<c:out value="${wzwg_contextPath}" />/subsite/<c:out value="${subsiteKey}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	
									</ul>  
								</li>   
								</c:if>
								</c:forEach>
						</c:when>
						<c:otherwise>
							<c:forEach items="${menuList}" var="oneDepth" varStatus="status">
							   <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }">
								<li <c:if test="${oneDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
									<c:choose>
										<c:when test="${oneDepth.sysmoduleSeq eq '888888888888' }">
										<a href="<c:out value="${oneDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:when test="${oneDepth.menuDivision eq 'link'}">
										<a href="<c:out value="${oneDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(oneDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:when>
										<c:otherwise>
										<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${oneDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${oneDepth.menuLinkSeq}" />"><c:out value="${oneDepth.menuNm }" escapeXml="false" /></a>
										</c:otherwise>
									</c:choose>
									
								
									<ul>
									<c:forEach items="${menuList}" var="twoDepth" varStatus="status">
									<c:if test="${oneDepth.menuSeq eq twoDepth.upperMenuSeq}">
										<li <c:if test="${twoDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
										
											<c:choose>
												<c:when test="${twoDepth.sysmoduleSeq eq '888888888888' }">
												<a href="<c:out value="${twoDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:when test="${twoDepth.menuDivision eq 'link'}">
												<a href="<c:out value="${twoDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(twoDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:when>
												<c:otherwise>
												<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${twoDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${twoDepth.menuLinkSeq}" />"><c:out value="${twoDepth.menuNm }" escapeXml="false" /></a>
												</c:otherwise>
											</c:choose>
											
											<ul>
											<c:forEach items="${menuList}" var="threeDepth" varStatus="status">
											  <c:if test="${twoDepth.menuSeq eq threeDepth.upperMenuSeq}"> 
												<li <c:if test="${threeDepth.menuDivision eq 'group' }">class="mnGroup"</c:if>>
												
												<c:choose>
													<c:when test="${threeDepth.sysmoduleSeq eq '888888888888' }">
													<a href="<c:out value="${threeDepth.menuLinkUrl}" />" data-type="anchor" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:when test="${threeDepth.menuDivision eq 'link'}">
													<a href="<c:out value="${threeDepth.menuLinkUrl}" />" <c:if test="${fn:indexOf(threeDepth.menuLinkUrl, 'http') > -1}">target="_blank" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"</c:if> data-type="link" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:when>
													<c:otherwise>
													<a href="<c:out value="${wzwg_contextPath}" />/subList/<c:out value="${threeDepth.menuLinkSeq}" />" data-type="subPage" data-mnSeq="<c:out value="${threeDepth.menuLinkSeq}" />"><c:out value="${threeDepth.menuNm }" escapeXml="false" /></a>
													</c:otherwise>
												</c:choose>
												
											
												</li>
											</c:if>
											</c:forEach>
											</ul>
										</li>
									</c:if>
									</c:forEach>	
									</ul>  
								</li>   
								</c:if>
								</c:forEach>
						</c:otherwise>
					</c:choose>
					
					
					<li>
						<div class="hdmenu"> 
							<ul class="data m_navTop" style="display:none;">
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
								<li><a href="#"  data-href="hdftrmenuLinkUrl" data-attr="hdftrmenuNm" data-target="hdftrmenuTyCode"></a></li>
							</ul>		
						</div>
					 </li> 
				</ul>
				
				<div id="lnbBg"></div>
				
		</div><!-- end menu -->
	</div>
	
	<!-- <div class="lnbActBg" id="lnbActBg" style="background: rgba(0,0,0,.2); position: fixed; width: 100%;height: 100%;z-index: 1; display: none;" onclick="fnLngReset()"></div> -->
	
	


<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

	<!-- 위즈위그 메시지 로드 -->
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<link rel="stylesheet" href="/css/wzwg/cmm/language_pop.css" type="text/css" />
	<script>
	jQuery(document).ready(function() {
		if(wz_msg == undefined){
			onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
		}
		
		if($("head link[href$='/css/wzwg/cmm/layout.css']").size() == 0) {
			$('head').append('<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css">');
		}
		if($("head link[href$='/css/wzwg/cmm/font.css']").size() == 0) {
			$('head').append('<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />');
		}
		
		sessionStorage.setItem('siteKey', '<c:out value="${wzwg_siteKey}" />');
		onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
		sessionStorage.setItem('siteSeq', '<c:out value="${sessionScope.SITE_SEQ}" />');
	});
	</script>
	

	<script> 
		/* siteWizbuilder.js 파일을 호출하기 전에 서버데이터를 자바스크립트 변수로 일부 선언을 먼저 해주어야 한다 */
		var b_loginVO = '<c:out value="${not empty sessionScope.loginVO}"/>';	// 'ture' or 'false'
		var s_subPrefix = '<c:out value="${subPrefix}" />';	//string
		var s_prefix = '<c:out value="${prefix}" />';		//string
		var s_subsiteKey = '<c:out value="${subsiteKey}" />';		//string
		var otherLoginMsg = '<c:out value="${OtherLoginMsg}" />';		//string 
	</script>
	
	<script type="text/javascript" src="/js/wzwg/cmm/tendina.min.js"></script>	
	<script src="/js/wzwg/site/siteWizbuilder.js"></script>

<link rel="stylesheet" href="/upload/subCss/<c:out value="${sessionScope.SITE_SEQ}" />/sub.css" type="text/css" />
  <script>
	function googleTranslateElementInit() {
		new google.translate.TranslateElement({
			pageLanguage: "ko",
			includedLanguages: "zh-CN,zh-TW,ja,vi,th,tl,km,my,mn,ru,en,fr,ar,ko",
			layout: google.translate.TranslateElement.InlineLayout.SIMPLE,
			autoDisplay: false
		}, "google_translate_element");
	}
	function googleTranslateElementInit2() 
	{ 
	 new google.translate.TranslateElement({pageLanguage: 'ko',autoDisplay: false}, 'google_translate_element2');
	}
</script>
<script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit2"></script>
<style type="text/css">
<!--
 
#goog-gt-tt {display:none !important;}
.goog-te-banner-frame {display:none !important;}
.goog-te-menu-value:hover {text-decoration:none !important;}
body {top:0 !important;}
#google_translate_element2 {display:none!important;}
-->
</style>

 
 

<script type="text/javascript">
/* <![CDATA[ */
eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('6 7(a,b){n{4(2.9){3 c=2.9("o");c.p(b,f,f);a.q(c)}g{3 c=2.r();a.s(\'t\'+b,c)}}u(e){}}6 h(a){4(a.8)a=a.8;4(a==\'\')v;3 b=a.w(\'|\')[1];3 c;3 d=2.x(\'y\');z(3 i=0;i<d.5;i++)4(d[i].A==\'B-C-D\')c=d[i];4(2.j(\'k\')==E||2.j(\'k\').l.5==0||c.5==0||c.l.5==0){F(6(){h(a)},G)}g{c.8=b;7(c,\'m\');7(c,\'m\')}}',43,43,'||document|var|if|length|function|GTranslateFireEvent|value|createEvent||||||true|else|doGTranslate||getElementById|google_translate_element2|innerHTML|change|try|HTMLEvents|initEvent|dispatchEvent|createEventObject|fireEvent|on|catch|return|split|getElementsByTagName|select|for|className|goog|te|combo|null|setTimeout|500'.split('|'),0,{}))
/* ]]> */
</script>                            
<script>

 

$(document).ready(function(){
	
	/* 위디자인 코어가 없으면 추가 */
	if($('link[href="/widesign/widesigncore.css"]').length == 0){
		var widesignCss = '<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />';
		var jqueryuiJs = '<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"/>';
		var widesignJs = '<script type="text/javascript" src="/widesign/widesign.js"/>';
		$('head').append(widesignCss);
		$('head').append(jqueryuiJs);
		$('head').append(widesignJs);
	}
	
	// 웹 접근성용 화면이동을 위한 스크립트 추가 2019-08-28 조원권
	if($('#skipnavi').length == 0){
		var skipnavi = '';
			skipnavi += '<div id="skipnavi">';
			skipnavi += 	'<ul>';
			skipnavi += 		'<li><a href="#mainContent" title="<spring:message code="wzwg.cmm.word.bdtcnshrtcut" />"><spring:message code="wzwg.cmm.word.bdtcnshrtcut" /></a></li>';
			skipnavi += 		'<li><a href="javascript:void(0);" onclick="$(\'#gnb\').focus()" title="<spring:message code="wzwg.cmm.word.mainmenushrtcut" />"><spring:message code="wzwg.cmm.word.mainmenushrtcut" /></a></li>';
			skipnavi += 		'<li><a href="javascript:void(0);" onclick="$(\'#footer\').find(\'a, button\').eq(0).focus()" title="<spring:message code="wzwg.cmm.word.footershrtcut" />"><spring:message code="wzwg.cmm.word.footershrtcut" /></a></li>';
			skipnavi += 	'</ul>';
			skipnavi += '</div>';
			
		$('body').prepend(skipnavi);
	}
	$('.menu .lnb').find('a').eq(0).attr('id', 'gnb');
	$('.inner .subCon').attr('id', 'mainContent');
	
	$('#mainContent');
	
	/* 서브배너 숨기기 스크립트 처리 2021.04.16 */
	var topClass = $('.topSubImgOrign').attr('data-topclass');
	if(topClass == 'sub_visual_None'){
		$('#top').addClass('sub_visual_None');
	}
	
	
	
	$('body').css('overflow-x', 'hidden');
	
	
	
     $("#content").css("height",$(document).height());
     $("#content").css("left", $("#content").css("width")+10+'px');
 
    
     
     
     /* 
    if($("#top  .hdmenu").length >0){ 
        if($(".hdmenu").data("sample") != undefined){
          fnAddTopDiv($(".hdmenu").data("sample"));
        }else{
            <c:if test="${empty sessionScope.loginVO}">
            topHdMenuParsing('N');
            </c:if>
           <c:if test="${not empty sessionScope.loginVO}">
            topHdMenuParsing('Y');
            </c:if>
        }
          
    }
    
    if($("#footer  .ftrmenu").length >0){ 
        if($(".hdmenu").data("sample") != undefined){
          fnAddTopDiv($(".hdmenu").data("sample"));
        }else{
            <c:if test="${empty sessionScope.loginVO}">
            footerFtrMenuParsing('N');
            </c:if>
           <c:if test="${not empty sessionScope.loginVO}">
            footerFtrMenuParsing('Y');
            </c:if>
        }
          
    }
     
    if($("#footer  .ftrinfo").length >0){ 
        if($(".ftrinfo").data("sample") != undefined){
          fnAddTopDiv($(".ftrinfo").data("sample"));
        }else{
            footerFtrMenuInfoParsing();
        }
          
    } */
    subMenuHomeChange()
    fnSetMenu();
     
     /* 조원권 */
 	setTimeout(addMenuGroupClass, 0);
 	fnHederScroll();
 	
 	/* 스크롤 이펙트 추가 2021.04.12 조원권 */
 	wzRestartScollEffect();
});  //end ready


function subMenuHomeChange() {
	
	if(s_subPrefix == '/subMngr' || s_subPrefix == '/subsite') {
		$('#menuLocationPath').find('li').find('a').attr('href','/subsite/'+s_subsiteKey);		
	}
}


function leftMenuParsing() { 
    var startMenuLv = 1;
    var stopMenuLv = 2;
    
var nowMenuNo = '<c:out value="${menuSeq}" />'; 
    $('#left').each(function (index, parentEle) {
        $.ajax({
            type:'POST'
          , url:'<c:out value="${wzwg_contextPath}" />/module/scrin/scrinSubMenuJson.do' 
          , data:{menuSeq:nowMenuNo}
          , success:function (data) {  
              var cntntsNm = jsonFilter(data,'menuLv', '1')[0]["menuNm"];  
              $("#left").find(".menuNm").html(cntntsNm);
              
              var cntntsDc = jsonFilter(data,'menuLv', '1')[0]["menuDc"];  
              $("#left").find(".menuDc").html(cntntsDc);
              
             var firstMenu = jsonFilter(data,'menuLv', '2'); 
                $("#left").find(".data").each(function (pIndex, pChildEle) {  
                    $(this).children().each(function (index, childEle) {
                    if (firstMenu.length > index) {  
                        if(firstMenu[index].menuSeq == nowMenuNo){ 
                            $(childEle).children("a").addClass("on");
                        }else{
                            $(childEle).children("a").removeClass("on");
                        }
                        
                         var subMenu  = jsonFilter(data,'upperMenuSeq', firstMenu[index].menuSeq);
                        
                         $(childEle).find("*").each(function(i,cl){ 
                             for(var key in firstMenu[index]){ 
                                if(key ==  $(cl).data("attr")){
                                    $(cl).html(firstMenu[index][key]); 
                                }
                                if(key ==  $(cl).data("href")){
                                    if(subMenu.length> 0){
                                    }else{
                                        $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+firstMenu[index][key]);
                                    }
                                }
                                
                                if(key ==  $(cl).data("src")){
                                    $(cl).attr("src",firstMenu[index][key]);   
                                }
                            }
                         });
                         
                         $(childEle).find(".sub-menu").children().each(function (indexSub, childSubEle) {  
                             if(subMenu.length > indexSub){
                                 if(indexSub ==0){
                                    // $(childEle).find("a").attr("href","/subList/"+subMenu[indexSub]["menuSeq"]);   

                                        if(subMenu[indexSub].menuSeq == nowMenuNo){ 
                                            $(childEle).addClass("on");
                                        }else{
                                            $(childEle).removeClass("on");
                                        }
                                 }
                             $(childSubEle).find("*").each(function(i,cl){
                                 for(var key in subMenu[indexSub]){ 
                                    if(key ==  $(cl).data("attr")){
                                        $(cl).html(subMenu[indexSub][key]);   
                                    }
                                    if(key ==  $(cl).data("href")){
                                        $(cl).attr("href","<c:out value="${wzwg_contextPath}" />/subList/"+subMenu[indexSub][key]);   
                                    }
                                    
                                    if(key ==  $(cl).data("src")){
                                        $(cl).attr("src",subMenu[indexSub][key]);   
                                    }
                                }
                             });
                             }else{
                                 $(childSubEle).remove();
                             }
                         });
                        if(subMenu.length ==0){
                            $(childEle).find(".sub-menu").remove();
                        }
                    }else{
                        $(childEle).remove();
                    }
                   
                });
                });
                
            }
            , dataType: 'json'
        });
    });
}


 
 function fnSetMenu(){  
    $("#menuTitle").html($("#menuNm").val());
//  var locationTxt ='<li class="home"><img src="/sample/template/basic/basic8/img/home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li>'
//                 +'<li class="ftbd">신협소개(1차 대메뉴)</li>'
//                 +'<li>현재페이지</li>';
    //$("#menuLocationPath").html();
    //$("#menuSubTitle").html($("#menuNm").val());
    //$("#menuInfo").html($("#menuDc").val());
    var menuNms = $('#menuPath').val().split(">");
    var menuSeqs = $('#menuPathSeq').val().split(">");
    
    //console.log(menuNms);
    //console.log(menuSeqs);
    if($('#menuLocationPath').children().length <= 1){
    	//1보다 크면 이미 만들어 져있는경우
	    for (var i = 0 ; i < menuNms.length; i++){
	        var nm = menuNms[i];
	        if(nm == ''){
	            break;
	        }
	        
	        var locationTag = '';
	        
	        if(s_subPrefix == '/subMngr' || s_subPrefix == '/subsite') {
	        	locationTag = '<li><a href="<c:out value="${wzwg_contextPath}" />/subsite/'+s_subsiteKey+'/subList/' + menuSeqs[i] + '">' + nm + '</a></li>';
	        }else {
	        	locationTag = '<li><a href="<c:out value="${wzwg_contextPath}" />/subList/' + menuSeqs[i] + '">' + nm + '</a></li>';
	        }
	        
	        $('#menuLocationPath').append($(locationTag));
	    }// end for
    }
 } 

 $(function() { 
 	 
	 if(location.pathname.indexOf('sitemap.do') >= 0){
		 //사이트맵 일 경우 강제 로케이션 및 left 메뉴 세팅
		 $('div .subCon').prepend('<ul class="location" id="menuLocationPath"><li class="home"><a href="/">HOME</a></li><li><a href="<c:out value="${wzwg_contextPath}" />/sitemap.do"><spring:message code="wzwg.cmm.word.sitemap" /></a></li></ul>');
		 
		 var subMenuHtml = '';
		 subMenuHtml += '<div class="subMenu">                                                                     ';
		 subMenuHtml += '<h3 class="menuNm"><spring:message code="wzwg.cmm.word.sitemap" /><span></span></h3>                                             ';
		 subMenuHtml += '	<ul class="slidebar">                                                                  ';
		 subMenuHtml += '	<li class="deepest">                                                                   ';
		 subMenuHtml += '	<a href="<c:out value="${wzwg_contextPath}" />/sitemap.do" data-href="menuLinkSeq" data-attr="menuNm">   ';
		 subMenuHtml += '	<spring message:code="wzwg.cmm.word.sitemap"/>                                                                               ';
		 subMenuHtml += '	</a>                                                                                   ';
		 subMenuHtml += '	</li>                                                                                  ';
		 subMenuHtml += '	</ul>                                                                                  ';
		 subMenuHtml += '</div>                                                                                    ';
		 
		 $('div .subCon').before($(subMenuHtml));
	 }
	 
	 $('body  div.inner > div.sub_div_wrap > div.subMenu > ul.slidebar').attr('id', 'leftMn');
	 
	 
	 //if($('#submenu').attr('data-type') == 'wide' || true){
	//	 
	//	 $('.location li').eq(2).append($('.slidebar'));
	//	 
	//	 
	//	 $('.location > li').eq(3).find('a').each(function(){
	//		var locationMenu = $(this); 
	//		//console.log(locationMenu);
	//		$('.slidebar ul').each(function(){
	//			var depth3List = $(this);
	//				$(this).find('a').each(function(){
     //
	//					if($(this).attr('href') == locationMenu.attr('href')){
	//						//console.log(depth3List);
	//						locationMenu.after(depth3List.clone());
	//					}
     //
	//				});
	//		});
	//	 });
	//	 
	//	 
	//	 
	//	 // 서브메뉴 첫번째 링크가 그룹일 경우 링크 버그 수정 2020.06.23
	//	 //우선 각 메뉴별 레벨세팅
	 //    $('#menuLocationPath>li>a').attr('data-lv', '1');
	 //    $('#menuLocationPath>li>ul>li>a').attr('data-lv', '2');
	 //    $('#menuLocationPath>li>ul>li>ul>li>a').attr('data-lv', '3');
	 //    
	 //    
	 //    var lv3Link = $('.location > li').eq(2).find('a[data-lv="3"]').eq(0);
	//	 var lv2Link = $('.location > li').eq(2).find('a[data-lv="2"]').eq(0);
	//	 if(lv2Link.siblings('ul').length == 0){
	//		 //lv2는 그룹이 아님
	//		 $($('.location > li').eq(1).find('a')[0]).attr('href', lv2Link.attr('href'));
	//	 }
	//	 
	//	 if(lv2Link.siblings('ul').length == 1){
	//		 //lv2는 그룹임
	//		 //lv2가 그룹이면 lv3의 링크값을 세팅함
	//		 if(lv3Link.length == 1){
	//			 lv2Link.attr('href', lv3Link.attr('href'));
	//			 $($('.location > li').eq(1).find('a')[0]).attr('href', lv3Link.attr('href'));
	//		 }
	//	 }
	//	 /*
	//	 if(lv3Link.length == 1){
	//		 lv2Link.attr('href', lv3Link.attr('href'));
	//		 $($('.location > li').eq(1).find('a')[0]).attr('href', lv3Link.attr('href'));
	//	 }else{
	//		 $($('.location > li').eq(1).find('a')[0]).attr('href', lv2Link.attr('href'));
	//	 }
	//	 */
	//	 
	//	 //그룹을 가지고 있다면 링크를 해제한다
	//	 $('.location > li').eq(2).find('a').each(function(){
	//	   if($(this).siblings('ul').length > 0){
	//	     $(this).attr('href', 'javascript:void(0);');
	//	   }
	//	 })
	 //    
	 //}else{
	//	 $('.subMenu .slidebar').show(); // 20201103 layout.css 에서 안보이게 처리함 wide 타입 프로세싱중 메뉴가 이동하는것처럼 보이기 때문에 히든처리함
	//	 
	 //    $('.slidebar').tendina({
	 //        animate: true,
	 //        speed: 500,
	 //        onHover: false,
	 //        hoverDelay: 300,
	 //        activeMenu: $('.deepest'),
	 //        openCallback: function(clickedEl) {
	 //          console.log('Hey dude!');
	 //        },
	 //        closeCallback: function(clickedEl) {
	 //          console.log('Bye dude!');
	 //        }
	 //     }); //left 메뉴
	//	 
	 //} // end if($('#submenu').attr('data-type') == 'wide'
			 
			 
if($('#submenu').attr('data-type') == 'wide' || true){
		 
		 var locationLi2 = $('.location li').eq(2);
		 var locationLi3 = $('.location li').eq(3);
		 
		 var leftMn = $('#leftMn').clone();
		 leftMn.attr('id', 'leftMnMoblie');
		 if(locationLi3.size() ==0){
			 $('.slidebar ul').each(function(){
					var depth3List = $(this);
						$(this).find('a').each(function(){
							 if(location.pathname == $(this).attr("href")){ 
								  $('.location').append("<li><a href='"+$(this).attr("href")+"'>"+$(this).text().replace("•","")+"</a></li"); 
								  locationLi3 = $('.location li').eq(3);
							 }
						});
				});
		 }
		 //leftMn.css('display', '');
		 locationLi2.append(leftMn);
		 //console.log(leftMn);
		 //console.log($('#leftMnMoblie').css('display'));
		 
		 locationLi3.find('a').each(function(){
			var locationMenu = $(this); 
			//console.log(locationMenu);
			$('.slidebar ul').each(function(){
				var depth3List = $(this);
					$(this).find('a').each(function(){
						//console.log($(this).text());

						if($(this).attr('href') == locationMenu.attr('href')){
							//console.log(depth3List);
							
							if(locationMenu.siblings().filter('ul').length == 0){
								var depth3ListClone = depth3List.clone();
								//depth3ListClone.css('display', '');
								locationMenu.after(depth3ListClone);
								//console.log(depth3ListClone);
							}
						}

					});
			});
		 });
		 // location 에 서브메뉴 복사 끝
		 //$('.location ul').hide();
		 if(locationLi2.find('ul').length == 1){
			 //locationLi2.find('ul').hide();
			 locationLi2.tendina();
		 }
		 if(locationLi3.find('ul').length == 1){
			 //locationLi3.find('ul').hide();
			 locationLi3.tendina();
		 }
		 
		 
		 
		 // 서브메뉴 첫번째 링크가 그룹일 경우 링크 버그 수정 2020.06.23
		 //우선 각 메뉴별 레벨세팅
	     $('#menuLocationPath>li>a').attr('data-lv', '1');
	     $('#menuLocationPath>li>ul>li>a').attr('data-lv', '2');
	     $('#menuLocationPath>li>ul>li>ul>li>a').attr('data-lv', '3');
	     
	     
	     var lv3Link = $('.location > li').eq(2).find('a[data-lv="3"]').eq(0);
		 var lv2Link = $('.location > li').eq(2).find('a[data-lv="2"]').eq(0);
		 if(lv2Link.siblings('ul').length == 0){
			 //lv2는 그룹이 아님
			 $($('.location > li').eq(1).find('a')[0]).attr('href', lv2Link.attr('href'));
		 }
		 
		 if(lv2Link.siblings('ul').length == 1){
			 //lv2는 그룹임
			 //lv2가 그룹이면 lv3의 링크값을 세팅함
			 if(lv3Link.length == 1){
				 lv2Link.attr('href', lv3Link.attr('href'));
				 $($('.location > li').eq(1).find('a')[0]).attr('href', lv3Link.attr('href'));
			 }
		 }
		 /*
		 if(lv3Link.length == 1){
			 lv2Link.attr('href', lv3Link.attr('href'));
			 $($('.location > li').eq(1).find('a')[0]).attr('href', lv3Link.attr('href'));
		 }else{
			 $($('.location > li').eq(1).find('a')[0]).attr('href', lv2Link.attr('href'));
		 }
		 */
		 
		 //그룹을 가지고 있다면 링크를 해제한다
		 $('.location > li').eq(2).find('a').each(function(){
		   if($(this).siblings('ul').length > 0){
		     $(this).attr('href', 'javascript:void(0);');
		   }
		 })
	     
		 $('.location > li a').each(function(){
			 var linkHref =$(this).attr('href');
			 if(linkHref.indexOf('http') == 0 || linkHref.indexOf('javascript') == 0){
				 //아무것도 안함
			 }else if(linkHref.indexOf('<c:out value="${wzwg_contextPath}" />') == -1){
				 $(this).attr('href', '<c:out value="${wzwg_contextPath}" />' + linkHref);
			 }else{
				 $(this).attr('href', linkHref);
				 
			 }
		 })
	 //}else{
		 //$('.subMenu .slidebar').show(); // 20201103 layout.css 에서 안보이게 처리함 wide 타입 프로세싱중 메뉴가 이동하는것처럼 보이기 때문에 히든처리함
		 
		 
		 
		 $('#leftMn').tendina({
	         animate: true,
	         speed: 500,
	         onHover: false,
	         hoverDelay: 300,
	         activeMenu: $('.deepest'),
	         openCallback: function(clickedEl) {
	           console.log('Hey dude!');
	         },
	         closeCallback: function(clickedEl) {
	           console.log('Bye dude!');
	         }
		 }); //left 메뉴
		 
	 } // end if($('#submenu').attr('data-type') == 'wide'
	
			 
	 $('.topBGbox  div.subMenu > ul.slidebar').attr('id', 'submainLeftMn');
	 
	 
	 $('#submainLeftMn').tendina({
         animate: true,
         speed: 500,
         onHover: false,
         hoverDelay: 300,
         activeMenu: $('.deepest'),
         openCallback: function(clickedEl) {
           console.log('Hey dude!');
         },
         closeCallback: function(clickedEl) {
           console.log('Bye dude!');
         }
	 }); //서브메인 left메뉴
			 
			 
			 
			 
			 
	
	 $("#contents").after(' <div id="google_translate_element2">');
      //$('.slidebar .selected').addClass('deepest'); //서브페이지 와이드유형 사용시 방어 스크립트 2019.04.17 조원권 추가
 });
	 
 var locdina;
 $(document).ready(function(){
	 $('.location ul').hide();
	 locdina = $('.location').tendina({
         animate: true,
         speed: 500,
         onHover: false,
         hoverDelay: 300,
         activeMenu: $('.deepest'),
         openCallback: function(clickedEl) {
           console.log('Hey dude!');
         },
         closeCallback: function(clickedEl) {
           console.log('Bye dude!');
         }
	 });
	 locdina.tendina('hideAll');
	 //$('.location').children().eq(3).tendina({
     //    animate: true,
     //    speed: 500,
     //    onHover: false,
     //    hoverDelay: 300,
     //    activeMenu: $('.deepest'),
     //    openCallback: function(clickedEl) {
     //      console.log('Hey dude!');
     //    },
     //    closeCallback: function(clickedEl) {
     //      console.log('Bye dude!');
     //    }
	 //});
	 //console.log($('#leftMnMoblie').css('display'));
 });
 
 function openLang() { 
     $( '.translatePOP' ).toggleClass( 'on' );
 }  
</script> 

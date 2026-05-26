<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<%  
	response.setHeader("Pragma","no-cache");   
	response.setHeader("Cache-Control","no-cache");  
	response.addHeader("Cache-Control","no-store");   
	response.setDateHeader("Expires",0);   
%>  
<c:set var="ogUrl" ><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%></c:set>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<meta name="naver-site-verification" content="<c:out value="${siteAdinfoVO.naverMetaKey }" />"/>
	<meta name="google-site-verification" content="<c:out value="${siteAdinfoVO.googleMetaKey }" />">
 
	
	<title><c:out value="${siteNm }"/></title>
	<meta name="description" content="<c:out value="${siteNm }"/>">
	<meta property="og:url" content="<c:out value="${ogUrl }" />">
	<meta property="og:type" content="website">
	<meta property="og:title" content="<c:out value="${siteNm }"/>">
	<meta property="og:description" content="<c:out value="${siteNm }"/>">
	<meta property="og:image" content="<c:out value="${ogUrl }${usrTopLogo}" />">
	
	
	<meta name="robots" content="index,follow">
	<c:if test="${not empty sessionScope.iconSImagePath and sessionScope.iconSImagePath ne ''}">
	<link href="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${sessionScope.iconSImagePath}"/>&fileSn=0" rel="shortcut icon">
	</c:if>
   	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />
 	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	
 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
 	<link rel="stylesheet" href="/js/wzwg/cmm/slick/slick.css" type="text/css" />
 	
	
    <script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
    <script src="/design/module/sample/js/swiper.jquery.min.js"></script> 
    <script src="/js/wzwg/cmm/slick/slick.js"></script> 
  	<script src="/js/wzwg/cmm/jquery-ui.js"></script>
  	
  	<!-- 구글 번역기능 -->
 	<link type="text/css" rel="stylesheet" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	<script type="text/javascript" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type="text/javascript" src="https://translate.googleapis.com/element/TE_20210503_00/e/js/element/element_main.js"></script>
	
	<link rel="stylesheet" href="/css/wzwg/cmm/language_pop.css" type="text/css" />
	<!-- 위즈위그 메시지 로드 -->
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
  	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<script>
	jQuery(document).ready(function() {
		sessionStorage.setItem('siteKey', '<c:out value="${wzwg_siteKey}" />');
		onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
		sessionStorage.setItem('siteSeq', '<c:out value="${sessionScope.SITE_SEQ}" />');
	});
	</script>
	<script src="/js/wzwg/site/schedule.js"></script>
 	<!-- 위디자인 -->
	<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
	<script type="text/javascript"> 
//eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('6 7(a,b){n{4(2.9){3 c=2.9("o");c.p(b,f,f);a.q(c)}g{3 c=2.r();a.s(\'t\'+b,c)}}u(e){}}6 h(a){4(a.8)a=a.8;4(a==\'\')v;3 b=a.w(\'|\')[1];3 c;3 d=2.x(\'y\');z(3 i=0;i<d.5;i++)4(d[i].A==\'B-C-D\')c=d[i];4(2.j(\'k\')==E||2.j(\'k\').l.5==0||c.5==0||c.l.5==0){F(6(){h(a)},G)}g{c.8=b;7(c,\'m\');7(c,\'m\')}}',43,43,'||document|var|if|length|function|GTranslateFireEvent|value|createEvent||||||true|else|doGTranslate||getElementById|google_translate_element2|innerHTML|change|try|HTMLEvents|initEvent|dispatchEvent|createEventObject|fireEvent|on|catch|return|split|getElementsByTagName|select|for|className|goog|te|combo|null|setTimeout|100'.split('|'),0,{}))
  /* <![CDATA[ */
  function GTranslateFireEvent(element, event) {
    try {
      if (document.createEventObject) {
        var evt= document.createEventObject();
        element.fireEvent('on' + event, evt)
      } else {
        var evt= document.createEvent('HTMLEvents');
        evt.initEvent(event, true, true);
        element.dispatchEvent(evt)
      }
    } catch (e) {}
  }
  function doGTranslate(lang_pair) {
	  //console.log(lang_pair);
    if (lang_pair.value) lang_pair= lang_pair.value;
    if (lang_pair== '') return;
    var lang= lang_pair.split('|')[1];
    var teCombo;
    var sel= document.getElementsByTagName('select');
    //console.log(sel.length);
    for (var i= 0; i < sel.length; i++){
      if (sel[i].className== 'goog-te-combo') teCombo= sel[i];
    //console.log(sel[i].className);
    }
    //console.log(document.getElementById('google_translate_element2'));
    //console.log(document.getElementById('google_translate_element2').innerHTML);
    if (document.getElementById('google_translate_element2')== null ||
        document.getElementById('google_translate_element2').innerHTML.length== 0 ||
        teCombo.length== 0 ||
        teCombo.innerHTML.length== 0) {
      setTimeout(function() {
        doGTranslate(lang_pair)
      }, 500)
    } else {
      teCombo.value= lang;
      GTranslateFireEvent(teCombo, 'change');
      GTranslateFireEvent(teCombo, 'change')
    }
  }
  function GTranslateGetCurrentLang() {
    var keyValue= document.cookie.match('(^|;) ?googtrans=([^;]*)(;|$)');
    return keyValue ? keyValue[2].split('/')[2] : null;
  }
  if (GTranslateGetCurrentLang() != null) jQuery(document).ready(function() {
    jQuery('div.switcher div.selected a').html(jQuery('div.switcher div.option').find('span.gflag img[alt="' + GTranslateGetCurrentLang() + '"]').parent().parent().html());
  });
  /* ]]> */
 
</script>    
	<script src="/widesign/widesign.js"></script>
    
  <!-- Global site tag (gtag.js) - Google Analytics -->
<!-- 
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-121105155-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-121105155-1');
</script>
 -->  
	<script> 
		/* siteWizbuilder.js 파일을 호출하기 전에 서버데이터를 자바스크립트 변수로 일부 선언을 먼저 해주어야 한다 */
		var b_loginVO = '<c:out value="${not empty sessionScope.loginVO}"/>';	// 'ture' or 'false'
		var s_subPrefix = '<c:out value="${subPrefix}" />';	//string
		var s_prefix = '<c:out value="${prefix}" />';		//string
		var s_subsiteKey = '<c:out value="${subsiteKey}" />';		//string 
		var otherLoginMsg = '<c:out value="${OtherLoginMsg}" />';		//string 
	</script>
	
	<script src="/js/wzwg/site/siteWizbuilder.js"></script>
	<script type="text/javascript">
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
	 new google.translate.TranslateElement({pageLanguage: 'ko',autoDisplay: true}, 'google_translate_element2');
	}
</script>
<script type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit2"></script>
	
	<script>
	$(document).ready(function(){
		
		if($("#loginBox").length >0){
			$("#loginBox").remove();
			if(b_loginVO == 'true'){
				$('.login_before').css('display','none');$('.login_after').css('display','');
			}else{
				$('.login_before').css('display','');$('.login_after').css('display','none');
			}
		}
		
		if($("#lgnFrm #password")!=undefined){
			$("#lgnFrm #password").bind("keypress", function(event){
	        	if(event.keyCode == 13){ 
	        		if ($("#lgnFrm #password").val() =="") {
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                }
	        		else{ 
	        			$("#lgnFrm #lgnBtn").click();
	        		}
	        	}
	        });
			
			$("#lgnFrm #userId").bind("keypress", function(event){
	        	if(event.keyCode == 13){ 
	        		if ($("#lgnFrm #password").val() =="") {
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                }
	        		else{ 
	        			$("#lgnFrm #lgnBtn").click();
	        		}
	        	}
	        });
		}
		
	 $(".slider").each(function(){
		 changeImgSliderAuto($(this).attr("id") ,0); 
	 });
	 fnDivJsonDataRead();
	 $("#content >  div").each(function(){ 
		 if($(this).data("tab") != undefined && $(this).data("tab")=='Y'){ 
			 $(this).tabs({active: 0}); 
		 }
	 });
	 
	 /* 탭 게시판 위젯 스크립트 추가 moo0506 2018.08.30*/
	 $( ".wzwg-tab-board>.wzwg-tab-list>.wzwg-tab" ).click(function() {
		 $(this).addClass("active").siblings().removeClass("active");
		 return true;
		});
	 

	 /* etc012 위젯 데이터 입력 준비 */
		$('.etc012, .wgContactUs').each(function(){
			var etc012 = $(this);
			
			if(etc012.length == 1){
				var btn = etc012.find('#btn_contact');
			
				btn.click(function(){
					if (etc012.find('#waterNm').val().length < 1) {
				        return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG025"><spring:argument><spring:message code="wzwg.cmm.word.wrter" /></spring:argument></spring:message>');
				    }
				    if (etc012.find('#waterCttpl').val().length < 1) {
				        return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG025"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument></spring:message>');
				    }
				    if (etc012.find('#inqrySj').val().length < 1) {
				        return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG025"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument></spring:message>');
				    }
				    if (etc012.find('#inqryCn').val().length < 1) {
				        return alert('<spring:message code="wzwg.cmm.cmmMsg.CMG025"><spring:argument><spring:message code="wzwg.cmm.word.inquir" /></spring:argument></spring:message>');
				    }
				
				    $.ajax({
				        type:'POST'
				        , url: '<c:out value="${wzwg_contextPath}" />/module/inqryDtls/registInqryDtls.do'
				        , dataType:'html'
				        , data: etc012.find("#frmContantUs").serialize()
				        , success:function (result) {
				            alert(wz_msg('wzwg.cmm.msg.MSG458'));
				        }
				    });
				}); //end click
			
			} // end if	
			
		}); //end etc012
		
		
		loginWidgetAct();
		
		
		/* moo0506 */
		wzwgSwiperAll();
		// $('.wzwg-swiper').each(function(){
		//	 playSwiper(this);
		// });
		
		swiperBannerAll();
		 
		//탭게시판 반응형 셀렉트박스 스크립트
		$('.wzwg-resp-tab').each(function(){
			 
			 responsiveTabActive($(this));
		});
		
		/* 조원권 */
		setTimeout(addMenuGroupClass, 0); 
		//addMenuGroupClass();
		
		fnHederScroll();
		
		anchorSroll();
		
		/* 스크롤 이펙트 추가 2021.04.12 조원권 */
		wzRestartScollEffect();
		
	}); //end ready
	
	function loginWidgetAct(){
		$('.lgnActnWidget').each(function(){
			//console.log(this);
			$(this).find('.lgnWdg_usrMn').html('<c:out value="${sessionScope.loginVO.userNm}"/>');
			$(this).find('.lgnWdg_homeMn').html('<c:out value="${siteNm }"/>');
			
			if(b_loginVO == 'true'){
				$(this).find('.loginAtN').hide();
				$(this).find('.loginAtY').show();
			}else{
				$(this).find('.loginAtN').show();
				$(this).find('.loginAtY').hide();
			}
			
			var lgnFrm = $(this).find('#lgnFrm');
			//console.log(lgnFrm);
			if(lgnFrm.length > 0){
				$(lgnFrm).find('#lgnBtn').click(function(){
					if($(lgnFrm).find('#userId').val() == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
						return;
					}
					if($(lgnFrm).find('#password').val() == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
						return;
					}
					
					//$(lgnFrm).attr('action', '/actionLogin.do');
					//$(lgnFrm).attr('method', 'post');
					//$(lgnFrm).submit();
					//console.log(lgnFrm);
					var frmData = lgnFrm.serialize();
					//console.log(frmData);
					
					$.ajax({
			            type:'POST'
			            , url: '<c:out value="${wzwg_contextPath}" />/actionLogin.do'
			            , dataType: 'xml'
			            , data: frmData
			            , success:function (result) {
			            	
			            	var value = "";
			                
			                $(result).find("value").each(function() {  
			                    value = $(this).text();  
			                });
			                
			                if(value == 'success'){
			                	//$(lgnFrm).attr('action', '/index.do'); 
			                	//$(lgnFrm).submit();
			                	location.replace('<c:out value="${wzwg_contextPath}" />/index.do');
			                	return;
			                }else{
			                	fnLoginCallback(result);	
			                }
			                
			            }
			            , error:function (request, status, error) {
			                alert('<spring:message code="fail.common.msg" text="error" />');
			            }
			        });   
				});
			}
		});
	}
	</script>
  <decorator:head />
  </head>
<body>
	<div id="skipnavi">
		<ul>
			<li><a href="javascript:void(0);" onclick="$('#content').focus()" title="<spring:message code="wzwg.cmm.word.bdtcnshrtcut" />"><spring:message code="wzwg.cmm.word.bdtcnshrtcut" /></a></li>
			<li><a href="javascript:void(0);" onclick="$('#gnb').focus()" title="<spring:message code="wzwg.cmm.word.mainmenushrtcut" />"><spring:message code="wzwg.cmm.word.mainmenushrtcut" /></a></li>
			<li><a href="javascript:void(0);" onclick="$('#footer').find('a, button').eq(0).focus()" title="<spring:message code="wzwg.cmm.word.footershrtcut" />"><spring:message code="wzwg.cmm.word.footershrtcut" /></a></li>
		</ul>
	</div>
<%-- 로그인 위젯 실행을위해 관련 스크립트 jsp 파일 인클루드 함 --%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/mber/sbscrb/sbscrbScript.jsp" %>
<c:import url="${wzwg_contextPath}/siteInfo/scrinPopupSliderAjax.do"></c:import>
<decorator:body />


<!-- 레이어팝업 영역 Start -->
	<div id="divLayerPopup" class="modal fade in" style="z-index: 99;"></div>
	<!-- 레이어팝업 영역 End -->
	<script>
	  function openLang() { 
          $( '.translatePOP' ).toggleClass( 'on' );
               }  
	</script>
	 <div id="google_translate_element2"></div>
</body>
</html>

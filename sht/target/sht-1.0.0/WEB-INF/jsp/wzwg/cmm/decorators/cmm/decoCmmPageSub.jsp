<%@page import="org.springframework.web.util.UrlPathHelper"%>
<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%> 
<c:set var="ogUrl" ><%=request.getScheme()%>://<%=request.getServerName() %><%=request.getServerPort() == 80 ? "" :  ":" + request.getServerPort()%></c:set>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
<%
UrlPathHelper up = new UrlPathHelper();
String ogServletPath = up.getOriginatingRequestUri(request);
request.setAttribute("ogServletPath", ogServletPath);
%>
<!doctype html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	
	<title><c:out value="${siteNm }"/><c:if test="${not empty menuNm}"> - <c:out value="${menuNm}" /></c:if></title>
	
	<meta name="description" content="<c:out value="${siteNm }"/><c:if test="${not empty menuNm}"> - <c:out value="${menuNm}" /> <spring:message code="wzwg.cmm.word.page" /></c:if>">
	<meta property="og:url" content="<c:out value="${ogUrl }${ogServletPath }" /> ">
	<meta property="og:type" content="website">
	<meta property="og:title" content="<c:out value="${siteNm }"/><c:if test="${not empty menuNm}"> - <c:out value="${menuNm}" /></c:if>">
	<meta property="og:description" content="<c:out value="${siteNm }"/><c:if test="${not empty menuNm}"> - <c:out value="${menuNm}" /> <spring:message code="wzwg.cmm.word.page" /></c:if>">
	<meta property="og:image" content="<c:out value="${ogUrl }${usrTopLogo}" />">
	
	<meta name="robots" content="index,follow">
	
	<c:if test="${not empty sessionScope.iconSImagePath and sessionScope.iconSImagePath ne ''}">
	<link href="<c:url value='${wzwg_contextPath}/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${sessionScope.iconSImagePath}" />&fileSn=0" rel="shortcut icon">
	</c:if>
	
	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/btns.css" type="text/css" /> -->
 	<!-- <link rel="stylesheet" href="/css/wzwg/cmm/pop.css" type="text/css" /> -->
	
    <link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css" />
	
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/swiper.jquery.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/tendina.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"></script>

	<!-- 위즈위그 메시지 로드 -->
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	<script>
	jQuery(document).ready(function() {
		onloadWzwgMsg("<c:out value="${sessionScope.langCode}"/>");
		sessionStorage.setItem('siteKey', '<c:out value="${wzwg_siteKey}" />');
		sessionStorage.setItem('siteSeq', '<c:out value="${sessionScope.SITE_SEQ}" />');
	});
	</script>
	
<!-- 위디자인 -->
	<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/cmm/language_pop.css" type="text/css" />
	<script src="/widesign/widesign.js"></script>
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

	

<decorator:head/>
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
</head>
<body>
<script>
	  function openLang() { 
          $( '.translatePOP' ).toggleClass( 'on' );
               }  
	</script>
<decorator:body/> 
 <div id="google_translate_element2"></div>
</body>
</html>
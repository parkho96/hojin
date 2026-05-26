<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	<%  
	response.setHeader("Pragma","no-cache");   
	response.setHeader("Cache-Control","no-cache");  
	response.addHeader("Cache-Control","no-store");   
	response.setDateHeader("Expires",0);   
	%>  
    <meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"> <!-- 새로추가! --> 
    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
		<title>::: <spring:message code="wzwg.cmm.menu.sysmngr" /> :::</title>
    </c:if>
    <c:if test="${sessionScope.SYSMNGR_AT ne 'Y'}">
    	<title>::: <spring:message code="wzwg.cmm.menu.sitemngr" /> :::</title>
    </c:if>
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />    

    <link rel="stylesheet" href="/css/wzwg/site/mngr/main.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/site/mngr/contents.css" type="text/css" id="style_contents"/>
    <link rel="stylesheet" href="/css/wzwg/cmm/common.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/site/mngr/style.css" type="text/css" />
    <link rel="stylesheet" href="/css/wzwg/site/mngr/form.css" type="text/css" />
    
    <!-- 에디터 커스터마이징 CSS 추가 -->
    <link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css" />
	
	<!-- 위디자인 -->
	<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
	<script type="text/javascript" src="/widesign/widesign.js"></script>
    
    <%-- 저장된 서브페이지 CSS 로드 2021.04.06 --%>
	<link rel="stylesheet" href="/upload/subCss/<c:out value="${sessionScope.SITE_SEQ}" />/sub.css" type="text/css" />
    
	
	<!-- 위즈위그 메시지 로드 -->
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/cmm/jquery.i18n.properties-min-1.0.9.js"></script>
	<script type="text/javascript" language="JavaScript"  src="/js/wzwg/site/wzwgMessage.js"></script>
	
    <!-- <script type="text/javascript" src="/js/wzwg/cmm/resize.js"></script> -->

<script type="text/javascript" src="/js/wzwg/cmm/common.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
 <script type="text/javascript">

 	fnSiteKeyCallUrl('<c:out value="${sessionScope.SITE_KEY}" />');
			
 	$(document).ready(function(){
 		/* 위즈위그 메시지 로드 */
 		if(wz_msg == undefined){
			onloadWzwgMsg("<c:out value="${sessionScope.langCode}" />");
		}
 		
 	 	$('#sidebar li').each(function(){
 	 		if($(this).find('ul').length ==1){
 	 			$(this).off();
 	 			$(this).click(function(event){
 	 				//console.log(event.target);
 	 				//console.log(event.target.parentElement);
 	 				var ele = $(event.target);
 	 				var eleParent = $(event.target.parentElement);
 	 				if( ele.hasClass('btn_fav') && eleParent.css('opacity') == 1){
 	 					//alert(ele.attr('data-mngrmenuseq'));
 	 					//console.log($(this));
 	 					if(ele.hasClass('fa-star')) { // 즐겨찾기 메뉴 등록 되어 있을 경우
 	 						var frmData = {};
 	 						frmData.mngrBkmkSeq = $(ele).attr('data-mngrBkmkSeq');
 	 						
 	 						$.ajax({
 	 						   type:'POST'
 	 						 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/deleteSiteMngrBkmkAjax.do'
 	 						 , data: frmData
 	 						 , success:function (data) {
 	 							 	 if(data.result =='success'){
 	 							 		 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
 	 							 		 location.reload();
 	 							 	 }
 								}
 	 						 , dataType: 'html'
 	 						});
 	 					
 	 					}else if(ele.hasClass('fa-star-o') && eleParent.css('opacity') == 1) { // 즐겨찾기 메뉴 등록 안 되어 있을 경우
 	 						var frmData = {};
 	 						frmData.mngrMenuSeq = $(ele).attr('data-mngrmenuseq');
 	 						
 	 						$.ajax({
 	 						   type:'POST'
 	 						 , url:'<c:out value="${wzwg_contextPath}"/>/mngr/menu/bkmk/registSiteMngrBkmkAjax.do'
 	 						 , data: frmData
 	 						 , success:function (data) {
	 	 							 	 if(data.result =='success'){
	 	 							 		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	 	 							 		location.reload();
	 	 							 	 }
 	 							}
 	 						 , dataType: 'html'
 	 					 	}); 
 	 					}
 	 					event.preventDefault();
 	 					event.stopPropagation();
 	 					//console.log('event stop');
 	 				}else{
	 	 				$(this).find('ul').slideToggle('1000');
	 	 				//console.log('slideToggle');
 	 				}
 	 				
 	 			});
 	 		}
 	 	});
 		 
 	 });
 
 </script>
    
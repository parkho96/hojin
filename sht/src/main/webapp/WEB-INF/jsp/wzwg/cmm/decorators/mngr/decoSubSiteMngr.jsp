<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator"%>
<!doctype html >
<html lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
    
		<title>::: <spring:message code="wzwg.cmm.cntnts.subsitemanage" /> :::</title> 
   
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
    
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.js"></script>
    <script type="text/javascript" src="/js/wzwg/cmm/resize.js"></script>

<script type="text/javascript" src="/js/wzwg/cmm/common.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
	
	<!-- 위디자인 -->
	<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
	<script type="text/javascript" src="/widesign/widesign.js"></script>
</head>
 <body>  
 
 
	<div id="wrap">
		<div id="container">
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoSubSiteMngrHeader.jsp" />
                <jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoSubSiteMngrLeft.jsp" />
          <div id="contents">
				<div id="main">
					<div class="content-wrapper">
						 <c:set var="locationNm" />
            <c:if test="${fn:indexOf(nowUrl, '/template/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.templatemanage"/></c:set></c:if>
            <c:if test="${fn:indexOf(nowUrl, '/menu/') > -1}"><c:set var="locationNm"><spring:message code="wzwg.cmm.cntnts.menumanage"/></c:set></c:if>
						<div class="location-001">
							<ul>
								 <li><img src="/images/wzwg/site/mngr/lo-home.png" alt="<spring:message code="wzwg.cmm.word.home" />" /></li> 
              				    <li><c:out value="${locationNm}" /></li>
							</ul>
						</div>
						<h2><c:out value="${locationNm}" /></h2>
        <!-- //header_m -->
                <decorator:body />
        <!-- //contentpanel -->
        	</div>
				</div>				
			</div>	
		<jsp:include page="/WEB-INF/jsp/wzwg/cmm/include/incDecoMngrFooter.jsp" />
        <!-- //footer -->
        
		</div>
	</div>
    <!-- //wrap -->
 </body>
</html>

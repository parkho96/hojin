<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" 		uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
	
	    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	    <meta http-equiv="Content-Script-Type" content="text/javascript" />
	    <meta http-equiv="Content-Style-Type" content="text/css" />
	    <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	    
	    <title>::: 404 ERROR :::</title>
	    
  		<link type="text/css" href="/css/wzwg/cmm/common.css" rel="stylesheet" />
  		<!-- <link type="text/css" href="/css/wzwg/cmm/error/404/style.css" rel="stylesheet" /> -->
  		<link type="text/css" href="/css/wzwg/cmm/error/500/style.css" rel="stylesheet" />
		<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />
		<link rel="stylesheet" href="/widesign/widesigncore.css" type="text/css" />
  		
  	</head>
 <body>
 
		<div class="lockWrap002">
			<div class="lockOut002">
				<img src="/images/wzwg/cmm/500Icon.png" alt="" />
		 <p><spring:message code="wzwg.cmm.msg.MSG330" /></p>
		 <span>
			<spring:message code="wzwg.cmm.msg.MSG331" />
		 </span>
		 <div class="lockOutBox">
					<a class="wzbtn-lg btn-red-bg" href="/index.do"><spring:message code="wzwg.cmm.word.gohm" /></a>
		 <a class="wzbtn-lg btn-basic" href="javascript:void(0);" onclick="javascript:history.go(-1);"><spring:message code="wzwg.cmm.word.prevpage" /></a>
		 </div>
	 </div>
	</div>
	 
 </body>
</html>
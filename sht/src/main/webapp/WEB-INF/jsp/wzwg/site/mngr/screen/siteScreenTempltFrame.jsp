<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/js/wzwg/cmm/jquery-latest.min.js"></script>
<script>
$(document).ready(function(){
	 
	$('#tmpltForm').attr('action', '<c:out value="${wzwg_contextPath}"/>/mngr/screen/selectSiteScreenTempIndexMngr.do');
	$('#tmpltForm').attr('target', 'tmpltFrame');
	$('#tmpltForm').submit();
	
}); 

function fnFrameToggle(){
	var width = $('#tmpltFrame').width();
	if(width > 599){
		$('#tmpltFrame').css('width', '599px');
	}else{
		$('#tmpltFrame').css('width', '100%');
	}
}
</script>
<style>
	body{overflow: hidden;text-align: center;}
	#tmpltFrame {width:100%; height:100vh; border: 0;}
	.btnFrameToggle {
			position: absolute;
    		top: 0;
    		left: 0;
    		background: #fff;
    		padding: 5px;
    		}
    .btnFrameToggle:hover{background: #eee;}
</style>
</head>
<body>
<form id="tmpltForm">
	<input type="hidden" name="templateSeq" value="<c:out value="${paramVO.templateSeq }"/>"/>
</form>
<iframe id="tmpltFrame" name="tmpltFrame"></iframe>
<button type="button" class="btnFrameToggle" onclick="fnFrameToggle()"><spring:message code="wzwg.site.screen.msg.MSG194"/></button>
</body>
</html>
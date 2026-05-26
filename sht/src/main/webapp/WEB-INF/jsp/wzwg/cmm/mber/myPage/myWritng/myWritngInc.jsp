<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href='/css/wzwg/module/ntt/basic/unityBoard.css' rel="stylesheet">
<link type="text/css" href="/css/wzwg/site/mngr/form.css" rel="stylesheet" />
<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<script type="text/javascript">
try{document.title = '<spring:message code="wzwg.cmm.word.mberinfo" />-<spring:message code="wzwg.cmm.word.writngntt" /> / <spring:message code="wzwg.cmm.word.answerlist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		fnTabLink('ntt');
	});
	
	function fnTabLink(val){
		
		var pageUrl = "";
		
		if(val == 'ntt'){
			pageUrl = '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyWritngNttListAjax.do';
			$('#tabTit').html('<spring:message code="wzwg.cmm.word.ntt" />');
		}		
		
		if(val == 'answer'){
			pageUrl = '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyWritngAnswerListAjax.do';
			$('#tabTit').html('<spring:message code="wzwg.cmm.word.answer02" />');
		}	
		
		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#myFrm").serialize()
	      , success:function (data) {
	    	  $('#list_area').html(data);
	          $(".step > .tapMenu > li > a").removeClass("on");
	          $("#"+val).addClass("on");
	          $("#content").css("height",$(document).height());
			  //$(window).scrollTop(0);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
</script>
             
    <form:form modelAttribute="paramVO" id="myFrm" name="myFrm" method="post" onsubmit="return false;">
	    <form:hidden path="siteSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
    </form:form>
    
    <div class="step">
    	<ul class="tapMenu">
			<li><a href="javascript:void(0);" onclick="fnTabLink('ntt');" 		title="<spring:message code="wzwg.cmm.word.ntt" />" 		id="ntt"><spring:message code="wzwg.cmm.word.ntt" /></a></li>
			<li><a href="javascript:void(0);" onclick="fnTabLink('answer');" 	title="<spring:message code="wzwg.cmm.word.answer02" />" 	id="answer"><spring:message code="wzwg.cmm.word.answer02" /></a></li>
    	</ul>
    </div>
	
	<h4 id="tabTit" class="fs24 fn wd100 pt30 pb10"><spring:message code="wzwg.cmm.word.ntt" /></h4>
	    
    <div class="allbox">
    	<div id="list_area"></div>
    </div>

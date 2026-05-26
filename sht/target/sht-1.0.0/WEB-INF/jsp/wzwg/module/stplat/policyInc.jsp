<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />

	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />

	
    <link rel="stylesheet" href="/smartEditorCustom/css/editorTool.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_common.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/subcon_tamplate.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css" />
	<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.min.css" type="text/css" />
	<link rel="stylesheet" href="/css/wzwg/cmm/mber/sbscrb/style.css" type="text/css" />

<script type="text/javascript">

$(document).ready(function(){
	fnInit();
});
	
	function fnInit(val){
		
		var pageUrl = "";
		
		pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/stplatLog/selectPolicyLogListFormAjax.do';

		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:''
	      , success:function (data) {
	    	  $('#policy_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}

</script>

		<div id="policy_area"></div>
    		




	   
	   			

	

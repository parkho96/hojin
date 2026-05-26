<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/module/onlineReqst/onlineRequst.css" rel="stylesheet">

<script type="text/javascript">

	$(document).ready(function(){
		
		if('<c:out value="${paramVO.reqstnttSeq}" />' != ""){
			var frm = document.getElementById("onlineReqstFrm");
			frm.reqstnttSeq.value = '<c:out value="${paramVO.reqstnttSeq}" />';
			
			$.ajax({
				  type : 'POST'
				, dataType : 'html'
				, url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"
				, cache : false
				, async : false
				, data : $("#onlineReqstFrm").serialize()
				, success : function(data) {
					$('#onlineReqst_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}else{
			fnInit();
		}

	});
	
	function fnInit(val){
		
		var pageUrl = "";
		
		pageUrl = '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do';

		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#onlineReqstFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineReqst_area').html(data);
	          $("#content").css("height",$(document).height());
			  $(window).scrollTop(0);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}

</script>

 	<form:form modelAttribute="paramVO" path="onlineReqstFrm" name="onlineReqstFrm" id="onlineReqstFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="reqstSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
		<form:hidden path="menuSeq" />
		<input type="hidden" id="reqstnttSeq" name="reqstnttSeq" />
        <form:hidden path="sitecntntsSeq" />
    	<input type="hidden" id="mngrAt" name="mngrAt" value="<c:out value="${mngrAt}" />" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="onlineReqst_layer" class="modal fade bs-example-modal-sm in" tabindex="-1" role="dialog" aria-hidden="false"></div>
		<!-- 레이어팝업 영역 End -->

		<!-- body -->	    
		<div id="onlineReqst_area"></div>
    		
	</form:form>




	   
	   			

	

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
		
<script type="text/javascript">
    $(document).ready(function(){
    	fnPage(1);
	});
	
	function fnPage(pageIndex){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		
		$('#qustnrFrm').find('#pageIndex').val(pageIndex);
		
		$.ajax({
	        type:'POST'
	      , url: '<c:out value="${wzwg_contextPath}" />/module/onlineQustnr/selectOnlineQustnrRespondListAjax.do'
	      , cache : false
	      , async : false
	      , data:$("#qustnrFrm").serialize()
	      , success:function (data) {
	    	  $('#onlineQustnrArea').html(data);
	    	  $('#pageInfo').find('.on>a').focus();
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
</script>

<div id="onlineQustnrArea"></div>
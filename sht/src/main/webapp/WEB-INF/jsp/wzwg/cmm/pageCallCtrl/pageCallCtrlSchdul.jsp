<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="/js/wzwg/site/jqueryDatepickerWaAction.js"></script>
	<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
	<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
	<script type="text/javascript" src="/js/wzwg/cmm/common_validator.js"></script>
	
<script>

	$(document).ready(function(){
		var pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/schdul/selectSchdulNttInitAjax.do';
		
		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#schdulFrm").serialize()
	      , success:function (data) {
	    	  $('#schdul_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	});
	
</script>
 
 	<form  name="schdulFrm" id="schdulFrm" method="post" onsubmit="return false;">
		<input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${cntntsData.siteSeq}" />"/>
        <input type="hidden" name="schdulSeq" id="schdulSeq" value="<c:out value="${cntntsData.schdulSeq}" />"/>
		<input type="hidden" name="pageIndex" id="pageIndex"  value="<c:out value="${cntntsData.pageIndex}" />"/>
		<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${cntntsData.searchCondition}" />"/>
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${cntntsData.searchKeyword}" />"/>
		<input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" value="<c:out value="${cntntsData.sitecntntsSeq}" />"/>
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="schdul_layer" class="modal fade bs-example-modal-sm in" tabindex="-1" role="dialog" aria-hidden="false"></div>
		<!-- 레이어팝업 영역 End -->
		 

		<!-- body -->	    
		<div id="schdul_area" class="w100"></div>
    		
    </form>
    <input type="hidden" name="openBtnId" id="openBtnId"/>
    
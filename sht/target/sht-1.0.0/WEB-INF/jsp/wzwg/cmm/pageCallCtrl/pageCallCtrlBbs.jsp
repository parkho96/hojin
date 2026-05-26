<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>

	$(document).ready(function(){

		var pageUrl = '<c:out value="${wzwg_contextPath}${prefix}" />/module/ntt/unity/selectNttListAjax.do';
		
		document.getElementById('searchCondition').value = '';
		document.getElementById('searchKeyword').value = '';
		document.getElementById('pageIndex').value = 1;
		
		$.ajax({
	        type:'POST'
	      , url:pageUrl
	      , cache : false
	      , async : false
	      , data:$("#bbsFrm").serialize()
	      , success:function (data) {
	    	  $('#bbs_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	});
	
</script>
 
 	<form:form modelAttribute="paramVO" path="bbsFrm" name="bbsFrm" id="bbsFrm" method="post" onsubmit="return false;">
		<form:hidden path="siteSeq" />
        <form:hidden path="bbsSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCondition" />
		<form:hidden path="searchKeyword" />
        <input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" />
    	<input type="hidden" id="tabTyCode" name="tabTyCode" />
    	
	    <!-- 레이어팝업 영역 Start -->
		<div id="bbs_layer" class="pop-box"></div>
		<!-- 레이어팝업 영역 End -->
		
		<!-- body -->	    
		<div id="bbs_area" class="w100"></div>
    		
    </form:form>
    
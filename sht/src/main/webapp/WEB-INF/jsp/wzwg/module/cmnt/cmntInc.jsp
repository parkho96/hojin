<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){ 
		fn_init();
	});
	 
	function fn_init(){
		 
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntListAjax.do'
	   	  , data:$("#cmntFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fn_search(pageIndex){
		document.cmntFrm.pageIndex.value = pageIndex;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntListAjax.do'
	   	  , data:$("#cmntFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	}); 
	}

	function fn_registForm(){ 
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/registCmntAjax.do' 
	      , cache : false
	      , async : false 
	      , success:function (data) { 
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
</script>
	
		
		<div class="allbox"><!-- allbox로 한번더 감싸주기 -->
			<div id="cntnts_area" class="w100"></div>
		</div><!-- END -->

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 

<script type="text/javascript">
	 
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

	function fn_regist(){ 
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
	
		
		  <div class="complete-box mt60">
				<!-- <img class="mg30" src="/images/wzwg/module/cmnt/house.png" alt="" /> -->
				<p><spring:message code="wzwg.cmm.msg.MSG082" text="Community Request to open has been completed " /></p>
				<span class="mt40 mb50"><spring:message code="wzwg.cmm.msg.MSG011" text="Community application has been completed After confirming and reviewing the administrator, the community will be opened <br/> We will send an approval e-mail to the e-mail entered when opening the community" /></span>
				<div class="ctr-box">
					<a href="javascript:fn_init();" class="wzbtn btn-black"><spring:message code="wzwg.module.word.cmmntymain" /></a>
				</div>
		  </div>

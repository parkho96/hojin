<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){ 
		//fn_init();
	});
	 
	function fn_registUsr(){
		  
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntUsrRegistAjax.do'
	   	  , data:$("#cmntUsrFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message>');
	    	  location.href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>";
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'json'
	 	});
	}
	 
	 
	 
</script>
<form name="cmntUsrFrm" id="cmntUsrFrm">
<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>" />
 <div class="joinUs_box mt10">	
 
							 		<div class="complete-box mt60">
											<!-- <img class="mg30" src="/images/wzwg/module/cmnt/house.png" alt="" /> -->
											<p><spring:message code="wzwg.cmm.msg.MSG0821" /></p>
											<div><spring:message code="wzwg.cmm.word.applcnt" /> : <c:out value="${sessionScope.loginVO.userId}"/>(<c:out value="${sessionScope.loginVO.userNm}"/>)</div>
											<span class="mt40 mb50">
												<spring:message code="wzwg.cmm.msg.MSG0822" /><br>
												<spring:message code="wzwg.cmm.msg.MSG0823" /><br>
												<spring:message code="wzwg.cmm.msg.MSG065" text="For the smooth operation of the community, you may be forcibly removed by the administrator when you leave your profanity and idiom" />
											</span>
											<div class="ctr-box">
												<a href="javascript:fn_registUsr();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.signup" text="signup" /></a>
												<a href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></a>
											</div>
									  </div>
 
								  </div><!-- joinUs_box end -->

	</form>	 

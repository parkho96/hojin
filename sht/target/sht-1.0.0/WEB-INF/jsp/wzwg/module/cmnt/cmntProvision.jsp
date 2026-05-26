<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<script type="text/javascript">
try{document.title = cmntNm+'-<spring:message code="wzwg.module.word.cmmntysbscrb" />';}catch(e){console.log(e.message);}
	$(document).ready(function(){ 
		//fn_init();
	});
	 
	function fn_registAgree(){
		if(!document.agreeFrm.agreeYn.checked){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.stplat" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.agre" /></spring:argument></spring:message>');
			return;
		}
		$.ajax({ 
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntUserRegistFormAjax.do'
	   	  , data:$("#agreeFrm").serialize()
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
<form name="agreeFrm" id="agreeFrm">
<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq }'/>" />
<div class="signUp001 mt10">
						 <div class="signUp_wrap pt10">
							<div class="signUp_box pt10">
								<span class="fl cmTit"><c:out value='${result.cmntNm}'/>  <spring:message code="wzwg.cmm.word.stplat" text="stipulation" /></span>
								<div class="signText pd10" tabIndex="0">
									 <c:out value='${provision.cmntProvisionInfo}' escapeXml="false"/>
								</div>
								<div class="signClick mt10">
									<div class="txt-r">
										<ul class="wzForm">
											<li>
												<label>
													<input class="mr5" type="checkbox" name="agreeYn" id="agreeYn" value="Y" title="<spring:message code="wzwg.module.word.stplatagrececk" />" >
													<span class="spanLabel"><spring:message code="wzwg.cmm.msg.MSG081" text="I have read the terms and will proceed with joining the community" /> </span>
												</label>
											</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<div class="ctr-box pb50">
								<a href="javascript:fn_registAgree();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.signup" text="sign up" /></a>
						</div>
					</div> <!-- 약관동의 끝 --> 

	</form>	 

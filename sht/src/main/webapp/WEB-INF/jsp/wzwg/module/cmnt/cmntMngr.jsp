<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
try{document.title = '<c:out value="${result.cmntNm}"/>-<spring:message code="wzwg.module.word.cmmntymanage" />';}catch(e){console.log(e.message);}
	
	var cmntNm = '<c:out value="${result.cmntNm}"/>';
	
	$(document).ready(function(){ 
		fn_init();
	});
	 
	function fn_init(){
		$(".tapMenuCmnt").find("a").removeClass("on");
		$("#tabOn1").addClass("on");
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/cmntMngrBasicAjax.do' 
	      , cache : false
	      , async : false 
	      , data : {"cmntSeq":<c:out value='${result.cmntSeq}'/>}
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
	function fn_provision(){
		$(".tapMenuCmnt").find("a").removeClass("on");
		$("#tabOn2").addClass("on");
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/cmntMngrProvisionAjax.do' 
	      , cache : false
	      , async : false 
	      , data : {"cmntSeq":<c:out value='${result.cmntSeq}'/>}
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	} 
	
	function fn_menu(){
		$(".tapMenuCmnt").find("a").removeClass("on");
		$("#tabOn3").addClass("on");
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/mngr/cmntMeunAjax.do' 
	      , cache : false
	      , async : false 
	      , data : {"cmntSeq":<c:out value='${result.cmntSeq}'/>}
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
	
	function fn_user_list(){
		$(".tapMenuCmnt").find("a").removeClass("on");
		$("#tabOn4").addClass("on");
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/cmnt/mngr/selectCmntUserMngrAjax.do' 
	      , cache : false
	      , async : false 
	      , data : {"cmntSeq":<c:out value='${result.cmntSeq}'/>}
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
							
						<div class="rt-box">
							<span class="fl cmTit wd100">
								<div class="cmnyMainTit"><c:out value='${result.cmntNm}'/></div>
								<div class="btnbox mt10">
									<a class="wzbtn btn-basic cmntHome" title="<c:out value="${result.cmntNm}" /> <spring:message code="wzwg.module.word.cmmntygohm" />" href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>">
										<spring:message code="wzwg.cmm.word.cmmnty" text="communty" /> 
										<spring:message code="wzwg.cmm.word.gohm" text="home" /> 
									</a>
									<a href="<c:out value='${wzwg_contextPath}'/>/subList/<c:out value='${menuSeq }'/>" class="wzbtn btn-basic">
										<spring:message code="wzwg.cmm.word.cmmnty" text="communty" /> 
										<spring:message code="wzwg.cmm.word.list" text="list" />
									</a>
								</div>
							</span>
						</div>
						<div class="search-box mt10">
							<p class="txt-l"><c:out value='${result.cmntIntro}' escapeXml="false"/></p>
						</div>
						<div class="step mt20">
							<ul class="tapMenuCmnt">
								<li><a class="on" href="javascript:;" onclick="fn_init()" id="tabOn1"><spring:message code="wzwg.module.word.bassestbs" /></a></li>
								<li><a href="javascript:;" onclick="fn_provision()" id="tabOn2"><spring:message code="wzwg.module.word.stplatmanage" /></a></li>
								<li><a href="javascript:;" onclick="fn_menu()" id="tabOn3"><spring:message code="mgr.menuMngt" text="menu Manage" /></a></li>
								<li><a href="javascript:;" onclick="fn_user_list()" id="tabOn4"><spring:message code="wzwg.module.word.mbermanage" /></a></li>
							</ul>
						</div><!-- step end -->
						<div id="cntnts_area" class="w100"></div>

						</div><!-- END -->
					 

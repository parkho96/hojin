<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<link rel="stylesheet" href="/smartEditorCustom/css/font-awesome.css" type="text/css">
<link type="text/css" href="/css/wzwg/module/ntt/basic/imageBoard.css" rel="stylesheet">

<script type="text/javascript">
	$(document).ready(function(){ 
		//fn_init();
		var bbsSeq =$("input[name=bbsSeq]").val();
		var menuSeq =$("input[name=menuSeqInit]").val();
		var cmntMenuNm;
		if(bbsSeq !=undefined){
			fn_menu(bbsSeq,menuSeq);  
		}
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
	
	function fn_menu(bbsSeq,menuSeq){
		document.menuFrm1.menuSeq.value= menuSeq;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/setCmntMenuSeqAjax.do'
	      , data : $("#menuFrm1").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) { 
	    	  fn_bbs(bbsSeq);
	      }
	      , error:function (data) {
	          alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	
	}
	
	
	function fn_bbs(bbsSeq){
	
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/module/bbs/unity/selectBbsInc.do?cmntYn=Y&cntntsSeq='+ bbsSeq
		      , cache : false
		      , async : false 
		      , success:function (data) { 
		    	  $('#cntnts_area').html(data);
		    		$(".tapMenuCmnt").find("a").removeClass("on");
		    		$("#tap"+bbsSeq).addClass("on");
		    		cmntMenuNm = $("#tap"+bbsSeq).html(); 
		    		$('#tabTit').html($('.tapMenuCmnt').find('.on').html());
		      }
		      , error:function (data) {
		          alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		
		}
	 
	
	function fn_search(pageIndex){
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		document.cmntFrm.pageIndex.value = pageIndex;
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntListAjax.do'
	   	  , data:$("#cmntFrm").serialize()
	      , cache : false
	      , async : false 
	      , success:function (data) {
	    	  $('#cntnts_area').html(data);
	    	  $('#pageInfo').find('.on>a').focus();
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
	
	var cmntNm = '<c:out value="${result.cmntNm}"/>';
	
</script>

<div class="allbox">
	<!-- allbox로 한번더 감싸주기 -->
	<form name="menuFrm1" id="menuFrm1">
		<input type="hidden" name="menuSeq" id="menuSeq" value="" />
		<input type="hidden" name="cmntSeq" id="cmntSeq" value="<c:out value='${result.cmntSeq}'/>" />
	</form>
	<div class="rt-box" style="margin-bottom:10px !important;">
		<span class="fl cmTit wd100">
			<div class="cmnyMainTit"><c:out value="${result.cmntNm}" /></div>
			<div class="btnbox mt10">
				<a class="wzbtn btn-basic cmntHome" href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>"  title="<c:out value="${result.cmntNm}" /> <spring:message code="wzwg.module.word.cmmntygohm" />">
					<spring:message code="wzwg.cmm.word.cmmnty" text="communty" /> 
					<spring:message code="wzwg.cmm.word.gohm" text="home" /> 
				</a>
				<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.loginVO.usrSeq eq result.cmntMngrSeq}">
					<a href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/mngr/<c:out value='${result.cmntSeq}'/>" class="wzbtn btn-basic cmntSetting" title="<spring:message code="wzwg.module.word.cmmntymanage" />">
						<spring:message code="wzwg.cmm.word.cmmnty" text="communty" />
						<spring:message code="wzwg.cmm.word.manage" text="manage" />
					</a>
				</c:if>
				<a href="<c:out value='${wzwg_contextPath}'/>/subList/<c:out value='${menuSeq }'/>" class="wzbtn btn-basic">
					<spring:message code="wzwg.cmm.word.cmmnty" text="communty" /> 
					<spring:message code="wzwg.cmm.word.list" text="list" />
				</a>
			
				<c:set var="authBtnRequst" value="N" />
				<c:forEach items="${groupList}" var="groupList" varStatus="status">
					<c:if test="${sessionScope.loginVO.usrgroupSeq eq  groupList.usrgroupSeq}">
						<c:set var="authBtnRequst" value="Y" />
					</c:if>
				</c:forEach>
				<c:if test="${authBtnRequst eq 'Y' and sessionScope.loginVO.usrSeq ne result.cmntMngrSeq and cmntUserYn eq 'N'}">
					<a href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/usr/<c:out value='${result.cmntSeq}'/>" class="wzbtn btn-black">
						<spring:message code="wzwg.cmm.word.sbscrb" text="subscribe" />
					</a>
				</c:if>
			</div>
		</span>
	</div>
	<div class="search-box">
		<p class="txt-l">
			<c:out value="${result.cmntIntro}" escapeXml="false" />
		</p>
	</div>
	<div class="step mt20">
		<ul class="tapMenuCmnt">
			<c:forEach items="${menuList}" var="resultList" varStatus="status">
				<li>
					<input type="hidden" name="bbsSeq" id="bbsSeq" value="<c:out value='${resultList.bbsSeq}'/>" />
					<input type="hidden" name="menuSeqInit" id="menuSeqInit" value="<c:out value='${resultList.menuSeq}'/>" />
					<a href="javascript:fn_menu('<c:out value="${resultList.bbsSeq}" />','<c:out value="${resultList.menuSeq}" />')" 
					   id="tap<c:out value='${resultList.bbsSeq}' />" >
					<c:out value="${resultList.menuNm}" /></a>
				</li>
			</c:forEach>
		</ul>
	</div><!-- step end -->
	<h5 id="tabTit" class="fs24 fn wd100 pt20"></h5>
	<div id="cntnts_area" class="w100"></div>
</div><!-- END -->


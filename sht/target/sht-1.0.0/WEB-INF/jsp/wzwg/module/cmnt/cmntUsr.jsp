<%@page import="egovframework.wzwg.cmm.util.CmmSessionUtil"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:set var="siteNm"><%=CmmSessionUtil.getSessionSiteNm(request) %></c:set>
	<title><c:out value="siteNm"/></title>
	<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
	
   	<link rel="stylesheet" href="/css/wzwg/cmm/layout.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/empty_line.css" type="text/css" />
 	<link rel="stylesheet" href="/css/wzwg/cmm/font.css" type="text/css" />
 	
<script type="text/javascript">
	$(document).ready(function(){ 
		//fn_init(); 
		<c:if test="${provision.cmntProvisionAt eq 'Y'}">
		fn_provision();
		</c:if>
		<c:if test="${provision.cmntProvisionAt eq 'N'}">
		fn_regist();
		</c:if>
	});
	 
	function fn_regist(){
		 
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntUserRegistFormAjax.do'
	   	  , data: {"cmntSeq":<c:out value="${result.cmntSeq}"/>}
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
	
	
	function fn_provision(){
			 
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}"/>/module/cmnt/selectCmntUserProvisionFormAjax.do'
		      , cache : false
		      , async : false 
		      , data: {"cmntSeq":<c:out value="${result.cmntSeq}"/>}
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

	<div class="rt-box">
		<span class="fl cmTit wd100">
			<div class="cmnyMainTit"><c:out value="${result.cmntNm}" /></div>
			<div class="btnbox mt10">
				<a class="wzbtn btn-basic cmntHome" href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>"  title="<c:out value="${result.cmntNm}" /> <spring:message code="wzwg.module.word.cmmntygohm" />">
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
		<p class="txt-l">
			<c:out value="${result.cmntIntro}" escapeXml="false" />
		</p>
	</div>

	<div id="cntnts_area" class="w100"></div>
</div><!-- END -->
						
	
		 

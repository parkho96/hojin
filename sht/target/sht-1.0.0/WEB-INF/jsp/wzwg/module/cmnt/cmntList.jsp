<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>	
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<link rel="stylesheet" href="/css/wzwg/module/cmnt/community.css"> 
<script>
try{document.title = $('#menuPath').val().replace(/>/gi,'-').slice(0,-1);}catch(e){console.log(e.message);}
</script>
  <form name="cmntFrm" id="cmntFrm">
		 <input type="hidden" name="pageIndex" id="pageIndex"  />
			<div class="search-box mt10">
				<p><c:out value="${cmntCfgVO.cmntInfo}" escapeXml="false"/></p>
			</div>
		 <ul class="community-box">
		 <c:forEach var="result" items="${resultList}" varStatus="status">
							<li>
								<span><img src="<c:out value='${result.cmntIconStre }'/>" alt="" /></span>
								<a href="<c:out value='${wzwg_contextPath}'/>/module/cmnt/main/<c:out value='${result.cmntSeq}'/>" title="<c:out value='${result.cmntNm }'/> <spring:message code="wzwg.cmm.word.shrtcut"/>">
									<span class="cmnyTit"><span><c:out value="${result.cmntNm }"/></span></span>
									<p class=""><c:out value="${result.cmntSimpIntro}" escapeXml="false"/></p>
								</a>
							</li>
		 </c:forEach>
						</ul>
						
						
						<div class="ctr-box" id="pageInfo">
							<ul class="num mobile-none">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_search" />
							</ul>
							
							<ul class="num pc-none">
								<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fn_search" />
							</ul>
						</div>
						<div class="rt-box fl">
						<c:set var="authBtnRequst" value="N"/>
						<c:forEach items="${groupList}" var="groupList" varStatus="status">
							<c:if test="${sessionScope.loginVO.usrgroupSeq eq  groupList.usrgroupSeq and cmntCfgVO.cmntEstblCode eq 'SC00000333'}"><c:set var="authBtnRequst" value="Y"/></c:if>
						</c:forEach>
						 
						<c:if test="${authBtnRequst eq 'Y'}">
							<a href="javascript:fn_registForm();" class="wzbtn btn-black"><spring:message code="wzwg.module.word.cmmntyreqst" /></a>
						</c:if>
						</div>
					
	 </form>
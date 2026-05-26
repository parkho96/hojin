<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
		 function fn_siteUsrGroupRegistForm(){
			 var frm = document.siteUsrGroupForm;
			 frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/registSiteUsrGroupForm.do';
			 frm.submit();
		 }
		 
		 function fn_siteUsrGroupDetail(paramSeq){
			 var frm = document.siteUsrGroupForm;
			 
			 frm.usrGroupSeq.value = paramSeq;
			 frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupDetail.do';
			 frm.submit(); 
		 }
		 
		 function fn_search(){
			var frm = document.siteUsrGroupForm;
			frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do';
			frm.submit();
		 }
		 
		 function fnPage(paramPageIndex){
		 	if(isNaN(paramPageIndex)){
				console.log('잘못된 페이지호출');
				return;
			}
			document.siteUsrGroupForm.pageIndex.value = paramPageIndex;
			document.siteUsrGroupForm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do';
			document.siteUsrGroupForm.submit();
		 }
	</script>
	
	<div class="wz_notice brbox bg-white br-blue-strong">	
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG045" /></li>
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG0451" /></li>
	                <li class="admpg-subp wd100 mb0 grey">· <spring:message code="wzwg.cmm.msg.tip.MSG046" /></li>
	         </ul>
	</div>
		
	<form id="siteUsrGroupForm" name="siteUsrGroupForm" method="post">
  	    <input type="hidden" name="usrGroupSeq" id="usrGroupSeq" value=""/>
  	    <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/>
		<div class="wzAdmSrchbox txt-l">
			<select name="searchCondition" id="searchCondition">
				<option value=""  <c:if test="${empty paramVO.searchCondition  }">selected="selected"</c:if>><spring:message code="wzwg.site.menu.msg.MSG004" /></option>
			</select>
			
			<c:set var="srchwrd">
				<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
			</c:set>
			
			<input type="text" name="searchKeyword" id="searchKeyword" placeholder="<c:out value="${srchwrd}" />" class="txt" onkeypress="if(window.event.keyCode == 13) {fn_search();}" <c:if test="${!empty paramVO.searchKeyword}">value="<c:out value="${paramVO.searchKeyword }" />"</c:if> />
	 		<a href="javascript:void(0);" class="wzbtn-table btn-srch" onclick="fn_search();"><spring:message code="wzwg.cmm.word.search01" /></a>
		</div>
	
		<table class="basic-table">
			<colgroup>
				<col width="20%" />
		        <col width="*" />
		        <col width="10%" />
			</colgroup>
			<thead>
			  <tr>
			  	<th>No</th>
				<th><spring:message code="wzwg.site.usrmngr.msg.MSG004" /></th>
				<th><spring:message code="wzwg.cmm.word.manage" /></th>
			  </tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${!empty siteUsrGroupList }">
						<c:forEach items="${siteUsrGroupList }" var="siteUsrGroupList" varStatus="status">
							<tr>
								<td>
									<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }"/>
								</td>
								<td class="txt-l">
									<c:out value="${siteUsrGroupList.usrGroupNm }"/>
								</td>
								<td>
									<a href="javascript:void(0);" onclick="fn_siteUsrGroupDetail('<c:out value="${siteUsrGroupList.usrGroupSeq}" />')" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.detail" />"><spring:message code="wzwg.cmm.word.detail" /></a>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="4"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</form>
	 
	 <c:if test="${!empty siteUsrGroupList}">
	 <div class="ctr-box" id="pageInfo">
		<ul class="num mobile-none">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
		
		<ul class="num pc-none">
			<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
		</ul>
	 </div>
	 </c:if>

	 <div class="rt-box">
	 	<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_siteUsrGroupRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
	 </div>

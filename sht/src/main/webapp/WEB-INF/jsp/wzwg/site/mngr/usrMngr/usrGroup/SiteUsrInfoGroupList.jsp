<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
	$(document).ready(function(){
		$("#checkall").click(function(){
			if($("#checkall").prop("checked")){
				$("input[name=chk]").prop("checked", true);
			}else{
				$("input[name=chk]").prop("checked", false);
			}
		});
	});
	
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
			fn_usrGrouplist();
		 }
	</script>
	  
  	    <%-- <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/> --%>
 
 		<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.cmm.word.groupUsrList"/></h3>
 
		<table class="basic-table">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/> 
				<col width="*"/>
				<col width="15%"/>
				<col width="15%"/> 
		 </colgroup>
		  <thead>
			 <tr class="bg-white">
				 <th><ul class="wzForm"><li><label><input type="checkbox" name="checkall" id="checkall"/><span class="spanLabel"></span></label></li></ul></th>
				 <th>No</th>
				 <th><spring:message code="wzwg.cmm.word.nm02" /> (<spring:message code="wzwg.cmm.word.id02" />)</th>
				 <th><spring:message code="wzwg.site.usrmngr.msg.MSG009" /></th>
				 <th><spring:message code="wzwg.cmm.word.sttus" /></th>
			 </tr>
		 </thead>
			<tbody>
				<c:if test="${empty usrInfoList}">
				<tr>
					<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG246" /></td>
				</tr>
				</c:if>
				<c:forEach items="${usrInfoList }" var="usrInfoList" varStatus="status">
					<tr>
						<td><ul class="wzForm"><li><label><input type="checkbox" name="chk" value="<c:out value="${usrInfoList.usrSeq}:${usrInfoList.siteSeq}" />" /><span class="spanLabel"></span></label></li></ul></td>
						<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1 }" /></td>
						<td class="txt-l"><c:out value="${usrInfoList.userNm }" /> <span class="grey">(<c:out value="${usrInfoList.userId }" />)</span></td>
						<td><c:out value="${usrInfoList.sbscrbPnttm }" /></td>
						<c:if test="${sessionScope.SYSMNGR_AT ne 'Y' }">
							<td><c:out value="${usrInfoList.usrSttusCodeNm }" /></td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		 
	<c:if test="${!empty usrInfoList}">
	 	<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
			</ul>
		</div>
	</c:if>

	  

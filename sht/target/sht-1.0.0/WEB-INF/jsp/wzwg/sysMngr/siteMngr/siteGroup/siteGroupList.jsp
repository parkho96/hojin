<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">
function fnRegistFrom() {
	document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do";
	document.frmSrh.submit();
}

function fnDetail(sitegrpSeq) {
    document.frmSrh.sitegrpSeq.value = sitegrpSeq;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do";
    document.frmSrh.submit();
}

function fnPage(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
	document.listForm.pageIndex.value = pageIndex;
	document.listForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/siteGroup/selectSiteGroupList.do";
	document.listForm.submit();
}
</script>
                    <form name="frmSrh" id="frmSrh" method="post">
                        <input type="hidden" name="sitegrpSeq" />
                    </form>
                    
                    <div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
						<ul class="wd100">
							<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG131" /></li>
							<li class="admpg-subp wd100 pb5">· <spring:message code="wzwg.cmm.msg.tip.MSG132" /></li>
							<li class="admpg-subp wd100 mb0 grey">· <spring:message code="wzwg.cmm.msg.tip.MSG133" /></li>
						</ul>
					</div>
					
					<!--//게시판명 table -->
						<form name="listForm" id="listForm" method="post">
							<input type="hidden" name="sitegrpSeq" value="" />
							<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
						</form>
					
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<colgroup>
						<col width="5%" />
                        <col width="*" />
                        <col width="10%" />
                        <col width="10%" />
                        <col width="13%" />
                        <col width="10%" /> 	
						</colgroup>
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
							<th><spring:message code="wzwg.sysMngr.word.firstGroupNm01" /></th>
							<th><spring:message code="wzwg.sysMngr.word.siteCo" /> </th>
							<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
							<th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
							<th><spring:message code="wzwg.cmm.word.manage" /></th>
						  </tr>
						</thead>
						<tbody>
						<c:if test="${empty resultList}">
						<tr>
							<td colspan="6"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="list" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
							<td><c:out value="${list.groupNm}" /></td>
                            <td><c:out value="${list.cnt}" /></td>
							<td>
								<c:if test="${list.useAt eq 'Y'}"><span class="circle_badge bg-blue-strong br3 vert-m"><spring:message code="wzwg.cmm.word.use" /></span></c:if>
								<c:if test="${list.useAt eq 'N'}"><span class="circle_badge bg-grey-strong br3 vert-m"><spring:message code="wzwg.cmm.word.unuse" /></span></c:if>
							</td>
                            <td><c:out value="${list.frstRegistPnttm}" /></td>
                            <td><a href="javascript:void(0);" onclick="javascript:fnDetail('<c:out value="${list.sitegrpSeq}" />');" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
						</tr>
						</c:forEach>
						</tbody>
					</table>
				  <c:if test="${!empty resultList}">
				  	<div class="ctr-box" id="pageInfo">
						<ul class="num mobile-none">
							<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
						
						<ul class="num pc-none">
							<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnPage" />
						</ul>
					</div>
				  </c:if>
					  
				<!--// button --> 
				<div class="rt-box">
					<a href="javascript:void(0);" onclick="fnRegistFrom(); return false;" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.regist" /></a>
				</div>

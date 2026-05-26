<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript">

$(document).ready(function(){
    var retMsg = "<c:out value="${message}" />";
    
    if (retMsg != "") {
        alert(retMsg);
    }    
});

function fnRegistFrom() {
	document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do";
	document.frmSrh.submit();
}

function fnDetail(estbsinfoSeq) {
    document.frmSrh.estbsinfoSeq.value = estbsinfoSeq;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do";
    document.frmSrh.submit();
}

function fnPage(pageIndex) {
	
	if(isNaN(pageIndex)){
		console.log('잘못된 페이지호출');
		return;
	}
	
	document.listForm.pageIndex.value = pageIndex;
	document.listForm.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do";
	document.listForm.submit();
}

function fnModifyEstbsAt(estbsinfoSeq, estbsAt) {
    
    if (!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
					'<spring:argument><spring:message code="wzwg.sysMngr.word.menuEstbs" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.change" /></spring:argument>'+
				  '</spring:message>')) return;
    
    document.frmSrh.estbsinfoSeq.value = estbsinfoSeq;
    document.frmSrh.estbsAt.value = estbsAt;
    
    document.frmSrh.action="<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/menuEstbs/modifyMenuEstbsAt.do";
    document.frmSrh.submit();
}
</script>
                    <form name="frmSrh" id="frmSrh" method="post">
                        <input type="hidden" name="estbsinfoSeq" />
                        <input type="hidden" name="estbsAt" />
                    </form>
                    
                    <div class="wz_notice brbox bg-white br-blue-strong">	
					    <ul class="wd100">
						    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG136" /></li>
						    <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG137" /></li>
					    </ul>
					</div>
					
					<!--//게시판명 table -->
						<form name="listForm" id="listForm" method="post">
							<input type="hidden" name="estbsinfoSeq" value="" />
							<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
						</form>
					
					<!--//게시판 설정 table -->
					<table class="basic-table">
						<colgroup>
							<col width="5%" />
	<!--                         <col width="20%" /> -->
	<!--                         <col width="20%" /> -->
	                        <col width="*" />
	<!--                         <col width="15%" /> -->
	                        <col width="15%" />
	                        <col width="10%" />
						</colgroup>
						<thead>
						  <tr>
							<th><spring:message code="wzwg.cmm.word.sn" /></th>
<!-- 							<th>공동유대구분</th> -->
<!--                             <th>지역본부코드</th> -->
							<th><spring:message code="wzwg.sysMngr.word.menuSetNm02" /></th>
<!--						<th>설정여부</th> -->
                            <th><spring:message code="wzwg.sysMngr.word.registDe" /></th>
                            <th><spring:message code="wzwg.cmm.word.manage" /></th>
						  </tr>
						</thead>
						<tbody>
						<c:if test="${empty resultList}">
						<tr>
							<td colspan="4"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
						</tr>
						</c:if>
						<c:forEach items="${resultList}" var="list" varStatus="status">
						<tr>
                            <td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>

                            <td class="txt-l"><c:out value="${list.estbsinfoNm}" /></td>
                          
                            <td onclick="javascript:fnDetail('<c:out value="${list.estbsinfoSeq}" />');"><c:out value="${list.frstRegistPnttm}" /></td>
                            <td><a href="javascript:void(0);" onclick="javascript:fnDetail('<c:out value="${list.estbsinfoSeq}" />');" class="iconOnlyBtn btn-basic btn-setting" title="<spring:message code="wzwg.cmm.word.estbs" />"><spring:message code="wzwg.cmm.word.estbs" /></a></td>
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

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
function fnSearch(pageIndex) {
	if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
   var frm = document.frmSrh;
   
   frm.pageIndex.value = pageIndex;
   
   frm.action = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkGrpList.do';
   frm.submit();
}

function fnRegistForm() {
    var frm = document.frmSrh;
    
    frm.action = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkGrpForm.do';
    frm.submit();
}

function fnDetail(linkGrpSeq) {
    var frm = document.frmSrh;
    
    frm.linkGrpSeq.value = linkGrpSeq;
    
    frm.action = '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/menu/linkGrp/selectLinkGrpForm.do';
    frm.submit();
}
</script>		
	<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">
	        <ul class="wd100">
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG023" /></li>
	                <li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG024" /></li>
	                <li class="admpg-subp wd100 mb0 grey">· <spring:message code="wzwg.site.menu.msg.MSG007" /> : 
                        <select>
                            <option><spring:message code="wzwg.site.menu.msg.MSG008" /></option>
                            <option><spring:message code="wzwg.site.menu.msg.MSG009" />01</option>
                            <option><spring:message code="wzwg.site.menu.msg.MSG009" />02</option>
                            <option><spring:message code="wzwg.site.menu.msg.MSG009" />03</option>
                        </select>
	                </li>
	        </ul>
	</div>
	<form id="frmSrh" name="frmSrh" method="post">
		<input type="hidden" name="linkGrpSeq" id="linkGrpSeq" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>"/>
		<table class="basic-table">
			  <colgroup>
				<col width="10%" />
				<col width="*" />
				<col width="20%" />
				<col width="10%" />
		      </colgroup>
			  <thead>
				<tr>
					<th>No</th>
					<th><spring:message code="wzwg.cmm.cntnts.linkgroup" /></th>
					<th><spring:message code="wzwg.cmm.word.rgsde" /></th>
					<th><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  <c:choose>
			  	<c:when test="${!empty resultList}">
			  		<c:forEach items="${resultList}" var="result" varStatus="status">
			  		<tr style="cursor:pointer;" onclick="fnDetail('<c:out value="${result.linkGrpSeq}"/>');">
			  			<td>
			  				<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/>
			  			</td>
			  			<td class="txt-l">
			  				<c:out value="${result.groupNm}"/>
			  			</td>
			  			<td>
			  				<c:out value="${result.frstRegistPnttm}"/>
			  			</td>
			  			<td><span class="iconOnlyBtn btn-basic btn-modify" title="<spring:message code="wzwg.cmm.word.updt" />"><spring:message code="wzwg.cmm.word.updt" /></span></td>
			  		</tr>
			  		</c:forEach>
			  	</c:when>
			  	<c:otherwise>
			  		<tr>
			  			<td colspan="4">
                            <spring:message code="wzwg.cmm.cmmMsg.CMG014">
                                <spring:argument><spring:message code="wzwg.cmm.word.dtartv" /></spring:argument>
                            </spring:message>
                        </td>
			  		</tr>
			  	</c:otherwise>
			  	</c:choose>
			  </tbody>
		</table>
		
		<c:if test="${!empty resultList}">
		<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnSearch" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnSearch" />
			</ul>
		</div>
		</c:if>
        
		<div class="rt-box">
			<a href="javascript:void(0);" class="wzbtn btn-save bg" onclick="fnRegistForm();"><spring:message code="wzwg.cmm.word.regist" /></a>
		</div>
	</form>
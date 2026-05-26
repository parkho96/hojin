<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	
	var retMsg = '<c:out value="${retMsg}" />';
	
	if (retMsg != null) {
		
		if (retMsg == 'SUCCESS') {
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
		} else if (retMsg == 'ERROR') {
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
		}
	}
});

function fnRegist() {
	var frm = document.frmList;
	
	frm.action = "<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/sbscrbCrtfcEstbs/registSbscrbCrtfcEstbs.do";
	frm.submit();
}
</script>
	<div class="wz_notice brbox bg-white br-blue-strong">	
		<p class="admpg-subp wd100 mb0"><spring:message code="wzwg.cmm.msg.tip.MSG047" /></p>
	</div>
	
	<form id="frmList" name="frmList" method="post">
	<table summary="<spring:message code="wzwg.site.usrmngr.msg.MSG022"/>" class="basic-table">
		<colgroup>
			<col width="20%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.site.usrmngr.msg.MSG001" /></th>
				<th><spring:message code="wzwg.site.usrmngr.msg.MSG002" /></th>
			</tr>
		</thead>
		<tbody>
        <c:set var="preSeq" />
		<c:forEach items="${resultList}" var="result" varStatus="status">
        <c:if test="${result.usrtySeq ne preSeq}">
		<tr class="tb_data">
			<th><c:out value="${result.tyNm}" /></th>
			<td style="background:#fff !important;">
				<ul class="wzForm">
				<c:forEach items="${codeList}" var="code" varStatus="codeSttus">
                <c:if test="${code.qesitmEstbsSe eq 'Y'}">
                    <c:set var="chkVal" value="" />
                    <c:forEach items="${resultList}" var="chkResult" varStatus="status">
					<c:if test="${chkResult.ucrtfcEstbsCode eq code.usrMngrestbsCode && result.usrtySeq eq chkResult.usrtySeq && chkResult.estbsAt eq 'Y'}">
					<c:set var="chkVal" value="checked" />
					</c:if>
                    </c:forEach>
                    	<li class="i-block ml5 mr5">
                    		<label>
                    			<input type="checkbox" id="estbsAtArr" name="estbsAtArr" value="<c:out value="${result.usrtySeq}:${code.usrMngrestbsCode}" />" <c:out value="${chkVal}" /> />
                    			<span class="spanLabel"><c:out value="${code.usrMngrestbsCodeNm}" /></span>
                    		</label>
                    	</li>
                </c:if>
				</c:forEach>
				</ul>
			</td>
		</tr>
        </c:if>
        <c:set var="preSeq" value="${result.usrtySeq}" />
		</c:forEach>
		</tbody>
	</table>
	</form>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnRegist();"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>

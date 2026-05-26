<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<% 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	if(getPort.equals("80")){getPort="";} else {getPort= ":"+getPort;}
	request.setAttribute("getUrl", getUrl);
	request.setAttribute("getPort", getPort);
%>

<script type="text/javascript">

	function fnSearch(callId){
		var frm = document.listFrm;
		
		frm.searchAt.value = "";
		
		if(frm.searchKeyword.value != ""){
			frm.searchAt.value = "Y";	
		}
		
		frm.pageIndex.value = 1;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyWritngAnswerListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#list_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	            }
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnPage(pageIndex){
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}" />/cmm/mber/myPage/selectMyWritngAnswerListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#list_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnNttOrgTxt(menuSeq, nttSeq){
		
		var getUrl = "http://<c:out value="${getUrl}"/><c:out value="${getPort}"/>/subList/"+menuSeq+"?pmode=detail&nttSeq="+nttSeq;
		
		var frm = document.listFrm;
		frm.action = getUrl;
		frm.target = "_blank";
		frm.submit();
	}
	
</script>
         
	<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
		<form:hidden path="siteSeq" />
		<form:hidden path="bbsSeq" />
		<form:hidden path="nttSeq" />
		<form:hidden path="pageIndex" />
		<form:hidden path="searchCnd" />
		<form:hidden path="searchAt" />
		
		<div class="sbscrb005">
		
			<table class="basic-table01">
			<caption><spring:message code="wzwg.cmm.word.answerlist" /></caption>
			<colgroup>
				<col width="5%">
				<col width="*">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
			<tr>
				<th scope="col">No</th>
				<th scope="col"><spring:message code="wzwg.cmm.word.answer02" /></th>
				<th scope="col"></th>
				<th scope="col"><spring:message code="wzwg.cmm.word.rgsde02" /></th>
			</tr>
			</thead>
			<tbody>
				<c:if test="${!empty resultList}">
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					
					<tr>
						<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}" /></td>
						<td class="txt-l">
							<c:out value="${resultList.answerCn}" escapeXml="false" />
						</td>
						<td>
							<c:if test="${resultList.nttDeletAt eq 'Y'}">
								<spring:message code="wzwg.cmm.word.orgtxtnttdelete" /> 
							</c:if>
							<c:if test="${resultList.nttDeletAt eq 'N'}">
								<a href="javascript:void(0);" onclick="fnNttOrgTxt('<c:out value="${resultList.menuSeq}" />', '<c:out value="${resultList.nttSeq}" />');" title="<spring:message code="wzwg.cmm.word.wa.newOpWin" />"><spring:message code="wzwg.cmm.word.orgtxtview" /> ▶</a>
							</c:if>
						</td>
						<td><c:out value="${resultList.frstRegistPnttm}" /></td>
					</tr>
					
					</c:forEach>
				</c:if>	
				
				<c:if test="${empty resultList}">
					<tr>
						<td colspan="4"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
					</tr>
				</c:if>	
			</tbody>
			</table>
			
			<c:if test="${!empty resultList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			<c:set var="searchkeyinp"><spring:message code="searchkeywordinput" /></c:set>
			<div class="txt-c" id="nttSearch">
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="searchKeyword" placeholder="${fn:escapeXml(srchwrd)}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${fn:escapeXml(searchkeyinp)}"/>
				<a href="javascript:void(0);" class="wzbtn-table btn-srch" id="btn_search" onclick="fnSearch('btn_search');"><spring:message code="wzwg.cmm.word.search01" /></a>
			</div>
			
		</div>
	
	</form:form>
    
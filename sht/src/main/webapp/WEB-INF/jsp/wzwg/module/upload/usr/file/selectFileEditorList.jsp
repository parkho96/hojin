<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
	pageContext.setAttribute("cn", "\n"); 
	String getUrl = request.getServerName().toString();
	String getPort = String.valueOf(request.getServerPort());
	
	if(getUrl != null) {
		getUrl = getUrl.replaceAll("<","&lt;");
		getUrl = getUrl.replaceAll(">","&gt;");
	}else{
		return;
	}
	
	if(getPort != null) {
		getPort = getPort.replaceAll("<","&lt;");
		getPort = getPort.replaceAll(">","&gt;");
	}else{
		return;
	}
	
	if(getPort.equals("80") || getPort.equals("443")){getPort="";} else {getPort= ":"+getPort;}
%>

<script src="/clipboard/dist/clipboard.min.js"></script>
<script>
function fnCopyUrl(usrfileSeq){
	$('#adres_copy_btn'+usrfileSeq).attr('data-clipboard-text', '<%=request.getScheme()%>://<%=getUrl%><%=getPort%><c:out value="${wzwg_contextPath}" />/module/upload/usr/file/fileDown.do?usrfileSeq='+usrfileSeq);    
	var clipboard = new Clipboard('#adres_copy_btn'+usrfileSeq);
	clipboard.on('success', function(e) {
	    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG010"><spring:argument><spring:message code="wzwg.cmm.word.copy" /></spring:argument></spring:message>');
	    clipboard.destroy();
	});
	clipboard.on('error', function(e) {
	    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
	    return false;
	    clipboard.destroy();
	});
}
</script>

<form id="fileFrm" name="fileFrm" method="post">
<Script>
function fnFileStoreSearch(pageIndex, callId){  
	$("#fileFrm #pageIndex").val(pageIndex);
	$("#fileFrm #filectgrySeq").val($("#fileFrm #filectgrySeqList").val());  
	//fnFileStorePop(pageIndex);
	$.ajax({
        type : 'POST'
		, url : '<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectFileEditorListAjax.do?id=<c:out value="${param.id}" />'
		, dateType : 'html'
		, data :$("#fileFrm").serialize()
		, success : function (data) {
			$('.pop-container').html(data);
			$('#pageInfo').find('.on>a').focus();
			if(callId != undefined || callId != ''){
            	$('#' + callId).focus();
            }
		}
		, error : function (request, status, error) {
			alert('error');
		}
	}); 
}
</Script>
<input type="hidden" name="usrfileSeq" id="usrfileSeq" />
<input type="hidden" name="filectgrySeq" id="filectgrySeq" />
   
<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${fileVO.pageIndex}" />"/>
 
 <div class="main-menu-bar">
	<select name="filectgrySeqList"  id="filectgrySeqList">
     	<option value="">--<spring:message code="wzwg.cmm.word.all" />-- </option>
     	<c:forEach items="${ctgryList }" var="list" varStatus="status">
     		<option value="<c:out value="${list.filectgrySeq}" />" <c:if test="${fileVO.filectgrySeq eq list.filectgrySeq}">selected="selected"</c:if>><c:out value="${list.filectgryNm}" /> </option>
     	</c:forEach>
     </select>
	<select name="searchCondition" title="<spring:message code="wzwg.module.word.searchse" />" class="w10" id="searchCondition"> 
		<%-- <option value=""><spring:message code="wzwg.cmm.word.all" /></option> --%>
		<option value="T" <c:if test="${fileVO.searchCondition eq 'T'}">selected="selected"</c:if>> <spring:message code="wzwg.module.word.filesj" /></option>
		<option value="F" <c:if test="${fileVO.searchCondition eq 'F'}">selected="selected"</c:if>> <spring:message code="wzwg.module.word.filenm" /></option>
	</select>
	
	<c:set var="srchwrd">
		<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
	</c:set>
	<input name="searchKeyword" title="<spring:message code="wzwg.module.word.searchkeywordinput" />" class="txt w30" id="searchKeyword" onkeydown="if(event.keyCode == 13){return false;}" type="text" placeholder="<c:out value="${srchwrd}" />" value="<c:out value="${fileVO.searchKeyword}" />">
	<a class="wzbtn-table btn-srch" id="btn_search" onclick="fnFileStoreSearch('1', 'btn_search');" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.search" /></a>				
	</div>
<table class="basic-table">
			  
			  <thead> 
				<tr> 
					<th scope="col">No</th>
					<th scope="col"><spring:message code="wzwg.cmm.word.ctgry02" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.filesj" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.orginlfilenm" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.filemg" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.rgsde" /></th>
					<th scope="col"><spring:message code="wzwg.cmm.word.manage" /></th>
				</tr>
		      </thead>
			  <tbody>
			  <c:forEach items="${fileList}" var="list" varStatus="status">
					<tr> 
						<td>
							<c:out value="${paginationInfo.totalRecordCount - ((fileVO.pageIndex-1) * fileVO.recordCountPerPage + status.count) + 1}" />
						</td>
						<td>
							<c:out value="${list.filectgryNm}" />	
						</td>
						<td>
							<c:out value="${list.usrfileNm}" />
						</td>
						<td>
							<c:out value="${list.orignlFileNm}" />
						</td>
						<td>
							<c:set var="defaultFileSize" value="${list.fileMg/1024}" />
							<fmt:formatNumber var="fileSize" value="${fn:escapeXml(defaultFileSize + (1 - (defaultFileSize % 1)) % 1)}" pattern="#,###" />
							<c:out value="${fileSize}" />&nbsp;KB
						</td>
						<td>
							<c:out value="${list.frstRegistPnttm}" />
						</td> 
						<td>
						<a href="javascript:void(0);" id="adres_copy_btn<c:out value="${list.usrfileSeq}" />" data-clipboard-action="copy" class="wzbtn-table btn-basic" onclick="fnCopyUrl('<c:out value="${list.usrfileSeq}" />');" ><spring:message code="wzwg.module.word.dwldadrescopy" /></a>
							<a class="wzbtn-table btn-basic" onclick="addFileEditor('<c:out value="${list.usrfileNm}" />','<c:out value="${list.usrfileSeq}" />','<c:out value="${param.id}" />','<c:out value="${list.fileExtsn}" />');" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.choise" /></a>
							<a class="wzbtn-table btn-basic" target="_blank" href="<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/fileDown.do?usrfileSeq=<c:out value="${list.usrfileSeq}" />"><spring:message code="wzwg.cmm.word.dwld" /></a>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty fileList }">
					<tr>
						<td colspan="7">
							<spring:message code="wzwg.cmm.msg.MSG097" />
						</td> 
					</tr>
					</c:if>
			  </tbody>
		</table>
		<c:if test="${!empty fileList }">
	 	<div class="ctr-box">
			<ul id="pageInfo" class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnFileStoreSearch" />
			</ul>
		</div>
	</c:if>
</form>
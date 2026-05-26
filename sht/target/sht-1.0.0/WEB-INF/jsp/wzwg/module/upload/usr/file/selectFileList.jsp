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

<input type="hidden" name="usrfileSeq" id="usrfileSeq" />
<input type="hidden" name="filectgrySeq" id="filectgrySeq" />
 <table class="basic mb10">
	<colgroup>
	<col width="15%">
	<col width="*">
	</colgroup>
	<tbody>
	<tr>
	    <th><spring:message code="wzwg.cmm.word.ctgry02" /></th>
	    <td>
	     <select name="filectgrySeqWrite" id="filectgrySeqWrite">
	     	<option value="">--<spring:message code="wzwg.cmm.word.unsel" />-- </option>
	     	<c:forEach items="${ctgryList }" var="list" varStatus="status">
	     		<option value="<c:out value="${list.filectgrySeq}" />" <c:if test="${paramVO.filectgrySeqWrite eq list.filectgrySeq}">selected="selected"</c:if>><c:out value="${list.filectgryNm}" /> </option>
	     	</c:forEach>
	     </select>
	    </td>
	</tr>
	<tr>
	    <th><spring:message code="wzwg.module.word.filesj" /></th>
	    <td>
	    <input name="usrfileNm" class="w70" id="usrfileNm" title="<spring:message code="wzwg.module.word.filesj" />" type="text" dir="required" >
	    </td>
	</tr>
	<tr>
	    <th><spring:message code="wzwg.cmm.word.file" /></th>
	    <td style="overflow: hidden;" colspan="4">
			<input id="file_text_image_4" style="width: 300px;" type="text" title="<spring:message code="wzwg.cmm.word.file" />" readonly="readonly" dir="required" >
			<a class="wzbtn-table btn-basic" onclick="$('#image_4').click();" href="javascript:void(0);"><spring:message code="wzwg.module.word.fileadd" /></a>
			<input name="image_4" title="<spring:message code="wzwg.module.word.fileatch" />" id="image_4" style="display: none;" onchange="document.getElementById('file_text_image_4').value=this.value;" type="file">
		</td>
	</tr>
	</tbody>
</table>
	<div class="rt-box"> 
		<a class="wzbtn btn-save bg" onclick="javascript:fnUpload();" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.regist" /></a>
	</div>
 <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${fileVO.pageIndex}" />"/>
 
 
 <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.module.word.filelist" /></h3>
 
 
 <div class="wzAdmMainSrchbox txt-l">
 	<label class="fs16 vert-m" for="filectgrySeqList"><spring:message code="wzwg.cmm.word.ctgry02" /> : </label>
	<select name="filectgrySeqList"  id="filectgrySeqList">
     	<option value="">--<spring:message code="wzwg.cmm.word.all" />-- </option>
     	<c:forEach items="${ctgryList }" var="list" varStatus="status">
     		<option value="<c:out value="${list.filectgrySeq}" />" <c:if test="${fileVO.filectgrySeqList eq list.filectgrySeq}">selected="selected"</c:if>><c:out value="${list.filectgryNm}" /> </option>
     	</c:forEach>
     </select>
    <label class="fs16 vert-m" for="searchCondition"><spring:message code="wzwg.cmm.word.search01" /> : </label>
	<select name="searchCondition" title="<spring:message code="wzwg.module.word.searchse" />" class="w10" id="searchCondition"> 
		<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
		<option value="T" <c:if test="${fileVO.searchCondition eq 'T'}">selected="selected"</c:if>><spring:message code="wzwg.module.word.filesj" /></option>
		<option value="F" <c:if test="${fileVO.searchCondition eq 'F'}">selected="selected"</c:if>><spring:message code="wzwg.module.word.filenm" /></option>
	</select>
	
	<c:set var="srchwrd">
		<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
	</c:set>
	<input name="searchKeyword" title="<spring:message code="wzwg.cmm.word.srchwrd" />" class="txt w30" id="searchKeyword" onkeydown="if(event.keyCode == 13){fnSearch('1');}" type="text" placeholder="<c:out value="${srchwrd}" />" value="<c:out value="${fileVO.searchKeyword}" />">
	<a class="wzbtn-table btn-srch" onclick="fnSearch('1');" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.search" /> </a>				
	</div>
<table class="basic-table">
			  <colgroup> 
				<col width="8%">
				<col width="15%">
				<col width="*">
				<col width="8%">
				<col width="9%">
				<col width="10%">
				<col width="20%">
		      </colgroup>
			  <thead>
				<tr class="bg-white">
					<th scope="col">No</th>
					<th scope="col"><spring:message code="wzwg.cmm.word.ctgry02" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.filesj" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.orginlfilenm" /></th>
					<th scope="col"><spring:message code="wzwg.module.word.filemg" /> </th>
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
							<a href="javascript:void(0);" id="adres_copy_btn<c:out value="${list.usrfileSeq}" />" data-clipboard-action="copy" class="iconOnlyBtnSameSize btn-basic" onclick="fnCopyUrl('<c:out value="${list.usrfileSeq}" />');" ><spring:message code="wzwg.module.word.dwldadrescopy" /></a>
							<a class="iconOnlyBtn btn-basic btn-delete" onclick="fnFileDelete('<c:out value="${list.usrfileSeq}" />');" href="javascript:void(0);" title="<spring:message code="wzwg.cmm.word.delete" />"><spring:message code="wzwg.cmm.word.delete" /></a>
							<a class="iconOnlyBtn btn-basic btn-download" target="_blank" href="<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/fileDown.do?usrfileSeq=<c:out value="${list.usrfileSeq}" />" title="<spring:message code="wzwg.cmm.word.dwld" />"><spring:message code="wzwg.cmm.word.dwld" /></a>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty fileList }">
					<tr>
						<td colspan="8">
							<spring:message code="wzwg.cmm.msg.MSG097" />
						</td> 
					</tr>
					</c:if>
			  </tbody>
		</table>
		<c:if test="${!empty fileList }">
		<div class="ctr-box" id="pageInfo">
			<ul class="num mobile-none">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnSearch" />
			</ul>
			
			<ul class="num pc-none">
				<ui:pagination paginationInfo="${mobilePaginationInfo}" type="image" jsFunction="fnSearch" />
			</ul>
		</div>
	</c:if>
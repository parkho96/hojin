<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style type="text/css">
.attatch_file_box { position:relative; padding:0 !important; height:45px; }
.attatch_file_box .file_route { width:400px; }
.attatch_file_box span.button { display:inline-block; width:100px; height:29px; padding:5px 15px; background:#E1E1E1; color:#242424; text-align:center; line-height:19px; border:0; box-sizing:border-box; vertical-align:middle; }
.attatch_file_box .attatchfile { position:absolute; top:0; left:0; width:500px; font-size:45px; opacity:0; filter:alpha(opacity=0); cursor:pointer; }
</style>

	<input type="hidden" name="fileListCnt" id="fileListCnt" value="<c:out value="${fileListCnt}" />">
	<input type="hidden" name="posblAtchFileNumber" value="<c:out value="${atchFileNumber}" />" />
	
	<fmt:formatNumber var="fileCnt" value="${fn:escapeXml(3 - fileListCnt)}" type="number" />
	
	<!-- 첨부파일이 있는 경우 Start -->
	<c:if test="${fn:length(fileList) ne 0}">
		<c:forEach var="fileList" items="${fileList}" varStatus="status">
			<div>
				<span><spring:message code='wzwg.cmm.word.atch' /> <c:out value="${status.count}" /></span>
				
				<c:set var="rawSize" value="${fileList.fileMg / 1024}" />
				<fmt:formatNumber var="fileSize" value="${fn:escapeXml(rawSize + (1 - (rawSize % 1)) % 1)}" pattern="#,###" />
				<span><c:out value="${fileSize}" /> KB</span>
				
				<c:choose>
				
					<c:when test="${updateFlag eq 'Y'}">
						<a href="javascript:void(0);" class="mg_r5" onclick="fnFileDelete('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />');">
							<img src="/images/wzwg/cmm/btn-del.gif" />
						</a>
						<c:out value="${fileList.orignlFileNm}"/>&nbsp;[<c:out value="${fileSize}" />&nbsp;KB]
					</c:when> 
				
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fnFileDown('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />');">
							<c:out value="${fileList.orignlFileNm}"/>&nbsp;[<c:out value="${fileSize}" />&nbsp;KB]
						</a>
					</c:otherwise>
					
				</c:choose>
			</div>
		</c:forEach>
	</c:if>
	<!-- 첨부파일이 있는 경우 End -->
	
	<!-- 등록화면 첨부파일이 없는 경우 Start -->
	<c:if test="${updateFlag eq 'N' and fileListCnt eq 0}">
		<c:forEach var="fileNum" begin="${fileListCnt + 1}" end="3" step="1" varStatus="status">
			<div>
				<div class="attatch_file_box">
					<span><spring:message code='wzwg.cmm.word.atch' /> <c:out value="${fileNum}" /></span>
					<input type="text" id="file_text_<c:out value="${fileNum}" />" class="file_route" readonly="readonly" />
					<span  class="wzbtn-table btn-basic"><spring:message code='wzwg.sysMngr.word.fileAdd' /></span>
					<input type="file" id="file_<c:out value="${fileNum}" />" name="file_<c:out value="${fileNum}" />" title="<spring:message code='wzwg.sysMngr.word.fileAtch' />" class="attatchfile" onchange="document.getElementById('file_text_<c:out value="${fileNum}" />').value=this.value;" />
				</div>
			</div>
		</c:forEach>
	</c:if>
	<!-- 등록화면 첨부파일이 없는 경우 End -->
	
	<!-- 수정화면 첨부파일이 없는 경우 Start -->
	<c:if test="${updateFlag eq 'Y' and fileCnt > 0}">
		<c:forEach var="fileNum" begin="${fileListCnt + 1}" end="3" step="1" varStatus="status">
			<div>
				<div class="attatch_file_box">
					<span><spring:message code='wzwg.cmm.word.atch' /><c:out value="${fileNum}" />	</span>
					<input type="text" id="file_text_<c:out value="${fileNum}" />" class="file_route" readonly="readonly" />
					<span  class="wzbtn-table btn-basic"><spring:message code='wzwg.sysMngr.word.fileAdd' /></span>
					<input type="file" id="file_<c:out value="${fileNum}" />" name="file_<c:out value="${fileNum}" />" title="<spring:message code='wzwg.sysMngr.word.fileAtch' />" class="attatchfile" onchange="document.getElementById('file_text_<c:out value="${fileNum}" />').value=this.value;" />
				</div>
			</div>
		</c:forEach>
	</c:if>
	<!-- 수정화면 첨부파일이 없는 경우 End -->
	

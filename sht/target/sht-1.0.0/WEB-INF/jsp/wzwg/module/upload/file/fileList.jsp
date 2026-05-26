<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<style type="text/css">
	.attatch_file_box { position:relative; padding:0 !important; overflow: hidden;}
	.attatch_file_box .attatchfile { position:absolute; top:0; left:0; width:85%; font-size:45px; opacity:0; filter:alpha(opacity=0); cursor:pointer; vertical-align:middle;}
</style>

<script>

	var fileNum = 1;
	
	// 첨부파일 추가
	function fnFileAdd() {
	
		if(fileNum + parseInt('<c:out value="${fileListCnt}" />') > '<c:out value="${posblAtchFileNumber}" />'){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020"><spring:argument><spring:message code="wzwg.module.word.atchpossiblefilecount" /></spring:argument><spring:argument><c:out value="${posblAtchFileNumber}" /><spring:message code="wzwg.cmm.word.count02" /></spring:argument></spring:message>');
			return;
		}
		
		var fileHtml = "<div id=\"file_area_"+fileNum+"\">";
		fileHtml 	+= "<li class=\"attatch_file_box\"><input class=\"uploadTit w70\" type=\"text\" id=\"file_text_"+fileNum+"\" readonly=\"readonly\" title=\"<spring:message code="wzwg.cmm.word.file" /> <spring:message code="wzwg.cmm.word.atch" />\" onclick=\"$('#file_"+fileNum+"').click();\"/>";
		fileHtml 	+= "<input type=\"file\" id=\"file_"+fileNum+"\" name=\"file_"+fileNum+"\" title=\"<spring:message code="wzwg.cmm.word.atch" />\" style=\"display:none;\" class=\"attatchfile\" onchange=\"fnFileRename('"+fileNum+"', this.value);fnFileInfoCheck('"+fileNum+"');\" />";
		fileHtml 	+= " <a href=\"javascript:void(0);\" class=\"wzbtn-table btn-basic\" onclick=\"$('#file_"+fileNum+"').click();\"><spring:message code="wzwg.cmm.word.atch" /></a>";
		fileHtml	+= " <a href=\"javascript:void(0);\" class=\"wzbtn-table btn-del\" onclick=\"fnFileDel('"+fileNum+"');$('#btnFileAdd').focus();\"><spring:message code="wzwg.cmm.word.delete" /></a>";
		fileHtml 	+= "</li>";
		fileHtml	+= "</div>";
		
		fileNum++; 
		
		$('#atch_file_div').append(fileHtml);
	}
	
	function fnFileRename(idx, val){
		document.getElementById('file_text_'+idx).value = val.replace("C:\\fakepath\\", "");
	}
	
	function fnFileDel(idx){
		fileNum--;
		$('#file_area_'+idx).remove();
	}

</script>


	<input type="hidden" name="fileListCnt" id="fileListCnt" value="<c:out value="${fileListCnt}" />">
	
	<ul class="fileplus" style="padding-left:0px;">
	
	<!-- 첨부파일이 있는 경우 Start -->
	<c:if test="${fn:length(fileList) ne 0}">
		
		<c:forEach var="fileList" items="${fileList}" varStatus="status">
			<li class="attatch_file_box" style="background:none;">
				<c:if test="${posblAtchFileNumber ne 1}">
				<img src="/images/wzwg/cmm/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
				</c:if>
				
				<c:set var="defaultFileSize" value="${fileList.fileMg/1024}" />
				<fmt:formatNumber var="fileSize" value="${fn:escapeXml(defaultFileSize + (1 - (defaultFileSize % 1)) % 1)}" pattern="#,###" />
				
				<c:choose>			
					<c:when test="${updateFlag eq 'Y'}">
						<a href="javascript:void(0);" onclick="fnFileDelete('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />');" title="<spring:message code="wzwg.module.word.atchfiledelete" />">
							<img src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />"/>
						</a>
						<span><c:out value="${fileList.orignlFileNm}"/>&nbsp;[<c:out value="${fileSize}" />&nbsp;KB]</span>
					</c:when> 			
					<c:otherwise>
						<a href="javascript:void(0);" onclick="fnFileDown('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />');" title="<spring:message code="wzwg.module.word.atchfiledwld" />">
							<c:out value="${fileList.orignlFileNm}"/>&nbsp;[<c:out value="${fileSize}" />&nbsp;KB]
						</a>
					</c:otherwise>			
				</c:choose>
                <c:if test="${status.first && !empty fileVO.helpAt && fileVO.helpAt eq 'Y'}">
                <span>
					<div class="menu_help">
						<img src="/images/wzwg/site/mngr/ico_help_grey.png" alt="<spring:message code="wzwg.cmm.msg.MSG218" />">
						<div class="help_pop"><spring:message code="wzwg.cmm.msg.MSG092" /></div>
					</div>
				</span>
                </c:if>
			</li>
		</c:forEach>
	</c:if>
	<!-- 첨부파일이 있는 경우 End -->
	 
	 <c:if test="${updateFlag eq 'N'}">
	 	<c:choose>	
			<c:when test="${fileProvdExcess eq 'Y' and fn:length(fileList) eq 0}">
				<!-- 용량 초과 -->
				<li class="bullet_none"><span class="circle_no bg-red-strong vert-m mr5" style="line-height:normal; font-size:13px; float:none;">!</span><spring:message code="wzwg.cmm.msg.wa.MSG002" /></li>
			</c:when>
			<c:otherwise>
				<!-- 등록화면 첨부파일이 없는 경우 Start -->
				<c:if test="${fileListCnt eq 0}">
					<button title="<spring:message code="wzwg.module.word.fileadd" />" type="button" id="btnFileAdd" class="wzbtn btn-grey mt5 mb5 black" onclick="fnFileAdd(); return false;"><spring:message code="wzwg.module.word.fileadd" /></button>
					<span class="mt5 mb5 ml10"><strong><span class="circle_no bg-red-strong" style="margin-top:-3px;">i</span> [<spring:message code="wzwg.cmm.word.lmtt"/>] <c:if test="${resultVO.fileProvdAt eq 'Y'}"><spring:message code="wzwg.module.word.siteprovdcpcty"/> : <c:out value="${resultVO.fileProvdMg}" /><c:out value="${resultVO.fileCpctySe}" />,</c:if> <spring:message code="wzwg.module.word.filecount"/> : <c:out value="${posblAtchFileNumber}" /> <spring:message code="wzwg.cmm.word.count02" /></strong></span>
					<div id="atch_file_div"></div>
				</c:if>
				<!-- 등록화면 첨부파일이 없는 경우 End -->
			</c:otherwise>
		</c:choose>
	</c:if>
	
	<!-- 수정화면 첨부파일이 없는 경우 Start -->
	<c:if test="${updateFlag eq 'Y'}">
		<c:choose>	
			<c:when test="${fileProvdExcess eq 'Y' and fn:length(fileList) eq 0}">
				<!-- 용량 초과 -->
				<li class="bullet_none"><span class="circle_no bg-red-strong vert-m mr5" style="line-height:normal; font-size:13px; float:none;">!</span><spring:message code="wzwg.cmm.msg.wa.MSG002" /></li>
			</c:when>
			<c:otherwise>
				<button title="<spring:message code="wzwg.module.word.fileadd" />" type="button" id="btnFileAdd" class="wzbtn btn-grey mt5 mb5 black" onclick="fnFileAdd(); return false;"><spring:message code="wzwg.module.word.fileadd" /></button>
				<span class="mt5 mb5 ml10"><strong><span class="circle_no bg-red-strong" style="margin-top:-3px;">i</span> [<spring:message code="wzwg.cmm.word.lmtt"/>] <c:if test="${resultVO.fileProvdAt eq 'Y'}"><spring:message code="wzwg.module.word.siteprovdcpcty"/> : <c:out value="${resultVO.fileProvdMg}" /><c:out value="${resultVO.fileCpctySe}" />,</c:if> <spring:message code="wzwg.module.word.filecount"/> : <c:out value="${posblAtchFileNumber}" /> <spring:message code="wzwg.cmm.word.count02" /></strong></span>
				<div id="atch_file_div"></div>
			</c:otherwise>
		</c:choose>
	</c:if>
	<!-- 수정화면 첨부파일이 없는 경우 End -->
	
	</ul>
	

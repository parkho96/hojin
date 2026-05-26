<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="imgReplcText">
	<spring:message code="wzwg.cmm.cmmMsg.CMG011">
		<spring:argument><spring:message code="wzwg.cmm.word.image" /> <spring:message code="wzwg.cmm.word.replc" /> <spring:message code="wzwg.cmm.word.txt" /></spring:argument>
		<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
	</spring:message>
</c:set>
<script>
	$(document).ready(function(){
		fnAltTxtTip();
	});
	
	var imageFileNum = parseInt('<c:out value="${fileListCnt}" />') +1;
	
	// 첨부파일 추가
	function fnImageFileAdd() {
	
		if(imageFileNum  > '<c:out value="${posblAtchFileNumber}" />'){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020"><spring:argument><spring:message code="wzwg.module.word.atchpossiblefilecount" /></spring:argument><spring:argument><c:out value="${posblAtchFileNumber}" /><spring:message code="wzwg.cmm.word.count02" /></spring:argument></spring:message>');
			return;
		}

		var fileHtml = '';
			fileHtml += '<div class="inp_box" id="image_file_area_'+imageFileNum+'">                                                                                                                                                                              ';
			fileHtml += '	<div class="wzfile_input">                                                                                                                                                                      ';
			fileHtml += '		<button class="img_box" type="button" onclick="$(\'#image_file_'+imageFileNum+'\').click();">                                                                                                                                                                      ';
			fileHtml += '			<img id="imgView_'+imageFileNum+'" src="/images/wzwg/site/mngr/no-img.png" alt="no image">                                                                                                                      ';
			fileHtml += '		</button>                                                                                                                                                                                   ';
			fileHtml += '		<input type="file" id="image_file_'+imageFileNum+'" name="image_file_'+imageFileNum+'" title="<spring:message code="wzwg.module.word.thumbimage" />" style="display:none;" onchange="wzImgPreview(\'image_file_'+imageFileNum+'\', \'imgView_'+imageFileNum+'\');fnImageFileInfoCheck(\''+imageFileNum+'\');">     ';
			fileHtml += '	</div>                                                                                                                                                                                          ';
			fileHtml += '	<div class="attatch_file_box">                                                                                                                                                                  ';
		    fileHtml += '                                                                                                                                                                                                   ';
			fileHtml += '		<a href="javascript:void(0);" class="wzbtn-table btn-basic addFile" onclick="$(\'#image_file_'+imageFileNum+'\').click();"><spring:message code="wzwg.cmm.word.atch" /></a>                                                                                        ';
			fileHtml += '		<a href="javascript:void(0);" class="wzbtn-table btn-del delFile" onclick="fnImageFileDel(\''+imageFileNum+'\');$(\'#btnFileAdd\').focus();"><spring:message code="wzwg.cmm.word.delete" /></a>                                                                       ';
			fileHtml += '		<input type="text" id="image_file_desc_'+imageFileNum+'" name="fileDescArr" placeholder="<c:out value="${imgReplcText}" />" title="<spring:message code="wzwg.cmm.msg.MSG191"/>">                                                   ';
			fileHtml += '	</div>                                                                                                                                                                                          ';
			fileHtml += '</div>                                                                                                                                                                                             ';
		imageFileNum++;
		
		$('#atch_image_file_div').append(fileHtml);
		fnAltTxtTip();
	}
	
	function fnImageFileRename(idx, val){
		document.getElementById('image_file_text_'+idx).value = val.replace("C:\\fakepath\\", "");
	}
	
	function fnImageFileDel(idx){
		//imageFileNum--;
		$('#image_file_area_'+idx).remove();
		
		$('.inp_box').each(function(idx, el){
			$(this).attr('id', 'image_file_area_' + (idx+1));
			$(this).find('button').attr('onclick', '$(\'#image_file_'+(idx+1)+'\').click();');
			$(this).find('img').attr('id', 'imgView_'+(idx+1) );
			$(this).find('input[type="file"]').attr('id', 'image_file_'+(idx+1) );
			$(this).find('input[type="file"]').attr('name', 'image_file_'+(idx+1) );
			$(this).find('input[type="file"]').attr('onchange', 'wzImgPreview(\'image_file_'+(idx+1)+'\', \'imgView_'+(idx+1)+'\');fnImageFileInfoCheck(\''+(idx+1)+'\');' );
			$(this).find('.addFile').attr('onclick', '$(\'#image_file_'+(idx+1)+'\').click();');
			$(this).find('.delFile').attr('onclick', 'fnImageFileDel(\''+(idx+1)+'\');$(\'#btnFileAdd\').focus();');
			$(this).find('input[name="fileDescArr"]').attr('id', 'image_file_desc_'+(idx+1));
			
		});
		
		imageFileNum = $('.inp_box').length+1;
		fnAltTxtTip();
	}

	function fnAltTxtTip(){
		if($('#atch_image_file_div .inp_box').length > 0) {
			$('#altTxtTipDiv').css('display', 'block');
		}else {
			$('#altTxtTipDiv').css('display', 'none');
		}
	}
	
</script>


	<input type="hidden" name="imageFileListCnt" id="imageFileListCnt" value="<c:out value="${fileListCnt}" />">
	
	<div class="fileplus" style="padding-left:0px;">
	
	
	
	
	 <c:if test="${updateFlag eq 'N'}">
	 	<c:choose>	
			<c:when test="${fileProvdExcess eq 'Y' and fn:length(fileList) eq 0}">
				<!-- 용량 초과 -->
				<div><font color="red"><spring:message code="wzwg.cmm.msg.wa.MSG002" /></font></div>
			</c:when>
			<c:otherwise>
				<!-- 등록화면 첨부파일이 없는 경우 Start -->
				<c:if test="${fileListCnt eq 0}">
					<button title="<spring:message code="wzwg.module.word.fileadd" />" type="button" id="btnFileAdd" class="wzbtn btn-grey mt5 mb5 black" onclick="fnImageFileAdd(); return false;"><spring:message code="wzwg.module.word.fileadd" /></button>
					<span class="mt5 mb5 ml10"><strong><span class="circle_no bg-red-strong" style="margin-top:-3px;">i</span> [<spring:message code="wzwg.cmm.word.lmtt"/>] <c:if test="${resultVO.fileProvdAt eq 'Y'}"><spring:message code="wzwg.module.word.siteprovdcpcty"/> : <c:out value="${resultVO.fileProvdMg}" /><c:out value="${resultVO.fileCpctySe}" />,</c:if> <spring:message code="wzwg.module.word.filecount"/> : <c:out value="${posblAtchFileNumber}" /> <spring:message code="wzwg.cmm.word.count02" /></strong></span>
				</c:if>
				<!-- 등록화면 첨부파일이 없는 경우 End -->
				<!-- <div id="atch_image_file_div"></div> -->
			</c:otherwise>
		</c:choose>
	</c:if>
	
	<!-- 수정화면 첨부파일이 없는 경우 Start -->
	<c:if test="${updateFlag eq 'Y'}">
		<c:choose>	
			<c:when test="${fileProvdExcess eq 'Y' and fn:length(fileList) eq 0}">
				<!-- 용량 초과 -->
				<div><font color="red"><spring:message code="wzwg.cmm.msg.wa.MSG002" /></font></div>
			</c:when>
			<c:otherwise>
				<button title="<spring:message code="wzwg.module.word.fileadd" />" type="button" id="btnFileAdd" class="wzbtn btn-grey mt5 mb5 black" onclick="fnImageFileAdd(); return false;"><spring:message code="wzwg.module.word.fileadd" /></button>
				<span class="mt5 mb5 ml10"><strong><span class="circle_no bg-red-strong" style="margin-top:-3px;">i</span> [<spring:message code="wzwg.cmm.word.lmtt"/>] <c:if test="${resultVO.fileProvdAt eq 'Y'}"><spring:message code="wzwg.module.word.siteprovdcpcty"/> : <c:out value="${resultVO.fileProvdMg}" /><c:out value="${resultVO.fileCpctySe}" />,</c:if> <spring:message code="wzwg.module.word.filecount"/> : <c:out value="${posblAtchFileNumber}" /> <spring:message code="wzwg.cmm.word.count02" /></strong></span>
				<!-- <div id="atch_image_file_div"></div> -->
			</c:otherwise>
		</c:choose>
	</c:if>
	<!-- 수정화면 첨부파일이 없는 경우 End -->
	
	</div>
	
	<div id="atch_image_file_div">
	<!-- 첨부파일이 있는 경우 Start -->
	<c:set var="ran"><%= java.lang.Math.round(java.lang.Math.random() * 1234567) %></c:set>
	<c:if test="${fn:length(fileList) ne 0}">
		
		<c:forEach var="fileList" items="${fileList}" varStatus="status">
			<c:set var="defaultFileSize" value="${fileList.fileMg/1024}" />			
			<fmt:formatNumber var="fileSize" value="${fn:escapeXml(defaultFileSize + (1 - (defaultFileSize % 1)) % 1)}" pattern="#,###" />
			
			<div class="inp_box" id="image_file_area_<c:out value="${status.count }" />">
				<div class="wzfile_input">
					<span class="img_box">
						<img id="imgView_<c:out value="${status.count }" />" src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${fileList.atchFileId}" />&fileSn=<c:out value="${fileList.fileSn}" />&ran=<c:out value="${ran}" />" alt="<c:out value="${fileList.fileDc}" />">
					</span>
					
				</div>
				<div class="attatch_file_box">
					
					<a href="javascript:void(0);" class="wzbtn-table btn-del" onclick="fnImageFileDelete('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />');"><spring:message code="wzwg.cmm.word.delete" /></a>
					<span class="grey">[<c:out value="${fileSize}" />&nbsp;KB]</span>
					<div class="inp-group">
						<input type="text" value="<c:out value="${fileList.fileDc }" />" id="fileDcTxt_<c:out value="${status.count}" />" placeholder="<c:out value="${imgReplcText}" />" title="<spring:message code="wzwg.cmm.msg.MSG191"/>">
						<button type="button" onclick="fnImageFileDcUpdt('<c:out value="${fileList.atchFileId}" />','<c:out value="${fileList.fileSn}" />', 'fileDcTxt_<c:out value="${status.count}" />');" class="wzbtn-table btn-save"><spring:message code="wzwg.cmm.word.tochange" /></button>
					</div>
				</div>
			</div>
			
		</c:forEach>
	</c:if>
	<!-- 첨부파일이 있는 경우 End -->
	</div>
	<span id="altTxtTipDiv" class="wd100 clboth block pt10 linehgt150" style="display: none;">
		<strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong><br>
		<spring:message code="wzwg.cmm.msg.tip.MSG004" />
		<span class="wz_tableguide mt5"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>
	</span>

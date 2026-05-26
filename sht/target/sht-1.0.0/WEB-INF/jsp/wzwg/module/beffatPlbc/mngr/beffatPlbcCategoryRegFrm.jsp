<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!-- 카테고리 등록/수정폼 -->

<form id="categoryRegForm" name="categoryRegForm" method="post" enctype="multipart/form-data">
<input type="hidden" name="ctgryCd" value="<c:out value='${paramVO.ctgryCd }'/>">
<table class="basic">
	<colgroup>
		<col width="30%"/>
		<col width="*"/>
	</colgroup>
	<tbody>
		<tr>
			<th><spring:message code="wzwg.module.word.clnm" /></th>
			<td><input type="text" name="ctgryDcCn" id="ctgryDcCn" value="<c:out value='${categoryVO.ctgryDcCn }'/>"/></td>
		</tr>
		<tr>
			<th><spring:message code="wzwg.cmm.word.icon" /></th>
			<td>
				<button type="button" onclick="$('#thumbFile').click();" >
					<c:choose>
						<c:when test="${not empty categoryVO.storFileId }">
						<img id="thumbFile_preview" style="width: 100px; height: 100px; border: solid 1px #ddd;" src="<c:out value='${wzwg_contextPath}'/>/module/upload/file/selectImageView.do?atchFileId=<c:out value='${categoryVO.storFileId }'/>&fileSn=0">
						</c:when>
						<c:otherwise>
						<img id="thumbFile_preview" style="width: 100px; height: 100px; border: solid 1px #ddd;" src="/images/wzwg/site/mngr/no-img.png">
						</c:otherwise>
					</c:choose>
					
				</button>
				<input type="file" name="thumbFile" id="thumbFile" title="<spring:message code="wzwg.module.word.thumbimage" />" style="display:none;" onchange="fnThumbCheck();wzImgPreview('thumbFile', 'thumbFile_preview');"/>
				<button class="wzbtn-table btn-basic" id="btn_thumbFile" type="button" style="vertical-align: bottom;" onclick="$('#thumbFile').click();"><spring:message code="wzwg.module.word.fileupdt" /></button>
			</td>
		</tr>
	</tbody>
</table>
</form>

<div class="rt-box">
	<c:choose>
		<c:when test="${not empty categoryVO.ctgryCd }">
		<button type="button" class="wzbtn btn-save" onclick="fnCategoryRegist('M')"><spring:message code="wzwg.cmm.word.stre" /></button>
		</c:when>
		<c:otherwise>
		<button type="button" class="wzbtn btn-save" onclick="fnCategoryRegist('R')"><spring:message code="wzwg.cmm.word.stre" /></button>
		</c:otherwise>
	</c:choose>
</div>
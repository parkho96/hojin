<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
		$(document).ready(function(){
			<c:if test="${!empty resultVO}">
				if($(':radio[name="imgLinkuseAt"]:checked').val() != 'N'){
					$("input[name=linkUrl]").removeAttr("disabled");
					$("input[name=linkUrl]").val('<c:out value="${resultVO.linkUrl}" />');
					
					$("select[name=linkTargetSe]").removeAttr("disabled");
					$("select[name=linkTargetSe]").val("<c:out value="${resultVO.linkTargetSe}" />").attr("selected", "selected");
				}else{ }
			</c:if>
		});
	</script>
	
	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tbody>
			<tr><th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.module.word.lypopupZoneestbs" /></th></tr><tr> <!-- 2019.04.18 신규 추가 tr-->
			<tr>
				<th><spring:message code="wzwg.module.word.imageupload" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td>
					<c:set var="msg_txt01">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.module.word.imagereplctxt" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
						</spring:message>
					</c:set>
					
					<c:choose>
						<c:when test="${not empty resultVO.atchFileId }">
							<c:set var="atchFileSrc"><c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${resultVO.atchFileId }"/>&fileSn=0</c:set>
						</c:when>
						<c:otherwise>
							<c:set var="atchFileSrc">/images/wzwg/site/mngr/no-img.png</c:set>
						</c:otherwise>
					</c:choose>
					
					<div class="wzfile_input">
						<img id="atchFile_preview" class="i-block box-border vert-t mb5" style="width: 106px; border: solid 1px #ddd;" src="<c:out value="${atchFileSrc }" />">
						<input type="file" name="atchFile" id="atchFile" <c:if test="${empty resultVO.atchFileId }">dir="required"</c:if> title="<spring:message code="wzwg.module.word.thumbimage" />" style="display:none;" onchange="fnAtchFileCheck();wzImgPreview('atchFile', 'atchFile_preview');"/>
						<div class="i-block" style="width: auto;">
							<button class="wzbtn btn-grey mb5 black" id="btn_atchFile" type="button" style="height: 40px;" onclick="$('#atchFile').click();"><spring:message code="wzwg.module.word.fileupdt" /></button>
							<input type="text" name="imgReplcText" class="i-block vert-b wd100" placeholder="<c:out value="${msg_txt01}" />" value="<c:out value="${resultVO.imgReplcText }" />" dir="required,vmaxlen=50" title="<spring:message code="wzwg.module.word.imagereplctxt" />"/>
						</div>
					</div>
					<span class="wz_tableguide mg5"><spring:message code="wzwg.cmm.msg.MSG114" /></span>
					<div>
						
						<!-- <p class="admpg-subp w100 fl mt10">
						    <span class="circle_no bg-green-strong">i</span><strong class="grey"><spring:message code="wzwg.cmm.msg.tip.MSG003" /> ?</strong>
						      <spring:message code="wzwg.cmm.msg.tip.MSG004" />
						    <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.tip.MSG005" /></span>			
						</p> -->
					</div>
					
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.imagelink" /></th>
				<td>
					<ul class="w100 fl mb10 wzForm">
						<li class="wd100"><label><input type="radio" name="imgLinkuseAt" value="N" onchange="fn_imgLinkUseAtChange(this.value);" dir="required" title="<spring:message code="wzwg.module.word.useat" />" checked="checked"><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
						<li class="wd100"><label><input type="radio" name="imgLinkuseAt" value="Y" onchange="fn_imgLinkUseAtChange(this.value);" dir="required" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.imgLinkuseAt eq 'Y' }">checked="checked"</c:if>>
							<span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label>
							<div class="i-block ml30 wm100">http://<input type="text" name="linkUrl" class="w40" disabled="disabled" />
								<select name="linkTargetSe" disabled="disabled">
									<option value="Y"><spring:message code="wzwg.cmm.word.newwin" /></option>
									<option value="N"><spring:message code="wzwg.cmm.word.nowwin" /></option>
								</select>
							</div>
						</li>
					</ul> 
				</td>
			</tr>
		</tbody>
	</table>
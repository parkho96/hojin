<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	/** 컨텐츠 CSS 등록 */
	function fn_CntntsStyleRegist(){

		if(!Validator.validate(document.cntntsStyleForm)){
			return;
		}
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/registCntntsStyleAjax.do'
			, data:$("#cntntsStyleForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						fn_CntntsStyleList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
		
	}

	/** 컨텐츠 CSS 목록으로 이동 */
	function fn_CntntsStyleList(){
		var frm = document.cntntsStyleForm;
		frm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do';
		frm.submit();
	}
	
	$(document).ready(function(){
		$('input[name=cssNm]').focus();
	});
</script>

	<form id="cntntsStyleForm" name="cntntsStyleForm" method="post">
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.module" /></th>
					<td>
						<select name="sysmoduleSeq" id="sysmoduleSeq" dir="required" title="<spring:message code="wzwg.cmm.word.module" />">
							<c:forEach items="${moduleList }" var="moduleList">
								<option value="<c:out value="${moduleList.sysmoduleSeq }" />">
								  <c:if test="${sessionScope.LANG eq 'SC00000016' }">
									<c:out value="${moduleList.moduleNm }"/>
								  </c:if>
								  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
									<c:out value="${moduleList.moduleNmEng }"/>
								  </c:if>
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.skinNm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.nm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssNm" class="w70" dir="required" title="CSS <spring:message code="wzwg.cmm.word.nm01" />" placeholder="CSS<c:out value="${msg_txt01}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.cssFileNm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.cssFileNm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssFileNm" class="w70" dir="required" title="<spring:message code="wzwg.sysMngr.word.cssFileNm01" />" placeholder="<c:out value="${msg_txt02}" />"/>
					</td>
				</tr>
				<tr>
					<th>CSS <spring:message code="wzwg.cmm.word.cours" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt03">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.cours" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssPath" class="w70" dir="required" title="CSS <spring:message code="wzwg.cmm.word.cours" />" placeholder="CSS<c:out value="${msg_txt03}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.previewCours" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt04">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.previewCours" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="prevewPath" class="w70" dir="required" title="<spring:message code="wzwg.sysMngr.word.previewCours" />" placeholder="<c:out value="${msg_txt04}" />"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_CntntsStyleRegist();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsStyleList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

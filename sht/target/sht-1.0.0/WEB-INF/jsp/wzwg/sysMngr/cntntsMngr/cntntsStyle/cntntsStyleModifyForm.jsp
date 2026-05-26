<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	/** 컨텐츠 템플릿 수정 */
	function fn_CntntsStyleModify(){

		if(!Validator.validate(document.cntntsStyleForm)){
			return;
		}

		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/modifyCntntsStyleAjax.do'
			, data:$("#cntntsStyleForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
						fn_CntntsStyleDetail();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}

	/** 컨텐츠 템플릿 상세조회 */
	function fn_CntntsStyleDetail(){
		document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleDetail.do';
		document.cntntsStyleForm.submit();
	}
	$(document).ready(function(){
		$('input[name=cssNm]').focus();
	});
</script>
	<form id="cntntsStyleForm" name="cntntsStyleForm" method="post">
		<input type="hidden" name="cssSeq" value="<c:out value="${cntntsStyleVO.cssSeq }" />"/>
		<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${param.searchCondition}" />" />
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${param.searchKeyword}" />" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${param.pageIndex}" />" />
		
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
								<option value="<c:out value="${moduleList.sysmoduleSeq }"/>" <c:if test="${moduleList.sysmoduleSeq eq cntntsStyleVO.sysmoduleSeq }">selected="selected"</c:if>>
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
					<th><spring:message code="wzwg.sysMngr.word.skinNm01" /></th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.nm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssNm" class="w70" dir="required" value="<c:out value="${cntntsStyleVO.cssNm }" />" title="<spring:message code="wzwg.sysMngr.word.skinNm01" />" placeholder="skin <c:out value="${msg_txt01}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.cssFileNm01" /></th>
					<td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.cssFileNm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssFileNm" class="w70" dir="required" value="<c:out value="${cntntsStyleVO.cssFileNm }" />" title="<spring:message code="wzwg.sysMngr.word.cssFileNm01" />>" placeholder="<c:out value="${msg_txt02}" />"/>
					</td>
				</tr>
				<tr>
					<th>CSS <spring:message code="wzwg.cmm.word.cours" /></th>
					<td>
						<c:set var="msg_txt03">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.cours" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="cssPath" class="w70" dir="required" value="<c:out value="${cntntsStyleVO.cssPath }" />" title="CSS <spring:message code="wzwg.cmm.word.cours" />" placeholder="CSS<c:out value="${msg_txt03}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.previewCours" /></th>
					<td>
						<c:set var="msg_txt04">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.cmm.word.preview" /> <spring:message code="wzwg.cmm.word.cours" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="prevewPath" class="w70" dir="required" value="<c:out value="${cntntsStyleVO.prevewPath }" />" title="<spring:message code="wzwg.cmm.word.preview" /> <spring:message code="wzwg.cmm.word.cours" />" placeholder="<c:out value="${msg_txt04}" />"/>
					</td>
				</tr>			
			</tbody>
		</table>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_CntntsStyleModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsStyleDetail();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

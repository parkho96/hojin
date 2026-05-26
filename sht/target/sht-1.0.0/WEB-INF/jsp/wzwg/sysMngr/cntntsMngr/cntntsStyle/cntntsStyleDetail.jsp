<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	/** 컨텐츠 템플릿 수정 폼 */
	function fn_CntntsStyle(){
		document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/modifyCntntsStyleForm.do';
		document.cntntsStyleForm.submit();
	}

	/** 컨텐츠 템플릿 삭제 */
	function fn_CntntsStyleDelete(){
 		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/deleteCntntsStyleAjax.do'
				, data:$("#cntntsStyleForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_CntntsStyleList();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
						}
					})
				}
				, error:function (request, status, error) {
		              alert('<spring:message code="fail.common.msg" text="error" />');
		          }
			});
		}else{
			return false;
		} 
	}
	
	/** 컨텐츠 템플릿 리스트 */
	function fn_CntntsStyleList(){
		document.cntntsStyleForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do';
		document.cntntsStyleForm.submit();
	}
	
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
						<c:if test="${sessionScope.LANG eq 'SC00000016' }">
							<c:out value="${cntntsStyleVO.moduleNm} "/>
						  </c:if>
						  <c:if test="${sessionScope.LANG ne 'SC00000016' }">
							<c:out value="${cntntsStyleVO.moduleNmEng} "/>
						  </c:if>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.skinNm01" /></th>
					<td>
						<c:out value="${cntntsStyleVO.cssNm} "/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.cssFileNm01" /></th>
					<td>
						<c:out value="${cntntsStyleVO.cssFileNm} "/>
					</td>
				</tr>
				<tr>
					<th>CSS <spring:message code="wzwg.cmm.word.cours" /></th>
					<td>
						<c:out value="${cntntsStyleVO.cssPath} "/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.previewCours" /></th>
					<td>
						<c:out value="${cntntsStyleVO.prevewPath} "/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl"onclick="fn_CntntsStyleDelete();"><spring:message code="wzwg.cmm.word.delete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsStyle();"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsStyleList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

	

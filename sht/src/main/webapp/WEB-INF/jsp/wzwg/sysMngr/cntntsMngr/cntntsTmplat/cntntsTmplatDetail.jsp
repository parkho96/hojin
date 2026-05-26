<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
	
<script type="text/javascript">
	
	/** 컨텐츠 템플릿 수정 폼 */
	function fn_CntntsTmplat(){
		document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/modifyCntntsTmplatForm.do';
		document.cntntsTmplatForm.submit();
	}

	/** 컨텐츠 템플릿 삭제 */
	function fn_CntntsTmplatDelete(){
 		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/deleteCntntsTmplatAjax.do'
				, data:$("#cntntsTmplatForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_CntntsTmplatList();
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
	function fn_CntntsTmplatList(){
		document.cntntsTmplatForm.action='<c:out value="${wzwg_contextPath}${prefix}" />/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do';
		document.cntntsTmplatForm.submit();
	}
	
</script>

	<form id="cntntsTmplatForm" name="cntntsTmplatForm" method="post">
		<input type="hidden" name="tmplatSeq" value="<c:out value="${cntntsTmplatVO.tmplatSeq }" />"/>
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
					<th><spring:message code="wzwg.cmm.word.ctgry02" /></th>
					<td>
						<c:out value="${cntntsTmplatVO.tmplatClSeqNm }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.thumb" /></th>
					<td>
						<img src="<c:url value='/module/upload/file/selectImageView.do'/>?atchFileId=<c:out value="${cntntsTmplatVO.atchFileId }"/>&fileSn=0" style="/* width: 150px; */ height: 200px;"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.tmplatSj" /></th>
					<td>
						<c:out value="${cntntsTmplatVO.tmplatSj }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.tmplatCn" /></th>
					<td style="line-height: 1.5">
						<c:out value="${cntntsTmplatVO.tmplatCn }" escapeXml="false"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl"onclick="fn_CntntsTmplatDelete();"><spring:message code="wzwg.cmm.word.delete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsTmplat();"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_CntntsTmplatList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

	

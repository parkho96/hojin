<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
	
<script type="text/javascript">
	function fn_ModuleBbsFormList(){
		document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/selectModuleBbsFormList.do';
		document.moduleBbsForm.submit();
	}
	
	function fn_ModuleBbsFormModifyForm(){
		document.moduleBbsForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/bbsForm/modifyModuleBbsFormForm.do';
		document.moduleBbsForm.submit();
	}
	
</script>

	<form id="moduleBbsForm" name="moduleBbsForm" method="post">
		<input type="hidden" name="formSeq" id="formSeq" value="<c:out value='${moduleBbsFormVO.formSeq }'/>"/>
		<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}"/>" />
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}"/>" />
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}"/>" />
		
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cl" /></th>
					<td>
						<c:out value="${moduleBbsFormVO.formClCodeNm}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.sj" /></th>
					<td>
						<c:out value="${moduleBbsFormVO.formSj }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.cn" /></th>
					<td>
						<c:out value="${moduleBbsFormVO.formCn }" escapeXml="false"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_ModuleBbsFormModifyForm();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" onclick="fn_ModuleBbsFormList();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		$("#itmCstdyAll").click(function(){
			if($("#itmCstdyAll").prop("checked")){
				$("#itmFrm input[name=qesitmSeqArr]").prop("checked", true);
			}else{
				$("#itmFrm input[name=qesitmSeqArr]").prop("checked", false);
			}
		});
	});
	
	/** 페이징 */
	function fnItmCstdyPage(paramPageIndex){
		if(isNaN(paramPageIndex)){console.log('잘못된 페이지호출');return;}
		var code = document.itmFrm.searchQesitmTyCode.value;
		var keyword = document.itmFrm.searchKeyword.value;
		wzModalClose();
		fnItmCstdyList(paramPageIndex, code, keyword);
	}
	
	/** 선택 삭제 */
	function fnItmCstdyDelete(){
		if( $(":checkbox[name='qesitmSeqArr']:checked").length < 1 ){
			alert("<spring:message code="wzwg.cmm.msg.MSG116" />");
			return ;
		}
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/deleteOnlineQustnrItmCstdyArrAjax.do'
	 			, data:$("#itmFrm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
	 						fnItmCstdyPage(1);
	 					}else{
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	 					}
	 				});
	 			}
	 			, error:function (request, status, error) {
	 	              alert('<spring:message code="fail.common.msg" text="error" />');
	 	          }
	 		});
		}
	}
	
	/** 현재 문항에 저장 */
	function fnQesitmRegist(){
		if( $(":checkbox[name='qesitmSeqArr']:checked").length < 1 ){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
 					'<spring:argument><spring:message code="wzwg.cmm.word.data" /></spring:argument>'+
 					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
 				  '</spring:message>');
			return ;
		}
		
 		$.ajax({
 			type:'POST'
 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/registOnlineQustnrItmCstdyNowQustnrAjax.do'
 			, data:$("#itmFrm").serialize()
 			,success:function (result){
 				$(result).find('value').each(function(){
 					if($(this).text() == "success"){
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
 						fnQesitmInit();
 						wzModalClose();
 					}else{
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
 					}
 				});
 			}
 			, error:function (request, status, error) {
 	              alert('<spring:message code="fail.common.msg" text="error" />');
 	          }
 		});
	}
	
</script>

<form id="itmFrm" name="itmFrm" method="post">
	<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />"/>
	<input type="hidden" name="qustnrSeq" value="<c:out value="${paramVO.qustnrSeq }" />"/> 

	<div class="main-menu-bar">
		<select name="searchQesitmTyCode" id="searchQesitmTyCode">
			<option value=""><spring:message code="wzwg.cmm.word.all" /></option>
			<c:forEach items="${codeList }" var="codeList">
				<option value="<c:out value="${codeList.code }" />" <c:if test="${paramVO.searchQesitmTyCode eq codeList.code }">selected="selected"</c:if>><c:out value="${codeList.codeNm }" /></option>
			</c:forEach>
		</select>
		<input type="text" name="searchKeyword" id="searchKeyword" class="w60" value="<c:out value="${paramVO.searchKeyword }" />"/>
		<a href="javascript:void(0);" onclick="fnItmCstdyPage(1);" class="wzbtn-table btn-srch"><spring:message code="wzwg.cmm.word.search01" /></a>
	</div>
	<table class="basic-table">
		<colgroup>
			<col width="10%"/>
			<col width="10%"/>
			<col width="30%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th><ul class="wzForm"><li><label><input type="checkbox" id="itmCstdyAll"/><span class="spanLabel"></span></label></li></ul></th>
				<th>No</th>
				<th><spring:message code="wzwg.module.word.qustnrty" /></th>
				<th><spring:message code="wzwg.module.word.qesitmnm" /></th>
			</tr>
		</thead>
		<tbody>
			<c:choose>
			<c:when test="${!empty resultList }">
				<c:forEach items="${resultList}" var="resultList" varStatus="status">
					<tr>
						<td><ul class="wzForm"><li><label><input type="checkbox" name="qesitmSeqArr" value="<c:out value="${resultList.qesitmSeq }" />"/><span class="spanLabel"></span></label></li></ul></td>
						<td><c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.pageSize + status.count) + 1}"/></td>
						<td><c:out value="${resultList.qesitmTyCodeNm }"/></td>
						<td><c:out value="${resultList.qesitmNm }"/></td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>
				<tr>
					<td colspan="4"><spring:message code="wzwg.cmm.msg.MSG241" /></td>
				</tr>
			</c:otherwise>
			</c:choose>
		</tbody>
	</table>

	<c:if test="${!empty resultList }">
	 	<div class="ctr-box">
			<ul class="num">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fnItmCstdyPage" />
			</ul>
		</div>
	</c:if>
	
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fnItmCstdyDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.module.word.choisedelete" /></a>
		<a href="javascript:void(0);" onclick="fnQesitmRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
	</div>
</form>
	
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	
	<script type="text/javascript">
		
		function fn_regist(){

	 		if(!Validator.validate(document.apiForm)){
	 			return;
	 		}
	 		
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/api/registModuleApiAjax.do'
	 			, data:$("#apiForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	 						fn_list();
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
		
		function fn_modify(){

	 		if(!Validator.validate(document.apiForm)){
	 			return;
	 		}
	 		
	 		$.ajax({
	 			type:'POST'
	 			, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/api/modifyModuleApiAjax.do'
	 			, data:$("#apiForm").serialize()
	 			,success:function (result){
	 				$(result).find('value').each(function(){
	 					if($(this).text() == "success"){
	 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
	 						fn_list();
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
		
		function fn_list(){
			document.apiForm.action='<c:out value="${wzwg_contextPath}${prefix}"/>/module/api/selectModuleApiList.do';
			document.apiForm.submit();
		}
	</script>
	
	<form id="apiForm" name="apiForm" method="post">
	<input type="hidden" name="apiSeq" value="<c:out value='${resultVO.apiSeq }'/>"/>
	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
		<tbody>
			<tr>
				<th><spring:message code="wzwg.cmm.word.se" /></th>
				<td>
					<select name="apiSeCode">
						<option value="<c:out value="${codeVO.code }"/>"><c:out value="${codeVO.codeNm }"/></option>
					</select>
				</td>
			</tr>
			<tr>
				<th>API 명</th>
				<td>
					<input type="text" class="w70" name="apiNm" value="<c:out value='${resultVO.apiNm }'/>" dir="required", title="API <spring:message code="wzwg.module.word.nm01" />"/>
				</td>
			</tr>
			<tr>
				<th>API 키</th>
				<td>
					<input type="text" class="w70" name="apiCrtfcKey" value="<c:out value='${resultVO.apiCrtfcKey }'/>" dir="required" title="API <spring:message code="wzwg.module.word.key" />"/>
				</td>
			</tr>
			<tr>
				<th>X 좌표</th>
				<td>
					<input type="text" class="w70" name="xCnts" value="<c:out value='${resultVO.xCnts }'/>" dir="required", title="<spring:message code="wzwg.module.word.xcnts" />" placeholder="ex) 37.5662952"/>
				</td>
			</tr>
			<tr>
				<th>Y 좌표</th>
				<td>
					<input type="text" class="w70" name="yCnts" value="<c:out value='${resultVO.yCnts }'/>" dir="required", title="<spring:message code="wzwg.module.word.ydnts" />" placeholder="ex) 126.9779451"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.useat" /></th>
				<td>
					<ul>
						<li><label><input type="radio" name="useAt" value="Y" dir="required" title="<spring:message code="wzwg.module.word.useat" />" checked="checked"/><spring:message code="wzwg.cmm.word.use" /></label></li>
						<li><label><input type="radio" name="useAt" value="N" dir="required" title="<spring:message code="wzwg.module.word.useat" />" <c:if test="${resultVO.useAt eq 'N' }">checked="checked"</c:if>/><spring:message code="wzwg.cmm.word.unuse" /></label></li>
					</ul>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
	
	<div class="rt-box">
		<c:if test="${empty resultVO.apiSeq }">
			<a href="javascript:void(0);" onclick="fn_regist();" class="btn-a"><spring:message code="wzwg.cmm.word.stre" /></a>
		</c:if>
		<c:if test="${!empty resultVO.apiSeq }">
			<a href="javascript:void(0);" onclick="fn_modify();" class="btn-a"><spring:message code="wzwg.cmm.word.updt" /></a>
		</c:if>
		<a href="javascript:void(0);" onclick="fn_list();" class="btn-a"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	

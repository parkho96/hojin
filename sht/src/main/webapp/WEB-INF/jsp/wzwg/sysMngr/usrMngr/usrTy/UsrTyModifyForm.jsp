<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	function fn_usrTyModify(){
		
		if(!Validator.validate(document.regForm)){
			return;
		}

		if($("input:radio[name=sbscrbTrgetAt]:checked").val() == "Y" && $("#bassGroupSeq").val() == ""){
			alert('<spring:message code="wzwg.cmm.msg.MSG345"/>');
			return ;
		}
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/modifyUsrTy.do'
			, data:$("#regForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
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
	
	function fn_usrTyDetail(){
		var frm = document.regForm;
		$('input[name=useAt]').val('');
        frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/selectUsrTyList.do';
		frm.submit();
	}
</script>

    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/usrMngr/usrTy/usrTyTab.jsp"></jsp:include>

	<form id="regForm" name="regForm" method="post">
		<input type="hidden" name="usrTySeq" value="<c:out value="${sysMngrUsrTyVO.usrTySeq }"/>"/>
		<input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex }" />"/> 
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
					<td>
						<select name="usrTyCode" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTy" />">
							<c:forEach items="${codeList }" var="codeList">
								<option value="<c:out value="${codeList.code }"/>" <c:if test="${codeList.code eq sysMngrUsrTyVO.usrTyCode }">selected="selected"</c:if>>
									<c:out value="${codeList.codeNm }"/>
								</option>
							</c:forEach>
						</select>
						<span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG0411" /></span>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.detail02TyNm01" /></th>
					<td> 
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.detail02TyNm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="tyNm" class="w60" value="<c:out value="${sysMngrUsrTyVO.tyNm }"/>" dir="required" title="<spring:message code="wzwg.sysMngr.word.detail02TyNm01" />" placeholder="<c:out value="${msg_txt01}"/>"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.detail02TyDc" /></th>
					<td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.detail02TyDc" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="tyDc" class="w60" value="<c:out value="${sysMngrUsrTyVO.tyDc }"/>" dir="required" title="<spring:message code="wzwg.sysMngr.word.detail02TyDc" />" placeholder="<c:out value="${msg_txt02}"/>"/>
					</td>
				</tr>
				<tr>
                    <th><spring:message code="wzwg.cmm.word.ExpsrMber" /></th>
                    <td>
                    	<ul class="wzForm">
                    		<li><label><input type="radio" name="sbscrbTrgetAt" value="Y" <c:if test="${sysMngrUsrTyVO.sbscrbTrgetAt eq 'Y'}">checked</c:if> title="<spring:message code="wzwg.cmm.word.use" />" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                    		<li><label><input type="radio" name="sbscrbTrgetAt" value="N" <c:if test="${sysMngrUsrTyVO.sbscrbTrgetAt eq 'N'}">checked</c:if> title="<spring:message code="wzwg.cmm.word.unuse" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                    	</ul>
                    	<span class="wz_tableguide wd100 fl"><spring:message code="wzwg.cmm.msg.tip.MSG041" /></span>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.bassMberGroup" /></th>
                    <td>
                        <select id="bassGroupSeq" name="bassGroupSeq">
                        <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                        <c:forEach items="${groupList}" var="result">
                        <option value="<c:out value="${result.usrGroupSeq}"/>" <c:if test="${result.usrGroupSeq eq sysMngrUsrTyVO.bassGroupSeq}">selected</c:if>><c:out value="${result.usrGroupNm}" /></option>
                        </c:forEach>
                        </select>
                        <span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG042" /></span>
						<span class="wz_tableguide wd100 fl mt5"><spring:message code="wzwg.cmm.msg.tip.MSG043" /></span>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.use" /> <spring:message code="wzwg.cmm.word.at" /></th>
                    <td>
                    	<ul class="wzForm">
                    		<li><label><input type="radio" name="useAt" value="Y" <c:if test="${sysMngrUsrTyVO.useAt eq 'Y' || empty sysMngrUsrTyVO.useAt}">checked</c:if> title="<spring:message code="wzwg.cmm.word.use" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                    		<li><label><input type="radio" name="useAt" value="N" <c:if test="${sysMngrUsrTyVO.useAt eq 'N'}">checked</c:if> title="<spring:message code="wzwg.cmm.word.unuse" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                    	</ul>
                    	<span class="wz_tableguide wd100 fl"><spring:message code="wzwg.cmm.msg.tip.MSG044" /></span>
                    </td>
                </tr>
			</tbody>
		</table>
	</form>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_usrTyModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_usrTyDetail();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

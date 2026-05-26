<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	function fn_usrTyRegist(){
		
		if(!Validator.validate(document.usrTyRegistForm)){
			return;
		}
		
		if($("input:radio[name=sbscrbTrgetAt]:checked").val() == "Y" && $("#bassGroupSeq").val() == ""){
			alert('<spring:message code="wzwg.cmm.msg.MSG345"/>');
			return ;
		}
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/registUsrTy.do'
			, data:$("#usrTyRegistForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						fn_usrTyList();
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
	
	function fn_usrTyList(){
		var frm = document.usrTyRegistForm;
		$('input[name=useAt]').val('');
		frm.action='<c:out value="${wzwg_contextPath}"/>/mngr/usrMngr/usrTy/selectUsrTyList.do';
		frm.submit();
	}
</script>

	<form id="usrTyRegistForm" name="usrTyRegistForm" method="post">
	
		<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.sysMngr.word.mbertyRegist"/></h3>
		
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
					<td>
						<select name="usrTyCode" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTyAll" />">
							<c:forEach items="${codeList }" var="codeList">
								<option value="<c:out value="${codeList.code }"/>"><c:out value="${codeList.codeNm }"/></option>
							</c:forEach>
						</select>
						<span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG0411" /></span>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.detail02TyNm01" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.detail02TyNm01" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="tyNm" class="w60" dir="required" title="<spring:message code="wzwg.sysMngr.word.detail02TyNm01" />" placeholder="<c:out value="${msg_txt01}"/>"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.detail02TyDc" />
						<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
						</span>
					</th>
					<td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.detail02TyDc" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="tyDc" class="w60" dir="required" title="<spring:message code="wzwg.sysMngr.word.detail02TyDc" />" placeholder="<c:out value="${msg_txt02}"/>"/>
					</td>
				</tr>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.ExpsrMber" /></th>
                    <td>
                    	<ul class="wzForm">
                        	<li><label><input type="radio" name="sbscrbTrgetAt" value="Y" title="<spring:message code="wzwg.cmm.word.use" />" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                        	<li><label><input type="radio" name="sbscrbTrgetAt" value="N" checked title="<spring:message code="wzwg.cmm.word.unuse" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
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
                        <option value="<c:out value="${result.usrGroupSeq}" />"><c:out value="${result.usrGroupNm}" /></option>
                        </c:forEach>
                        </select>
                        <span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG042" /></span>
						<span class="wz_tableguide wd100 fl mt5"><spring:message code="wzwg.cmm.msg.tip.MSG043" /></span>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
                    <td>
                    	<ul class="wzForm">
                    		<li><label><input type="radio" name="useAt" value="Y" checked title="<spring:message code="wzwg.cmm.word.use" />" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                    		<li><label><input type="radio" name="useAt" value="N" title="<spring:message code="wzwg.cmm.word.unuse" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                    	</ul>
                    	<span class="wz_tableguide wd100 fl"><spring:message code="wzwg.cmm.msg.tip.MSG044" /></span>
                    </td>
                </tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_usrTyRegist();"><spring:message code="wzwg.cmm.word.regist" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_usrTyList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

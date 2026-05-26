<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	function fn_usrTyModifyForm(){
		document.usrTyDetailForm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/modifyUsrTyForm.do';
		document.usrTyDetailForm.submit();
	}
	
	function fn_usrTyDelete(){
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/deleteUsrTy.do'
				, data:$("#usrTyDetailForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_usrTyList();
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
			return;
		}
	}
	
	function fn_usrTyList(){
		var frm = document.usrTyDetailForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/selectUsrTyList.do';
		frm.submit();
	}
</script>

	<form id="usrTyDetailForm" name="usrTyDetailForm" method="post">
		<input type="hidden" name="usrTySeq" id="usrTySeq" value="<c:out value="${sysMngrUsrTyVO.usrTySeq}" />"/>
		<input type="hidden" name="usrTyCode" id="usrTyCode" value="<c:out value="${sysMngrUsrTyVO.usrTyCode }" />"/>
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="80%"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.mberTyTy03" /></th>
					<td>
						<c:out value="${sysMngrUsrTyVO.usrTyCodeNm }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.mberTyNm01" /></th>
					<td>
						<c:out value="${sysMngrUsrTyVO.tyNm }"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.tyDc" /></th>
					<td>
						<c:out value="${sysMngrUsrTyVO.tyDc }"/>
					</td>
				</tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.sbscrbTrgetAt" /></th>
                    <td>
                        <c:choose>
                        <c:when test="${sysMngrUsrTyVO.sbscrbTrgetAt eq 'Y'}"><spring:message code="wzwg.cmm.word.use" /></c:when>
                        <c:otherwise><spring:message code="wzwg.cmm.word.unuse" /></c:otherwise>
                        </c:choose>
                    </td>
                </tr>
			</tbody>
		</table>
	</form>

	<div class="rt-box">
		<a href="javascript:void(0);" class="btn-a fl" onclick="fn_usrTyDelete();"><spring:message code="wzwg.cmm.word.delete" /></a>
		
		<a href="javascript:void(0);" class="btn-a" onclick="fn_usrTyModifyForm();"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" class="btn-a" onclick="fn_usrTyList();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

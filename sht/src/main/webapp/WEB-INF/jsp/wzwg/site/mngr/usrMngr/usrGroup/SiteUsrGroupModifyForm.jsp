<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	/** 사이트사용자그룹 수정 */
	function fn_siteUsrGroupModify(){
		if(!Validator.validate(document.siteUsrGroupForm)){
			return;
		}
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/modifySiteUsrGroup.do'
			, data:$("#siteUsrGroupForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
						fn_cancel();
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
	
	/** 사이트사용자그룹 상세조회로 이동 */
	function fn_cancel(){
		var frm = document.siteUsrGroupForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupDetail.do';
		frm.submit();
	}
</script>

	<form id="siteUsrGroupForm" name="siteUsrGroupForm" method="post">
		<input type="hidden" name="usrGroupSeq" id="usrGroupSeq" value="<c:out value="${siteUsrGroupVO.usrGroupSeq }" />"/>
		
		<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.site.usrmngr.msg.MSG007"/></h3>
		
		
		<table class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.site.usrmngr.msg.MSG004" /></th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.site.menu.msg.MSG004" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="usrGroupNm" id="usrGroupNm" value="<c:out value="${siteUsrGroupVO.usrGroupNm}" />" class="w60" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG004" />" placeholder="<c:out value="${msg_txt01}" />"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.usrmngr.msg.MSG005" /></th>
					<td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.site.menu.msg.MSG005" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="usrDc" id="usrDc" value="<c:out value="${siteUsrGroupVO.usrDc}" />" class="w60" dir="required" title="<spring:message code="wzwg.site.menu.msg.MSG005=" />" placeholder="<c:out value="${msg_txt02}" />"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_siteUsrGroupModify();"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_cancel();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

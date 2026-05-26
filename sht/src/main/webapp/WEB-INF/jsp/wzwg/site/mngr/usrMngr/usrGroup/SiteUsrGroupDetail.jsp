<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$(function() { 
	fn_usrGrouplist();
});
	/** 사이트사용자그룹 수정 폼 */
	function fn_siteUsrGroupModifyForm(){
		var frm = document.siteUsrGroupForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/modifySiteUsrGroupForm.do';
		frm.submit();
	}
	
	/** 사이트그룹 삭제 */
	function fn_siteUsrGroupDelete(){
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" text="delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/deleteSiteUsrGroup.do'
				, data:$("#siteUsrGroupForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fn_list();
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
	
	/** 사이트사용자그룹 삭제 */
	function fn_siteUsrInfoGroupDelete(){
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.excl" text="delete" /></spring:argument></spring:message>')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/deleteSiteUsrInfoGroup.do'
				, data:$("#siteUsrGroupForm").serialize()
				,success:function (result){
					$(result).find('value').each(function(){
						if($(this).text() == "success"){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.excl" /></spring:argument></spring:message>');
							fn_usrGrouplist();
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.excl" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
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
	
	
	function fn_usrGrouplist(){
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/SiteUsrInfoGroupListAjax.do'
			, data:$("#siteUsrGroupForm").serialize()
			,success:function (result){ 
				$("#usrinfoDiv").html(result);
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}
	
	function fn_nonUsrGrouplist(){
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/SiteUsrInfoNonGroupListAjax.do'
			, data:$("#siteUsrGroupForm").serialize()
			,success:function (result){ 
				wzAjaxModal('popup_s', '<spring:message code="wzwg.cmm.word.groupUsrAdd" />', result);
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}
	
	/** 사이트사용자그룹 리스트로 이동 */
	function fn_list(){
		var frm = document.siteUsrGroupForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do';
		frm.submit();
	}
	

	
</script>
	
	<form id="siteUsrGroupForm" name="siteUsrGroupForm" method="post">
		<input type="hidden" name="usrGroupSeq" id="usrGroupSeq" value="<c:out value="${siteUsrGroupVO.usrGroupSeq }" />"/>
		
		<input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition }" />"/>
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword }" />"/>
		
		<h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.site.usrmngr.msg.MSG003"/></h3>
		
		
		<table summary="<spring:message code="wzwg.site.usrmngr.msg.MSG022"/>" class="basic">
			<colgroup>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.site.usrmngr.msg.MSG004" /></th>
					<td>
						<c:out value="${siteUsrGroupVO.usrGroupNm}"/>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.site.usrmngr.msg.MSG005" /></th>
					<td>
						<c:out value="${siteUsrGroupVO.usrDc}"/>
					</td>
				</tr>
			</tbody>
		</table>

	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fn_siteUsrGroupDelete();"><spring:message code="wzwg.cmm.word.delete" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_siteUsrGroupModifyForm();"><spring:message code="wzwg.cmm.word.updt" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-basic" onclick="fn_list();"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
	<div id="usrinfoDiv" class="pt10"></div>
	
	<div class="rt-box">
		<a href="javascript:void(0);" class="wzbtn btn-del fl" onclick="fn_siteUsrInfoGroupDelete();"><spring:message code="wzwg.cmm.word.excludeMember" /></a>
		<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fn_nonUsrGrouplist();"><spring:message code="wzwg.site.usrmngr.msg.MSG006" /></a>
	</div>
	</form>

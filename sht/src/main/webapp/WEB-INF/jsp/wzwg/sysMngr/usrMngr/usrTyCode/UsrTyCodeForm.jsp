<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	function fn_usrTyModify(){
		
		if(!Validator.validate(document.usrTyModifyForm)){
			return;
		}
		
		$.ajax({
			type:'POST'
		    <c:choose>
			<c:when test="${empty resultVO.code}">
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/registUsrTyCode.do'
			</c:when>
			<c:otherwise>
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/modifyUsrTyCode.do'
			</c:otherwise>
			</c:choose>
			, data:$("#usrTyModifyForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
					    <c:if test="${empty resultVO.code}">
						fn_usrTyDetail();
					    </c:if>
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
				})
			}
			, error:function (request, status, error) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
		});
	}
	
	function fn_usrTyDetail(){
		var frm = document.usrTyModifyForm;
		frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeList.do';
		frm.submit();
	}
	
	function fn_usrTyDelete(){
 		if('<c:out value="${applcCount}" />' != 0){
			alert('<spring:message code="wzwg.cmm.msg.MSG276" />');
			return ;
		}else{
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG277" />')){
				return ;
			}else{
		 		$.ajax({
		 			type:'POST'
		 			, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/deleteUsrTyCode.do'
		 			, data:$("#usrTyModifyForm").serialize()
		 			,success:function (result){
		 				$(result).find('value').each(function(){
		 					if($(this).text() == "success"){
		 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
		 						fn_usrTyDetail();
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
 	}
</script>

    <c:if test="${!empty resultVO.code}">
    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/usrMngr/usrTyCode/usrTyCodeTab.jsp"></jsp:include>
    </c:if>

	<form id="usrTyModifyForm" name="usrTyModifyForm" method="post">
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
		<input type="hidden" name="code" id="code" value="<c:out value="${resultVO.code}" />"/>
		<table class="basic">
			<colgroup>
				<col width="30%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
					<td>
						<c:set var="msg_txt01">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.mberTy" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
						<input type="text" name="codeNm" class="w70" value="<c:out value="${resultVO.codeNm}" />" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTy" />" placeholder="<c:out value="${msg_txt01}" />"/>
					</td>
				</tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.mberTyDc" /></th>
                    <td>
						<c:set var="msg_txt02">
							<spring:message code="wzwg.cmm.cmmMsg.CMG011">
								<spring:argument><spring:message code="wzwg.sysMngr.word.mberTyDc" /></spring:argument>
								<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
							</spring:message>
						</c:set>
                        <input type="text" name="codeDc" class="w70" value="<c:out value="${resultVO.codeDc}" />" dir="required" title="<spring:message code="wzwg.sysMngr.word.mberTyDc" />" placeholder="<c:out value="${msg_txt02}" />"/>
                    </td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.siteMngUseAt" /></th>
                    <td>
                    	<ul class="wzForm">
                    		<li><label><input type="radio" name="useAt" value="Y" <c:if test="${resultVO.useAt eq 'Y' || empty resultVO.useAt}">checked</c:if> title="<spring:message code="wzwg.cmm.word.use" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label></li>
                    		<li><label><input type="radio" name="useAt" value="N" <c:if test="${resultVO.useAt eq 'N'}">checked</c:if> title="<spring:message code="wzwg.cmm.word.unuse" />"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                    	</ul>
                    </td>
                </tr>
			</tbody>
		</table>
	</form>
	
	<div class="rt-box">
        <c:if test="${!empty resultVO.code }">
        <a href="javascript:void(0);" onclick="fn_usrTyDelete();" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.delete" /></a>
        </c:if>
		<a href="javascript:void(0);" onclick="fn_usrTyModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fn_usrTyDetail();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

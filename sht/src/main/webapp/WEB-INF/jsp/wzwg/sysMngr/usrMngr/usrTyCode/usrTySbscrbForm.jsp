<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
function fn_usrTySbscrbModify() {
    
    if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){

        $('input[name="qesitmEstbsSeArr"]').each(function(idx){
            var rdoVal = $('input[name="rdoQesitmEstbsSe'+idx+'"]:checked').val();
            $('input[name="qesitmEstbsSeArr"]').eq(idx).val(rdoVal);
        });
        
        $.ajax({
            type:'POST'
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/modifyUsrTySbscrbForm.do'
            , data:$("#usrTyModifyForm").serialize()
            ,success:function (result){
                $(result).find('value').each(function(){
                    if($(this).text() == "success"){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
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
}

function fn_usrTyDetail(){
    var frm = document.usrTyModifyForm;
    frm.action='<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeList.do';
    frm.submit();
}
</script>

    <c:if test="${!empty resultVO.code}">
    <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/usrMngr/usrTyCode/usrTyCodeTab.jsp"></jsp:include>
    </c:if>

	<form id="usrTyModifyForm" name="usrTyModifyForm" method="post">
        <input type="hidden" id="code" name="code" value="<c:out value="${resultVO.code}" />" />
        <input type="hidden" id="usrTyCode" name="usrTyCode" value="<c:out value="${resultVO.code}" />" />
		<table class="basic">
			<colgroup>
				<col width="30%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
				<tr>
					<th><spring:message code="wzwg.cmm.word.id02" /></th>
					<td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
				</tr>
                <tr>
                    <th><spring:message code="wzwg.cmm.word.password" /></th>
                    <td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
                </tr>
                <tr>
                    <th><spring:message code="wzwg.sysMngr.word.passwdCnfirm" /></th>
                    <td><spring:message code="wzwg.sysMngr.word.chgImprty" /></td>
                </tr>
                <c:choose>
                <c:when test="${empty resultList}">
                <tr>
                    <td><spring:message code="wzwg.cmm.msg.MSG153" /></td>
                </tr>
                </c:when>
                <c:otherwise>
                <c:forEach items="${resultList}" var="result" varStatus="status">
                <input type="hidden" id="mberSbsfrmCodeArr" name="mberSbsfrmCodeArr" value="<c:out value="${result.mberSbsfrmCode}" />" />
                <input type="hidden" id="qesitmEstbsSeArr" name="qesitmEstbsSeArr" value="<c:out value="${status.count}" />" />
                <tr>
                    <th><c:out value="${result.mberSbsfrmCodeNm}" /></td>
                    <td>
                    	<ul class="wzForm">
                    		<li><label><input type="radio" name="rdoQesitmEstbsSe<c:out value="${status.count-1}" />" value="E" <c:if test="${result.qesitmEstbsSe eq 'E'}">checked</c:if> title="사용(필수입력)" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" />(<spring:message code="wzwg.cmm.word.requinput" />)</span></label></li>
                    		<li><label><input type="radio" name="rdoQesitmEstbsSe<c:out value="${status.count-1}" />" value="S" <c:if test="${result.qesitmEstbsSe eq 'S'}">checked</c:if> title="사용(선택입력)" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.use" />(<spring:message code="wzwg.cmm.word.electinput" />)</span></label></li>
                    		<li><label><input type="radio" name="rdoQesitmEstbsSe<c:out value="${status.count-1}" />" value="N" <c:if test="${result.qesitmEstbsSe eq 'N'}">checked</c:if> title="사용안함" /> <span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
                    	</ul>
                    </td>
                </tr>
                </c:forEach>
                </c:otherwise>
                </c:choose>
			</tbody>
		</table>
	</form>
		
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_usrTySbscrbModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fn_usrTyDetail();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

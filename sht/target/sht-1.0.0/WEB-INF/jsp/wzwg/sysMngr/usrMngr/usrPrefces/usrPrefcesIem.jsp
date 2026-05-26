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
            , url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/usrPrefces/modifyusrPrefces.do'
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

</script>

		<form id="usrTyModifyForm" name="usrTyModifyForm" method="post">
        <input type="hidden" id="usrPrefeCode" name="usrPrefeCode" />
		<table class="basic">
			<colgroup>
				<col width="30%"/>
				<col width="*"/>
			</colgroup>
			<tbody>
                <c:choose>
                <c:when test="${empty resultList}">
                <tr>
                    <td><spring:message code="wzwg.cmm.msg.MSG153" /></td>
                </tr>
                </c:when>
                <c:otherwise>
                <c:forEach items="${resultList}" var="result" varStatus="status">
                <input type="hidden" id="usrMngrestbsCodeArr" name="usrMngrestbsCodeArr" value="<c:out value="${result.usrMngrestbsCode}" />" />
                <input type="hidden" id="qesitmEstbsSeArr" name="qesitmEstbsSeArr" value="<c:out value="${status.count}" />" />
                <tr>
                    <th><c:out value="${result.usrMngrestbsCodeNm}" /></td>
                    <td>
                    	<ul class="wzForm">       	            	
 	                   		<li><label><input type="radio" name="rdoQesitmEstbsSe${status.count-1}" value="Y" <c:if test="${result.qesitmEstbsSe eq 'Y'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.use" /></span></label>
	 	                   		<c:if test="${!empty codeList}">
			                    (<select id="pdEstbsCodeArr" name="pdEstbsCodeArr" style="width:80px;">
			                    <c:forEach items="${codeList}" var="code">
			  	                  <option value="<c:out value="${code.code}" />" <c:if test="${code.code eq result.pdEstbsCode}">selected</c:if>><c:out value="${code.codeAbrvNm}" /> <%-- <spring:message code="wzwg.cmm.word.month" /> --%></option>
			                    </c:forEach>
			                    </select>)
			                    </c:if>
 	                   		</li>
	 	                   	<li><label><input type="radio" name="rdoQesitmEstbsSe<c:out value="${status.count-1}" />" value="N" <c:if test="${result.qesitmEstbsSe eq 'N'}">checked</c:if> /><span class="spanLabel"><spring:message code="wzwg.cmm.word.unuse" /></span></label></li>
 	                   </ul>
                    </td>
                </tr>
                </c:forEach>
                </c:otherwise>
                </c:choose>
			</tbody>
		</table>
		</form>

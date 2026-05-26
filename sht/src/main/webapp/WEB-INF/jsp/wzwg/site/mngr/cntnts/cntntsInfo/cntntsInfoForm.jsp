<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">

function fnSelModule() {
    var frm = document.frmInfo;

    frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoForm.do";
    frm.submit();
}

function fnList() {
    var frm = document.frmSrh;

    frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/selectCntntsInfoList.do";
    frm.submit();
}

function fnCntntsRegist() {
    
    $.ajax({
        type : 'POST'
        , url : '<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/cntnts/cntntsInfo/registCntntsInfo.do'
        , dataType: 'xml'
        , data : $("#frmInfo").serialize()
        , success : function (result) {
          
            var value = "";
            
            $(result).find("value").each(function() {  
                value = $(this).text();  
            });
            
            if(value == 'success'){
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.site.cntnts.msg.MSG019" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
                
                var frm = document.frmSrh;
                frm.pageIndex.value = 1;
                //frm.searchModuleSeq.value = $('#sysmoduleSeq').val();
                
                fnList();
            }else{
                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
            }
          
        }
        , error : function (request, status, error) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
}

$(document).ready(function(){

	if($('#sysmoduleSeq').val() != ''){
	    $.ajax({
	          type:'POST'
	        , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/<c:out value="${moduleVO.pckagePath}"/>/<c:out value="${moduleVO.moduleNcnm}"/>FormAjax.do'
	        , data:{'searchModuleSeq':$('#sysmoduleSeq').val()}
	        , cache : false
	        , async : false
	        , success:function (data) {
	            $('#module_area').html(data);
	            $("#regist_btn").attr("onclick",'');
	            /* 저장 */
	            $('#regist_btn').click(function(){
	                fnRegist('C');
	            });
	
	
	            $("#reset_btn").attr("onclick",'');
	            
	            /* 취소 */
	            $('#reset_btn').click(function(){
	                fnList();
	            });
	        }
	        , error:function (data) {
	            alert('<spring:message code="fail.common.msg" text="error" />');
	        }
	        , dataType: 'html'
	    });
	}
    
});
</script>
                <form:form modelAttribute="paramVO" id="frmSrh" name="frmSrh">
                    <form:hidden path="pageIndex" />
                    <form:hidden path="sitecntntsSeq"/>
                    <form:hidden path="searchModuleSeq" />
                    <form:hidden path="searchCondition" /> 
                    <form:hidden path="searchKeyword" />
                </form:form>
                
                <form:form modelAttribute="cntntsInfoVO" id="frmInfo" name="frmInfo">
                	<c:set var="wMsg"><spring:message code="wzwg.site.cntnts.msg.MSG021"/></c:set>
                    <form:hidden path="cntntsNm" title="${fn:escapeXml(wMsg)}" dir="required"/>
                    <input type="hidden" id="moduleTyCode" name="moduleTyCode" value="<c:out value="${moduleVO.moduleTyCode}"/>" />
                    
                    <table class="basic mb10" summary="<spring:message code="wzwg.site.cmm.msg.MSG005"/>">
                    <colgroup>
                        <col width="15%"/>
                        <col width="*"/>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th><spring:message code="wzwg.site.cntnts.msg.MSG020" /></th>
                            <td>
                            	<c:set var="wMsg"><spring:message code="wzwg.cmm.word.module"/></c:set>
                                <form:select path="sysmoduleSeq" cssClass="w70" onchange="javascript:fnSelModule();" dir="required" title="${fn:escapeXml(wMsg)}">
                                	<form:option value=""><label for="choise"><spring:message code="wzwg.cmm.word.choise" /></label></form:option>
                                	    <c:forEach var="item" items="${moduleAllList}">
								        	<form:option value="${fn:escapeXml(item.sysmoduleSeq)}" label="${fn:escapeXml(item.moduleNm)}" />
								    	</c:forEach>
                                </form:select>
                            </td>
                        </tr>
                    </tbody>
                    </table>
                    
                </form:form>
        
                <!-- body -->       
                <div id="module_area" class="w100"></div>
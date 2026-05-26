<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	
	function fnRegist(){
		
		var frm = document.regFrm;
		
		var fileTyCodeArr = "";
		var mdPermAtArr = "";
		
		for(var i = 0; i < "<c:out value="${fn:length(resultList)}" />"; i++){
			fileTyCodeArr 	+= frm.fileTyCode[i].value + ",";
			mdPermAtArr		+= ( frm.fileTyCode[i].checked == true ? "Y" : "N" ) + ",";
		}
		
		frm.fileTyCodeArr.value = fileTyCodeArr;
		frm.mdPermAtArr.value 	= mdPermAtArr;
		
		$.ajax({
            type : 'POST'
            , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/fileEstbs/modifyFileEstbsInfo.do'
            , dateType : 'html'
            , data : $("#regFrm").serialize()
            , success : function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
                }else{
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                }
              
            }
            , error : function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
	}
	
</script>
        
        <form:form modelAttribute="resultVO" path="regFrm" id="regFrm" name="regFrm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="fileTyCodeArr" />
            <form:hidden path="mdPermAtArr" />
            
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0073"/></li>
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0074"/></li>
		        </ul>
			</div>
			
			<table class="basic-table">
					<colgroup>
						<col width="20%">
						<col width="*">
						<col width="20%">
					</colgroup>
					<thead>
					<tr>
						<th><spring:message code="wzwg.module.word.filety" /></th>
						<th><spring:message code="wzwg.module.word.permextsn" /></th>
						<th><spring:message code="wzwg.module.word.permat" /></th>
					</tr>
					</thead>
					
					<tbody>
					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					<tr>
						<td class="txt-c">
							<c:out value="${resultList.fileTyCodeNm}" />
						</td>
						<td class="txt-l">
							<c:out value="${resultList.fileEstbsExtsn}" />
						</td>
						<td>
							<ul class="wzForm"><li>
							<input type="checkbox" id="fileTyCode_<c:out value="${resultList.fileTyCode}" />" name="fileTyCode" value="<c:out value="${resultList.fileTyCode}" />" <c:if test="${resultList.mdPermAt eq 'Y'}">checked="true"</c:if> />
							<label for="fileTyCode_<c:out value="${resultList.fileTyCode}" />"><span class=dp-none""></span></label>
							</li></ul>
						</td>
					</tr>
					</c:forEach>
					</tbody>
			</table>
            
        </form:form>
                
        <div class="rt-box">
            <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
        </div>

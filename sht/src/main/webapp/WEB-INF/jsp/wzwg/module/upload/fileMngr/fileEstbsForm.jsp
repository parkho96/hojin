<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<jsp:include page="/WEB-INF/jsp/wzwg/webModule/editorTool.jsp"></jsp:include>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
	
	function fnRegist(){
		
		var frm = document.regFrm;
		
		var fileTyCodeArr = "";
		var fileCpctyArr = "";
		var fileCpctySeArr = "";
		var permAtArr = "";
		var fileAllCpcty = "";
		
		for(var i = 0; i < "<c:out value="${fn:length(resultList)}" />"; i++){
			
			if('<c:out value="${fileEstbsSe}" />' == 'B'){
				fileTyCodeArr 	+= frm.fileTyCode[i].value + ",";
				fileCpctyArr 	+= frm.fileCpcty[i].value + ",";
				fileCpctySeArr 	+= frm.fileCpctySe[i].value + ",";
				permAtArr		+= ( frm.fileTyCode[i].checked == true ? "Y" : "N" ) + ",";
				fileAllCpcty	+= frm.fileCpcty[i].value + ",";
			}

			if('<c:out value="${fileEstbsSe}" />' == 'C'){
				fileTyCodeArr 	+= frm.fileTyCode[i].value + ",";
				fileCpctyArr 	+= frm.tmpFileCpcty.value + ",";
				fileCpctySeArr 	+= frm.fileCpctySe[i].value + ",";
				permAtArr		+= ( frm.fileTyCode[i].checked == true ? "Y" : "N" ) + ",";
				fileAllCpcty	+= frm.tmpFileAllCpcty.value + ",";
			}
			
		}
		

		
		
		frm.fileTyCodeArr.value  	= fileTyCodeArr;
		frm.fileCpctyArr.value 	 	= fileCpctyArr;
		frm.fileCpctySeArr.value 	= fileCpctySeArr;
		frm.permAtArr.value 	 	= permAtArr;
		frm.fileAllCpctyArr.value	= fileAllCpcty;
		
		$.ajax({
            type : 'POST'
            , url : '<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/upload/fileMngr/fileEstbs/modifyFileEstbsMngr.do'
            , dateType : 'html'
            , data : $("#regFrm").serialize()
            , success : function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value == 'success'){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
					location.reload();
                }else{
                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
                }
              
            }
            , error : function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
	}
	
	function fnTagChk(val){
		var RegExp = /[ \{\}\[\]\/?.;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=\s]/gi;
		var inputVal = $('#fileCpcty_'+val).val();
		$('#fileCpcty_'+val).val(inputVal.replace(RegExp, ''));
	}
	
</script>
        
        <form:form modelAttribute="resultVO" path="regFrm" id="regFrm" name="regFrm" method="post">
            <form:hidden path="sitecntntsSeq" />
            <form:hidden path="siteSeq" />
            <form:hidden path="fileTyCodeArr" />
            <form:hidden path="fileCpctyArr" />
            <form:hidden path="fileCpctySeArr" />
            <form:hidden path="permAtArr" />
            <form:hidden path="fileAllCpctyArr" />
               
					<div class="wz_notice brbox bg-white br-blue-strong" style="overflow: visible;">	
						<ul class="wd100">
							<li class="admpg-subp wd100">· <spring:message code="wzwg.cmm.msg.tip.MSG150" /></li>
						</ul>
					</div>
					
					<table class="basic-table">
					<colgroup>
						<c:if test="${fileEstbsSe eq 'B'}">
						<col width="50%">
						<col width="20%">
						<col width="30%">
						</c:if>
						
						<c:if test="${fileEstbsSe eq 'C'}">
						<col width="20%">
						<col width="20%">
						<col width="30%">
						</c:if>
					</colgroup>
					<thead>
					<tr>
						<th><spring:message code="wzwg.module.word.filety" /></th>
						<th><spring:message code="wzwg.module.word.permat" /></th>
						
						<c:if test="${fileEstbsSe eq 'B'}">
							<th><spring:message code="wzwg.module.word.cpctylmtt" /></th>
						</c:if>
						
						<c:if test="${fileEstbsSe eq 'C'}">
							<th><spring:message code="wzwg.module.word.indvdlzcpctylmtt" /></th>
							<th><spring:message code="wzwg.module.word.allcpctylmtt" /></th>
						</c:if>
					</tr>
					</thead>
					
					<tbody>
					
					<c:set var="rowspanCnt" value="${fn:length(resultList)}" />

					<c:forEach var="resultList" items="${resultList}" varStatus="status">
					<tr>
						<td class="txt-l">
							<c:out value="${resultList.fileTyCodeNm}" /> <br />( <c:out value="${resultList.fileEstbsExtsn}" /> )
						</td>
						<td>
							<ul class="wzForm"><li><label><input type="checkbox" id="fileTyCode_<c:out value="${resultList.fileTyCode}" />" name="fileTyCode" value="<c:out value="${resultList.fileTyCode}" />" <c:if test="${resultList.permAt eq 'Y'}">checked="true"</c:if> /><span class="spanLabel"></span></label></li></ul>
						</td>
						<c:if test="${fileEstbsSe eq 'B'}">
						<td>
							<form:input path="fileCpcty" id="fileCpcty_${fn:escapeXml(resultList.fileTyCode)}" value="${fn:escapeXml(resultList.fileCpcty)}" cssStyle="ime-mode:disabled;" onkeyup="fnTagChk('${fn:escapeXml(resultList.fileTyCode)}');" />
							<span>
							    <form:select path="fileCpctySe" id="fileCpctySe_${fn:escapeXml(resultList.fileTyCode)}" cssStyle="width:50px;">
									<option value="K" <c:if test="${resultList.fileCpctySe eq 'K' or resultList.fileCpctySe eq null}">selected=selected</c:if>>KB</option>
									<option value="M" <c:if test="${resultList.fileCpctySe eq 'M'}">selected=selected</c:if>>MB</option>
								</form:select>
							</span>
						</td>
						</c:if>
						<c:if test="${fileEstbsSe eq 'C'}">
						<form:hidden path="fileCpctySe" id="fileCpctySe_${fn:escapeXml(resultList.fileTyCode)}" value="M" />
						<form:hidden path="fileCpcty" id="fileCpcty_${fn:escapeXml(resultList.fileCpcty)}" value="${fn:escapeXml(resultList.fileCpcty)}" />
						<form:hidden path="fileAllCpcty" id="fileAllCpcty_${fn:escapeXml(resultList.fileAllCpcty)}" value="${fn:escapeXml(resultList.fileAllCpcty)}" />

						<c:if test="${status.first}">
						<td rowspan="<c:out value="${rowspanCnt}" />">
							<input type="text" id="tmpFileCpcty" name="tmpFileCpcty" value="<c:out value="${resultList.fileCpcty}" />" style="ime-mode:disabled;" onkeyup="fnTagChk('<c:out value="${resultList.fileTyCode}" />');" /> MB
						</td>
						<td rowspan="<c:out value="${rowspanCnt}" />">
							<input type="text" id="tmpFileAllCpcty" name="tmpFileAllCpcty" value="<c:out value="${resultList.fileAllCpcty}" />" style="ime-mode:disabled;" onkeyup="fnTagChk('<c:out value="${resultList.fileTyCode}" />');" /> MB
						</td>
						</c:if>
						</c:if>
					</tr>
					</c:forEach>
					</tbody>
				</table>
            
        </form:form>
                
        <div class="rt-box">
            <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
        </div>

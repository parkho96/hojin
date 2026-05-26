<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<c:set var="paramSiteSeq" value="${resultVO.siteSeq}" />
<c:if test="${empty paramSiteSeq}">
<c:set var="paramSiteSeq" value="${paramVO.siteSeq}" />
</c:if>

<script type="text/javascript">

	$(document).ready(function(){
		
		if('<c:out value="${resultVO.fileProvdAt}"/>" />' == 'Y'){
			$('#fileProvdMg').prop('disabled', false);
			$('#fileCpctySe').prop('disabled', false);
		}else{
			$('#fileProvdMg').prop('disabled', true);
			$('#fileCpctySe').prop('disabled', true);
		}
		
		$('#fileProvdAtY').click(function(){
			$('#fileProvdMg').prop('disabled', false);
			$('#fileCpctySe').prop('disabled', false);
		});
		
		$('#fileProvdAtN').click(function(){
			$('#fileProvdMg').prop('disabled', true);
			$('#fileCpctySe').prop('disabled', true);
		});
		
	});
	
	function fnRegist(){
		
		if($(":input:radio[name=fileProvdAt]:checked").val() == 'Y' && $('#fileProvdMg').val() == ''){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG050" />');
			return;
		}
		
		$.ajax({
	            type : 'POST'
	            , url : '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/modifySiteFileProvdAjax.do'
	            , dataType: 'xml'
	            , data : $("#regForm").serialize()
	            , success : function (result) {
	              
	                var value = "";
	                
	                $(result).find("value").each(function() {  
	                    value = $(this).text();  
	                });
	                
	                if(value == 'success'){
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
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
			<c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3><spring:message code="wzwg.cmm.menu.fileprovdmg" /></h3>
            </c:otherwise>
            </c:choose>
			
            <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
             
				<c:choose>
	                <c:when test="${empty resultVO.siteSeq}">
	                	<input type="hidden" id="siteSeq" name="siteSeq" value="<c:out value="${paramVO.siteSeq}" />" />
	                </c:when>
	                <c:otherwise>
	                	<form:hidden path="siteSeq" name="siteSeq" />
	                </c:otherwise>
                </c:choose>
                
			<table class="basic">
				<colgroup>
					<col width="20%">
					<col width="80%">
				</colgroup>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.useAt" /></th>
					<td>
						<ul class="wzForm">
							<li><input type="radio" id="fileProvdAtY" name="fileProvdAt" value="Y" dir="required" <c:if test="${resultVO.fileProvdAt eq 'Y' or resultVO.fileProvdAt eq null}">checked="true"</c:if> />
							<label for="fileProvdAtY"><spring:message code="wzwg.cmm.word.use" /></label></li>
				            <li><input type="radio" id="fileProvdAtN" name="fileProvdAt" value="N" dir="required" <c:if test="${resultVO.fileProvdAt eq 'N'}">checked="true"</c:if> />
				            <label for="fileProvdAtN"><spring:message code="wzwg.cmm.word.unuse" /></label></li>
			            </ul>
					</td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.sysMngr.word.provdMg" /></th>
					<td>
						<form:input path="fileProvdMg" id="fileProvdMg" value="${fn:escapeXml(resultVO.fileProvdMg)}" cssClass="pr10" onkeyup="fnKeyUpEvent('fileProvdMg', 1);" cssStyle="text-align:right;width:150px;ime-mode:disabled;" />
						<form:select path="fileCpctySe" id="fileCpctySe" cssStyle="width:60px;">
							<option value="M" <c:if test="${fn:escapeXml(resultVO.fileCpctySe) eq 'M' or fn:escapeXml(resultVO.fileCpctySe) eq null}">selected=selected</c:if>>MB</option>
							<option value="G" <c:if test="${fn:escapeXml(resultVO.fileCpctySe) eq 'G'}">selected=selected</c:if>>GB</option>
						</form:select>
					</td>
				</tr>
			</table>
            
        </form:form>
                
        <div class="rt-box">
            <a href="javascript:void(0);" id="regist_btn" onclick="javascript:fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
        </div>
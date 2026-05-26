<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %> 

 
 <script>
    
    function viewTempltPath(){
    	var newTemplateNcnm = $('#newTemplateNcnm').val();
    	
    	try{
    		$('#newModPath').html(newTemplateNcnm);
    	}catch(e){
    		console.log(e);
    	}
    	
    }
</script>
				<input type="hidden" id="tempalteStreCours" value="<c:out value="${tempalteStreCours }" />">
				
				<table class="basic">
					<tr>
						<th><spring:message code="wzwg.sysMngr.word.streCours" /></th>
						<td><c:out value="${tempalteStreCours }" /><span id="newModPath" style="margin: 0; padding: 0"></span></td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.sysMngr.word.tmplatNm02" /></th>
						<td><input type="text" id="newTemplateNm" placeholder="<c:out value="${templtVO.templateNm }" />" ></td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.sysMngr.word.tmplatNm02" />(<spring:message code="wzwg.cmm.word.eng" />)</th>
						<td><input type="text" id="newTemplateNcnm" placeholder="<c:out value="${templtVO.templateNcnm }" />" onkeyup="viewTempltPath();"><span>(<spring:message code="wzwg.cmm.msg.MSG282" />)</span></td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.sysMngr.word.tmplatComposition" />(<spring:message code="wzwg.cmm.word.dc" />)</th>
						<td><textarea id="newTemplateCntns" style="width:200px; height: 100px;"><c:out value="${templtVO.templateCntns }" escapeXml="false" /></textarea></td>
					</tr>
					<tr>
						<th></th>
						<td><a href="javascript:void(0);" class="wzbtn btn-save" onclick="newTemplateSave()"><spring:message code="wzwg.cmm.word.tostre" /></a></td>
					</tr>
				</table>				
				
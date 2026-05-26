<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	/* 말머리 수정 폼 */
	function fnSubospecModifyForm(subospecSeq, subospecSj, idx, val) {
		
		if(val == 'Y'){
			
			for(var i = 0; i < '<c:out value="${fn:length(subospecList)}" />'; i++){
				if($('#modifySubospecSj'+i).show()){
					$('#subospecSj'+i).show();
					$('#modifySubospecSj'+i).hide();
					$('#default_btn'+i).show();
					$('#modify_btn'+i).hide();
				}
			}
			
			$('#subospecSj'+idx).hide();
			$('#modifySubospecSj'+idx).show();
			$('#default_btn'+idx).hide();
			$('#modify_btn'+idx).show();
			
			var innerTag = "";
			innerTag += "<input type='text' id='inputSubospecSj"+idx+"' name='inputSubospecSj' value='"+subospecSj+"' class='w90' dir='required' title='<spring:message code="wzwg.cmm.word.ctgry02" />' />";
			
			$('#modifySubospecSj'+idx).text('');
			$('#modifySubospecSj'+idx).append(innerTag);
			
		}else{
			$('#modifySubospecSj'+idx).text('');
			
			$('#subospecSj'+idx).show();
			$('#modifySubospecSj'+idx).hide();
			$('#default_btn'+idx).show();
			$('#modify_btn'+idx).hide();
		}
		
	}
	
	/* 말머리 삭제 */
	function fnSubospecDelete(subospecSeq) {
		
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			
			document.getElementById('subospecSeq').value = subospecSeq;
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/deleteBbsSubospecAjax.do'
				, dataType : 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						//alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						fnDefaultList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		
		}
		
	}
	
	/* 수정 */
	function fnSubospecModify(subospecSeq, idx){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
			return;
		}else{

			$('#subospecSeq').val(subospecSeq);
			
			if($('#inputSubospecSj').val() == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
						'<spring:argument><spring:message code="wzwg.sysMngr.word.ctgry02Sj" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
					  '</spring:message>');
				return;
			}
			
			$('#subospecSj').val($('#inputSubospecSj'+idx).val());
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/modifyBbsSubospecAjax.do'
				, dataType : 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						//alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
						fnDefaultList();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		    	  
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		
		}
	}
	
	function fnDefaultList(){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/selectBbsSubospecListAjax.do'
			, dataType : 'html'
			, data : $("#regForm").serialize()
			, success : function (data) {
				$('#subospecList').html(data);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	
</script>

	<input type="hidden" id="subospecSeq" name="subospecSeq" />
	
	<table class="basic-table">
		<colgroup>
			<col width="70%" />
			<col width="30%" />
		</colgroup>
	 	<tbody>	

	<c:if test="${!empty subospecList}">
	
		<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
		
			<tr>
				<td class="txt-l">
					<span id="subospecSj<c:out value="${status.index}" />">
						<c:out value="${subospecList.subospecSj}" escapeXml="false" /> 
					</span>
					<span id="modifySubospecSj<c:out value="${status.index}" />" style="display:none;"></span>
				</td>
				<td>
					<span id="default_btn<c:out value="${status.index}" />">
						<a href="javascript:void(0);" onclick="fnSubospecModifyForm('<c:out value="${subospecList.subospecSeq}" />', '<c:out value="${subospecList.subospecSj}" />', '<c:out value="${status.index}" />', 'Y');" class="iconOnlyBtn btn-basic btn-modify"><spring:message code="wzwg.cmm.word.updt" /></a>
						<a href="javascript:void(0);" onclick="fnSubospecDelete('<c:out value="${subospecList.subospecSeq}" />');" class="iconOnlyBtn btn-basic btn-delete"><spring:message code="wzwg.cmm.word.delete" /></a>
					</span>
					
					<span id="modify_btn<c:out value="${status.index}" />" style="display:none;">
						<a href="javascript:void(0);" onclick="fnSubospecModify('<c:out value="${subospecList.subospecSeq}" />', '<c:out value="${status.index}" />');" class="iconOnlyBtnSameSize btn-save white"><spring:message code="wzwg.cmm.word.stre" /></a>
						<a href="javascript:void(0);" onclick="fnSubospecModifyForm('<c:out value="${subospecList.subospecSeq}" />', '<c:out value="${subospecList.subospecSj}" />', '<c:out value="${status.index}" />', 'N');" class="iconOnlyBtn btn-basic btn-delete"><spring:message code="wzwg.cmm.word.cancl" /></a>
					</span>
				</td>
			</tr>	

		</c:forEach>
		
		
		
	</c:if>
	
		</tbody>
	</table>
	
	
	
	
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


<script type="text/javascript">

	/* 말머리 수정 폼 */
	function fnSubospecModifyForm(subospecSeq, subospecSj, idx, val) {
		
		if(val == 'Y'){
			var dataSize = parseInt('<c:out value="${fn:length(subospecList)}"/>');
			for(var i = 0; i < dataSize; i++){
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/deleteBbsSubospecAjax.do'
				, dataType: 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
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
				 alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.module.word.ctgrysj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument></spring:message>');
				return;
			}
			
			$('#subospecSj').val($('#inputSubospecSj'+idx).val());
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/modifyBbsSubospecAjax.do'
				, dataType: 'xml'
				, data : $("#regForm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectBbsSubospecListAjax.do'
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
	
	<div class="categoryHashtag">
		<c:if test="${!empty subospecList}">
			<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
				<div class="categoryCo">
						<span id="subospecSj<c:out value='${status.index}'/>" class="cateTxt">
								<c:out value="${subospecList.subospecSj}" escapeXml="false" /> 
						</span>
						<span id="modifySubospecSj<c:out value='${status.index}'/>" style="display:none;" class="cateEdit"></span>
						<div class="categorySetBtn" id="default_btn<c:out value='${status.index}'/>">
							<a href="javascript:void(0);" onclick="fnSubospecModifyForm('<c:out value="${subospecList.subospecSeq}"/>', '<c:out value="${subospecList.subospecSj}"/>', '<c:out value="${status.index}"/>', 'Y');" class="iconbtn_edit" title="<spring:message code="wzwg.cmm.word.updt" />"><span><spring:message code="wzwg.cmm.word.updt" /></span></a>
							<a href="javascript:void(0);" onclick="fnSubospecDelete('<c:out value="${subospecList.subospecSeq}"/>');" class="iconbtn_del" title="<spring:message code="wzwg.cmm.word.delete" text="delete" />"><span><spring:message code="wzwg.cmm.word.delete" text="delete" /></span></a>
						</div>
						
						<div class="categorySetBtn modify" id="modify_btn<c:out value='${status.index}'/>" style="display:none;">
							<a href="javascript:void(0);" onclick="fnSubospecModify('<c:out value="${subospecList.subospecSeq}"/>', '<c:out value="${status.index}"/>');" class="iconbtn_save"><span><spring:message code="wzwg.cmm.word.stre" text="save" /></span></a>
							<a href="javascript:void(0);" onclick="fnSubospecModifyForm('<c:out value="${subospecList.subospecSeq}"/>', '<c:out value="${subospecList.subospecSj}"/>', '<c:out value="${status.index}"/>', 'N');" class="iconbtn_del" title="<spring:message code="wzwg.cmm.word.cancl" text="cancle" />"><span><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></span></a>
						</div>
				</div>
			</c:forEach>
		</c:if>
	</div>
	
	
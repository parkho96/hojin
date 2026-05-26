<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${sessionScope.SADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<script type="text/javascript">

	$(document).ready(function(){

		fnChangeSubospecList('<c:out value="${resultVO.bbsSeq}" />');
		
		<c:if test="${adminAuthAt eq 'Y'}">
		if('<c:out value="${resultVO.noticeAt}" />' == 'Y'){
			$("input[name=noticeAt]").prop("checked", true);
		}
		</c:if>
		
		if('<c:out value="${resultVO.answerPermAt}" />' == 'Y'){
			$("input[name=answerPermAt]").prop("checked", true);
		}
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.replyFrm;
				
				<c:if test="${adminAuthAt eq 'Y'}">
				// 게시판 공지 여부
				frm.noticeAt.value 		= $("input[name=noticeAt]").is(":checked") == true ? "Y" : "N";
				</c:if>

				// 댓글 허용 여부
				frm.answerPermAt.value 	= $("input[name=answerPermAt]").is(":checked") == true ? "Y" : "N";
				
				if(frm.nttSj.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				}
				
				if('<c:out value="${editorEstbsSe}" />' == 'S'){
					frm.nttCn.value = oEditors.getById["nttCn"].getIR();	
					
					if(frm.nttCn.value == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.cn" text="contents" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
						      '</spring:message>');
						oEditors.getById["nttCn"].exec("FOCUS",[]);
						return;				
					}
				}

				if('<c:out value="${editorEstbsSe}" />' == 'C'){
					if(!bEditor_nttCn.IsDirty()){ // 크로스에디터 안의 컨텐츠 입력 확인 
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.cn" text="contents" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
						      '</spring:message>');
						bEditor_nttCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
						return false; 
					}
					
					frm.nttCn.value = bEditor_nttCn.GetBodyValue("nttCn");
				}
				
				frm.bbsSeq.value = frm.searchBbsSeq.value;
				
				var formData = new FormData(frm);
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/registNttInfoAjax.do'
					, mimeType: 'multipart/form-data'
					, cache : false
					, async : false
					, processData: false
					, contentType: false
					, data : formData
					, success : function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							fnNttView(value);
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						} 
				
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});
			}
			
		});
		
		// 취소
		$('#cancle_btn').click(function(){
			
			$('#subospecSeq').val("");
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttDetailAjax.do'
				, dataType : 'html'
				, data : $("#replyFrm").serialize()
				, success : function (data) {
					$('#bbs_area').html(data);
					$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		});
		
		// 말머리 추가
		$('#subospec_add_btn').click(function(){
			
			fnTabLink('bassInfo'); 
		});
		
	});
	
	// 상세화면으로 이동
	function fnNttView(nttSeq){
		
		var frm = document.replyFrm;
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/selectNttDetailAjax.do'
			, dataType : 'html'
			, data : $("#replyFrm").serialize()
			, success : function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
		     	$(window).scrollTop(0);
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	/* 게시판 변경 - 말머리 목록 */
	function fnChangeSubospecList(val){
		
		var frm = document.replyFrm;
		
		frm.searchBbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/module/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do'
			, cache : false
			, async : false
			, data : $("#replyFrm").serialize()
			, success : function(xml, status, request) {
				
				$("#subospecSeq").find("option").remove().end().append("option value=\"\"><spring:message code='wzwg.sysMngr.word.ctgry02Choise' /></option>");
				$("#subospecSeq").append("<option value=\"\"><spring:message code='wzwg.sysMngr.word.ctgry02Choise' /></option>");
				$(xml).find("item").each(function(){
					var subospecSeq = $(this).find('name').text();
					var subospecSj = $(this).find('value').text();
					if(subospecSeq == '<c:out value="${resultVO.subospecSeq}" />'){
						$("#subospecSeq").append("<option value=\"" +subospecSeq+ "\" selected >" + subospecSj + "</option>");						
					}else{
						$("#subospecSeq").append("<option value=\"" +subospecSeq+ "\">" + subospecSj + "</option>");
					}
				});
				
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	}
	
	/* 게시판 말머리 변경 */
	function fnChangeSubospec(val){
		var frm = document.replyFrm;
		
		frm.bbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/unity/registNttFormAjax.do'
			, cache : false
			, async : false
			, data:$("#replyFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				
				fnChangeSubospecList(val);
				
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}

	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	$('#cancle_btn').click();
	    	return false;
		}
	}	
	
</script>

		<form:form modelAttribute="resultVO" path="replyFrm" id="replyFrm" name="replyFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="parntsNttSeq" value="${fn:escapeXml(resultVO.nttSeq)}" />
			<form:hidden path="menuSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="sysMngrAt" name="sysMngrAt" value="<c:out value="${paramVO.sysMngrAt}" />"/>
		
			<table class="basic">
					<colgroup>
						<col width="20%" />
						<col width="80%" />
					</colgroup>
				  <tbody>
					<tr>
						<th><spring:message code="wzwg.cmm.word.ctgry02" /></th>
						<td colspan="3">
							<form:select path="subospecSeq" id="subospecSeq" cssClass="w30">
								<form:option value=""><label for="ctgry01"><spring:message code="wzwg.sysMngr.word.ctgry02Choise" /></label></form:option>
							</form:select>		
							<!-- 관리자 기능 -->
							<c:if test="${paramVO.sysMngrAt eq 'Y'}">
								<a href="javascript:void(0);" id="subospec_add_btn" class="btn-c"><spring:message code='wzwg.sysMngr.word.ctgry02Add' /></a>	
							</c:if>		
						</td>
					</tr>
					<tr>
						<th>* <spring:message code="wzwg.cmm.word.sj" /></th>
						<td colspan="3">
							<form:input path="nttSj" id="nttSj" cssClass="w70" dir="required" />
						</td>
					</tr>
					<!-- 관리자 기능 -->
					<c:if test="${adminAuthAt eq 'Y'}">
					<tr>
						<th><spring:message code='wzwg.sysMngr.word.postsEstbs' /></th>
						<td colspan="3">
							<ul>
								<li>
									<form:checkbox path="noticeAt" name="noticeAt" value="N" dir="required" /><spring:message code="wzwg.sysMngr.word.bbsNotice01" />
								</li>
							</ul>
						</td>
					</tr>
					</c:if>
					<tr>
						<th><spring:message code='wzwg.sysMngr.word.fileAtch' /></th>
						<td colspan="3">
							<c:import url="${wzwg_contextPath}/opnsu/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="0" />
								<c:param name="param_updateFlag" value="N" />
							</c:import>			
						</td>
					</tr>
					<tr>
						<th>* <spring:message code="wzwg.cmm.word.cn" /></th>
						<td colspan="3">
							<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;display:none;"><c:out value="${resultVO.nttCn}" escapeXml="false" /></textarea>
							
							<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
								<c:param name="param_editorNm" 	value="nttCn" />
								<c:param name="param_editorTy" 	value="custom" />
							</c:import>
						</td>
					</tr>
					<tr>
						<th><spring:message code='wzwg.sysMngr.word.skillEstbs' /></th>
						<td colspan="3">
							<li>
								<form:checkbox path="answerPermAt" name="answerPermAt" value="N" dir="required" />
							</li>
						</td>
					</tr>
			
				  </tbody>
			</table>
			<div class="rt-box">
				<a href="javascript:void(0);" id="cancle_btn" class="btn-b fl"><spring:message code="wzwg.cmm.word.cancl" /></a>
				<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
			</div>		
					
		</form:form>

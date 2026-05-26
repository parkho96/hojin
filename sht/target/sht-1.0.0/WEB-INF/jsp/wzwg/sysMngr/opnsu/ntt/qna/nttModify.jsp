<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${sessionScope.SADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>	

<style type="text/css">

.attatch_file_box { position:relative; display:inline-block; padding:0 !important; height:29px; }
.attatch_file_box .file_route { width:400px; }
.attatch_file_box span.button { display:inline-block; width:100px; height:29px; padding:5px 15px; background:#E1E1E1; color:#242424; text-align:center; line-height:19px; border:0; box-sizing:border-box; vertical-align:middle; }
.attatch_file_box .attatchfile { position:absolute; top:0; right:0; width:100%; font-size:45px; opacity:0; filter:alpha(opacity=0); cursor:pointer; }

</style>

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
		
		
		// 수정
		$('#modify_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.getElementById("modifyFrm");
				
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
					, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/modifyNttInfoAjax.do'
					//, mimeType: 'multipart/form-data'
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
							fnNttView();
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttListAjax.do'
				, dataType : 'html'
				, data : $("#modifyFrm").serialize()
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
			/* var frm = document.getElementById("modifyFrm");

			frm.action = "<c:out value="${prefix}"/>/opnsu/bbs/qna/selectBbsInc.do";
			frm.submit(); */
		});
		
	});
	
	// 상세화면으로 이동
	function fnNttView(){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/ntt/qna/selectNttDetailAjax.do'
			, dataType : 'html'
			, data : $("#modifyFrm").serialize()
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
		
		var frm = document.getElementById("modifyFrm");
		
		frm.searchBbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
			, url : '<c:out value="${wzwg_contextPath}${prefix}" />/opnsu/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do'
			, cache : false
			, async : false
			, data : $("#modifyFrm").serialize()
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
	
	// 태그 특수문자 제한
	function fnTagChk(){
		var RegExp = /[ \{\}\[\]\/?.;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=\s]/gi;
		var inputVal = $('#tagArr').val();
		$('#tagArr').val(inputVal.replace(RegExp, ''));
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

		<form:form modelAttribute="resultVO" path="modifyFrm" id="modifyFrm" name="modifyFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<form:hidden path="menuSeq" value="${fn:escapeXml(paramVO.menuSeq)}" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="sysMngrAt" name="sysMngrAt" value="<c:out value="${paramVO.sysMngrAt}" />"/>
			<input type="hidden" id="noticeAt" name="noticeAt" value="N" />
			<input type="hidden" id="answerPermAt" name="answerPermAt" value="N" />
			
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
							<%-- <c:if test="${paramVO.sysMngrAt eq 'Y'}">
								<a href="javascript:void(0);" id="subospec_add_btn" class="btn-c"><spring:message code='wzwg.cmm.word.ctgry02' /> <spring:message code='wzwg.cmm.word.add' /></a>	
							</c:if> --%>		
						</td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.cmm.word.sj" /></th>
						<td colspan="3">
							<c:set var="msg_title_txt01"> 
								 <spring:message code="wzwg.module.word.nttsj" /> 
							</c:set>
							<form:input path="nttSj" id="nttSj" cssClass="w70" dir="required" title="${fn:escapeXml(msg_title_txt01)}" />
						</td>
					</tr>
					<!-- 관리자 기능 -->
					<!-- 
					<c:if test="${adminAuthAt eq 'Y'}">
					<tr>
						<th><spring:message code='wzwg.cmm.word.posts' /> <spring:message code='wzwg.cmm.word.estbs' /></th>
						<td colspan="3">
							<ul>
								<li>
									<form:checkbox path="noticeAt" name="noticeAt" value="N" dir="required" title="FAQ 등록" />FAQ 등록
								</li>
							</ul>
						</td>
					</tr>
					</c:if>
					 -->
					<c:if test="${resultVO.atchFileCnt ne '0'}">
					<tr>
						<th><spring:message code='wzwg.sysMngr.word.fileAtch' /></th>
						<td colspan="3">
							<c:import url="${wzwg_contextPath}/opnsu/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${resultVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="Y" />
							</c:import>			
						</td>
					</tr>
					</c:if>
					<c:if test="${resultVO.atchFileCnt eq '0'}">
					<tr>
						<th><spring:message code='wzwg.sysMngr.word.fileAtch' /></th>
						<td colspan="3">
							<c:import url="${wzwg_contextPath}/opnsu/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${resultVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="N" />
							</c:import>			
						</td>
					</tr>
					</c:if>	
					<tr>
						<th><spring:message code="wzwg.cmm.word.cn" /></th>
						<td colspan="3">
							<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;display:none;"><c:out value="${resultVO.nttCn}" escapeXml="false"/></textarea>
							
							<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
								<c:param name="param_editorNm" 	value="nttCn" />
								<c:param name="param_editorTy" 	value="custom" />
							</c:import>
						</td>
					</tr>
					<!-- 
					<tr>
						<th><spring:message code='wzwg.cmm.word.skll' /> <spring:message code='wzwg.cmm.word.estbs' /></th>
						<td colspan="3">
							<form:checkbox path="answerPermAt" name="answerPermAt" value="N" dir="required" />
						</td>
					</tr>
					 -->
				  </tbody>
			</table>
			<div class="rt-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del fl"><spring:message code="wzwg.cmm.word.cancl" /></a>
				<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>			
			</div>
					
		</form:form>		
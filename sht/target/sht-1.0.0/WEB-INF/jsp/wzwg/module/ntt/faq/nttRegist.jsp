<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script src="/jquery/js/jquery.form.min.js"></script>

<c:set var="adminAuthAt" value="N"/>

<c:if test="${paramVO.cmntUseAt eq 'Y'}">
	<c:if test="${sessionScope.cmntMngrAt == true}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
</c:if>	

<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postwritng" />');
		
		fnChangeSubospecList('<c:out value="${paramVO.bbsSeq}"/>');
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
								
				var frm = document.getElementById("regFrm");
				
				if(frm.nttSj.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				}
				
				if('<c:out value="${editorEstbsSe}"/>' == 'S'){
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

				if('<c:out value="${editorEstbsSe}"/>' == 'C'){
					if(bEditor_nttCn.GetBodyElementsByTagName("img").length == 0 && bEditor_nttCn.GetTextValue().replace("<p>", "").replace("</p>", "") == ""){ // 크로스에디터 안의 컨텐츠 입력 확인 
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.cn" text="contents" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
						      '</spring:message>');
						bEditor_nttCn.SetFocusEditor(); // 크로스에디터 Focus 이동 
						return false; 
					}
					
					frm.nttCn.value = bEditor_nttCn.GetBodyValue("nttCn");
				}

				frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
				
				frm.bbsSeq.value = frm.searchBbsSeq.value;
				
				//var formData = new FormData(frm);

				$("#regFrm").ajaxSubmit({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/registNttInfoAjax.do'
					, cache : false
					, async : false
					, mimeType: 'multipart/form-data'
					, processData: false
					, contentType: false
					, success : function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							
							$("#subospecSeq").val("");
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttListAjax.do'
								, dataType : 'html'
								, data : $("#regFrm").serialize()
								, success : function (data) {
									$('#bbs_area').html(data);
									$("#content").css("height",$(document).height());
							     	$(window).scrollTop(0);
								}
								, error : function (request, status, error) {
									alert('<spring:message code="fail.common.msg" text="error" />');
								}
							});

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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/selectNttListAjax.do'
				, dataType : 'html'
				, data : $("#regFrm").serialize()
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
		
	});
	
	/* 게시판 변경 - 말머리 목록 */
	function fnChangeSubospecList(val){
		
		var frm = document.getElementById("regFrm");

		frm.searchBbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do'
			, cache : false
			, async : false
			, data : $("#regFrm").serialize()
			, success : function(xml, status, request) {
				
				//$("#subospecSeq").find("option").remove().end().append("option value=\"\"><spring:message code='wzwg.cmm.word.ctgry02' /> <spring:message code='wzwg.cmm.word.choise' /></option>");
				//$("#subospecSeq").append("<option value=\"\"><spring:message code='wzwg.cmm.word.ctgry02' /> <spring:message code='wzwg.cmm.word.choise' /></option>");
				$(xml).find("item").each(function(){
					var subospecSeq = $(this).find('name').text();
					var subospecSj = $(this).find('value').text();
					$("#subospecSeq").append("<option value=\"" +subospecSeq+ "\">" + subospecSj + "</option>");
				});
				
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	}
	
	/* 게시판 말머리 변경 */
	function fnChangeSubospec(val){
		var frm = document.getElementById("regFrm");
		
		frm.bbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/faq/registNttFormAjax.do'
			, cache : false
			, async : false
			, data:$("#regFrm").serialize()
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
	
	function fnFileUploader(){
		$('#regist_btn').click();
	}

</script>

		<form:form modelAttribute="paramVO" path="regFrm" id="regFrm" name="regFrm" method="post" enctype="multipart/form-data">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<input type="hidden" id="nttSeq" name="nttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" name="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>"/>
			<form:hidden path="cmntUseAt" />
			<form:hidden path="atchFilePosblAt" />
			
			<c:set var="ctgryTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
			<c:set var="qestnTit"><spring:message code="wzwg.cmm.word.qestn" /></c:set>
			
			<div class="register-box">
				<div class="subject">
					<table>
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postwritng" /></caption>
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
					</colgroup>
					<thead>
					</thead>
					<tbody>				
						<c:if test="${paramVO.cmntUseAt ne 'Y'}">	
						<c:if test="${paramVO.subospecSeq ne null}">
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ctgry02" />
							</th>
							<td>
								<form:select path="subospecSeq" id="subospecSeq" cssClass="headId" title="${fn:escapeXml(ctgryTit)}">
								    <form:option value=""><spring:message code="wzwg.module.word.ctgrychoise" /></form:option>
								</form:select>	
								<!-- 관리자 기능 -->
<%-- 								<c:if test="${paramVO.mngrAt eq 'Y'}">
									<a href="javascript:void(0);" id="subospec_add_btn"  class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.ctgryadd" /></a>	
								</c:if>						 --%>
							</td>
						</tr>
						</c:if>
						</c:if>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.qestn" />
							</th>
							<td colspan="3" style="padding-right:5px;">
								<form:input path="nttSj" id="nttSj" style="width:100%;" dir="required" title="${fn:escapeXml(qestnTit)}" />
							</td>
						</tr>
						<c:if test="${paramVO.atchFilePosblAt eq 'Y'}">
						<tr>
							<th scope="row" class="subTit">
								<spring:message code='wzwg.module.word.fileatch' />
							</th>
							<td colspan="4">
								<c:if test="${fileEstbsSe eq 'B'}">
									<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
										<c:param name="param_updateFlag" 		value="N" />
										<c:param name="param_atchFileNumber" 	value="${paramVO.atchFilePosblCo}" />
										<c:param name="param_sitecntntsSeq" 	value="${paramVO.sitecntntsSeq}" />
										<c:param name="param_cntntsSeq" 		value="${paramVO.bbsSeq}" />
									</c:import>
								</c:if>
								
								<c:if test="${fileEstbsSe eq 'C'}">
									<c:import url="${wzwg_contextPath}/module/upload/crossuploader/uploadForm.do" charEncoding="utf-8">
										<c:param name="param_atchFileNumber" 	value="${paramVO.atchFilePosblCo}" />
										<c:param name="param_sitecntntsSeq" 	value="${paramVO.sitecntntsSeq}" />
										<c:param name="param_cntntsSeq" 		value="${paramVO.bbsSeq}" />
									</c:import>
								</c:if>
							</td>
						</tr>
						</c:if>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.answer01" />
							</th>
							<td colspan="4">
								<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;display:none;" title="<spring:message code="wzwg.module.word.postwritng" />"><c:out value="${paramVO.nttCn}"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
								
								<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttCn" />
									<c:param name="param_editorTy" 	value="custom" />
								</c:import>
							</td>
						</tr>
						<tr>
							<td colspan="5" style="text-align:center !important;letter-spacing:-1px;"><spring:message code="wzwg.cmm.msg.MSG006" /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
				
				<c:if test="${paramVO.atchFilePosblAt eq 'Y'}">
					<c:if test="${fileEstbsSe eq 'B'}">
						<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
					</c:if>
					
					<c:if test="${fileEstbsSe eq 'C'}">
						<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save" style="display:none;"><spring:message code="wzwg.cmm.word.stre" /></a>
						<a href="javascript:void(0);" class="wzbtn btn-save" onclick="fnFileUploader();"><spring:message code="wzwg.cmm.word.stre" /></a>
					</c:if>
				</c:if>
				
				<c:if test="${paramVO.atchFilePosblAt ne 'Y'}">
					<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
				
			</div>		
					
		</form:form> 


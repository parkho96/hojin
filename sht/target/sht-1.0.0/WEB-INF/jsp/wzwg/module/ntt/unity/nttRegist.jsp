<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

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
if($(location).attr('href').indexOf('/cmnt') > -1) {
	if(cmntNm && cmntMenuNm) {
		try{document.title = cmntNm+'-'+cmntMenuNm+'-<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}	
	}else {
		try{document.title = '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}
	}
}else {
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}
}


	$(document).ready(function(){
		
		if($("input[name=secretAt]").is(":checked")){
			$("input[name=secretAt]").attr('checked', false);
		}
		
 		if('<c:out value="${tmprnttListCnt}"/>' > 0){
 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value='${tmprnttListCnt}'/>)</span></a>");
 			$('#tmprntt_area').show();
 		}
		
		fnChangeSubospecList('<c:out value="${paramVO.bbsSeq}"/>');
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
								
				var frm = document.getElementById("regFrm");
				
				<c:if test="${adminAuthAt eq 'Y'}">
				// 게시판 공지 여부
				frm.noticeAt.value 		= $("input[name=noticeAt]").is(":checked") == true ? "Y" : "N";
				</c:if>
				
				// 비밀글 여부
				frm.secretAt.value 		= $("input[name=secretAt]").is(":checked") == true ? "Y" : "N";
				// 익명글 여부
				frm.annymtyAt.value 	= $("input[name=annymtyAt]").is(":checked") == true ? "Y" : "N";
				// 댓글 허용 여부
				frm.answerPermAt.value 	= $("input[name=answerPermAt]").is(":checked") == true ? "Y" : "N";
				
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
				
				var formData = new FormData(frm);

				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/registNttInfoAjax.do'
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
							
							if('<c:out value="${paramVO.listScrinCode}"/>' == 'B'){
								
								$("#subospecSeq").val("");
								
								$.ajax({
							        type : 'POST'
									, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
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
								fnNttView(value);
							}

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
		
		// 게시글 임시저장
 		$('#tmpr_regist_btn').click(function(){
				
 			var frm = document.getElementById("regFrm");
			
 			<c:if test="${adminAuthAt eq 'Y'}">
 			// 게시판 공지 여부
 			frm.noticeAt.value 		= $("input[name=noticeAt]").is(":checked") == true ? "Y" : "N";
 			</c:if>
			
 			// 비밀글 여부
 			frm.secretAt.value 		= $("input[name=secretAt]").is(":checked") == true ? "Y" : "N";
 			// 익명글 여부
 			frm.annymtyAt.value 	= $("input[name=annymtyAt]").is(":checked") == true ? "Y" : "N";
 			// 댓글 허용 여부
 			frm.answerPermAt.value 	= $("input[name=answerPermAt]").is(":checked") == true ? "Y" : "N";
			
 			if('<c:out value="${editorEstbsSe}"/>' == 'S'){
				frm.nttCn.value = oEditors.getById["nttCn"].getIR();		
			}
			if('<c:out value="${editorEstbsSe}"/>' == 'C'){
				frm.nttCn.value = bEditor_nttCn.GetBodyValue("nttCn");
			}
			
 			$.ajax({
 		        type : 'POST'
 				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/registTmprnttInfoAjax.do'
 				, dataType: 'xml'
 				, data : $("#regFrm").serialize()
 				, success : function (result) {
		    	  
 		    	  	var value = "";
					
 					$(result).find("value").each(function() {  
 						value = $(this).text();  
 					});
					 					
 					if(value != 'fail'){
 						$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' id='btn_temprntt' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>("+value+")</span></a>");
 						$('#tmprntt_area').show();
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG023"><spring:argument><spring:message code="wzwg.module.word.tmprposts" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
 					}else{
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
 					}
		    	  
 				}
 				, error : function (request, status, error) {
 					alert('<spring:message code="fail.common.msg" text="error" />');
 				}
 			});
			
 		});
		
		// 취소
		$('#cancle_btn').click(function(){
			
			$('#subospecSeq').val("");
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttListAjax.do'
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
		
		// 말머리 추가
		$('#subospec_add_btn').click(function(){
			
			var frm = document.getElementById("regFrm");
			
			frm.cntntsSeq.value = frm.bbsSeq.value;
			
			frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/unity/selectBbsInc.do";
			frm.submit();
		});
		
		
	});
	
	// 상세화면으로 이동
	function fnNttView(nttSeq){
		
		var frm = document.getElementById("regFrm");
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttDetailAjax.do'
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
	}
	
	// 임시저장 글 목록 (팝업)
	function fnTmprPop(btn){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#regFrm").serialize()
	      , success:function (data) {
	    	  //$("#bbs_layer").show();
	    	  //$("#bbs_layer").html(data);
	    	  var title = '<spring:message code="wzwg.module.word.temsveptlist" />';
	    	  wzAjaxModal('popup_s', title, data, true, btn);
	      }
	      , error:function (request, status, error) {
	    	  alert('<spring:message code="fail.common.msg" text="error" />');
	      }
	      , dataType: 'html'
	 	});
	}
	
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/registNttFormAjax.do'
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
	
	// 태그 특수문자 제한
	function fnTagChk(){
		
		var inputVal = $('#tagArr').val();
		
		var count = (inputVal.match(/,/g) || []).length;
		
		if(count > 9){
			alert('<spring:message code="wzwg.cmm.msg.MSG317" />');
			
			var strArr = inputVal.split(",");
			$('#tagArr').val(strArr.slice(0, 10));
			return;
		}
	
		var RegExp = /[ \{\}\[\]\/?.;:|\)*~`!^\-_+┼<>@\#$%&\'\"\\\(\=\s]/gi;
		$('#tagArr').val(inputVal.replace(RegExp, ''));
	}
	
	// 나의 태그 선택
	function fnTagInput(tagNm){
		
		var inputVal = document.getElementById('tagArr');
		
		var strArr = inputVal.value.split(",");
		
		for(var i = 0; i < strArr.length; i++){
			if(strArr[i] == tagNm){
				alert('<spring:message code="wzwg.cmm.msg.MSG318" />');
				return;
			}
		}
		
		if(inputVal.value != ''){
			
			if(inputVal.value.substring(inputVal.value.length - 1, inputVal.value.length) != ','){
				inputVal.value += ",";
			}
			
			var count = (inputVal.value.match(/,/g) || []).length;
		
			if(count > 9){
				alert('<spring:message code="wzwg.cmm.msg.MSG317" />');
				$('#tagArr').val(inputVal.value.substring(0, inputVal.value.length - 1));
				return;
			}else{
				inputVal.value += tagNm;
			}
			
		}else{
			inputVal.value = tagNm;
		}
		
	}
	
	function fnFileUploader(){
		$('#regist_btn').click();
	}
	
	
	$('input[type="text"]').keydown(function() {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});

</script>

		<form:form modelAttribute="paramVO" path="regFrm" id="regFrm" name="regFrm" method="post" enctype="multipart/form-data">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<input type="hidden" id="nttSeq" name="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="tmpTag" name="tmpTag" />
			<input type="hidden" name="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>"/>
			<form:hidden path="cmntUseAt" />
			
			<c:set var="ctgryTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
			<c:set var="nttSjTit"><spring:message code="wzwg.module.word.nttsj" /></c:set>
			<c:set var="notiChekTit"><spring:message code="wzwg.module.word.noticececk" /></c:set>
			<c:set var="secretPostTit"><spring:message code="wzwg.module.word.secretpostsceck" /></c:set>
			<c:set var="annymtyPostTit"><spring:message code="wzwg.module.word.annymtypostsceck" /></c:set>
			<c:set var="answerPermTit"><spring:message code="wzwg.module.word.answerpermceck" /></c:set>
						
			<div class="register-box">
				<div class="subject">
					<table>
					<caption><spring:message code="wzwg.module.word.postregist" /></caption>
					<colgroup>
						<col width="10%"/>
						<col width="15%"/>
						<col width="13%"/>
						<col width="*"/>
						<col width="20%"/>
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
							<td colspan="4">
								
								<form:select path="subospecSeq" id="subospecSeq" cssClass="headId" title="${fn:escapeXml(ctgryTit)}">
									<form:option value=""><label for="ctgry01"><spring:message code="wzwg.module.word.ctgrychoise" /></label></form:option>
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
								<spring:message code="wzwg.cmm.word.sj" />
							</th>
							<td colspan="3" style="padding-right:5px;">
								<form:input path="nttSj" id="nttSj" style="width:100%;" dir="required" title="${fn:escapeXml(nttSjTit)}" />
							</td>
							<td>
								<span id="tmprntt_area" style="display:none;"></span>
							</td>							
						</tr>
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.postsestbs" /></th>
							<td colspan="4">
								<!-- 관리자 기능 -->
								<ul class="setlist">
									<c:if test="${adminAuthAt eq 'Y'}">							
									<li><label><form:checkbox path="noticeAt" name="noticeAt" value="Y" dir="required" title="${fn:escapeXml(notiChekTit)}"/> <span><spring:message code="wzwg.module.word.bbsnotice" /></span></label></li>
									</c:if>
									<li><label><form:checkbox path="secretAt" name="secretAt" value="Y" dir="required" title="${fn:escapeXml(secretPostTit)}" /> <span><spring:message code="wzwg.module.word.secretposts" /></span></label></li>
									<li><label><form:checkbox path="annymtyAt" name="annymtyAt" value="Y" dir="required" title="${fn:escapeXml(annymtyPostTit)}" /> <span><spring:message code="wzwg.module.word.annymtyposts" /></span></label></li>
								</ul>
							</td>							
						</tr>
						<c:if test="${paramVO.atchFilePosblAt eq 'Y'}">
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.fileatch" />
							</th>
							<td colspan="4">
								<c:if test="${paramVO.listScrinCode eq 'I'}" >
									<p class="mb5"><span class="circle_no bg-green-strong">i</span> <spring:message code='wzwg.cmm.msg.MSG415' /></p>
								</c:if>
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
							<td colspan="5">
								<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;display:none;"><c:out value="${paramVO.nttCn}"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
								
								<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttCn" />
									<c:param name="param_editorTy" 	value="custom" />
								</c:import>
							</td>
						</tr>
						<%-- <tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.tag01" /></th>
							<td class="ta_l" colspan="4">
								<input type="text" name="tagArr" id="tagArr" placeholder="<spring:message code="wzwg.cmm.msg.MSG013" />" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.tag01" />" onkeyup="fnTagChk();" />
								<a href="javascript:void(0);" onclick="$('.tagListDiv').toggle();"><img class="vtc2" src="/images/wzwg/module/ntt/mybtn.png" alt="<spring:message code="wzwg.cmm.word.my" /> <spring:message code="wzwg.cmm.word.tag" /> <spring:message code="wzwg.cmm.word.view" />" /></a></a>
								<div class="tagListDiv" style="display:none;">
									<c:if test="${empty myTagList}">
										<p><spring:message code="wzwg.cmm.msg.MSG316" /></p>
									</c:if>
									
									<c:if test="${!empty myTagList}">
									<c:forEach var="tagList" items="${myTagList}" varStatus="status">
										<span><a href="javascript:void(0);" onclick="fnTagInput('${tagList.tagNm}');">${tagList.tagNm}</a></span>
									</c:forEach>
									</c:if>
								</div>
							</td>
						</tr> --%>
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.skllestbs" /></th>
							<td colspan="4">
								<ul class="setlist">
									<li><label><form:checkbox path="answerPermAt" name="answerPermAt" value="N" dir="required" title="${fn:escapeXml(answerPermTit)}"/> <span><spring:message code="wzwg.module.word.answerperm" /></span></label></li>
								</ul>
							</td>
						</tr>						 
						<tr>
							<td colspan="5" class="txt-c" style="letter-spacing:-1px;"><spring:message code="wzwg.cmm.msg.MSG006" /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
 				<a href="javascript:void(0);" id="tmpr_regist_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a>
				
				<c:if test="${fileEstbsSe eq 'B'}">
					<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
				
				<c:if test="${fileEstbsSe eq 'C'}">
					<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save" style="display:none;"><spring:message code="wzwg.cmm.word.stre" /></a>
					<a href="javascript:void(0);" class="wzbtn btn-save" onclick="onStartUpload();"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
				
			</div>		
					
		</form:form> 


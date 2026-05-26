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
		try{document.title = cmntNm+'-'+cmntMenuNm+'-<spring:message code="wzwg.cmm.word.updt" />';}catch(e){console.log(e.message);}	
	}else {
		try{document.title = '<spring:message code="wzwg.cmm.word.updt" />';}catch(e){console.log(e.message);}
	}
}else {
	try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.updt" />';}catch(e){console.log(e.message);}
}


	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postupdt" />');
		
 		if('<c:out value="${tmprnttListCnt}"/>' > 0){
 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value='${tmprnttListCnt}'/>)</span></a>");
 			$('#tmprntt_area').show();
 		}
		
		fnChangeSubospecList('<c:out value="${resultVO.bbsSeq}"/>');
		
		<c:if test="${adminAuthAt eq 'Y'}">
		if('<c:out value="${resultVO.noticeAt}"/>' == 'Y'){
			$("input[name=noticeAt]").prop("checked", true);
		}
		</c:if>
		
		if('<c:out value="${resultVO.secretAt}"/>' == 'Y'){
			$("input[name=secretAt]").prop("checked", true);
		}
		
		if('<c:out value="${resultVO.annymtyAt}"/>' == 'Y'){
			$("input[name=annymtyAt]").prop("checked", true);
		}
		
		if('<c:out value="${resultVO.answerPermAt}"/>' == 'Y'){
			$("input[name=answerPermAt]").prop("checked", true);
		}
		
		if('<c:out value="${fn:length(tagList)}"/>' > 0){
			var tagList = "";	
			
			<c:forEach var="result" items="${tagList}" varStatus="status">
				tagList += '<c:out value="${result.tagNm}"/>' + '<c:if test="${!status.last}">,</c:if>';
			</c:forEach>
			
			$('#tagNm').val(tagList);
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

				frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
				
				frm.bbsSeq.value = frm.searchBbsSeq.value;
				
				var formData = new FormData(frm);
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/modifyNttInfoAjax.do'
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
						
						if(value == 'success'){
							if('<c:out value="${resultVO.listScrinCode}"/>' == 'B'){
								
								$("#subospecSeq").val("");
								
								$.ajax({
							        type : 'POST'
									, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do'
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
							}else{
								fnNttView();
							}
							
						}else if(value == 'authFail'){
							alert('<spring:message code="wzwg.cmm.msg.MSG084"></spring:message>');
							if($('#menuSeq').length == 1){
								location.replace('/subList/' + $('#menuSeq').val());
							}else{
								location.replace('/<c:out value="${wzwg_contextPath}${prefix}"/>');
							}
							
						}else if(value == 'fail'){
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
				
			var frm = document.getElementById("modifyFrm");
			
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
				, data : $("#modifyFrm").serialize()
				, success : function (result) {
		    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>("+value+")</span></a>");
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
			
			var returnUrl;
			
			if('<c:out value="${resultVO.listScrinCode}"/>' == 'B'){
				returnUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttListAjax.do';
			}else{
				returnUrl = '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttDetailAjax.do';
			}
			
			$('#subospecSeq').val("");
			
			$.ajax({
		        type : 'POST'
				, url : returnUrl
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
			
			var frm = document.getElementById("modifyFrm");
			
			frm.cntntsSeq.value = frm.bbsSeq.value;
			
			frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/image/selectBbsInc.do";
			frm.submit();
		});
		
	});
	
	// 상세화면으로 이동
	function fnNttView(){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/selectNttDetailAjax.do'
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
	
	// 임시저장 글 목록 (팝업)
	function fnTmprPop(btn){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#modifyFrm").serialize()
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
		
		var frm = document.getElementById("modifyFrm");
		
		frm.searchBbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do'
			, cache : false
			, async : false
			, data : $("#modifyFrm").serialize()
			, success : function(xml, status, request) {
				
				//$("#subospecSeq").find("option").remove().end().append("option value=\"\"><spring:message code='wzwg.cmm.word.ctgry02' /> <spring:message code='wzwg.cmm.word.choise' /></option>");
				//$("#subospecSeq").append("<option value=\"\"><spring:message code='wzwg.cmm.word.ctgry02' /> <spring:message code='wzwg.cmm.word.choise' /></option>");
				if($(xml).find("item").length == 0){
					$('#subospecTr').remove();
				}
				
				$(xml).find("item").each(function(){
					var subospecSeq = $(this).find('name').text();
					var subospecSj = $(this).find('value').text();
					if(subospecSeq == '<c:out value="${resultVO.subospecSeq}"/>'){
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
		var frm = document.getElementById("modifyFrm");
		
		frm.bbsSeq.value = val;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/image/registNttFormAjax.do'
			, cache : false
			, async : false
			, data:$("#modifyFrm").serialize()
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
		$('#modify_btn').click();
	}
	
	$('input[type="text"]').keydown(function() {
	    if (event.keyCode === 13) {
	        event.preventDefault();
	    }
	});
	
</script>

		<form:form modelAttribute="resultVO" path="modifyFrm" id="modifyFrm" name="modifyFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<form:hidden path="menuSeq" value="${fn:escapeXml(paramVO.menuSeq)}" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="tmpTag" name="tmpTag" />
			<input type="hidden" id="mngrAt" name="mngrAt" value="${fn:escapeXml(paramVO.mngrAt)}"/>
			<form:hidden path="cmntUseAt" />
			<input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" value="${fn:escapeXml(paramVO.sitecntntsSeq)}"/>
		
			<input type="hidden" id="pageIndex" name="pageIndex" value="${fn:escapeXml(paramVO.pageIndex)}" />
			<input type="hidden" id="searchCondition" name="searchCondition" value="${fn:escapeXml(paramVO.searchCondition)}"  />
			<input type="hidden" id="searchKeyword" name="searchKeyword" value="${fn:escapeXml(paramVO.searchKeyword)}"  />
			
			<c:set var="ctgryTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
			<c:set var="nttSjTit"><spring:message code="wzwg.module.word.nttsj" /></c:set>
			<c:set var="notiChekTit"><spring:message code="wzwg.module.word.noticececk" /></c:set>
			<c:set var="secretPostTit"><spring:message code="wzwg.module.word.secretpostsceck" /></c:set>
			<c:set var="annymtyPostTit"><spring:message code="wzwg.module.word.annymtypostsceck" /></c:set>
			<c:set var="answerPermTit"><spring:message code="wzwg.module.word.answerpermceck" /></c:set>
			
			<div class="register-box">
				<div class="subject">
					<table>
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postupdt" /></caption>
					<colgroup>
						<col width="10%"/>
						<col width="10%"/>
						<col width="13%"/>
						<col width="*"/>
						<col width="20%"/>
					</colgroup>
					<thead>
					</thead>
					<tbody>		
						<c:if test="${paramVO.cmntUseAt ne 'Y'}">		
						<tr id="subospecTr">
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ctgry02" />
							</th>
							<td colspan="4">
								<form:select path="subospecSeq" id="subospecSeq" cssClass="headId" title="${fn:escapeXml(ctgryTit)}">
									<form:option value=""><label for="ctgry01"><spring:message code="wzwg.module.word.ctgrychoise" /></label></form:option>
								</form:select>	
							</td>
						</tr>
						</c:if>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.sj" />
							</th>
							<td colspan="3" style="padding-right:5px;">
								<form:input path="nttSj" id="nttSj" name="nttSj" style="width:100%;" dir="required" title="${fn:escapeXml(nttSjTit)}" />
							</td>
							<td>
								<span id="tmprntt_area" style="display:none;"></span>
							</td>
						</tr>
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.postsestbs" /></th>
							<td colspan="4">
								<ul class="setlist">
									<c:if test="${adminAuthAt eq 'Y'}">
										<li><label><form:checkbox path="noticeAt" name="noticeAt" value="Y" dir="required" title="${fn:escapeXml(notiChekTit)}"/> <span><spring:message code="wzwg.module.word.bbsnotice" /></span></label></li>
									</c:if>
									<li><label><form:checkbox path="secretAt" name="secretAt" value="Y" dir="required" title="${fn:escapeXml(secretPostTit)}" /> <span><spring:message code="wzwg.module.word.secretposts" /></span></label></li>
									<li><label><form:checkbox path="annymtyAt" name="annymtyAt" value="Y" dir="required" title="${fn:escapeXml(annymtyPostTit)}" /> <span><spring:message code="wzwg.module.word.annymtyposts" /></span></label></li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.imagefileatch" />
							</th>
							<td colspan="4">
								<p class="mb5"><span class="circle_no bg-green-strong">i</span> <spring:message code='wzwg.cmm.msg.MSG415' /></p>
								
								<c:import url="${wzwg_contextPath}/module/upload/descImage/selectDescImageInc.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" 		value="${resultVO.atchImageFileId}" />
									<c:param name="param_updateFlag" 		value="Y" />
									<c:param name="param_atchFileNumber" 	value="${paramVO.atchImgFilePosblCo}" />
									<c:param name="param_sitecntntsSeq" 	value="${paramVO.sitecntntsSeq}" />
									<c:param name="param_cntntsSeq" 		value="${paramVO.bbsSeq}" />
								</c:import>
							</td>
						</tr>
						<c:if test="${paramVO.atchFilePosblAt eq 'Y'}">
						
							<c:if test="${fileEstbsSe eq 'B'}">
								<c:if test="${resultVO.atchFileCnt ne '0'}">
								<tr>
									<th scope="row" class="subTit">
										<spring:message code="wzwg.module.word.fileatch" />
									</th>
									<td colspan="4">
										<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
											<c:param name="param_updateFlag" 		value="Y" />
											<c:param name="param_atchFileNumber" 	value="${paramVO.atchFilePosblCo}" />
											<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
										</c:import>
									</td>
								</tr>
								</c:if>
								<c:if test="${resultVO.atchFileCnt eq '0'}">
								<tr>
									<th scope="row" class="subTit">
										<spring:message code="wzwg.module.word.fileatch" />
									</th>
									<td colspan="4">
										<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
											<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
											<c:param name="param_updateFlag" 		value="N" />
											<c:param name="param_atchFileNumber" 	value="${paramVO.atchFilePosblCo}" />
											<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
										</c:import>
									</td>
								</tr>
								</c:if>
							</c:if>
							
							<c:if test="${fileEstbsSe eq 'C'}">
								<tr>
									<th scope="row" class="subTit">
										<spring:message code="wzwg.module.word.fileatch" />
									</th>
									<td colspan="4">
										<c:import url="${wzwg_contextPath}/module/upload/crossuploader/modifyForm.do" charEncoding="utf-8">
											<c:param name="param_atchFileId"		value="${resultVO.atchFileId}" />
											<c:param name="param_atchFileNumber" 	value="${paramVO.atchFilePosblCo}" />
											<c:param name="param_sitecntntsSeq" 	value="${paramVO.sitecntntsSeq}" />
											<c:param name="param_cntntsSeq" 		value="${paramVO.bbsSeq}" />
										</c:import>
									</td>
								</tr>
							</c:if>
						
						</c:if>
						<tr>
							<td colspan="5">
								<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;display:none;"><c:out value="${resultVO.nttCn}"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
								
								<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttCn" />
									<c:param name="param_editorTy" 	value="custom" />
								</c:import>
							</td>
						</tr>
						<%-- <tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.tag01" /></th>
							<td class="ta_l" colspan="2">
								<input type="text" name="tagArr" id="tagArr" placeholder="<spring:message code="wzwg.cmm.msg.MSG013" />" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.tag01" />" onkeyup="fnTagChk();" value="${resultVO.tagArr}" />
								<a href="javascript:void(0);" onclick="$('.tagListDiv').toggle();"><img class="vtc2" src="/images/wzwg/module/ntt/mybtn.png" alt="<spring:message code="wzwg.cmm.word.my" /> <spring:message code="wzwg.cmm.word.tag" /> <spring:message code="wzwg.cmm.word.view" />" /></a></a>
								<div class="tagListDiv" style="display:none;">
									<c:if test="${empty myTagList}">
										<p><spring:message code="wzwg.cmm.msg.MSG316" /></p>
									</c:if>
									
									<c:if test="${!empty myTagList}">
									<c:forEach var="tagList" items="${myTagList}" varStatus="status">
										<c:choose>
											<c:when test="${fn:indexOf(resultVO.tagArr, tagList.tagNm) ne -1}">
												<span style="background-color:#D5D5D5;">
											</c:when>
											<c:otherwise>
												<span>
											</c:otherwise>
										</c:choose>
										<a href="javascript:void(0);" onclick="fnTagInput('${tagList.tagNm}');">${tagList.tagNm}</a></span>
									</c:forEach>
									</c:if>
								</div>
							</td>
						</tr> --%>
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.skllestbs" /></th>
							<td colspan="4">
								<ul class="setlist">
									<li><label><form:checkbox path="answerPermAt" name="answerPermAt" value="Y" dir="required" title="${fn:escapeXml(answerPermTit)}"/> <span><spring:message code="wzwg.module.word.answerperm" /></span></label></li>
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
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
				
				<c:if test="${fileEstbsSe eq 'C'}">
					<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save" style="display:none;"><spring:message code="wzwg.cmm.word.stre" /></a>
					<a href="javascript:void(0);" class="wzbtn btn-save" onclick="onStartUpload();"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>			
			</div>
					
		</form:form>

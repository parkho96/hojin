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
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postregist" />');
		
 		if('<c:out value="${tmprnttListCnt}"/>' > 0){
 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop(this);' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value='${tmprnttListCnt}'/>')</span></a>");
 			$('#tmprntt_area').show();
 		}
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.getElementById("regFrm");
				
				var clSe = $("input:radio[name=nttClSe]:checked").val();
				
				if(clSe == 'C'){
					if(frm.nttSj.value == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.module.word.clnm" text="name" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
							  '</spring:message>');
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
				}
				
				if(clSe == 'L'){
					var target = $('#nttClTarget').val();
					var linkUrl = $('#linkUrl').val();
					
					if(linkUrl == ''){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
								'<spring:argument><spring:message code="wzwg.cmm.word.url" text="contents" /></spring:argument>'+
								'<spring:argument><spring:message code="wzwg.cmm.word.input" text="input" /></spring:argument>'+
							  '</spring:message>');
						return;	
					}
					
					frm.nttCn.value = '[' + target + ']' + linkUrl;
				}
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/registNttInfoAjax.do'
					, dataType: 'xml'
					, data : $("#regFrm").serialize()
					, success : function (result) {
			    	  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value != 'fail'){
							frm.nttSeq.value = value;
							
							$.ajax({
						        type : 'POST'
								, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttListAjax.do'
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
		
		// 게시글 임시저장
 		$('#tmpr_regist_btn').click(function(){
				
 			var frm = document.getElementById("regFrm");
			
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
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttListAjax.do'
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
	
	// 상세화면으로 이동
	function fnNttView(nttSeq){
		
		var frm = document.getElementById("regFrm");
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cl/selectNttDetailAjax.do'
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
	
	function fnChangeWriteType(com){
		if(com == 'C'){
			$('#cntntsWrite').show();
			$('#linkWrite').hide();
			$('#tmpr_regist_btn').show(); //임시저장버튼 
			$('#tmprntt_area').show(); // 임시저장한글 팝업
		}else{
			$('#cntntsWrite').hide();
			$('#linkWrite').show();
			$('#tmpr_regist_btn').hide(); //임시저장버튼 
			$('#tmprntt_area').hide(); // 임시저장한글 팝업
		}
	}

	function fnChangeWriteType(com){
		if(com == 'C'){
			$('#cntntsWrite').show();
			$('#linkWrite').hide();
			$('#tmpr_regist_btn').show(); //임시저장버튼 
			$('#tmprntt_area').show(); // 임시저장한글 팝업
		}else{
			$('#cntntsWrite').hide();
			$('#linkWrite').show();
			$('#tmpr_regist_btn').hide(); //임시저장버튼 
			$('#tmprntt_area').hide(); // 임시저장한글 팝업
		}
	}
</script>

		<form:form modelAttribute="paramVO" path="regFrm" id="regFrm" name="regFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<input type="hidden" id="nttSeq" name="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<form:hidden path="sitecntntsSeq" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="tmpTag" name="tmpTag" />
			<form:hidden path="cmntUseAt" />
			
			<c:set var="clNmTit"><spring:message code="wzwg.module.word.clnminpcmpt" /></c:set>
			
			<div class="register-box mt0">
				<div class="">
					<table class="basic">
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postwritng" /></caption>
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
						<col width="10%"/>
					</colgroup>
					<thead>
					</thead>
					<tbody>				
						<tr style="border-top:none;">
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.tabsj" />
							</th>
							<td class="mr10">
								<c:set var="txt01"><spring:message code="wzwg.cmm.word.ntt" /></c:set>
								<c:set var="txt02"><spring:message code="wzwg.module.word.clnm" /></c:set>
								<form:input path="nttSj" id="nttSj" style="width:100%;" maxlength="20" dir="required" title="<c:out value='${clNmTit}'/>" />
							</td>
							<td>
							 	<span id="tmprntt_area" style="display:none;"></span>
							</td>							
						</tr>
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ty03" text="name" />
							</th>
							<td colspan="2" class="mr10">
								<label><input type="radio" name="nttClSe" value="C" checked="checked" onclick="fnChangeWriteType('C')" title="<spring:message code="wzwg.cmm.word.cntnts" />"> <spring:message code="wzwg.cmm.word.cntnts"/></label>
								<label class="ml10"><input type="radio" name="nttClSe" value="L" onclick="fnChangeWriteType('L')" title="<spring:message code="wzwg.cmm.word.link" />"> <spring:message code="wzwg.cmm.word.link"/></label>
							</td>
						</tr>
						<tr id="cntntsWrite">
							<td colspan="3">
								<textarea name="nttCn" id="nttCn" rows="30" style="width:100%;"><c:out value="${paramVO.nttCn}" escapeXml="false"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
								<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttCn" />
									<c:param name="param_editorTy" 	value="custom" />
								</c:import>
							</td>
						</tr>
						<tr id="linkWrite" style="display:none;">
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.url"/></th>
							<td colspan="2">
								<input type="text" class="w80" id="linkUrl" title="<spring:message code="wzwg.module.word.urlinpcmpt"/>">
								<select id="nttClTarget" class="mt10" title="<spring:message code="wzwg.module.word.urlopense"/>">
									<option value="G"><spring:message code="wzwg.cmm.word.nowwin"/></option>
									<option value="N"><spring:message code="wzwg.cmm.word.newwin"/></option>
								</select>
								<div class="wz_notice brbox bg-white clnone mt10">
									 <ul class="wd100">
										<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG346" /></li>
									</ul>
								</div>
							</td>
						</tr>
						<%-- <tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.tag01" /></th>
							<td class="ta_l" colspan="2">
								<input type="text" name="tagArr" id="tagArr" placeholder="<spring:message code="wzwg.cmm.msg.MSG013" />" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.tag01" />" onkeyup="fnTagChk();" />
								<a href="javascript:void(0);" onclick="$('.tagListDiv').toggle();"><img class="vtc2" src="/images/wzwg/module/ntt/mybtn.png" alt="<spring:message code="wzwg.cmm.word.my" /> <spring:message code="wzwg.cmm.word.tag" /> <spring:message code="wzwg.cmm.word.view" />" /></a></a>
								<div class="tagListDiv" style="display:none;">
									<c:if test="${empty myTagList}">
										<p><spring:message code="wzwg.cmm.msg.MSG316" /></p>
									</c:if>
									
									<c:if test="${!empty myTagList}">
									<c:forEach var="tagList" items="${myTagList}" varStatus="status">
										<span style="background-color:#D5D5D5;"><a href="javascript:void(0);" onclick="fnTagInput('${tagList.tagNm}');">${tagList.tagNm}</a></span>
									</c:forEach>
									</c:if>
								</div>
							</td>
						</tr>	 --%>			 
						<tr>
							<td colspan="3" class="txt-c" style="letter-spacing:-1px;"><spring:message code="wzwg.cmm.msg.MSG006" /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></a>
 				<a href="javascript:void(0);" id="tmpr_regist_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a>
				<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" text="save" /></a>			
			</div>		
					
		</form:form>


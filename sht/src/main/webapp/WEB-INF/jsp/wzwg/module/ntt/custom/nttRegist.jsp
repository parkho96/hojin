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

<c:choose>
<c:when  test="${funcVO.nolognAt ne 'Y' and nttAuthVO.authorSe ne 'W' and adminAuthAt ne 'Y'}">
<script>
alert('<spring:message code="wzwg.cmm.cmmMsg.CMG014"><spring:argument><spring:message code="wzwg.cmm.word.author" text="author" /></spring:argument></spring:message>');
location.href="/index.do";
</script>
</c:when>
<c:otherwise>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.regist" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postwritng" />');
		
// 		if('<c:out value="${tmprnttListCnt}"/>' > 0){
// 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop();' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value="${tmprnttListCnt}"/>)</span></a>");
// 			$('#tmprntt_area').show();
// 		}
		
		fnChangeSubospecList('<c:out value="${paramVO.bbsSeq}"/>');
		
		// 등록
		$('#regist_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.getElementById("regFrm");
				
				<c:if test="${funcVO.usrScrinTy ne 'W'}">
				
					<c:if test="${adminAuthAt eq 'Y' and funcVO.nolognAt ne 'Y'}">
					// 게시판 공지 여부
					frm.noticeAt.value 		= $("input[name=noticeAt]").is(":checked") == true ? "Y" : "N";
					</c:if>
				
				// 비밀글 여부
				frm.secretAt.value 		= $("input[name=secretAt]").is(":checked") == true ? "Y" : "N";
				// 익명글 여부
				frm.annymtyAt.value 	= $("input[name=annymtyAt]").is(":checked") == true ? "Y" : "N";
				// 댓글 허용 여부
				frm.answerPermAt.value 	= $("input[name=answerPermAt]").is(":checked") == true ? "Y" : "N";
				</c:if>
				/* 
				frm.nttCn.value = oEditors.getById["nttCn"].getIR();
				frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");

				if(frm.nttSj.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				}
				
				if(frm.nttCn.value == ''){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
					return;				
				} 
				*/
				
				frm.bbsSeq.value = frm.searchBbsSeq.value;
				
				if(customFieldCheck() == false){
					return;
				}
				
				var formData = new FormData(frm);

				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttInfoAjax.do'
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
							<c:if test="${funcVO.usrScrinTy ne 'W'}">
							fnNttView(value);
							</c:if>
							<c:if test="${funcVO.usrScrinTy eq 'W'}">
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
							fnNttRegist();
							</c:if>
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
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do'
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
			
			frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/custom/selectBbsInc.do";
			frm.submit();
		});
		
		<c:if test="${funcVO.nolognAt eq 'Y' }">
		nologinCodeRefresh();
		</c:if>
		
		//전화번호 필드 정규식
		var pn = /^[0-9\-]*$/;
		var pnr = /[^0-9\-]/g;
		$('input[data-type="telView"]').on('keyup', function (event){
			var val = $(this).val();
			if(pn.test(val) == false){
				alert('<spring:message code="wzwg.cmm.msg.MSG338"/>');
				
				$(this).val(val.replace(/[^0-9\-]/g,""));
				/* if(val.length > 1){
					$(this).val(val.substring(0, val.length -1));
				} */
			}else{
				$(this).val(phoneFomatter(val));
			}
		});
		
		//첫 input 포커스 넣기 2019.09.17 추가 조원권
		$('.subCon').find('input').not('[type="hidden"]').eq(0).focus();
	}); // end ready
	
	
	function phoneFomatter(num){
		num = num.replace(/[^0-9]/g,"");
	    var formatNum = '';

	    if(num.length==11){
	        formatNum = num.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');

	    }else if(num.length==8){

	        formatNum = num.replace(/(\d{4})(\d{4})/, '$1-$2');

	    }else{

	        if(num.indexOf('02')==0 && num.length == 10){
	        	formatNum = num.replace(/(\d{2})(\d{4})(\d{4})/, '$1-$2-$3');
	        }else if(num.indexOf('02')==0 && num.length == 9){
	            formatNum = num.replace(/(\d{2})(\d{3})(\d{4})/, '$1-$2-$3');
	        }else{
	        	formatNum = num.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
	        }
	    }

	    return formatNum;
	}
	
	
	
	// 상세화면으로 이동
	function fnNttView(nttSeq){
		
		var frm = document.getElementById("regFrm");
		frm.nttSeq.value = nttSeq;
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do'
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
	
	// 등록화면으로 이동
	function fnNttRegist(){
		
		var frm = document.getElementById("regFrm");
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttFormAjax.do'
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
	function fnTmprPop(){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#regFrm").serialize()
	      , success:function (data) {
	    	  $("#bbs_layer").show();
	    	  $("#bbs_layer").html(data);
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttFormAjax.do'
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
	
	window.onkeydown = function() {

	    var keyCode = event.keyCode;

	    if(keyCode == 8
	    		&& 'INPUT'.indexOf(event.target.nodeName.toUpperCase()) == -1 
	    		&& 'TEXTAREA'.indexOf(event.target.nodeName.toUpperCase()) == -1) {

	    	$('#cancle_btn').click();
	    	return false;
		}
	}		
	
	
	function customFieldCheck(){
		<c:if test="${funcVO.nolognAt eq 'Y' }">
		if(nologinCodeFlag == false){
			alert('<spring:message code="wzwg.cmm.msg.MSG124"/>');
			return false;
		}
		</c:if>
		
		var tmp;
		<c:if test="${not empty funcVO.agreementCn}">
			if($('#agreementChk').is(":checked") == false){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.stplat" /></spring:argument>'+
                    		'<spring:argument><spring:message code="wzwg.cmm.word.agre" /></spring:argument>'+
                    	  '</spring:message>');
				return false;
			}
		</c:if>
		
		<c:forEach items="${fieldList }" var="list">
		<c:if test="${list.useAt eq 'Y' }">
			<c:if test="${list.fieldTy eq 'text' or list.fieldTy eq 'name' or list.fieldTy eq 'number' or list.fieldTy eq 'email'}">
				if($('#<c:out value="${list.fieldId}"/>').val() == ''){
					alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
					$('#<c:out value="${list.fieldId}"/>').focus();
					return false;
				}
			</c:if>
			
			<c:if test="${list.fieldTy eq 'email'}">
				if($('#<c:out value="${list.fieldId}"/>').val() != ''){
					//이메일 정규식
					var em = /^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{1,5}$/;
					var val = $('#<c:out value="${list.fieldId}"/>').val()
						if(em.test(val) == false){
							alert('<spring:message code="wzwg.cmm.msg.MSG339"/>');
							$('#<c:out value="${list.fieldId}"/>').focus();
							return false;
							
						}
				}
			</c:if>
			
			<c:if test="${list.fieldTy eq 'tel'}">
				if($('#<c:out value="${list.fieldId}"/>_view').val() == ''){
					alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
					$('#<c:out value="${list.fieldId}"/>_view').focus();
					return false;
				}
				
				var frm = new FormData();
				frm.append('name','data');
				frm.append('data',$('#<c:out value="${list.fieldId}"/>_view').val());
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectEncryptFieldAjax.do'
					, cache : false
					, async : false
					, processData: false
					, contentType: false
					, data : frm
					, success : function (data) {
			    	  	console.log(data);
			    	  	if(data.result == 'success'){
			    	  		$('#<c:out value="${list.fieldId}"/>').val(data.dataList[0]);
			    	  	}else{
			    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.encpt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
			    	  		return false;
			    	  	}
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
				});
				
			</c:if>
			
			<c:if test="${list.fieldTy eq 'contents'}">
				
				if('<c:out value="${editorEstbsSe}"/>' == 'S'){
					tmp = oEditors.getById["<c:out value='${list.fieldId}'/>"].getIR();	
	
					if(tmp.replace(/[<][^>]*[>]/g, "") == ''){
						alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
						oEditors.getById["<c:out value='${list.fieldId}'/>"].exec("FOCUS",[]);	
						return false;
					}else{
						$('#<c:out value="${list.fieldId}"/>').val(tmp);
					}
				}
				
				if('<c:out value="${editorEstbsSe}"/>' == 'C'){
					tmp = bEditor_<c:out value="${list.fieldId}"/>.GetBodyValue();
					
					if(!bEditor_<c:out value="${list.fieldId}"/>.IsDirty()){
						alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
						bEditor_<c:out value="${list.fieldId}"/>.SetFocusEditor();	
						return false;
					}else{
						$('#<c:out value="${list.fieldId}"/>').val(tmp);
					}
				}
					
			
			</c:if>
			
			<c:if test="${list.fieldTy eq 'title'}">
				if($('#<c:out value="${list.fieldId}"/>').val() == ''){
					alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
					$('#<c:out value="${list.fieldId}"/>').focus();
					return false;
				}else{
					$('#nttSj').val($('#<c:out value="${list.fieldId}"/>').val());
				}
			
			</c:if>
			
			<c:if test="${list.fieldTy eq 'password'}">
			if($('#<c:out value="${list.fieldId}"/>').val() == ''){
				alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG036" />');
				$('#<c:out value="${list.fieldId}"/>').focus();
				return false;
			}
			
			if($('#<c:out value="${list.fieldId}"/>').val().length < 4 || $('#<c:out value="${list.fieldId}"/>').val().length > 10){
				alert('<c:out value="${list.fieldNm}"/> <spring:message code="wzwg.cmm.msg.MSG035" />');
				$('#<c:out value="${list.fieldId}"/>').focus();
				return false;
			}
			
			var frm = new FormData();
			frm.append('name','data');
			frm.append('data',$('#<c:out value="${list.fieldId}"/>').val());
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectEncryptFieldAjax.do'
				, cache : false
				, async : false
				, processData: false
				, contentType: false
				, data : frm
				, success : function (data) {
		    	  	if(data.result == 'success'){
		    	  		$('#<c:out value="${list.fieldId}"/>').val(data.dataList[0]);
		    	  	}else{
		    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.encpt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
		    	  		return false;
		    	  	}
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
			
			</c:if>
		</c:if>
		</c:forEach>
		
		return true;
	}
	
	
	var nologinCodeFlag = false;
	var nologinCodeCount = 0;
	function nologinCodeCheck(){
		var answerValue = $('#codeAnswerValue').val();
		if(answerValue == ''){
			alert('<spring:message code="wzwg.cmm.msg.MSG123"/>');
			$('#codeAnswerValue').focus();
			return false;
		}
		
		var frm = new FormData();
		frm.append("answer", answerValue );
		
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}"/>/webutil/captcha/selectCaptchaAnswerAjax.do'
			, cache : false
			, async : false
			, processData: false
			, contentType: false
			, data : frm
			, success : function (data) {
	    	  	if(data.result == 'success'){
	    	  		var tag = '';
	    	  		tag += '<div style="height: 25px; border: solid 1px #e0e0e0; border-radius: 3px; text-align: center; line-height: 25px;">'
	    	  		tag += '		<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cnfirm" /></spring:argument></spring:message>'
	    	  		tag += '</div>'
	    	  		$('#codeAnswerView').html(tag);
	    	  		nologinCodeFlag = true;
	    	  		return true;
	    	  	}else{
	    	  		if(nologinCodeCount >= 4){
	    	  			alert('<spring:message code="wzwg.cmm.msg.MSG030" />');
	    	  			$('#codeAnswerValue').val('');
	    	  			nologinCodeRefresh();
	    	  			nologinCodeCount = 0;
	    	  			$('#codeAnswerValue').focus();
	    	  		}else{
		    	  		alert('<spring:message code="wzwg.cmm.msg.MSG122"/>');
		    	  		$('#codeAnswerValue').focus();
		    	  		nologinCodeCount++;
	    	  		}
	    	  		return false;
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
		
	}
	
	function nologinCodeRefresh(){
        
		$('#writeCodeImg').attr('src', '<c:out value="${wzwg_contextPath}"/>/webutil/captcha/selectCaptchaImageAjax.do?r=' + Math.random());
		$('#codeAnswerValue').val('');
		//$('#codeAnswerValue').focus();
	}
	
	function nologinAudio(){
		var rand = Math.random(); 
		var uAgent = navigator.userAgent; 
		var soundUrl = '<c:out value="${wzwg_contextPath}"/>/webutil/captcha/selectCaptchaAudioAjax.do?rand='+rand; 
		
		if(uAgent.indexOf('Trident')>-1 || uAgent.indexOf('MISE')>-1){ /*IE 경우 */
			audioPlayer(soundUrl); 
		}else if(!!document.createElement('audio').canPlayType){	/*Chrome 경우 */
			try { 
				 new Audio(soundUrl).play();
			} catch (e) { 
				audioPlayer(soundUrl); 
			} 
		}else{ 
			window.open(soundUrl,'','width=1,height=1'); 
		}

		
	}
	
	var oEditors = []; // 에디터 배열 공용변수

	function fnFileInfoCheck(val, paramType){
		
		var objFile = document.getElementById(val);
		var objExtsn = objFile.value.slice(objFile.value.lastIndexOf(".") + 1).toLowerCase();
		var objCpcty = 0;
		
		var browser = navigator.appName;
		
		if(browser == "Microsoft Internet Explorer"){ // IE 인 경우
			var oas = new ActiveXObject("Scripting.FileSystemObject");
			objCpcty = oas.getFile(objFile.value).size;
		}else{	// IE 아닌경우
			objCpcty = objFile.files[0].size;
		}
		
		var fileTyCode, fileCpcty, fileEstbsExtsn, fileEstbsAt, fileCpctyAt;
		
		<c:forEach var="fileList" items="${fileList}" varStatus="status">
			
			if(paramType == "image"){
				if('<c:out value="${fileList.fileTyCode}"/>' == 'SC00000063' && "<c:out value='${fileList.fileEstbsExtsn}'/>".indexOf(objExtsn) > -1){
					fileTyCode = "<c:out value='${fileList.fileTyCode}'/>";
					fileEstbsAt = "Y";
				}
			}else{
				if("<c:out value='${fileList.fileEstbsExtsn}'/>".indexOf(objExtsn) > -1){
					fileTyCode = "<c:out value='${fileList.fileTyCode}'/>";
					fileEstbsAt = "Y";
				}
			}
			
		</c:forEach>
		
		if(fileEstbsAt == "Y"){
			<c:forEach var="fileList" items="${fileList}" varStatus="status">
			
				if(fileTyCode == "<c:out value='${fileList.fileTyCode}'/>"){
					fileCpcty = "<c:out value='${fileList.fileCpcty}'/>";
					fileCpctySe = "<c:out value='${fileList.fileCpctySe}'/>";
					fileEstbsExtsn = "<c:out value='${fileList.fileEstbsExtsn}'/>";
					
					if(fileCpctySe == "K"){
						objCpcty = objCpcty / 1024;
					}else if(fileCpctySe == "M"){
						objCpcty = objCpcty / (1024 * 1024);
					}
					
					if(objCpcty <= fileCpcty){
						fileCpctyAt = "Y";
					}else{
						fileCpctyAt = "N";
					}
				}
			
			</c:forEach>			
		}
		
		if(fileEstbsAt != "Y") {
			alert('<spring:message code="wzwg.cmm.msg.MSG090" />');
			fnFileReset(val);
		}
		
		if(fileCpctyAt == "N") {
			alert('<spring:message code="wzwg.cmm.msg.MSG091" />');
			fnFileReset(val);
		}
		
	}

	function fnFileReset(val){
		var browser = navigator.appName;
		
		if(browser == "Microsoft Internet Explorer"){ // IE 인 경우
			$(val).replaceWith( $(val).clone(true) );
			$('file_text_' + val).replaceWith( $('file_text_' + val).clone(true) );
		}else{	// IE 아닌경우
			document.getElementById(val).value = "";
			document.getElementById('file_text_' + val).value = "";
		}
		
	}
	
</script>
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${fn:replace(resultVO.bbsPrface, cn, "<br />")}' escapeXml="false" />
		</div>
		</c:if>
		<form:form modelAttribute="paramVO" path="regFrm" id="regFrm" name="regFrm" method="post" enctype="multipart/form-data">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<form:hidden path="menuSeq" />
			<form:hidden path="mngrAt" />
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="tmpTag" name="tmpTag" />
			<input type="hidden" name="sitecntntsSeq" value="${paramVO.sitecntntsSeq}"/>
			<form:hidden path="cmntUseAt" />
			
			<input type="hidden" id="nttSj" name="nttSj" value="test <spring:message code="wzwg.cmm.word.sj" />"/>
			<input type="hidden" id="nttCn" name="nttCn" value="test"/>
			<input type="hidden" id="nttCnChrctr" name="nttCnChrctr" value="test"/>
			
			<c:set var="ctgryTit"><spring:message code="wzwg.module.word.ctgryse" /></c:set>
			<c:set var="nttSjTit"><spring:message code="wzwg.module.word.nttsj" /></c:set>
			<c:set var="notiChekTit"><spring:message code="wzwg.module.word.noticececk" /></c:set>
			<c:set var="secretPostTit"><spring:message code="wzwg.module.word.secretpostsceck" /></c:set>
			<c:set var="annymtyPostTit"><spring:message code="wzwg.module.word.annymtypostsceck" /></c:set>
			<c:set var="answerPermTit"><spring:message code="wzwg.module.word.answerpermceck" /></c:set>
			
			<div class="register-box">
				<div class="subject">
					<table>
					<caption id="contentsCaption"><spring:message code="wzwg.module.word.postwritng" /></caption>
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
						<c:if test="${funcVO.usrScrinTy ne 'W'}">	
						<c:if test="${not empty funcVO.agreementCn}">
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ctgry02" />
							</th>
							<td colspan="4">
								<form:select path="subospecSeq" id="subospecSeq" cssClass="headId" title="${ctgryTit}">
									<form:option value=""><label for="ctgry01"><spring:message code="wzwg.module.word.ctgrychoise" /></label></form:option>
								</form:select>		
								<!-- 관리자 기능 -->
								<%-- <c:if test="${paramVO.mngrAt eq 'Y'}">
									<a href="javascript:void(0);" id="subospec_add_btn"  class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.ctgryadd" /></a>	
								</c:if> --%>						
							</td>
						</tr>
						</c:if>
						
						<tr>
							<th scope="row" class="subTit"><spring:message code='wzwg.module.word.postsestbs' /></th>
							<td colspan="4">
								<!-- 관리자 기능 -->
								<ul class="setlist">
									<c:if test="${adminAuthAt eq 'Y' and funcVO.nolognAt ne 'Y'}">
									<li><label><form:checkbox path="noticeAt" name="noticeAt" value="Y" dir="required" title="<c:out value='${notiChekTit}'/>"/> <span><spring:message code='wzwg.module.word.bbsnotice' /></span></label></li>
									</c:if>
									<li><label><form:checkbox path="secretAt" name="secretAt" value="Y" dir="required" title="<c:out value='${secretPostTit}'/>" /> <span><spring:message code='wzwg.module.word.secretposts' /></span></label></li>
									<li><label><form:checkbox path="annymtyAt" name="annymtyAt" value="Y" dir="required" title="<c:out value='${annymtyPostTit}'/>" /> <span><spring:message code='wzwg.module.word.annymtyposts' /></span></label></li>
								</ul>
							</td>							
						</tr>
					</c:if>	 
						<%-- 커스텀 입력란 추가 --%>
						<c:forEach items="${fieldList }" var="list">
						<c:if test="${list.useAt eq 'Y' }">
							<tr>
								<th scope="row" class="subTit"><c:out value="${list.fieldNm }"/></th>
								
								<c:if test="${list.fieldTy eq 'text' or list.fieldTy eq 'name' or list.fieldTy eq 'title' or list.fieldTy eq 'number'}">
									<td colspan="3" style="padding-right:5px;">
										<input type="<c:out value='${list.fieldTy}'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" title="<c:out value='${list.fieldNm}'/> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
									</td>
									<td>
										<span id="tmprntt_area" style="display:none;"></span>
									</td>
								</c:if>
								
																
								<c:if test="${list.fieldTy eq 'email'}">
									<td colspan="3" style="padding-right:5px;">
										<input type="text" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" data-type="email" title="<c:out value='${list.fieldNm}'/> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
									</td>
									<td>
										<span id="tmprntt_area" style="display:none;"></span>
									</td>
								</c:if>
								
								<c:if test="${list.fieldTy eq 'tel'}">
									<td colspan="3" style="padding-right:5px;">
										<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="display:none;">
										<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>_view" id="<c:out value='${list.fieldId}'/>_view" style="width: 100%;" data-type="telView" title="<c:out value='${list.fieldNm }'/> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
									</td>
									<td>
										<span id="tmprntt_area" style="display:none;"></span>
									</td>
								</c:if>
								
								<c:if test="${list.fieldTy eq 'password'}">
									<td colspan="3" style="padding-right:5px;">
										<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" title="<c:out value='${list.fieldNm}'/> <spring:message code="wzwg.cmm.word.wa.inpcmpt" />">
									</td>
									<td>
										<span id="tmprntt_area" style="display:none;"></span>
									</td>
								</c:if>
								
								
								<c:if test="${list.fieldTy eq 'select'}">
									<td colspan="3" style="padding-right:5px;">
										<select name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" title="<c:out value='${list.fieldNm}'/> <spring:message code="wzwg.cmm.word.se" />">
											<%-- <c:set var="fieldSelOpt">${fn:split(list.fieldSel, ',')}</c:set> --%>
											<c:forEach items="${fn:split(list.fieldSel, ',')}" var="optList">
												<option value="<c:out value='${optList}'/>"><c:out value="${optList }"/></option>
											</c:forEach>
										</select>
									</td>
									<td>
										<span id="tmprntt_area" style="display:none;"></span>
									</td>
								</c:if>
								
								
								<c:if test="${list.fieldTy eq 'contents'}">
									<td colspan="4" style="padding-right:5px;">
										<textarea name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;display:none;"></textarea>
										<!-- <input type="hidden" name="nttCnChrctr" id="nttCnChrctr" /> -->
										<c:import url="/module/editor/editorForm.do" charEncoding="utf-8">
											<c:param name="param_editorNm" 	value="${list.fieldId}" />
											<c:param name="param_editorTy" 	value="custom" />
											<c:param name="param_bbsSeq" 	value="${paramVO.bbsSeq }" />
										</c:import>
									</td>
									
								</c:if>
								<c:if test="${list.fieldTy eq 'image'}">
									<td  colspan="4" style="overflow: hidden;">
										<input type="text" id="file_text_<c:out value='${list.fieldId}'/>" readonly="readonly" style="width:300px;" onclick="$('#<c:out value="${list.fieldId}"/>').click();" title="<spring:message code="wzwg.module.word.atchfile" />">
										<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="$('#<c:out value="${list.fieldId}"/>').click();"><spring:message code="wzwg.module.word.fileadd" /></a>
										<input type="file" id="<c:out value='${list.fieldId}'/>" name="<c:out value='${list.fieldId}'/>" title="<spring:message code="wzwg.module.word.fileatch" />"  onchange="document.getElementById('file_text_<c:out value="${list.fieldId}"/>').value=this.value;fnFileInfoCheck('<c:out value="${list.fieldId}"/>','image');" style="display:none;">
									</td>
									
								</c:if>
								<c:if test="${list.fieldTy eq 'file'}">
									<td  colspan="4" style="overflow: hidden;">
										<input type="text" id="file_text_<c:out value='${list.fieldId}'/>" readonly="readonly" style="width:300px;" onclick="$('#<c:out value="${list.fieldId}"/>').click();" title="<spring:message code="wzwg.module.word.atchfile" />">
										<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="$('#<c:out value="${list.fieldId}"/>').click();"><spring:message code="wzwg.module.word.fileadd" /></a>
										<input type="file" id="<c:out value='${list.fieldId}'/>" name="<c:out value='${list.fieldId}'/>" title="<spring:message code="wzwg.module.word.fileatch" />"  onchange="document.getElementById('file_text_<c:out value="${list.fieldId}"/>','file').value=this.value;fnFileInfoCheck('<c:out value="${list.fieldId}"/>','file');"" style="display:none;">
									</td>
									
								</c:if>
							</tr>	
						</c:if>
						</c:forEach> 
						
						<c:if test="${not empty funcVO.agreementCn}">
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.module.word.stplatagre" /></th>
							<td colspan="4">
								<div class="agreement" style="border: solid 1px #c2c2c2; padding: 5px;">
									<c:out value="${funcVO.agreementCn}" escapeXml="false"/>
								</div>
								<div style="padding: 5px; float: right;">
									<label style="position: inherit;"><input type="checkbox" id="agreementChk" name="agreementChk" title="<spring:message code="wzwg.module.word.stplatagrececk" />"> <span><spring:message code="wzwg.cmm.msg.MSG064" /></span></label>
								</div>
							</td>
						</tr>	
						</c:if>
						
						<c:if test="${funcVO.nolognAt eq 'Y' }">
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.atinptprv" /></th>
							<td colspan="4" id="codeAnswerView">
						        <div style="clear: both;"><spring:message code="wzwg.cmm.msg.MSG131" /></div>
						        <div style="float:left;">
						        	<img id="writeCodeImg" alt="<spring:message code="wzwg.module.word.captchaTextimage" />">
						        	<button type="button" class="wzbtn btn-basic hgt30 p0 ml5 vert-b" onclick="nologinCodeRefresh();$('#codeAnswerValue').focus()" title="<spring:message code="wzwg.module.word.imagerefresh" />">
                						<i class="fa fa-redo fs18 mr5 ml5 vert-m"></i>
            						</button>
						        </div>
						        
						        <div style="float:left;">
						            <div class="m-fl wm10 mr10">
						                <button type="button" class="wzbtn btn-basic hgt40 p0 mt5" onclick="nologinAudio()" title="<spring:message code="wzwg.module.word.captchaTextlistenVoice"/>"><i class="fa fa-volume-up fs30 mr10 ml10"></i></button>
						            </div>
						            <div class="m-fl wm80 mtxt-r">
						            	<c:set var="msg_txt01">
											<spring:message code="wzwg.cmm.cmmMsg.CMG011">
												<spring:argument><spring:message code="wzwg.cmm.word.chrctr" /></spring:argument>
												<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
											</spring:message>
										</c:set>
						                <input id="codeAnswerValue" type="text" class="mt5" placeholder="<c:out value='${msg_txt01 }'/>" title="<spring:message code="wzwg.module.word.captchaTextinpcmpt"/>">
						                <button type="button" class="wzbtn btn-basic hgt40 mt5" onclick="nologinCodeCheck()"><spring:message code="wzwg.module.word.chrctrcnfirm" /></button>
						            </div>
						        </div>
						    </td>
						</tr>
						</c:if>
						
						<c:choose>
							<c:when test="${funcVO.nolognAt eq 'Y' }"><input type="hidden" name="answerPermAt" id="answerPermAt" value="Y" /></c:when>
							<c:otherwise>
							<c:if test="${funcVO.usrScrinTy ne 'W'}">
							<tr>
								<th scope="row" class="subTit"><spring:message code='wzwg.module.word.skllestbs' /></th>
								<td colspan="4">
									<ul class="setlist">
										<li><label><form:checkbox path="answerPermAt" name="answerPermAt" value="N" dir="required" title="${answerPermTit}"/> <span><spring:message code='wzwg.module.word.answerperm' /></span></label></li>
									</ul>
								</td>
							</tr>			
							</c:if>
							</c:otherwise>
						</c:choose>
										
												 
						<tr>
							<td colspan="5" class="txt-c" style="letter-spacing:-1px;"><spring:message code="wzwg.cmm.msg.MSG006" /></td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>
			<div class="ctr-box">
				<c:if test="${funcVO.usrScrinTy ne 'W'}">			
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
				</c:if>
				<a href="javascript:void(0);" id="regist_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
				<!-- <a href="javascript:void(0);" id="tmpr_regist_btn" class="btn-a"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a> -->
			</div>		
			
			<c:if test="${nowUrl.indexOf('/mngr') == -1 }">
			<div class="mt20">
				<c:import url="${wzwg_contextPath}/usr/cntnts/cntPagadiEstbs/selectCntPagadiEstbsUsrAjax.do">
					<c:param name="cntntsSeq" value="${paramVO.bbsSeq }" />
					<c:param name="nttSeqAt" value="N" />
				</c:import>
			</div>
			</c:if>
			
		</form:form>
</c:otherwise>

</c:choose>   

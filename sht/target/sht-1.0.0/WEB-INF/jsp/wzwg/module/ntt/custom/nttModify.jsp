<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<% 
    pageContext.setAttribute("cn", "\n"); 
%>

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
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.updt" />';}catch(e){console.log(e.message);}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postupdt" />');
// 		if('<c:out value="${tmprnttListCnt}"/>' > 0){
// 			$('#tmprntt_area').html("<a href='javascript:void(0);' onclick='fnTmprPop();' class='save'><spring:message code='wzwg.cmm.word.temsvept' /><span class='red'>(<c:out value="${tmprnttListCnt}"/>)</span></a>");
// 			$('#tmprntt_area').show();
// 		}
		
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
		
		/*
		if('<c:out value="${fn:length(tagList)}"/>' > 0){
			var tagList = "";	
			
			<c:forEach var="result" items="${tagList}" varStatus="status">
				tagList += '<c:out value="${result.tagNm}"/>' + '<c:if test="${!status.last}">,</c:if>';
			</c:forEach>
			
			$('#tagNm').val(tagList);
		}
		*/
		
		// 수정
		$('#modify_btn').click(function(){
			
			if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>')){
				return;
			}else{
				
				var frm = document.getElementById("modifyFrm");

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
				
				frm.bbsSeq.value = frm.searchBbsSeq.value;
				
				if(customFieldCheck() == false){
					return;
				}
				
				var formData = new FormData(frm);
				
				$.ajax({
			        type : 'POST'
					, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/modifyNttInfoAjax.do'
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
							fnNttView();
							
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
		
		// 취소
		$('#cancle_btn').click(function(){
			
			$('#subospecSeq').val("");
			
			$.ajax({
		        type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do'
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
			
			frm.action = "<c:out value='${wzwg_contextPath}${prefix}'/>/module/bbs/custom/selectBbsInc.do";
			frm.submit();
		});
		
		
		/* 전화번호 필드가 있을경우 자동으로 복호화 해준다*/
		$('input[data-type="tel"]').each(function(idx, el){
			var value = $(el).val();
			if(value != ''){
				var decStr = fnFieldDecrypt(value);
				if(decStr){
					var id = $(this).attr('id');
					$('#' + id + '_view').val(decStr);
				}
			}
		});
		
		//전화번호 정규식
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
		
	});// onload
	
	
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
	function fnNttView(){
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do'
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
	function fnTmprPop(){
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectTmprnttPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#modifyFrm").serialize()
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
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttFormAjax.do'
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
		<%-- 리플보기일 경우는 기존대로 보여준다 --%>
		<c:if test="${not empty resultVO.parntsNttSeq }">
			var frm = document.getElementById("modifyFrm");
			
			frm.nttCn.value = oEditors.getById["nttCn"].getIR();
			frm.nttCnChrctr.value = frm.nttCn.value.replace(/[<][^>]*[>]/g, "");
			
			if(frm.nttSj.value == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				return false;				
			}
			
			if(frm.nttCn.value == ''){
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cn" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
				return false;				
			} 
			return true;
		</c:if>
		
		var tmp;
		<c:forEach items="${fieldList }" var="list">
		<c:if test="${list.useAt eq 'Y' }">
			<c:if test="${list.fieldTy eq 'text' or list.fieldTy eq 'name' or list.fieldTy eq 'number'}">
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
			    	  		$('<c:out value="#${list.fieldId}"/>').val(data.dataList[0]);
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
			if($('#<c:out value="${list.fieldId}"/>').attr('data-change') == 'Y'){
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
			}else if($('#<c:out value="${list.fieldId}"/>').val() == ''){
				$('#<c:out value="${list.fieldId}"/>').val($('#<c:out value="${list.fieldId}"/>').attr('data-ori'))
			}else{
				$('#<c:out value="${list.fieldId}"/>').val($('#<c:out value="${list.fieldId}"/>').attr('data-ori'))
			}
			
			</c:if>
		</c:if>
		</c:forEach>
		
		return true;
	}
	
	var oEditors = []; // 에디터 배열 공용변수
	
	
	function imgPreview(input, fieldId) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader(); //파일을 읽기 위한 FileReader객체 생성
	        reader.onload = function (e) {
	        //파일 읽어들이기를 성공했을때 호출되는 이벤트 핸들러
	        	var img = $('<img>');
	            img.attr('src', e.target.result);
	            $('#imgview_' + fieldId).html(img);
	            //이미지 Tag의 SRC속성에 읽어들인 File내용을 지정
	            //(아래 코드에서 읽어들인 dataURL형식)
	            
	        }                   
	        reader.readAsDataURL(input.files[0]);
	        //File내용을 읽어 dataURL형식의 문자열로 저장
	    }else{
	    	//파일이 없을때 ??
	    }
	}//readURL()--
	
	function fnFieldDecrypt(str){
		
		
		var frm = new FormData();
		frm.append('name','data');
		frm.append('data', str);
		
		var result;
		$.ajax({
	        type : 'POST'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectDecryptFieldAjax.do'
			, cache : false
			, async : false
			, processData: false
			, contentType: false
			, data : frm
			, success : function (data) {
	    	  	if(data.result == 'success'){
	    	  		result = data.dataList[0];
	    	  	}else{
	    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.decd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	    	  		
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
		return result;
	}
	
	function fnFileDelete(atchFileId, fileSn) {
		
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG089" />')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}"/>/module/upload/file/deleteFileInfs.do'
				, data:"atchFileId="+atchFileId+"&fileSn="+fileSn
				, success:function (result) {
					
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						$("#fileview_"+fileSn).remove();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
				}
				, error:function (data) {
				    alert('<spring:message code="fail.common.msg" text="error" />');
				}
	 		});
		}
	}
	
	function fnChangePwForm(btn, pwid){
		//console.log(pwid);
		$(btn).hide();
		$('#' + pwid).val('');
		//$('#' + pwid).attr('data-change', 'Y');
		$('#' + pwid).show();
		
		$('#' + pwid).on('change', function(e){
			$(this).attr('data-change', 'Y');
		 });
	}
			
	

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

		<form:form modelAttribute="resultVO" path="modifyFrm" id="modifyFrm" name="modifyFrm" method="post">
			<form:hidden path="siteSeq" />
			<form:hidden path="bbsSeq" />
			<form:hidden path="nttSeq" />
			<form:hidden path="tmprnttSeq" />
			<input type="hidden" id="menuSeq" name="menuSeq"  value="<c:out value='${paramVO.menuSeq }'/>"/>
			<input type="hidden" id="cntntsSeq" name="cntntsSeq" />
			<input type="hidden" id="searchBbsSeq" name="searchBbsSeq" />
			<input type="hidden" id="tmpTag" name="tmpTag" />
			<input type="hidden" id="mngrAt" name="mngrAt" value="<c:out value='${paramVO.mngrAt}'/>"/>
			<input type="hidden" id="atchFileId" name="atchFileId" value="<c:out value='${resultVO.atchFileId }'/>"/>
			<input type="hidden" id="sitecntntsSeq" name="sitecntntsSeq" value="<c:out value='${paramVO.sitecntntsSeq}'/>"/>
			<form:hidden path="cmntUseAt" />
			<form:hidden path="parntsNttSeq" />
			<%-- <form:hidden path="password" /> --%>
			
			<input type="hidden" id="pageIndex" name="pageIndex" value="${fn:escapeXml(paramVO.pageIndex)}" />
			<input type="hidden" id="searchCondition" name="searchCondition" value="${fn:escapeXml(paramVO.searchCondition)}" />
			<input type="hidden" id="searchKeyword" name="searchKeyword" value="${fn:escapeXml(paramVO.searchKeyword)}" />
			
			<%-- 리플이 아닐때 --%>
			<c:if test="${empty resultVO.parntsNttSeq }">
				<form:hidden path="nttSj" id="nttSj" name="nttSj" />
			</c:if>
			
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
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.cmm.word.ctgry02" />
							</th>
							<td colspan="4">
								<form:select path="subospecSeq" id="subospecSeq" cssClass="headId" title="${fn:escapeXml(ctgryTit)}">
									<form:option value=""><label for="ctgry01"><spring:message code="wzwg.module.word.ctgrychoise" /></label></form:option>
								</form:select>	
								<!-- 관리자 기능 -->	
								<%-- <c:if test="${paramVO.mngrAt eq 'Y'}">		
									<a href="javascript:void(0);" id="subospec_add_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.module.word.ctgryadd" /></a>
								</c:if> --%>
							</td>
						</tr>
						</c:if>
						
						<%-- 리플보기일 경우는 기존대로 보여준다 --%>
						<c:if test="${not empty resultVO.parntsNttSeq }">
						<tr>
							<th scope="row"  class="subTit">
								<spring:message code="wzwg.cmm.word.sj" />
							</th>
							<td colspan="3" style="padding-right:5px;">
								<form:input path="nttSj" id="nttSj" name="nttSj" style="width:100%;" dir="required" title="<c:out value='${nttSjTit}'/>" />
							</td>
							<td>
								<span id="tmprntt_area" style="display:none;"></span>
							</td>
						</tr>
						</c:if>
						
						<tr>
							<th scope="row"  class="subTit">
								<spring:message code='wzwg.module.word.postsestbs' />
							</th>
							<td colspan="4">
								<ul class="setlist">
									<c:if test="${adminAuthAt eq 'Y' and funcVO.nolognAt ne 'Y'}">
									<li><label><form:checkbox path="noticeAt" name="noticeAt" value="Y" dir="required" title="<c:out value='${notiChekTit}'/>"/> <span><spring:message code='wzwg.module.word.bbsnotice' /></span></label></li>
									</c:if>
									<li><label><form:checkbox path="secretAt" name="secretAt" value="Y" dir="required" title="<c:out value='${secretPostTit}'/>" /> <span><spring:message code='wzwg.module.word.secretposts' /></span></label></li>
									<li><label><form:checkbox path="annymtyAt" name="annymtyAt" value="Y" dir="required" title="<c:out value='${annymtyPostTit}'/>" /> <span><spring:message code='wzwg.module.word.annymtyposts' /></span></label></li>
								</ul>
							</td>
						</tr>
						
						<%-- 리플보기일 경우는 기존대로 보여준다 --%>
						<%-- <c:if test="${empty resultVO.parntsNttSeq }">
						<c:if test="${resultVO.atchFileCnt ne '0'}">
						<tr>
							<th scope="row" class="subTit">
								<spring:message code="wzwg.module.word.fileatch" />
							</th>
							<td colspan="4">
								<c:import url="/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									<c:param name="param_updateFlag" 		value="Y" />
									<c:param name="param_atchFileNumber" 	value="3" />
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
								<c:import url="/module/upload/file/selectFileInc.do" charEncoding="utf-8">
									<c:param name="param_atchFileId" 		value="${resultVO.atchFileId}" />
									<c:param name="param_updateFlag" 		value="N" />
									<c:param name="param_atchFileNumber" 	value="3" />
									<c:param name="param_cntntsSeq" 		value="${resultVO.bbsSeq}" />
								</c:import>
							</td>
						</tr>
						</c:if>		 	
						</c:if>		 --%>	
						
						<%-- 리플보기일 경우는 기존대로 보여준다 --%>
						<c:if test="${not empty resultVO.parntsNttSeq }">	
						<tr>
							<td colspan="5">
								<!-- 
								<div class="tool">
								 -->
								<textarea name="nttCn" id="nttCn" rows="20" style="width:100%;"><c:out value="${resultVO.nttCn}" escapeXml="false"/></textarea>
								<input type="hidden" name="nttCnChrctr" id="nttCnChrctr" />
								<c:import url="/module/editor/editorForm.do" charEncoding="utf-8">
									<c:param name="param_editorNm" 	value="nttCn" />
									<c:param name="param_editorTy" 	value="custom" />
									<c:param name="param_bbsSeq" 	value="${paramVO.bbsSeq }" />
								</c:import>
								<!-- 							
								</div>
								 -->
							</td>
						</tr>
						</c:if>
						<!-- 
						<tr>
							<th scope="row" class="subTit"><spring:message code="wzwg.cmm.word.tag01" /></th>
							<td class="ta_l" colspan="4">
								<input type="text" name="tagArr" id="tagArr" placeholder="<spring:message code="wzwg.cmm.msg.MSG013" />" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.tag01" />" onkeyup="fnTagChk();" value="<c:out value='${resultVO.tagArr}'/>" />
								<a href="javascript:void(0);" onclick="$('.tagListDiv').toggle();"><img class="vtc2" src="/images/wzwg/module/ntt/mybtn.png" alt="<spring:message code="wzwg.cmm.word.my" /> <spring:message code="wzwg.cmm.word.tag" /> <spring:message code="wzwg.cmm.word.view" />" /></a></a>
								<div class="tagListDiv" style="display:none;">
									<c:if test="${empty myTagList}">
										<p><spring:message code="wzwg.cmm.msg.MSG316" /></p>
									</c:if>
									
									<c:if test="${!empty myTagList}">
									<c:forEach var="tagList" items="${myTagList}" varStatus="status">
										<span style="background-color:#D5D5D5;"><a href="javascript:void(0);" onclick="fnTagInput('<c:out value="${tagList.tagNm}"/>');"><c:out value="${tagList.tagNm}"/></a></span>
									</c:forEach>
									</c:if>
								</div>
							</td>
						</tr>		
						 -->
						<%-- 리플보기일 경우는 기존대로 보여준다 --%>
						
						<c:if test="${empty resultVO.parntsNttSeq }">
							 <%-- 커스텀 입력란 추가 --%>
							<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.useAt eq 'Y' }">
								<c:set var="datakey">${list.fieldId }</c:set>
								
								<tr>
									<th scope="row"  class="subTit"><c:out value="${list.fieldNm}"/></th> <%-- 필드 <spring:message code="wzwg.cmm.word.sj" /> 출력 --%>
									
									<c:if test="${list.fieldTy eq 'text' or list.fieldTy eq 'name' or list.fieldTy eq 'number' or list.fieldTy eq 'title'}">
										<td colspan="3" style="padding-right:5px;">
											<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" value="<c:out value='${customData[list.fieldId]}'/>">
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td>
									</c:if>
									
									<c:if test="${list.fieldTy eq 'email'}">
										<td colspan="3" style="padding-right:5px;">
											<input type="text" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;" value="<c:out value='${customData[list.fieldId]}'/>" data-type="email">
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td>
									</c:if>
									
									
									<c:if test="${list.fieldTy eq 'tel'}">
										<td colspan="3" style="padding-right:5px;">
											<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="display:none;" value="<c:out value='${customData[list.fieldId] }'/>" data-type="<c:out value='${list.fieldTy }'/>">
											<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>_view" id="<c:out value='${list.fieldId}'/>_view" style="width: 100%;" data-type="telView">
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td>
									</c:if>
									
									<c:if test="${list.fieldTy eq 'password'}">
										<td colspan="3" style="padding-right:5px;">
											<button type="button" class="wzbtn-table btn-black" onclick="fnChangePwForm(this, '<c:out value="${list.fieldId}"/>')"><spring:message code="wzwg.cmm.word.findp" /></button>
											<input type="<c:out value='${list.fieldTy }'/>" name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;display: none;" value="<c:out value='${customData[list.fieldId]}'/>" data-ori="<c:out value='${customData[list.fieldId]}'/>">
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td>
									</c:if>
									
									<c:if test="${list.fieldTy eq 'select'}">
										<td colspan="3" style="padding-right:5px;">
											<select name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width: 100%;">
												<%-- <c:set var="fieldSelOpt">${fn:split(list.fieldSel, ',')}</c:set> --%>
												<c:forEach items="${fn:split(list.fieldSel, ',')}" var="optList">
													<c:choose>
														<c:when test="${customData[datakey] eq optList }"><c:set var="selected">selected="selected"</c:set></c:when>
														<c:otherwise><c:set var="selected"></c:set></c:otherwise>
													</c:choose>
													<option value="<c:out value='${optList }'/>" <c:out value="${selected }"/>><c:out value="${optList }"/></option>
												</c:forEach>
											</select>
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td>
									</c:if>
									
									
									<c:if test="${list.fieldTy eq 'contents'}">
										<td colspan="4" style="padding-right:5px;">
											<textarea name="<c:out value='${list.fieldId}'/>" id="<c:out value='${list.fieldId}'/>" style="width:100%;display:none;"><c:out value="${customData[datakey] }" escapeXml="false"/></textarea>
											<!-- <input type="hidden" name="nttCnChrctr" id="nttCnChrctr" /> -->
											<c:import url="${wzwg_contextPath}/module/editor/editorForm.do" charEncoding="utf-8">
												<c:param name="param_editorNm" 	value="${list.fieldId}" />
												<c:param name="param_editorTy" 	value="custom" />
												<c:param name="param_bbsSeq" 	value="${paramVO.bbsSeq }" />
											</c:import>
										</td>
										
									</c:if>
									<c:if test="${list.fieldTy eq 'image'}">
										<%-- <td colspan="3" style="padding-right:5px;">
											<input type="text" name="${list.fieldId}" style="width: 100%;" value="${customData[datakey] }">
										</td>
										<td>
											<span id="tmprntt_area" style="display:none;"></span>
										</td> --%>
										
										<td  colspan="4">
											<div id="imgview_<c:out value='${list.fieldId}'/>">
												<c:if test="${not empty customData[datakey] }">
												<img src="/module/upload/file/selectOrignlImageView.do?atchFileId=<c:out value='${resultVO.atchFileId}'/>&fileSn=${customData[list.fieldId]}" >
												</c:if>
											</div>
											<input type="text" id="file_text_<c:out value='${list.fieldId}'/>" readonly="readonly" style="width:300px;" onclick="$('#<c:out value="${list.fieldId}"/>').click();">
											<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="$('#<c:out value="${list.fieldId}"/>').click();"><spring:message code='wzwg.module.word.filechange' /></a>
											<%-- <input type="file" id="${list.fieldId}" name="${list.fieldId}" onchange="imgPreview(this, '${list.fieldId}')" style="display:none;"> --%>
											<input type="file" id="<c:out value='${list.fieldId}'/>" name="<c:out value='${list.fieldId}'/>" title="<spring:message code="wzwg.module.word.fileatch" />"  onchange="document.getElementById('file_text_<c:out value="${list.fieldId}"/>').value=this.value;fnFileInfoCheck('<c:out value="${list.fieldId}"/>','image');" style="display:none;" value="<c:out value='${customData[datakey]}'/>">
											<input type="hidden" id="save_<c:out value='${list.fieldId}'/>" name="save_<c:out value='${list.fieldId}'/>" value="<c:out value='${customData[datakey] }'/>">
										</td>
									</c:if>
									<c:if test="${list.fieldTy eq 'file'}">
										<td  colspan="4">
											<div id="fileview_${customData[list.fieldId]}">
												<c:if test="${!empty atchFileList }"> 
												<c:forEach items="${atchFileList }" var="atchFileList"> 
													<c:if test="${customData[list.fieldId] eq atchFileList.fileSn }">
														<a title="<spring:message code="wzwg.module.word.atchfiledelete" />" href="javascript:void(0);" onclick="fnFileDelete('<c:out value="${resultVO.atchFileId}"/>','<c:out value="${customData[list.fieldId]}"/>');">
															<img src="/images/wzwg/cmm/btn-del.gif" alt="<spring:message code="wzwg.module.word.deleteicon" />"/>
														</a>
														<a href="javscript:void(0);" onclick="window.open('/module/upload/file/fileDown.do?atchFileId=<c:out value="${atchFileList.atchFileId}"/>&fileSn=<c:out value="${customData[list.fieldId]}"/>');">
															<c:out value="${atchFileList.orignlFileNm }"/>
														</a>
													</c:if>
												</c:forEach>
												</c:if>
											</div>
											<input type="text" id="file_text_<c:out value='${list.fieldId}'/>" readonly="readonly" style="width:300px;" onclick="$('#<c:out value="${list.fieldId}"/>').click();">
											<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="$('#<c:out value="${list.fieldId}"/>').click();"><spring:message code='wzwg.module.word.filechange' /></a>
											<%-- <input type="file" id="${list.fieldId}" name="${list.fieldId}" onchange="imgPreview(this, '${list.fieldId}')" style="display:none;"> --%>
											<input type="file" id="<c:out value='${list.fieldId}'/>" name="<c:out value='${list.fieldId}'/>" title="<spring:message code="wzwg.module.word.fileatch" />"  onchange="document.getElementById('file_text_<c:out value="${list.fieldId}"/>').value=this.value;fnFileInfoCheck('<c:out value="${list.fieldId}"/>','file');" style="display:none;" value="<c:out value='${customData[datakey]}'/>">
											<input type="hidden" id="save_<c:out value='${list.fieldId}'/>" name="save_<c:out value='${list.fieldId}'/>" value="<c:out value='${customData[datakey]}'/>">
										</td>
									</c:if>
									
								</tr>	
							</c:if>
							</c:forEach> 
						</c:if>
						
						<c:choose>
							<c:when test="${funcVO.nolognAt eq 'Y' }"><input type="hidden" name="answerPermAt" id="answerPermAt" value="Y" /></c:when>
							<c:otherwise>
							<c:if test="${funcVO.usrScrinTy ne 'W'}">
							<tr>
								<th scope="row" class="subTit"><spring:message code='wzwg.module.word.skllestbs' /></th>
								<td colspan="4">
									<ul class="setlist">
										<li><label><form:checkbox path="answerPermAt" name="answerPermAt" value="N" dir="required" title="<c:out value='${answerPermTit}'/>"/> <span><spring:message code='wzwg.module.word.answerperm' /></span></label></li>
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
<!-- 				<a href="javascript:void(0);" id="tmpr_regist_btn" class="btn-a"><spring:message code="wzwg.cmm.word.temsve" text="temporary save" /></a> -->
				<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></a>
				<a href="javascript:void(0);" id="modify_btn" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>			
			</div>
					
		</form:form>

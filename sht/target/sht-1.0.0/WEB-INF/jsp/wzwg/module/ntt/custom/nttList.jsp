<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
	 <c:if test="${funcVO.usrScrinTy eq 'W'}">
	   <script type="text/javascript" src="/js/wzwg/cmm/excel/jszip.min.js"></script>
	<script src="/js/wzwg/cmm/excel/excel-gen.js"></script>
	<script src="/js/wzwg/cmm/excel/FileSaver.min.js"></script>
	</c:if>
<c:set var="adminAuthAt" value="N"/>

<c:if test="${resultVO.cmntUseAt eq 'Y'}">
	<c:if test="${sessionScope.cmntMngrAt == true}">
		<c:set var="adminAuthAt" value="Y"/>
	</c:if>
</c:if>

<c:if test="${sessionScope.SADMIN_AT or sessionScope.NADMIN_AT or sessionScope.CNTNTS_ADMIN_AT}">
	<c:set var="adminAuthAt" value="Y"/>
</c:if>

<script type="text/javascript">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.cmm.word.list" />';}catch(e){console.log(e.message);}

<c:if test="${!empty authorMessage}">
	alert('${authorMessage}');
	history.go(-1);
</c:if>

<c:if test="${funcVO.usrScrinTy eq 'W'}">
function fnDownExcel(){ 
	fnExcelList();
    excel = new ExcelGen({
        "src_id": "div-exceldown-table",
       "show_header": true
    }); 
        excel.generate('${resultVO.bbsNm}.xlsx'); 
}
</c:if>
function fnCallRegistForm() {

    $.ajax({
          type : 'POST'
        , dataType: 'html'
        , url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/registNttFormAjax.do'
        , cache : false
        , async : false
        , data:$("#listFrm").serialize()
        , success:function (data) {
            $('#bbs_area').html(data);
            $("#content").css("height",$(document).height());
            $(window).scrollTop(0);
        }
        , error:function (data) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
}

	$(document).ready(function(){
		$('#contentsCaption').html($('#menuNm').val() + ' <spring:message code="wzwg.module.word.postlist" />');
		// 글쓰기
		$('#regist_form_btn').click(function(){
			
			fnCallRegistForm();
			
		});
		
		// 말머리 선택
		$('#btn_subospecSeq').click(function(){
			
			var frm = document.listFrm;

			frm.pageIndex.value = 1;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
					
					if($('#tabBtn-' + $('#subospecSeq').val()).length > 0){
		            	$('#tabBtn-' + $('#subospecSeq').val()).focus();
		            }
		            
		            if($('#btn_subospecSeq').length > 0){
			            $('#btn_subospecSeq').focus();
		            }
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
			
		});
		
		// 말머리 수정
		$('#subospec_modify_btn').click(function(){
			var checkCnt = 0;
			var nttChkArr = "";

			$("input[name=nttChk]").each(function(){
				if(this.checked){
					nttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return;
			}
			
			var frm = document.listFrm;
			
			frm.checkNttSeq.value = nttChkArr;
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/modifySubospecPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  //$("#bbs_layer").show();
		    	  //$("#bbs_layer").html(data);
		    	  var title = '<spring:message code="wzwg.module.word.ctgryupdt" />';
		    	  wzAjaxModal('popup_s', title, data);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 게시물 이동
		$('#move_btn').click(function(){
			var checkCnt = 0;
			var nttChkArr = "";

			$("input[name=nttChk]").each(function(){
				if(this.checked){
					nttChkArr += $(this).val() + ",";
					checkCnt++;
				}
			});
			
			if(checkCnt < 1){
				alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
				return;
			}
			
			var frm = document.listFrm;
			
			frm.checkNttSeq.value = nttChkArr;
			
			$('body').css({overflow:'hidden'});
			
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/mvmnNttPopup.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (data) {
		    	  $("#bbs_layer").show();
		    	  $("#bbs_layer").html(data);
		    	  $("#content").css("height",$(document).height());
		    	  $(window).scrollTop(0);
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'html'
		 	});
		});
		
		// 삭제
		$('#delete_btn').click(function(){
			if(!confirm('<spring:message code="wzwg.cmm.msg.MSG059" />')){
				return;
			}else{
				var checkCnt = 0;
				var nttChkArr = "";

				$("input[name=nttChk]").each(function(){
					if(this.checked){
						nttChkArr += $(this).val() + ",";
						checkCnt++;
					}
				});
				
				if(checkCnt < 1){
					alert('<spring:message code="wzwg.cmm.msg.MSG087" />');
					return;
				}
					
				var frm = document.listFrm;
				
				frm.checkNttSeq.value = nttChkArr;
				
				$.ajax({
  					type:'POST'
					, url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/deleteNttInfoAjax.do'
					, cache : false
					, async : false
					, data:$("#listFrm").serialize()
					, success:function (result) {
						var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
							fnPage(1);
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
   					}
				   , error:function (request, status, error) {
				 	  alert('<spring:message code="fail.common.msg" text="error" />');
				   }
				   , dataType: 'xml'
				});
			}
		});
		
		// 체크박스 전체선택 / 해제
		$("input[name=nttAllChk]").on('click', function(){
			var boolean_chk = $("input[name=nttAllChk]").get(0).checked;
			$("input[name=nttChk]").each(function(){
				this.checked = boolean_chk;
			});
		});
		
		//$("#listCount").change(function(){
		//	fnPage(1);
		//});
		 
	});
	
	function fnListCountChange(){
		fnPage(1);
		$('#btn-listCount').focus();
	}
	
	// 상세정보
	function fnView(nttSeq, ntcrId, secretAt, parntsNttSeq, ntcrSeq){
		
		var viewAt = "N";
		
		if(secretAt == 'Y' && ntcrId != '비회원') {
			if('${loginVO.usrSeq}' == ntcrSeq || '${sessionScope.SADMIN_AT}' == 'true' || '${sessionScope.NADMIN_AT}' == 'true' || '${sessionScope.CNTNTS_ADMIN_AT}' == 'true'){
				viewAt = "Y";
			} else {
				viewAt = fnNtcrIdCheck(parntsNttSeq);	
			}
		} else {
			viewAt = "Y";
		}

		if(viewAt == "Y"){
			var frm = document.listFrm;
			frm.nttSeq.value = nttSeq;
			frm.parntsNttSeq.value = parntsNttSeq;
			frm.secretAt.value = secretAt;
			
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttDetailAjax.do'
				, cache : false
				, async : false
				, data:$("#listFrm").serialize()
				, success:function (data) {
					$('#bbs_area').html(data);
			     	$("#content").css("height",$(document).height());
			     	$(window).scrollTop(0);
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});				
		} else {
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;			
		}		
	}	
	
	function fnNtcrIdCheck(nttSeq) {
		var viewAt = "N";
		
		$.ajax({
			  type : 'POST'
			, dataType: 'xml'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/cmmn/selectNttNtcrIdAjax.do'
			, cache : false
			, async : false
			, data:"nttSeq="+nttSeq
			, success:function (result) {
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});

				if(value != '<c:out value="${loginVO.userId}"/>'){
					viewAt = "N";
				} else {
					viewAt = "Y";
				}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});			
		return viewAt;
	}
	
	function fnSearch(callId){
		var frm = document.listFrm;
		
		frm.searchAt.value = "";
		
		if(frm.searchKeyword.value != ""){
			frm.searchAt.value = "Y";	
		}
		
		frm.pageIndex.value = 1;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				if(callId != undefined || callId != ''){
	            	$('#' + callId).focus();
	            }
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnPage(pageIndex){
		var frm = document.listFrm;
		
		frm.pageIndex.value = pageIndex;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
				$("#content").css("height",$(document).height());
				//$(window).scrollTop(0);
				$('#pageInfo').find('.on>a').focus();
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	// 공지 게시물 삭제
	function fnDelNotice(nttSeq){
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.notice02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			$.ajax({
		        type:'POST'
		      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/modifyNttNoticeAjax.do'
		      , cache : false
		      , async : false
		      , data:$("#listFrm").serialize()
		      , success:function (result) {
		    	  var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						fnPage(1);
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
		      }
		      , error:function (request, status, error) {
		    	  alert('<spring:message code="fail.common.msg" text="error" />');
		      }
		      , dataType: 'xml'
		 	});
		}
	}
	
	// 댓글 팝업
	function fnAnswerPop(nttSeq, ntcrId, secretAt){
		
		if(secretAt == 'Y' && '${loginVO.userId}' != ntcrId){
			alert('<spring:message code="wzwg.cmm.msg.MSG004" />');
			return;
		}
		
		var frm = document.listFrm;
		
		frm.nttSeq.value = nttSeq;
		
		$('body').css({overflow:'hidden'});
		
		$.ajax({
	        type:'POST'
	      , url:'<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/answer/selectNttAnswerFormPopup.do'
	      , cache : false
	      , async : false
	      , data:$("#listFrm").serialize()
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
	
	// 말머리 선택
	function fnSubospecSelect(subospecSeq){
		
		var frm = document.listFrm;

		frm.pageIndex.value = 1;
		frm.subospecSeq.value = subospecSeq;
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/unity/selectNttRecycleListAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#bbs_area').html(data);
			}
			, error:function (data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	}
	
function fnExcelList(){
		
		var frm = document.listFrm;

		frm.pageIndex.value = 1; 
		
		$.ajax({
			  type : 'POST'
			, dataType: 'html'
			, url : '<c:out value="${wzwg_contextPath}${prefix}"/>/module/ntt/custom/selectNttExcelAjax.do'
			, cache : false
			, async : false
			, data:$("#listFrm").serialize()
			, success:function (data) {
				$('#div-exceldown').html(data);
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

	    	fnPage(1);
	    	return false;
		}
	}	
	// 이하 커스텀 게시판을 위한 스크립트
	var ctDataList = [];
	var ntDataList = [];
	
	var ctDataExcel = [];
	var ntDataExcel = [];
	
	function customDataParse(){
		
		//$('.customScript').remove();
		dataListProc(ntDataList, 'noti-row-');
		dataListProc(ctDataList, 'row-');
		
	}
	
	
	function customDataParseExcel(){
		//$('.customScript').remove();
		dataListProcExcel(ntDataExcel, 'noti-row-excel-');
		dataListProcExcel(ctDataExcel, 'row-excel-');
		
	}
	
	function dataListProc(dataList, trPreName){
		for(var i = 0 ; i < dataList.length ; i++){
			try{
				//console.log(dataList[i]);
				//var er = new RegExp(/\\/, "g");
				
				var src = dataList[i];
				//src = src.replace(er, '\\');
				src = src.replace(/\'/g, '"{sq}');
				//console.log(src);
				//console.log(JSON.parse(src));
				var jdata = JSON.parse(src);
				//console.log('ddd');
				
				var seq = jdata.nttSeq;
				if(!seq) continue;
				
				var tr = $('#' + trPreName +seq);
				
				for (var key in jdata) {
				    if(key == 'nttSeq') continue;
				    tr.find('td').each(function(idx, td){
				    var atchFileId = tr.attr('data-fileId');
				    	if($(this).attr('data-id') == key){
				    		
				    		if($(this).attr('data-ty') == 'image'){
				    			var img = '<img src="/module/upload/file/selectImageView.do?atchFileId=' + atchFileId + '&fileSn=' + jdata[key] + '" style="height:50px;">';
				    			if(jdata[key]) $(this).html(img);
				    		}else if($(this).attr('data-ty') == 'tel'){
				    			<c:if test="${funcVO.usrScrinTy eq 'W'}">
				    			var er = new RegExp('\"{sq}', "g");
				    			var value = jdata[key]; 
				    			value =fnWriteFieldDecrypt(value); 
				    			$(this).html(value.replace(er, '&apos;'));
				    			</c:if>
				    			<c:if test="${funcVO.usrScrinTy ne 'W'}">
				    			var tel = '<button type="button" class="wzbtn-table btn-basic" onclick="fnFieldDecrypt(this)" data-tel="' + jdata[key] + '"><spring:message code="wzwg.cmm.word.no" /> <spring:message code="wzwg.cmm.word.cnfirm" /></button>'; 
				    			if(jdata[key]) $(this).html(tel);
				    			</c:if>
				    		}else{
				    			var er = new RegExp('\"{sq}', "g");
				    			var value = jdata[key];
				    			$(this).html(value.replace(er, '&apos;'));
				    		}
				    	}
				    });
				    
				    if(key == 'password'){
				    	tr.attr('data-pw', jdata[key]);
				    }
				   
				} //end td for
				
				var auth = "${listDetAuthAt eq 'Y'}";
				    
			    tr.click(function(event){
			    	if($(event.target).is('td')){
			    		var nolognAt = "${funcVO.nolognAt eq 'Y' and adminAuthAt ne 'Y'}";
			    		var clickAction = '';
			    		if(nolognAt == "true"){
			    			clickAction = $(this).attr('data-pwchk');
			    		}else{
			    			clickAction = $(this).attr('data-click'); 
			    		}
			    		
			    		$(this).attr('onclick', clickAction);
			    		$(this).click();
			    	}
			    	
			    })
			    //tr.css('cursor', 'pointer');
				
			}catch(e){
				console.log('custom data json parse ERROR');
				continue;
			}
			
		}
	}
	
	function dataListProcExcel(dataList, trPreName){
		for(var i = 0 ; i < dataList.length ; i++){
			try{
				//console.log(dataList[i]);
				//var er = new RegExp(/\\/, "g");
				
				var src = dataList[i];
				//src = src.replace(er, '\\');
				src = src.replace(/\'/g, '"{sq}');
				//console.log(src);
				//console.log(JSON.parse(src));
				var jdata = JSON.parse(src);
				//console.log('ddd');
				
				var seq = jdata.nttSeq;
				if(!seq) continue;
				
				var tr = $('#' + trPreName +seq);
				
				for (var key in jdata) {
				    if(key == 'nttSeq') continue;
				    tr.find('td').each(function(idx, td){
				    var atchFileId = tr.attr('data-fileId');
				    	if($(this).attr('data-id') == key){
				    		
				    		if($(this).attr('data-ty') == 'image'){
				    			//var img = '/module/upload/file/selectImageView.do?atchFileId=' + atchFileId + '=char(102)fileSn=' + jdata[key];
				    			var img = '/module/upload/file/selectImageView.do?atchFileId=' + atchFileId ;
				    			if(jdata[key]) $(this).html(img);
				    		}else if($(this).attr('data-ty') == 'tel'){
				    			<c:if test="${funcVO.usrScrinTy eq 'W'}">
				    			var er = new RegExp('\"{sq}', "g");
				    			var value = jdata[key]; 
				    			value =fnWriteFieldDecrypt(value); 
				    			$(this).html(value.replace(er, '&apos;'));
				    			</c:if>
				    			<c:if test="${funcVO.usrScrinTy ne 'W'}">
				    			var tel = '<button type="button" class="wzbtn-table btn-basic" onclick="fnFieldDecrypt(this)" data-tel="' + jdata[key] + '"><spring:message code="wzwg.cmm.word.no" /> <spring:message code="wzwg.cmm.word.cnfirm" /></button>'; 
				    			if(jdata[key]) $(this).html(tel);
				    			</c:if>
				    		}else{
				    			var er = new RegExp('\"{sq}', "g");
				    			var value = jdata[key];
				    			$(this).html(value.replace(er, '&apos;'));
				    		}
				    	}
				    });
				    
				    if(key == 'password'){
				    	tr.attr('data-pw', jdata[key]);
				    }
				   
				} //end td for
				
				var auth = "${listDetAuthAt eq 'Y'}";
				    
			    tr.click(function(event){
			    	if($(event.target).is('td')){
			    		var nolognAt = "${funcVO.nolognAt eq 'Y' and adminAuthAt ne 'Y'}";
			    		var clickAction = '';
			    		if(nolognAt == "true"){
			    			clickAction = $(this).attr('data-pwchk');
			    		}else{
			    			clickAction = $(this).attr('data-click'); 
			    		}
			    		
			    		$(this).attr('onclick', clickAction);
			    		$(this).click();
			    	}
			    	
			    })
			    //tr.css('cursor', 'pointer');
				
			}catch(e){
				console.log('custom data json parse ERROR');
				continue;
			}
			
		}
	}
	
	function fnFieldDecrypt(btn){
		var data = $(btn).attr('data-tel');
		
		var frm = new FormData();
		frm.append('name','data');
		frm.append('data', data);
		
		
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
	    	  		var val = data.dataList[0];
	    	  		$(btn).after('<div>' + val.substring(0,(val.length-4)) + '****' + '</div>');
	    	  		$(btn).remove();
	    	  	}else{
	    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.decd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	    	  		
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
	}
	
	function fnWriteFieldDecrypt(tel){
		var data = tel;
		var value = '';
		var frm = new FormData();
		frm.append('name','data');
		frm.append('data', data);
		
		
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
	    	  		var val = data.dataList[0]; 
	    	  		value =val;
	    	  	}else{
	    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.decd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	    	  		
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});
		return value;
	}
	
	
	function passwordPopupClose(){
		$('#pwPassword').val('');
		$('.wzpopup .close').click();
		
	}
	
	function passwordPoopupOpen(trid){
		
	var data= '<div class="registor-box">'
			+'<table class="basic-table01"><tr><th scope="row">비밀번호</th><td><input type="password" id="pwPassword"  style="width: 100%;">'
			+'	<input type="hidden" id="selectTrId" value="'+trid+'"></td></tr></table>'
			+'</div>'
			+'<div class="btnbox-r">'
			+'	<button type="button" class="wzbtn btn-save" onclick="passwordCheckAction()"><spring:message code="wzwg.cmm.word.cnfirm" /></button><button type="button" class="wzbtn btn-basic" onclick="passwordPopupClose()"><spring:message code="wzwg.cmm.word.close" /></button></div>'
			+'</div>';
	
	if($('.wzpopup').size() == 0) {
		wzAjaxModal('popup_s', '<spring:message code="wzwg.cmm.word.password" /> <spring:message code="wzwg.cmm.word.input" /> ', data);
		$('#pwPassword').focus();
	}
	//	$('#selectTrId').val(trid);
	//	$('#password_popup').show();
	}
	
	function passwordCheckAction(){
		
		var pw = $('#pwPassword').val(); 
		var frm = new FormData();
		frm.append('name','data');
		frm.append('data', pw);
		
		
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
		    		$('#password').val(pw);
		    		
	    	  		var trpw = $('#row-' + $('#selectTrId').val()).attr('data-pw'); 
	    	  		if(trpw == data.dataList[0]){
	    	  			var clickAction = $('#row-' + $('#selectTrId').val()).attr('data-click'); 
		    			var a = $('<a>');
		    			a.attr('onclick', clickAction);
		    			a.click();
		    			  $('.wzpopup .close').click();
	    	  		}else{
	    	  			alert('<spring:message code="wzwg.cmm.msg.MSG050" />');
	    	  		}
	    	  		
	    	  	}else{
	    	  		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.encpt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
	    	  		return false;
	    	  	}
			}
			, error : function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
		});				
	}
</script>

		<c:if test="${nowUrl.indexOf('/mngr') > -1 }">
			<div class="wz_notice brbox bg-white br-blue-strong fl mt10" style="overflow:visible;">
		        <ul class="wd100 pl0">
	                <li class="admpg-subp wd100" style="list-style:none;">· <spring:message code="wzwg.cmm.msg.MSG0075"/></li>
		        </ul>
			</div>
		</c:if>
		
		<c:if test="${not empty resultVO.bbsPrface}">
		<div class="mb30">
			<c:out value='${resultVO.bbsPrface}' escapeXml="false" />
		</div>
		</c:if>

		<form:form modelAttribute="paramVO" path="listFrm" id="listFrm" name="listFrm" method="post">
			<form:hidden path="siteSeq" id=""/>
			<form:hidden path="bbsSeq" id=""/>
			<form:hidden path="nttSeq" id=""/>
			<form:hidden path="pageIndex" id=""/>
			<form:hidden path="ordrSe" id=""/>
			<form:hidden path="searchCnd" id=""/>
			<form:hidden path="checkNttSeq" id=""/>	
			<form:hidden path="menuSeq" id=""/>
			<form:hidden path="mngrAt" id=""/>
			<form:hidden path="parntsNttSeq" id=""/>
			<form:hidden path="secretAt" id=""/>		
			<form:hidden path="searchAt" id=""/>	
			<form:hidden path="sitecntntsSeq" id=""/>
			<input type="hidden" name="cmntUseAt" id="cmntUseAt" value="${resultVO.cmntUseAt}" />
			<input type="hidden" name="password" id="password"/>
			
			<c:set var="listCntSeTit"><spring:message code="wzwg.module.word.listcountse" /></c:set>
			
			<div>
				<c:if test="${resultVO.cmntUseAt ne 'Y'}">
				<div class="main-menu-bar i-block">
					<c:import url="${wzwg_contextPath}${prefix}/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do" charEncoding="utf-8">
						<c:param name="param_bbsSeq" value="${paramVO.bbsSeq}" />
					</c:import>	
				</div>	
				</c:if>
				
				<c:if test="${resultVO.listCountAt eq 'Y'}">
					<div style="float:right;">
					<form:select path="listCount" name="listCount" id="listCount" cssStyle="width:80px;margin-bottom:0px;" title="${listCntSeTit}">
						<c:forEach items="${countList}" var="countList">
							<form:option value="${countList}"><label for="list_count">${countList}<spring:message code="wzwg.cmm.word.count03" /></label></form:option>
						</c:forEach>
					</form:select>
					<button type="button" class="wzbtn btn-basic" id="btn-listCount" onclick="fnListCountChange()"><spring:message code="wzwg.cmm.word.change" /></button>
					</div>
				</c:if>
				
			</div>
			
			<%-- <c:set var="tableCss" value="basic-table02 txt-c"/>
			<c:if test="${paramVO.mngrAt eq 'N'}">
				<c:set var="tableCss" value="basic-table01"/>
			</c:if>		 --%>	
			
			<c:set var="tableCss" value="basic-table01"/>
					
			
			<c:set var="expsrAtNoAt" value="N"/>
			<c:set var="expsrAtWrtrAt" value="N"/>
			<c:set var="expsrAtRgsdAt" value="N"/>
			<c:set var="expsrAtIngrAt" value="N"/>
			
			<c:forEach items="${fn:split(resultVO.expsrAt, ',')}" var="expsrArr">
				<c:choose>
					<c:when test="${expsrArr eq 'N'}"><c:set var="expsrAtNoAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'W'}"><c:set var="expsrAtWrtrAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'R'}"><c:set var="expsrAtRgsdAt" value="Y"/></c:when>
					<c:when test="${expsrArr eq 'I'}"><c:set var="expsrAtIngrAt" value="Y"/></c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
	    	</c:forEach>

   			<h6 id="subospecSj_txt" class="hide-txt"><c:out value="${paramVO.subospecSj}"/><c:if test="${empty paramVO.subospecSj}"><spring:message code="wzwg.cmm.word.all" /></c:if></h6>

			<table class="${tableCss}" id="customBoard">
				<caption id="contentsCaption"><spring:message code="wzwg.module.word.postlist" /></caption>
				  <colgroup>
					<c:if test="${adminAuthAt eq 'Y'}">
						<col width="5%"/>						
					</c:if>
					<c:if test="${mobileAt eq 'N'}">
						<c:if test="${expsrAtNoAt eq 'Y' }"><col width="10%"/></c:if>
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<col width="*"/>
							</c:if>
						</c:forEach>
						<c:if test="${expsrAtWrtrAt eq 'Y' }"><col width="10%"/></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y' }"><col width="10%"/></c:if>
						<c:if test="${expsrAtIngrAt eq 'Y' }"><col width="10%"/></c:if>
						<!-- <col width="10%"/> -->
					</c:if>
					<c:if test="${mobileAt eq 'Y'}">
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<col width="*"/>
							</c:if>
						</c:forEach>
						<c:if test="${expsrAtWrtrAt eq 'Y' }"><col width="20%"/></c:if>
						<c:if test="${expsrAtRgsdAt eq 'Y' }"><col width="20%"/></c:if>
					</c:if>
			      </colgroup>
				  <thead>
					<tr>
						<c:if test="${adminAuthAt eq 'Y'}">
							<th scope="col"><input type="checkbox" name="nttAllChk" id="nttAllChk" title="<spring:message code="wzwg.cmm.word.rowallchoise" />"/></th>					
						</c:if>
						<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
							<th scope="col"><span><spring:message code="wzwg.cmm.word.no" /></span></th>
						</c:if>
						<c:forEach items="${fieldList }" var="list">
							<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y'}">
							<th scope="col"><span>${list.fieldNm }</span></th>
							</c:if>
						</c:forEach>
						<!-- <th><span><spring:message code="wzwg.cmm.word.sj" /></span></th> -->
						
						<c:if test="${expsrAtWrtrAt eq 'Y' }">
						<th scope="col"><span><spring:message code="wzwg.cmm.word.wrter" /></span></th>
						</c:if>
						 
						<c:if test="${expsrAtRgsdAt eq 'Y' }">
						<th scope="col">
							<span><spring:message code="wzwg.cmm.word.rgsde02" /></span>
						</th>
						</c:if>
						<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
							<th scope="col">
								<span><spring:message code="wzwg.cmm.word.inqire" /></span>
							</th>
						</c:if>
					</tr>
					
					<script type="text/javascript">
						var showAt = "N";
						function fnShowHeadListLayer() {
							if(showAt == "N") {
								showAt = "Y";
								$('#headListLayer').show();
							} else {
								showAt = "N";
								$('#headListLayer').hide();
							}
						}
					</script>
								
					<div class="ly_sbjt" id="headListLayer" style="left:12px;top:23px;display:none;z-index:1000;">
						<c:if test="${!empty subospecList}">
							<ul> 
							<li><a href="javascript:void(0);" onclick="fnSubospecSelect('');"><span><spring:message code="wzwg.module.word.allview" /></span></a></li>
							<c:forEach var="subospecList" items="${subospecList}" varStatus="status">
								<li><a href="javascript:void(0);" onclick="fnSubospecSelect('${subospecList.subospecSeq}');"><span><c:out value="${subospecList.subospecSj}"/></span></a></li>
							</c:forEach>
							</ul>										
						</c:if>
					</div>							
					
			      </thead>
				  <tbody>
	
					<c:import url="${wzwg_contextPath}${prefix}/module/ntt/cmmn/selectNttNoticeListAjax.do" charEncoding="utf-8">
						<c:param name="expsrAt" 	value="${resultVO.expsrAt}" />
						<c:param name="adminAuthAt" value="${adminAuthAt}" />
						<c:param name="mobileAt" 	value="${mobileAt}" />
						<c:param name="subospecSeq" value="${subospecSeq}" />
						<c:param name="noticeSe" 	value="N" />
						<c:param name="customSe" 	value="Y" />
					</c:import>	  
					
					<c:if test="${!empty resultList}">
			
						<c:forEach var="resultList" items="${resultList}" varStatus="status">		
						
						<c:set var="listDetAuthAt" value="" />	
						
						<c:if test="${loginVO.usrSeq eq resultList.ntcrSeq or nttAuthVO.authorSe eq 'R' or nttAuthVO.authorSe eq 'W' or adminAuthAt eq 'Y' or cmntAuthR eq 'Y' or cmntAuthW eq 'Y'}">
							<c:set var="listDetAuthAt" value="Y" />
						</c:if>									
						
						<c:choose>
							<c:when test="${listDetAuthAt eq 'Y'}">
								<c:set var="trClick">fnView('${resultList.nttSeq}', '${resultList.ntcrId}', '${resultList.secretAt}', '${resultList.parntsNttSeq}', '${resultList.ntcrSeq}');</c:set>
							</c:when>
							<c:otherwise>
								<c:set var="trClick">alert('<spring:message code="wzwg.cmm.msg.MSG084" />');</c:set>
							</c:otherwise>
						</c:choose>
							<c:if test="${funcVO.nolognAt eq 'Y' and adminAuthAt ne 'Y'}">
								<c:set var="trPwChk">passwordPoopupOpen('${resultList.nttSeq}');</c:set>
							</c:if>
						
						<%-- <tr id="row-${resultList.nttSeq}" onclick="${trClick}" style="cursor: pointer;"> --%>
						<tr id="row-${resultList.nttSeq}" data-click="${trClick}" data-pwchk="${trPwChk}" data-fileid="${resultList.atchFileId}">
							
							<c:if test="${adminAuthAt eq 'Y'}">
								<td><input type="checkbox" name="nttChk" value="${resultList.nttSeq}" title="<spring:message code="wzwg.cmm.word.rowchoise" />"/></td>				
							</c:if>						
			
							<c:if test="${mobileAt eq 'N' and expsrAtNoAt eq 'Y'}">
		
							<td>
							<c:choose>
								<c:when test="${resultVO.listNumCode eq 'P'}">
									<c:out value="${paginationInfo.totalRecordCount - ((paramVO.pageIndex-1) * paramVO.recordCountPerPage + status.count) + 1}"/>
								</c:when>
								<c:otherwise>
									<c:out value="${resultList.nttSeq}"/>
								</c:otherwise>
							</c:choose>
							</td>
							
							</c:if>
							
							<%-- 커스텀 필드세팅 --%>
							<c:forEach items="${fieldList }" var="list">
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드일 경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy eq 'title'}">
								<td class="txt-l">
										<c:choose>
											<c:when test="${!empty resultList.nttSj}">
												<c:if test="${fn:length(resultList.nttSj) > 43}">
													<c:set var="nttSj" value="${fn:substring(resultList.nttSj, 0, 43)}..." />
												</c:if>
												<c:if test="${fn:length(resultList.nttSj) < 44}">
													<c:set var="nttSj" value="${resultList.nttSj}" />
												</c:if>
											</c:when>
											<c:otherwise>
												<c:set var="nttSj"><spring:message code="wzwg.cmm.word.untitle"/></c:set>
											</c:otherwise>
										</c:choose>
								
										<c:if test="${resultList.lv > 1}">
											<c:set var="pd_reply_class" value="${(10 * resultList.lv) - 10}" />
											<img src="/images/wzwg/module/ntt/icoReply.png" style="margin-left:${pd_reply_class}px;" alt="<spring:message code="wzwg.cmm.word.answer03" />" />
										</c:if>
									
										<c:if test="${!empty resultList.subospecSj}">
											<span>[<c:out value="${resultList.subospecSj}"/>]</span>
										</c:if>
										
										<c:if test="${resultList.secretAt eq 'Y'}">
											<img src="/images/wzwg/module/ntt/ico-secret.png" alt="<spring:message code="wzwg.module.word.secretposts" />" />
										</c:if>
									
										<c:choose>
											<c:when test="${listDetAuthAt eq 'Y'}">
												<a href="javascript:void(0);" onclick="$(this).parent().click()"><c:out value="${nttSj}"/></a>
												<c:if test="${resultList.answerCnt > 0}">
													<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
												</c:if>					
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"><c:out value="${nttSj}"/></a>							
												<c:if test="${resultList.answerCnt > 0}">
													<%-- <a href="javascript:void(0);" onclick="alert('<spring:message code="wzwg.cmm.msg.MSG084" />');"> --%>
														<span class="colorRed">[<c:out value="${resultList.answerCnt}"/>]</span>
													<!-- </a> -->								
												</c:if>							
											</c:otherwise>
										</c:choose>	
										
										<c:if test="${resultList.nttNew eq 'Y'}">
											<img src="/images/wzwg/module/ntt/new.png" alt="<spring:message code="wzwg.module.word.newpostsicon" />"/>
										</c:if>
										
										<c:if test="${resultList.atchFileCnt ne '0'}">
											<img src="/images/wzwg/module/ntt/ico-file.gif" alt="<spring:message code="wzwg.module.word.atchfileicon" />"/>
										</c:if>	
								</td>
								</c:if>
								
								<%-- <spring:message code="wzwg.cmm.word.sj" /> 필드가 아닌경우 --%>
								<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' and list.fieldTy ne 'title'}">
								<td data-nm="${list.fieldNm }" data-id="${list.fieldId}" data-ty="${list.fieldTy }">
									
								</td>
								</c:if>
							</c:forEach>
							
							<c:if test="${expsrAtWrtrAt eq 'Y' }">
								<td>
									<c:if test="${resultList.annymtyAt eq 'Y'}"><spring:message code="wzwg.cmm.word.annymty" /></c:if>
									<c:if test="${resultList.annymtyAt ne 'Y'}"><c:out value="${resultList.ntcrNm}"/></c:if>							
								</td>
							</c:if>
							<c:if test="${expsrAtRgsdAt eq 'Y' }">
								<td><c:out value="${resultList.frstRegistPnttm}"/></td>
							</c:if>
							
							<c:if test="${mobileAt eq 'N' and expsrAtIngrAt eq 'Y'}">
								<td><c:out value="${resultList.inqireCnt}"/></td>
							</c:if>
							
						</tr>	
						<%-- <c:set var="squot">'</c:set>
						<c:set var="afterSquot">\'</c:set>
						<c:set var="pushdata">${fn:replace(resultList.nttCn, '\\"', '\\\\"')}</c:set>
						<c:set var="pushdata">${fn:replace(pushdata, squot, afterSquot)}</c:set>
						<c:set var="pushdata">${fn:replace(pushdata, '\\', '\\\\')}</c:set> --%>
						<%-- 인터넷에서 어디 이상한놈이 해놓은거 잘됨 --%>
						<c:set var="myContent" value="${resultList.nttCn}"/>
					    <c:set var="singlequote" value="'"/>
					    <c:set var="backslash" value="\\"/>
					    <c:if test="${fn:contains(myContent, singlequote) && !fn:contains(myContent,backslash)}">
					            <c:set var="search" value="'" />
					            <c:set var="replace" value="\\'" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					    </c:if>
					    <c:if test="${fn:contains(myContent, backslash) && !fn:contains(myContent,singlequote)}">
					            <c:set var="search" value="\\" />
					            <c:set var="replace" value="\\\\" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					    </c:if>
					    <c:if test="${fn:contains(myContent, singlequote) && fn:contains(myContent,backslash)}">
					            <c:set var="search" value="\\"/>
					            <c:set var="replace" value="\\\\" />
					            <c:set var="myContent" value="${fn:replace(myContent, search, replace)}"/>
					            <c:set var="find" value="'"/>
					            <c:set var="change" value="\\'" />
					            <c:set var="myContent" value="${fn:replace(myContent, find, change)}"/>
					    </c:if>
						
						<script class="customScript">
						ctDataList.push('${myContent}');
						</script>
						</c:forEach>
					</c:if>		
					
					<c:set var="colCnt" value="6" />
					<c:if test="${adminAuthAt eq 'Y'}">
						<c:set var="colCnt" value="7" />
					</c:if>
					
					<c:if test="${mobileAt eq 'Y'}">
						<c:set var="colCnt" value="${colCnt - 2}" />
				 	</c:if>
							
					<c:set var="colCnt" value="${colCnt - 1}" /><%-- 기존 <spring:message code="wzwg.cmm.word.sj" /> 칸수 제거 --%>
					<c:forEach items="${fieldList }" var="list">
						<c:if test="${list.listAt eq 'Y' and list.useAt eq 'Y' }">
						<c:set var="colCnt" value="${colCnt + 1}" />
						</c:if>
					</c:forEach>
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="${colCnt}"><spring:message code="wzwg.cmm.msg.MSG085" /></td>
						</tr>
					</c:if>	

				  </tbody>
			</table>
			<!-- 
			<div id="password_popup" style="position: absolute; top: 0; left: 0; height:100%; width:100%; background: rgba(50,50,50, 0.25); display:none;">
				<div style="border: solid 1px #f1f1f1; border-radius: 4px; margin: 10%; background: #fff;">
					<div><spring:message code="wzwg.cmm.word.password" /> <spring:message code="wzwg.cmm.word.input" /> <span onclick="passwordPopupClose()">X</span></div>
					<div>
						<input type="password" id="pwPassword">
						<input type="hidden" id="selectTrId">
					</div>
					<div><button type="button"><spring:message code="wzwg.cmm.word.cancl" /></button><button type="button" onclick="passwordCheckAction()"><spring:message code="wzwg.cmm.word.cnfirm" /></button></div>
				</div>
			</div>
 -->
			<c:if test="${!empty resultList}">
			<div class="ctr-box" id="pageInfo">
				<ul class="num mobile-none">
					<ui:pagination paginationInfo="${paginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
				
				<ul class="num pc-none">
					<ui:pagination paginationInfo="${mobilePaginationInfo}" type="ntt" jsFunction="fnPage" />
				</ul>
			</div>
			</c:if>
			
			<div class="ctr-box" id="nttSearch">
				<c:set var="searchTit"><spring:message code="wzwg.module.word.searchse" /></c:set>
				<c:set var="searchkeyinp"><spring:message code="wzwg.module.word.searchkeywordinput" /></c:set>
				<form:select path="searchCondition" title="${searchTit}"> 
					<form:option value="1"><label for="option1"><spring:message code="wzwg.cmm.word.cn" /></label></form:option>
					<c:if test="${expsrAtWrtrAt eq 'Y' }">
					<form:option value="3"><label for="option3"><spring:message code="wzwg.module.word.wrternm" /></label></form:option>
					</c:if>
				</form:select>
				
				<c:set var="srchwrd">
					<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.srchwrd" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>
				</c:set>
				<form:input path="searchKeyword" id="" placeholder="${srchwrd}" cssClass="txt" onkeydown="if(event.keyCode == 13){fnPage(1);}" title="${searchkeyinp}"/>
				<a href="javascript:void(0);" id="btn_search" class="wzbtn-table btn-srch" onclick="fnSearch('btn_search');"><spring:message code="wzwg.cmm.word.search01" /></a>		 
			</div>
			
			<div class="rt-box">

				<c:set var="subospecModAuthAt" value="" />
				<c:set var="movAuthAt" value="" />
				<c:set var="delAuthAt" value="" />
				<c:set var="regAuthAt" value="" />					
			
				<c:if test="${nttAuthVO.authorSe eq 'W' or cmntAuthW eq 'Y'}">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${funcVO.nolognAt eq 'Y' }">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				
				<c:if test="${adminAuthAt eq 'Y'}">
					<c:if test="${subospecListCnt > 0}">	
						<c:set var="subospecModAuthAt" value="Y" />
					</c:if>
					<c:set var="movAuthAt" value="Y" />
					<c:set var="delAuthAt" value="Y" />
					<c:set var="regAuthAt" value="Y" />
				</c:if> 
				<c:if test="${funcVO.nolognAt eq 'Y' }">
					<c:set var="regAuthAt" value="Y" />
				</c:if>
				<c:if test="${subospecModAuthAt eq 'Y'}">	
					<c:if test="${resultVO.cmntUseAt ne 'Y'}">		
					<a href="javascript:void(0);" class="wzbtn btn-basic fl" id="subospec_modify_btn"><spring:message code="wzwg.module.word.ctgryupdt" /></a>
					</c:if>
				</c:if>		
				<c:if test="${delAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-del fl" id="delete_btn"><spring:message code="wzwg.module.word.choisedelete" /></a>
				</c:if>							
				<%-- <c:if test="${movAuthAt eq 'Y'}">
					<c:if test="${resultVO.cmntUseAt ne 'Y'}">
					<a href="javascript:void(0);" class="btn-a" id="move_btn"><spring:message code="wzwg.cmm.word.mvmn" /></a>
					</c:if>
				</c:if> --%>
				<c:if test="${regAuthAt eq 'Y'}">
					<a href="javascript:void(0);" class="wzbtn btn-basic" id="regist_form_btn"><spring:message code="wzwg.module.word.postswrt" /></a>
					<c:if test="${funcVO.usrScrinTy eq 'W'}">
						<a href="javascript:void(0);" style="height:34px;margin-left:5px; " class="wzbtn btn-green ico-excel fr" onclick="fnDownExcel()"><spring:message code="wzwg.module.word.exceldwld" /></a>
					</c:if>
				</c:if>																	
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
	
		<c:if test="${not empty resultVO.bbsCnclsn}">
		<div class="mt30">
			<c:out value='${resultVO.bbsCnclsn}' escapeXml="false" />
		</div>
		</c:if>
		<c:if test="${funcVO.usrScrinTy eq 'W'}">
		<iframe id="ifExcelSave" style="display: none"></iframe> <!-- 페이지 공통 JSP에 넣으면 좋음 -->
		<div id="div-exceldown" class="hide"  style="display: none"></div>
		</c:if>
		
		<script>
		customDataParse();
		</script>
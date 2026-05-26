<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/file/selectFileList.do"
			, data : "siteSeq=<c:out value="${fileVO.siteSeq}" />&atchFileId=<c:out value="${fileVO.atchFileId}" />&updateFlag=<c:out value="${fileVO.updateFlag}" />&posblAtchFileNumber=<c:out value="${fileVO.posblAtchFileNumber}" />&helpAt=<c:out value="${fileVO.helpAt}" />"
			, success : function (data) {
				$("#file_div_<c:out value="${fileVO.atchFileId}" />").html(data);
				if('<c:out value="${param.listScrinCode}" />' == 'I'){
					console.log($(".attatch_file_box > #file_text_1").eq(0));
					$(".attatch_file_box > #file_text_1").eq(0).attr('placeholder','<spring:message code="wzwg.cmm.msg.MSG332"/>'); 
				}
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	});
	
	function fnFileDown(atchFileId, fileSn) {
		var downUrl = "";
		var usemode = "${fileVO.usemode}";

		if (!usemode) {
			downUrl = "<c:url value='/module/upload/file/fileDown.do'/>";
		} else if (usemode === 'bbs') {
			downUrl = "<c:url value='/module/upload/file/fileBBSDown.do'/>";
		}

		// 동적 Form 생성
		var $form = $('<form>', {
			method: 'POST', 
			action: downUrl,
			target: 'filedown_frame'
		});

		$form.append($('<input>', {type: 'hidden', name: 'atchFileId', value: atchFileId}));
		$form.append($('<input>', {type: 'hidden', name: 'fileSn', value: fileSn}));
		
		if (usemode === 'bbs') {
			$form.append($('<input>', {type: 'hidden', name: 'sitecntntsSeq', value: $('#sitecntntsSeq').val()}));
		}

		// 전송 후 폼 삭제
		$form.appendTo('body').submit().remove();
	}

	function fnFileDelete(atchFileId, fileSn) {
		if(confirm('<spring:message code="wzwg.cmm.msg.MSG089" />')){
			$.ajax({
				type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/module/upload/file/deleteFileInfs.do'
				, data:"atchFileId="+atchFileId+"&fileSn="+fileSn+"&updateFlag=<c:out value="${fileVO.updateFlag}" />"
				, success:function (result) {
					
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						
						$.ajax({
					        type:'POST'
					      , url:'<c:out value="${wzwg_contextPath}" />/module/upload/file/selectFileList.do'
					      , data:"siteSeq=<c:out value="${fileVO.siteSeq}" />&atchFileId=<c:out value="${fileVO.atchFileId}" />&updateFlag=<c:out value="${fileVO.updateFlag}" />&posblAtchFileNumber=<c:out value="${fileVO.posblAtchFileNumber}" />"
					      , success:function (data) {
					    	  $("#file_div_<c:out value="${fileVO.atchFileId}" />").html(data);
					    	  if('<c:out value="${param.listScrinCode}" />' == 'I'){
						    	  $(".attatch_file_box > #file_text_1").eq(0).attr('placeholder','<spring:message code="wzwg.cmm.msg.MSG332"/>');
						    	  }
					      }
					      , error:function (request, status, error) {
					    	  alert('<spring:message code="fail.common.msg" text="error" />');
					      }
					      , dateType: 'html'
					 	});
						
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
	
	function fnFileInfoCheck(val){
		
		var objFile = document.getElementById('file_' + val);
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
		
		if('<c:out value="${bbsSe}" />' != 'link'){
			<c:forEach var="resultList" items="${resultList}" varStatus="status">
			if("<c:out value="${resultList.fileEstbsExtsn}" />".indexOf(objExtsn) > -1){
				fileTyCode = "<c:out value="${resultList.fileTyCode}" />";
				fileEstbsAt = "Y";
			}
			</c:forEach>
		}else{
			if("<c:out value="${imgFileExt}" />".indexOf(objExtsn) > -1){
				fileTyCode = "SC00000063";
				fileEstbsAt = "Y";
			}
		}
		
		if(fileEstbsAt == "Y"){
			<c:forEach var="resultList" items="${resultList}" varStatus="status">
			
				if(fileTyCode == "<c:out value="${resultList.fileTyCode}" />"){
					fileCpcty = "<c:out value="${resultList.fileCpcty}" />";
					fileCpctySe = "<c:out value="${resultList.fileCpctySe}" />";
					fileEstbsExtsn = "<c:out value="${resultList.fileEstbsExtsn}" />";
					
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
			$('file_' + val).replaceWith( $('file_' + val).clone(true) );
			$('file_text_' + val).replaceWith( $('file_text_' + val).clone(true) );
		}else{	// IE 아닌경우
			document.getElementById('file_' + val).value = "";
			document.getElementById('file_text_' + val).value = "";
		}
		
	}
	
</script>

<form:form modelAttribute="fileVO" path="fileFrm" id="fileFrm" name="fileFrm" method="post">
	<form:hidden path="atchFileId" />
	<form:hidden path="fileSn" />
	<form:hidden path="updateFlag" />
	<form:hidden path="posblAtchFileNumber" />
	<form:hidden path="helpAt" />
	
	<iframe id="filedown_frame" style="visibility:hidden;display:none;" src=""></iframe>
	
</form:form>
	<div id="file_div_<c:out value="${fileVO.atchFileId}" />"></div>



	
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
        $("#dataManage").addClass("on");
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectFileListAjax.do"
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				$("#file_div").html(data); 
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
	});
	
	function fnSearch(pageIndex){ 
		if(isNaN(pageIndex)){console.log('잘못된 페이지호출');return;}
		$("#filectgrySeq").val($("#filectgrySeqList").val());
		$("#pageIndex").val(pageIndex);
		fnTabLink('dataManage');
	}
	
	function fnUpload(){  
		$("#filectgrySeq").val($("#filectgrySeqWrite").val()); 
		var frm = document.getElementById("fileFrm");
		
		if(!Validator.validate(document.fileFrm)){
			return;
		}
		
		 var formData = new FormData(frm);
 
		 
		 var frm = $("#fileFrm");
	        
	        frm.ajaxSubmit({
	            type:'POST'
	            , url:'<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/uploadFileAjax.do'
	            , async: false
	            , data: frm 
	            , mimeType: 'multipart/form-data'
	            , success:function(result){
	            	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
	              	fnTabLink('dataManage');
	            }
	            , error:function (request, status, error) {
	                  alert('<spring:message code="fail.common.msg" text="error" />');
	              }
	            , dateType: 'html'
	        });
 
		
	}
	function fnCtgryAdd(){

		if(!Validator.validate(document.fileFrm)){
			return;
		}
		
		
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/registCtgryFileAjax.do"
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
				fnTabLink('bassInfo');
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnCtgryDelete(filectgrySeq){
		$('#filectgrySeq').val(filectgrySeq);
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/deleteCtgryFileAjax.do"
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
				fnTabLink('bassInfo');
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	
	function fnFileDelete(usrfileSeq){
		$('#usrfileSeq').val(usrfileSeq);
		$.ajax({
			type : 'POST'
			, url : "<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/deleteFileAjax.do"
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
				fnTabLink('dataManage');
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	function fnTabLink(tab){
		var dataUrl = '';
		if(tab == 'dataManage' || tab ==''){
			dataUrl ="<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectFileListAjax.do";
		}else{
			dataUrl ="<c:out value="${wzwg_contextPath}" />/module/upload/usr/file/selectCtgryListAjax.do";
		}
		
		$.ajax({
			type : 'POST'
			, url : dataUrl
			, data :$("#fileFrm").serialize()
			, success : function (data) {
				$(".step > .tapMenu > li > a").removeClass("on");
		          $("#"+tab).addClass("on");
				$("#file_div").html(data); 
			}
			, error : function (data) {
			    alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	}
	
	
	function fnFileDown(atchFileId, fileSn){
		window.open("<c:url value='${wzwg_contextPath}/module/upload/file/fileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"'/>");
	}
 
	
	 
</script>

<form id="fileFrm" name="fileFrm" method="post" enctype="multipart/form-data" >
 		<div class="step underLine theme-blue">
	    	<ul class="tapMenu">		
				<li><a href="javascript:void(0);" onclick="fnTabLink('dataManage');" 	title="<spring:message code="wzwg.cmm.menu.datamanage" />" 	id="dataManage" name="bbsTab"><spring:message code="wzwg.cmm.menu.datamanage" /></a></li>
				<li><a href="javascript:void(0);" onclick="fnTabLink('bassInfo');" 		title="<spring:message code="wzwg.module.word.ctgrymanage" />" 	id="bassInfo" 	name="bbsTab"><spring:message code="wzwg.module.word.ctgrymanage" /></a></li>
			</ul>
		</div>
	
	<div id="file_div"></div> 


</form>

	
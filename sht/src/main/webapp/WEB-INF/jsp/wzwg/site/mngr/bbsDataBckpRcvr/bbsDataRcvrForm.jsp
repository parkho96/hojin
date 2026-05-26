<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

	$(document).ready(function(){

	});	

    function fnNttExcelUpload() {
    	var frm = document.dataFrm;
    	var formData = new FormData(frm);
    	
    	if(fnFileCheck()) {

	   	  	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.recovry02" /></spring:argument>'+
						  '</spring:message>')){
	   	        $.ajax({
	   	            type : 'POST'
	   	          	, url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/registBbsDataRcvr.do'
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
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>');
						}else if(value == 'nocnt'){
							alert('<spring:message code="wzwg.cmm.msg.MSG133" />');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
	
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
	   			});   
	   	  	}
    	}
    }    
    
    function fnFileExcelUpload() {
    	var frm = document.dataFrm;
    	var formData = new FormData(frm);
    	
    	if(fnFileCheck()) {

   	  		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
						'<spring:argument><spring:message code="wzwg.site.bbsbckp.msg.MSG001" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.recovry02" /></spring:argument>'+
					  '</spring:message>')){
	   	        $.ajax({
	   	            type : 'POST'
	   	          	, url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/registBbsFileDataRcvr.do'
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
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.site.bbsbckp.msg.MSG001" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>');
						}else if(value == 'nocnt'){
							alert('<spring:message code="wzwg.cmm.msg.MSG133" />');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
	
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
	   			});   
	   	  	}
    	}
    }    
    
    function fnFileCheck() {
    	var filename = document.getElementById("file").value.toLowerCase();
    	var format = "\.(xls|xlsx)";
    	if(!(new RegExp(format,'i')).test(filename)) {
    		alert('<spring:message code="wzwg.cmm.msg.MSG134" />');
    		return false;
    	} else {
    		return true;
    	}
    } 
    
    function fnTabLink(val){
    	
		var pageUrl = "";
		
		if(val == 'backup'){
			pageUrl = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpForm.do";
		}
		if(val == 'recovery'){
			pageUrl = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsDataRcvrForm.do";
		}
		
    	frm = document.dataFrm;
    	frm.method = "post";
    	frm.action = pageUrl;
    	frm.submit();
    }
</script>

    <div class="step wztab underLine theme-blue">
    	<ul class="tapMenu">
			<li><a href="javascript:void(0);" onclick="fnTabLink('backup');" title="<spring:message code="wzwg.cmm.word.backup"/>" id="backup" name="bbsTab"><spring:message code="wzwg.cmm.menu.backup" /></a></li>
			<li><a href="javascript:void(0);" onclick="fnTabLink('recovery');" 	title="<spring:message code="wzwg.cmm.word.recovry02"/>" id="recovery" name="bbsTab" class="on"><spring:message code="wzwg.cmm.menu.restore" /></a></li>
		</ul>
	</div>

	<div class="wz_cowrap">
		<!-- <div class="mg_t10">&nbsp;</div> -->
		
		<%-- <div class="search-box">
			<p class="notice">※ <spring:message code="wzwg.cmm.msg.MSG157" /></p>
			<ul class="txt-l red">
				<li>1. <spring:message code="wzwg.cmm.msg.MSG291" /></li>
				<li>2. <spring:message code="wzwg.cmm.msg.MSG292" /></li>
				<li>3. <spring:message code="wzwg.cmm.msg.MSG293" /></li>
				<li>4. <spring:message code="wzwg.cmm.msg.MSG294" /></li>
			</ul>
			<p>&nbsp;</p>
			<p class="notice">* <spring:message code="wzwg.site.bbsbckp.msg.MSG005" /></p>
			<ul class="txt-l">
				<li> -> <spring:message code="wzwg.cmm.msg.MSG295" /></li>
				<li> -> <spring:message code="wzwg.cmm.msg.MSG296" /></li>
			</ul>
			<p>&nbsp;</p>
			<p class="notice">* <spring:message code="wzwg.site.bbsbckp.msg.MSG006" /></p>
			<ul class="txt-l">
				<li> -> <spring:message code="wzwg.cmm.msg.MSG297" /></li>
				<li> -> <spring:message code="wzwg.cmm.msg.MSG298" /></li>
			</ul>
		</div>	 --%>
		
		<div class="wz_notice">
			<h4 class="admpg-tit2"><spring:message code="wzwg.cmm.word.precautions"/></h4>
			<ul class="wd100 mt20">
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG291" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG292" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG293" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG294" /></li>
			</ul>
		</div>
		
		<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.site.bbsbckp.msg.MSG005" /></h4>
			<ul class="txt-l wd100 fl mb30">
				<li class="wz_stepli wd66"><p><spring:message code="wzwg.cmm.msg.MSG295" /></p></li>
				<li class="wz_stepli wd30"><p><spring:message code="wzwg.cmm.msg.MSG296" /></p></li>
			</ul>
		<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.site.bbsbckp.msg.MSG006" /></h4>
		<ul class="txt-l wd100 fl mb30">
				<li class="wz_stepli wd66"><p><spring:message code="wzwg.cmm.msg.MSG297" /></p></li>
				<li class="wz_stepli wd30"><p><spring:message code="wzwg.cmm.msg.MSG298" /></p></li>
			</ul>
		<!-- <div class="mg_t10">&nbsp;</div> -->
		
		<form:form modelAttribute="paramVO" path="dataFrm" id="dataFrm" name="dataFrm" method="post">
		<input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>"/>
		
		<input id="dataFileRcv" style="width:300px;" type="text" title="<spring:message code="wzwg.cmm.word.file"/>" readonly="readonly" dir="required">
		<a class="wzbtn-table btn-basic" onclick="$('#file').click();" href="javascript:void(0);"><spring:message code="wzwg.cmm.word.wa.fileSelect" /></a>
		<input type="file" name="file" id="file" style="width:500px; display:none;" onchange="document.getElementById('dataFileRcv').value=this.value;"/>
		
		</form:form>	
		
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="fnNttExcelUpload();" id="excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.MSG289" /></a>	
			<a href="javascript:void(0);" onclick="fnFileExcelUpload();" id="excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.MSG290" /></a>		
		</div>		
	
	</div>
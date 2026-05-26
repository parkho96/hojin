<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

	$(document).ready(function(){

	});	
	
	function fnBbsExcelUpload() {
    	var frm = document.dataFrm;
    	var formData = new FormData(frm);

    	if(fnFileCheck()) {
	   	  	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.bbs" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument>'+
						  '</spring:message>')){
	   	        $.ajax({
	   	            type : 'POST'
	   	          	, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/trans/registSysMngrBbsTransAjax.do'
	   				, mimeType: 'multipart/form-data'
	   				, cache : false
	   				, async : false
	   				, processData: false
	   				, contentType: false
	   				, data : formData
					, success : function (result) {
						alert('<spring:message code="wzwg.sysMngr.msg.MSG055" />');
						/***  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						}else if(value == 'nocnt'){
							alert('<spring:message code="wzwg.cmm.msg.MSG133" />');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
						***/
	
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
	   			});   
	   	  	}
    	}
    }    
	

    function fnNttExcelUpload() {
    	var frm = document.dataFrm;
    	var formData = new FormData(frm);
    	
    	if(fnFileCheck()) {

	   	  	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
							'<spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument>'+
							'<spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument>'+
						  '</spring:message>')){
	   	        $.ajax({
	   	            type : 'POST'
	   	          	, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/trans/registSysMngrNttTransAjax.do'
	   				, mimeType: 'multipart/form-data'
	   				, cache : false
	   				, async : false
	   				, processData: false
	   				, contentType: false
	   				, data : formData
					, success : function (result) {
						alert('<spring:message code="wzwg.sysMngr.msg.MSG055" />');
				    	/***  
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
						}else if(value == 'nocnt'){
							alert('<spring:message code="wzwg.cmm.msg.MSG133" />');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
						***/
	
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
						'<spring:argument><spring:message code="wzwg.sysMngr.word.atchFile" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument>'+
					  '</spring:message>')){
	   	        $.ajax({
	   	            type : 'POST'
	   	          	, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/siteMngr/trans/registSysMngrAtchTransAjax.do'
	   				, mimeType: 'multipart/form-data'
	   				, cache : false
	   				, async : false
	   				, processData: false
	   				, contentType: false
	   				, data : formData
					, success : function (result) {
						alert('<spring:message code="wzwg.sysMngr.msg.MSG055" />');
				    	 /***
			    	  	var value = "";
						
						$(result).find("value").each(function() {  
							value = $(this).text();  
						});
						
						if(value == 'success'){
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.cmm.word.atch" /><spring:message code="wzwg.cmm.word.file" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.recovry" /></spring:argument></spring:message>');
						}else if(value == 'nocnt'){
							alert('<spring:message code="wzwg.cmm.msg.MSG133" />');
						}else{
							alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
						}
						**/
	
					}
					, error : function (request, status, error) {
						alert('<spring:message code="fail.common.msg" text="error" />');
					}
	   			});   
	   	  	}
    	}
    }    
    function fnFileCheck() {
    	var transFileTy = $("#transFileTy").val();
    	if(transFileTy == 'excel'){
    		if(fnFileExcelCheck()){
    			return true;	
    		}else{
    			return false;
    		}
    		
    	}else{
    		if(fnFileXmlCheck()){
    		return true;
    		}else{
    			return false;
    		}
    	}
    	
    }
    function fnFileXmlCheck() {
    	var filename = document.getElementById("file").value.toLowerCase();
    	var format = "\.(xml|XML)";
    	if(!(new RegExp(format,'i')).test(filename)) {
    		alert('<spring:message code="wzwg.cmm.msg.MSG134" />');
    		return false;
    	} else {
    		return true;
    	}
    } 
    
    function fnFileExcelCheck() {
    	var filename = document.getElementById("file").value.toLowerCase();
    	var format = "\.(xlsx|xls)";
    	if(!(new RegExp(format,'i')).test(filename)) {
    		alert('<spring:message code="wzwg.cmm.msg.MSG134" />');
    		return false;
    	} else {
    		return true;
    	}
    } 
     
</script>

      <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <h3> </h3>
            </c:otherwise>
            </c:choose>

	<div class="wz_cowrap">
		<form:form modelAttribute="paramVO" path="dataFrm" id="dataFrm" name="dataFrm" method="post">
	
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
			<p class="notice">* <spring:message code="wzwg.cmm.word.ntt" /> <spring:message code="wzwg.cmm.word.recovry02" /> <spring:message code="wzwg.cmm.word.mth" /></p>
			<ul class="txt-l">
				<li> -> <spring:message code="wzwg.cmm.msg.MSG295" /></li>
				<li> -> <spring:message code="wzwg.cmm.msg.MSG296" /></li>
			</ul>
			<p>&nbsp;</p>
			<p class="notice">* <spring:message code="wzwg.cmm.word.atch" /> <spring:message code="wzwg.cmm.word.file" /> <spring:message code="wzwg.cmm.word.recovry02" /> <spring:message code="wzwg.cmm.word.mth" /> </p>
			<ul class="txt-l">
				<li> -> <spring:message code="wzwg.cmm.msg.MSG297" /></li>
				<li> -> <spring:message code="wzwg.cmm.msg.MSG298" /></li>
			</ul>
		</div>	 --%>
		
		<div class="wz_notice">
			<h4 class="admpg-tit2"><spring:message code="wzwg.cmm.word.precautions"/></h4>
			<ul class="wd100 mt20">
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG116" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG117" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG118" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG119" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG120" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.tip.MSG121" /> (EX /upload/<c:out value="${paramVO.siteSeq}" />/trans/<spring:message code="wzwg.sysMngr.word.legacyCours" />)</li>
			</ul>
		</div>
		
		<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.sysMngr.word.bbsRegistMth" /> <a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=1"    class="wzbtn-table btn-green ml25">SAMPLE EXCEL</a> <a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=2"   class="wzbtn-table btn-green">SAMPLE XML</a></h4>
			<ul class="txt-l wd100 fl mb30">
				<li class="wz_stepli wd66"><p><spring:message code="wzwg.cmm.msg.tip.MSG122" /> </p></li>
				<li class="wz_stepli wd30"><p><spring:message code="wzwg.cmm.msg.tip.MSG123" /></p></li>
			</ul>
			
			<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.sysMngr.word.nttRegistMth" /><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=3"   class="wzbtn-table btn-green ml25">SAMPLE EXCEL</a> <a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=4"  class="wzbtn-table btn-green">SAMPLE XML</a></h4>
			<ul class="txt-l wd100 fl mb30">
				<li class="wz_stepli wd66"><p><spring:message code="wzwg.cmm.msg.tip.MSG124" /></p></li>
				<li class="wz_stepli wd30"><p><spring:message code="wzwg.cmm.msg.tip.MSG125" /></p></li>
			</ul>
			
		<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.sysMngr.word.atchFileRegistMth" /><a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=5"   class="wzbtn-table btn-green ml25">SAMPLE EXCEL</a> <a href="<c:out value="${wzwg_contextPath}" />/sysMngr/module/upload/transFile/fileTransDown.do?fileSeq=6"   class="wzbtn-table btn-green">SAMPLE XML</a></h4>
		<ul class="txt-l wd100 fl mb30">
				<li class="wz_stepli wd66"><p><spring:message code="wzwg.cmm.msg.tip.MSG126" /></p></li>
				<li class="wz_stepli wd30"><p><spring:message code="wzwg.cmm.msg.tip.MSG127" /></p></li>
			</ul>
		<!-- <div class="mg_t10">&nbsp;</div> -->
		
		<input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${paramVO.siteSeq}" />"/>
	<select name="transFileTy" id="transFileTy">
			<option value="excel">excel</option>
			<option value="xml">xml</option>
		</select>
		<input type="file" name="file" id="file" style="width:500px;"/>
		
		</form:form>	
		
		<div class="rt-box">
		   <a href="javascript:void(0);" onclick="fnBbsExcelUpload();" id="excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.tip.MSG128" /></a>
			<a href="javascript:void(0);" onclick="fnNttExcelUpload();" id="excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.tip.MSG129" /></a>	
			<a href="javascript:void(0);" onclick="fnFileExcelUpload();" id="excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.tip.MSG130" /></a>		
		</div>		
	
	</div>
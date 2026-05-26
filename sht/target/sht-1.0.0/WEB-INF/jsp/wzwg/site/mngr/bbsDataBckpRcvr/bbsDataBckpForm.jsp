<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<!-- 셀렉트 검색 라이브러리 -->
<link href="/js/wzwg/cmm/select2/select2.css" rel="stylesheet" />
<script src="/js/wzwg/cmm/select2/select2.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		fnBbsmoduleChange($("#bbsmoduleSeq").val());
		
		$('#bbsSeq').select2();
	});	

    function fnBbsmoduleChange(bbsmoduleSeq) {
    	if(bbsmoduleSeq != ""){
    		$("#sysmoduleSeq").val(bbsmoduleSeq);
  
	        $.ajax({
	            type : 'POST'
	          , dataType: 'xml'
	          , contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
	          , url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsListAjax.do'
	          , cache : false
	          , async : false
	          , data:$("#dataFrm").serialize()
	          , success : function(xml, status, request) {
	              
	              $("#bbsSeq").find("option").remove().end().append("option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
	              $("#bbsSeq").append("<option value=\"\">::<spring:message code="wzwg.cmm.word.choise" />::</option>");
	              $(xml).find("item").each(function(){
	                  var cntntsSeq = $(this).find('name').text();
	                  var cntntsNm = $(this).find('value').text();
	                  $("#bbsSeq").append("<option value=\"" +cntntsSeq+ "\">" + cntntsNm + "</option>");
	              });
	              
	          }
	          , error:function (data) {
	              alert('<spring:message code="fail.common.msg" text="error" />');
	          }
	      });

        }else{
        	$("#bbsSeq").empty();
        	$("#bbsSeq").append('<option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>');
        }
    	
    	fnBbsChange("");
	}
    
    function fnBbsChange(bbsSeq) {
    	
    	if(bbsSeq != "" ) {
   	        $.ajax({
   	            type : 'POST'
   	          	, url:'<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectModuleBbsSeAjax.do'
  	          	, cache : false
	          	, async : false
	          	, data:$("#dataFrm").serialize()
				, success : function (result) {
			    	  
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'simp'){
						$("#file_excel_btn").show();
					}else{
						$("#file_excel_btn").hide();
					}

				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
   			});    		
    	} else {
    		$("#file_excel_btn").hide();
    	}
    }
    
    function fnNttExcelDownload() {
    	var frm = document.dataFrm;
    	
    	if($("#sysmoduleSeq").val() == "") {
    		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.module" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				  '</spring:message>');
    		return false;
    	} else	if($("#bbsSeq").val() == "") {
    		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.bbs" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				  '</spring:message>');
    		return false;
    	} else {

	   	  	if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
						'<spring:argument><spring:message code="wzwg.cmm.word.ntt" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.backup" /></spring:argument>'+
					  '</spring:message>')){ 	
	   			frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpExcel.do";
	   			frm.method = "post";
	   			frm.submit();
	   	  	}
   	  	
    	}
    }   
    
    function fnNttFileExcelDownload() {
    	var frm = document.dataFrm;
    	
    	if($("#sysmoduleSeq").val() == "") {
    		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.module" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				  '</spring:message>');
    		return false;
    	} else	if($("#bbsSeq").val() == "") {
    		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.bbs" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>'+
				  '</spring:message>');
    		return false;
    	} else {

    		if(confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006">'+
						'<spring:argument><spring:message code="wzwg.site.bbsbckp.msg.MSG001" /></spring:argument>'+
						'<spring:argument><spring:message code="wzwg.cmm.word.backup" /></spring:argument>'+
					  '</spring:message>')){ 
	   			frm.action = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsFileDataBckpExcel.do";
	   			frm.method = "post";
	   			frm.submit();
	   	  	}
   	  	
    	}
    }     
    
    function fnTabLink(val){
    	
		var pageUrl = "";
    	frm = document.dataFrm;
		
		if(val == 'backup'){
			pageUrl = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpForm.do";
		}
		if(val == 'recovery'){
			frm.sysmoduleSeq.value = '';
			pageUrl = "<c:out value="${wzwg_contextPath}"/><c:out value="${prefix}"/>/siteMngr/bbsDataBckpRcvr/selectBbsDataRcvrForm.do";
		}
		
    	frm.method = "post";
    	frm.action = pageUrl;
    	frm.submit();
    }
</script>

    <div class="step wztab underLine theme-blue">
    	<ul class="tapMenu">
			<li><a href="javascript:void(0);" onclick="fnTabLink('backup');" title="<spring:message code="wzwg.cmm.menu.backup" />" id="backup" name="bbsTab" class="on"><spring:message code="wzwg.cmm.menu.backup" /></a></li>
			<li><a href="javascript:void(0);" onclick="fnTabLink('recovery');" 	title="<spring:message code="wzwg.cmm.menu.restore" />" id="recovery" name="bbsTab"><spring:message code="wzwg.cmm.menu.restore" /></a></li>
		</ul>
	</div>

	<div class="wz_cowrap">
		<!-- <div class="mg_t10">&nbsp;</div> -->
		
		<%-- <div class="search-box">
			<p class="notice">※ <spring:message code="wzwg.cmm.msg.MSG157" /></p>
			<ul class="txt-l red">
				<li>1. <spring:message code="wzwg.cmm.msg.MSG158" /></li>
				<li>2. <spring:message code="wzwg.cmm.msg.MSG159" /></li>
			</ul>
			<p>&nbsp;</p>
			<p class="notice">* <spring:message code="wzwg.site.bbsbckp.msg.MSG002" /></p>
			<ul class="txt-l"> 
				<li> -> <spring:message code="wzwg.cmm.msg.MSG160" /></li>
				<li> -> <spring:message code="wzwg.cmm.msg.MSG161" /></li>	
				<li> -> <spring:message code="wzwg.cmm.msg.MSG162" /></li>
				<li> ※ <spring:message code="wzwg.cmm.msg.MSG163" /></li>
			</ul>		
		</div>	 --%>
		
		<div class="wz_notice">
			<h4 class="admpg-tit2"><spring:message code="wzwg.cmm.word.precautions"/></h4>
			<ul class="wd100 mt20">
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG158" /></li>
				<li class="admpg-subp wd100"><spring:message code="wzwg.cmm.msg.MSG159" /></li>
			</ul>
		</div>
	
	
		<h4 class="admpg-tit3 ico-tit"><spring:message code="wzwg.site.bbsbckp.msg.MSG002" /></h4>
		<ul class="txt-l wd100 fl mb30"> 
			<li class="wz_stepli wd30"><p><spring:message code="wzwg.site.bbsbckp.msg.MSG003"/></p></li>
			<li class="wz_stepli wd30"><p><spring:message code="wzwg.site.bbsbckp.msg.MSG004"/></p>
				<ul class="wd100 fl">
					<li class="wz_tableguide fl"><spring:message code="wzwg.cmm.msg.MSG378" /></li> 
				</ul>
			</li>	
			<li class="wz_stepli wd40"><p><spring:message code="wzwg.cmm.msg.MSG379" /></p>
				<ul class="wd100 fl">
					<li class="wz_tableguide fl"><spring:message code="wzwg.cmm.msg.MSG162" /> </li> 
					<li class="wz_tableguide fl"><spring:message code="wzwg.cmm.msg.MSG380" /> <br>
												<spring:message code="wzwg.cmm.msg.MSG163" />
					</li>
				</ul>
			</li>
		</ul>	
		
		<!-- <div class="mg_t10">&nbsp;</div> -->
		
		<form:form modelAttribute="paramVO" path="dataFrm" id="dataFrm" name="dataFrm" method="post">
		<input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${paramVO.siteSeq}"/>"/>
		<input type="hidden" name="sysmoduleSeq" id="sysmoduleSeq" value=""/>
		
		<table class="basic mt10" style="border-top:1px solid #e5e5e5;">
			<colgroup>
				<col width="20%">
				<col width="80%">
			</colgroup>
		  <tbody>
		  			
			<tr>
				<th><spring:message code="wzwg.site.bbsbckp.msg.MSG003"/></th>
				<td>
					<select name="bbsmoduleSeq" id="bbsmoduleSeq" class="w20 mg_b30" onchange="fnBbsmoduleChange(this.value);">
						<c:forEach var="resultList" items="${bbsModuleList}">
							<option value="<c:out value="${resultList.sysmoduleSeq}"/>">
								 <c:if test="${sessionScope.LANG eq 'SC00000016' }">
			                       <c:out value="${resultList.moduleNm}"/>
			                    </c:if>
			                    <c:if test="${sessionScope.LANG ne 'SC00000016' }">
			                       <c:out value="${resultList.moduleNmEng}"/>
			                    </c:if>
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.site.bbsbckp.msg.MSG004"/></th>
				<td>
				    <select name="bbsSeq" id="bbsSeq" class="w20 mg_b30" onchange="fnBbsChange(this.value);">
				        <option value="">::<spring:message code="wzwg.cmm.word.choise" />::</option>
				    </select>  
				</td>
			</tr>
		</tbody>
		</table>
		
		</form:form>	
		
		<div class="rt-box">
			<a href="javascript:void(0);" onclick="fnNttExcelDownload();" id="ntt_excel_btn" class="wzbtn btn-del"><spring:message code="wzwg.cmm.msg.MSG164" /></a>		
			<a href="javascript:void(0);" onclick="fnNttFileExcelDownload();" id="file_excel_btn" class="wzbtn btn-del" style="display:none;"><spring:message code="wzwg.cmm.msg.MSG165" /></a>	
		</div>		
	
	</div>
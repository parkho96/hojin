<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

/* var oEditors = []; */

function fnRegistOrgInfoMem(orgnztNmKr, orgnztTySe){

	if(!Validator.validate(document.frmOrgMem)){
		return;
	}
	
	
	/* 시도지부그룹선택 */
	//var ctrdVal = $('#cityCodeGrpSel option:selected').val();
	//document.frmOrgMem.memCtrd.value = ctrdVal;	
	
	
	var orgnztSeq = document.frmOrgMem.orgnztSeq.value;
	var formData = $("#frmOrgMem").serialize();
	
	
	$.ajax({
		   type:'POST'
		 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/registOrgnztInfoMemAjax.do'
		 , data:formData
		 , success:function (data) {
			  if(data.head.result == 'success'){
				 alert('<spring:message code="wzwg.module.word.registcompt"/>');
				 //location.reload();
				 
				 fnGetOrgInfoMemList(orgnztSeq,orgnztNmKr,orgnztTySe);
			  	 wzModalClose();	
			  }else{
				  alert('<spring:message code="wzwg.module.word.registfailr"/>')
			  }
		 }
		 , dataType: 'html'
	});
	
}

</script>

<form id="frmOrgMem" name="frmOrgMem" method="post" >
	<input type="hidden" id="orgnztSeq" name="orgnztSeq" value="<c:out value="${paramVO.orgnztSeq}" />">
	
	
	
	<table class="basic">
	<colgroup>
		<col style="width: 35%;">
		<col style="width: *;">
	</colgroup>
	<tbody>				
			<tr>
				<th><spring:message code="wzwg.cmm.word.nm02" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td><input name="orgnztmberNm" id="orgnztmberNm" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.nm02" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.rspofc" /></th>
				<td><input name="orgnztmberClsf" id="orgnztmberClsf" class="w70" title="<spring:message code="wzwg.cmm.word.rspofc" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.chrgjob" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td><textarea name="chrgJob" id="chrgJob" class="w70 fs14" style="height: 100px;" title="<spring:message code="wzwg.module.word.chrgjob" />"></textarea></td>
			</tr>
 			
			<tr>   
				<th><spring:message code="wzwg.cmm.word.telno" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td><input name="telno" id="telno" class="w70" placeholder="(ex)010-0000-0000" dir="required" title="<spring:message code="wzwg.cmm.word.telno" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.fax" /></th>
				<td><input name="faxnum" id="faxnum" class="w70" placeholder="(ex)000-000-0000"  title="<spring:message code="wzwg.cmm.word.fax" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.email" /></th>
				<td><input name="emailAdres" id="emailAdres" class="w70" placeholder="(ex)test@test.com"  title="<spring:message code="wzwg.cmm.word.email" />"></td>
			</tr>
	</tbody>
	</table>

	<div class="rt-box">
		<button type="button" onmousedown="fnRegistOrgInfoMem('<c:out value="${paramVO.orgnztNmKr}" />','<c:out value="${paramVO.orgnztTySe}" />');" class="wzbtn btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></button> 
	</div>

</form>

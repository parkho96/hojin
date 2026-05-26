<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">

var oEditors = [];

function fnModifyOrgInfoMem(orgnztNmKr, orgnztTySe){
	
	
	var formData = $("#frmOrgMem").serialize();
	var orgnztSeq = document.frmOrgMem.orgnztSeq.value;
	
	
	if(!confirm('<spring:message code="wzwg.cmm.module.org.MSG007"/>')){
		return;
	}else{
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/modifyOrgnztInfoMemAjax.do'
			 , data:formData
			 , success:function (data) {
				  if(data.head.result == 'success'){

					 fnGetOrgInfoMemList(orgnztSeq,orgnztNmKr,orgnztTySe);
				  	 wzModalClose();	
				  }else{
					  alert('<spring:message code="wzwg.module.word.updtfailr"/><spring:message code="wzwg.cmm.msg.MSG331"/>');
				  }
			 }
			 , dataType: 'html'
		});
	}	
}

function fnDelOrgInfoMem(orgnztNmKr, orgnztTySe) {
	
	var formData = $("#frmOrgMem").serialize();
	var orgnztSeq = document.frmOrgMem.orgnztSeq.value;
	
	
	if(!confirm('<spring:message code="wzwg.cmm.module.org.MSG008"/>')){
		return;
	}else{
	
		$.ajax({
			   type:'POST'
			 , url:'<c:out value="${wzwg_contextPath}" />/mngr/module/orgnztInfo/deleteOrgnztInfoMem.do'
			 , data:formData
			 , success:function (data) {
				  if(data.head.result == 'success'){
					 
					 fnGetOrgInfoMemList(orgnztSeq,orgnztNmKr,orgnztTySe);
				  	 wzModalClose();	
				  }else{
					  alert('<spring:message code="wzwg.module.word.deletefailr" /><spring:message code="wzwg.cmm.msg.MSG331"/>');
				  }
			 }
			 , dataType: 'html'
		});
	}
		
}
</script>

<form id="frmOrgMem" name="frmOrgMem" method="post" >
	<input type="hidden" id="orgnztSeq" name="orgnztSeq" value="<c:out value="${orgnztInfoVO.orgnztSeq}" />">
	<input type="hidden" id="orgnztmberSeq" name="orgnztmberSeq" value="<c:out value="${orgnztInfoVO.orgnztmberSeq}" />">


	<table class="basic">
	<colgroup>
		<col style="width: 35%;">
		<col style="width: *;">
	</colgroup>
	<tbody>				
			<tr>
				<th><spring:message code="wzwg.cmm.word.nm02" /></th>
				<td><input name="orgnztmberNm" id="orgnztmberNm" class="w70" dir="required" title="<spring:message code="wzwg.cmm.word.nm02" />" value="<c:out value="${orgnztInfoVO.orgnztmberNm}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.rspofc" /></th>
				<td><input name="orgnztmberClsf" id="orgnztmberClsf" class="w70" title="<spring:message code="wzwg.cmm.word.rspofc" />" value="<c:out value="${orgnztInfoVO.orgnztmberClsf}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.module.word.chrgjob" /></th>
				<td>
					<textarea name="chrgJob" id="chrgJob" class="w70 fs14" style="height: 100px;" title="<spring:message code="wzwg.module.word.chrgjob" />"><c:out value="${orgnztInfoVO.chrgJob}" /></textarea>
					<!-- <div>
						<span class="circle_no bg-blue-strong">i</span>
						<span>i</span>
					</div> -->
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.telno" /></th>
				<td><input name="telno" id="telno" class="w70"  title="<spring:message code="wzwg.cmm.word.telno" />" value="<c:out value="${orgnztInfoVO.telno}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.fax" /></th>
				<td><input name="faxnum" id="faxnum" class="w70" title="<spring:message code="wzwg.cmm.word.fax" />" value="<c:out value="${orgnztInfoVO.faxnum}" />"></td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.email" /></th>
				<td><input name="emailAdres" id="emailAdres" class="w70"  title="<spring:message code="wzwg.cmm.word.email" />" value="<c:out value="${orgnztInfoVO.emailAdres}" />"></td>
			</tr>
	</tbody>
	</table>

	<div class="rt-box">
		<button type="button" onmousedown="fnDelOrgInfoMem('<c:out value="${paramVO.orgnztNmKr}" />','<c:out value="${paramVO.orgnztTySe}" />');" class="wzbtn wzbtn-table btn-del bg"><spring:message code="wzwg.cmm.word.delete" /></button> 
		<button type="button" onmousedown="fnModifyOrgInfoMem('<c:out value="${paramVO.orgnztNmKr}" />','<c:out value="${paramVO.orgnztTySe}" />');" class="wzbtn wzbtn-table btn-save bg"><spring:message code="wzwg.cmm.word.stre" /></button>
	</div>

</form>

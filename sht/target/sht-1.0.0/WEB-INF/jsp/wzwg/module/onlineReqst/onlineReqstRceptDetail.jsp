<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

<style type="text/css">
	.basic-table01 tbody tr td {padding-left:10px;}
	input {height:20px;}
	.attatch_file_box { position:relative; padding:0 !important;}
	.attatch_file_box .attatchfile { position:absolute; top:0; left:0; width:80%; font-size:45px; opacity:0; filter:alpha(opacity=0); cursor:pointer; vertical-align:middle;}
</style>


<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>


<script type="text/javascript">
<c:if test="${rceptAt eq 'Y'}">
try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.reqstcnfirm" />';}catch(e){console.log(e.message);}
</c:if>

	$(document).ready(function(){

		$('#cancle_btn').click(function(){
			$.ajax({
				  type : 'POST'
				, dataType: 'html'
				, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttListAjax.do'
				, cache : false
				, async : false
				, data : $("#searchFrm").serialize()
				, success : function(data) {
					$('#onlineReqst_area').html(data);
				}
				, error : function(data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});	
		});		

	});
	
	function fnRegistRcept() {

		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.reqst" /></spring:argument></spring:message>')){
			return;
		} else {			
		
			var frm = document.getElementById("modFrm");			
			
			var formData = new FormData(frm);
			
			$.ajax({
				  type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/registOnlineReqstRceptAjax.do'
				, mimeType : 'multipart/form-data'
				, cache : false
				, async : false
				, processData : false
				, contentType : false
				, data : formData
				, success : function(result) {
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.rcept" /></spring:argument></spring:message>');
						fnDetailReload();
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

	function fnModifyRcept() {

		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>')){
			return;
		} else {			
		
			var frm = document.getElementById("modFrm");			
			
			var formData = new FormData(frm);
			
			$.ajax({
				  type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/modifyOnlineReqstRceptAjax.do'
				, mimeType : 'multipart/form-data'
				, cache : false
				, async : false
				, processData : false
				, contentType : false
				, data : formData
				, success : function(result) {
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.stre" text="save" /></spring:argument></spring:message>');
						fnDetailReload();
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
	
	function fnCancleRcept() {

		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.cancl" /></spring:argument></spring:message>')){
			return;
		} else {			
		
			var frm = document.getElementById("modFrm");	
			frm.confmSttusCode.value = "SC00000117";
			
			var formData = new FormData(frm);
			
			$.ajax({
				  type : 'POST'
				, url : '<c:out value="${wzwg_contextPath}" />/module/onlineReqst/modifyOnlineReqstRceptAjax.do'
				, mimeType : 'multipart/form-data'
				, cache : false
				, async : false
				, processData : false
				, contentType : false
				, data : formData
				, success : function(result) {
		    	  	var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != 'fail'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></spring:argument></spring:message>');
						fnDetailReload();
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
	
	function fnDetailReload(){

		$.ajax({
			  type : 'POST'
			, dataType : 'html'
			, url : "<c:out value="${wzwg_contextPath}" />/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"
			, cache : false
			, async : false
			, data : $("#modFrm").serialize()
			, success : function(data) {
				$('#onlineReqst_area').html(data);
			}
			, error : function(data) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
		
		<c:if test="${rceptAt eq 'Y'}">
			try{document.title = $('#menuPath').val().replace(/>/gi,'-') + '<spring:message code="wzwg.module.word.reqstcnfirm" />';}catch(e){console.log(e.message);}
		</c:if>
		
	}

</script>

	<form:form modelAttribute="paramVO" path="modFrm" id="modFrm" name="modFrm" method="post" enctype="multipart/form-data" >
		<form:hidden path="reqstnttSeq"/>
		<form:hidden path="reqstSeq"/>
		<c:set var="rceptSeq" value="${onlineReqstRceptVO.rceptSeq}" />
		<c:set var="ttusCode" value="${onlineReqstRceptVO.confmSttusCode}" />
		
		<form:hidden path="rceptSeq" name="rceptSeq" value="${fn:escapeXml(rceptSeq)}"/>
		<form:hidden path="confmSttusCode" name="confmSttusCode" value="${fn:escapeXml(sttusCode)}"/>	
		<form:hidden path="beforeConfmSttusCode" name="beforeConfmSttusCode" value="${fn:escapeXml(sttusCode)}"/>
		
		
		
		<c:if test="${rceptAt eq 'N'}">
			<c:set var="subTitle"><spring:message code="wzwg.module.word.onlinetoreqst" /></c:set>
		</c:if>
		<c:if test="${rceptAt eq 'Y'}">
			<c:set var="subTitle"><spring:message code="wzwg.module.word.onlinereqststtus" /></c:set>
		</c:if>
		<h5 class="pb10 pt20"><c:out value="${subTitle}"/></h5>
		
		<table class="basic-table01">
		  <caption><spring:message code="wzwg.cmm.cmmMsg.CMG024"><spring:argument><c:out value="${subTitle}" /> <spring:message code="wzwg.cmm.word.applcnt" />, <spring:message code="wzwg.cmm.word.reqstdoc" /><c:if test="${rceptAt eq 'Y'}">, <spring:message code="wzwg.module.word.reqstde" />, <spring:message code="wzwg.cmm.word.sttus" /></c:if></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.wa.table" /></spring:argument></spring:message></caption>
		  <colgroup>
			<col width="20%" />
			<col width="80%" />
	      </colgroup>
		  <tbody>
			<tr>
				<th scope="row"><spring:message code="wzwg.cmm.word.applcnt" /></th>
				<td class="txt-l">
					<c:out value="${onlineReqstRceptVO.userNm}"/>(<c:out value="${onlineReqstNttVO.tyNm}"/>)	
				</td>
			</tr>
			<c:if test="${rceptAt eq 'Y'}">
			<tr>
				<th scope="row"><spring:message code="wzwg.module.word.reqstde" /></th>
				<td class="txt-l">
					<c:out value="${onlineReqstRceptVO.frstRegistPnttm}"/>						
				</td>
			</tr>
			<tr>
				<th scope="row"><spring:message code="wzwg.cmm.word.sttus" /></th>
				<td class="txt-l">
					<c:forEach items="${reqcscList}" var="reqcscList" varStatus="status">
						<c:if test="${reqcscList.code eq onlineReqstRceptVO.confmSttusCode}">
							<c:out value="${reqcscList.codeNm}"/>
						</c:if>
					</c:forEach>									
				</td>
			</tr>
			</c:if>				
			<tr>
				<th scope="row"><spring:message code="wzwg.cmm.word.reqstdoc" /></th>
				<td class="txt-l">
					<c:if test="${onlineReqstNttVO.progrsSttusCode ne 'SC00000114'}">
					
						<c:if test="${!empty onlineReqstRceptVO.atchFileId}">
							<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${onlineReqstRceptVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="Y" />
								<c:param name="param_atchFileNumber" value="1" />
								<c:param name="param_cntntsSeq" value="${paramVO.reqstSeq}" />
							</c:import>								
						</c:if>
						<c:if test="${empty onlineReqstRceptVO.atchFileId}">
							<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${onlineReqstRceptVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="N" />
								<c:param name="param_atchFileNumber" value="1" />
								<c:param name="param_cntntsSeq" value="${paramVO.reqstSeq}" />
							</c:import>	
						</c:if>
					
					</c:if>
					
					<c:if test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000114'}">
					
						<c:if test="${!empty onlineReqstRceptVO.atchFileId}">
							<c:import url="${wzwg_contextPath}/module/upload/file/selectFileInc.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" 	value="${onlineReqstRceptVO.atchFileId}" />
								<c:param name="param_updateFlag" 	value="N" />
								<c:param name="param_atchFileNumber" value="1" />
								<c:param name="param_cntntsSeq" value="${paramVO.reqstSeq}" />
							</c:import>				
						</c:if>						
					
					</c:if>				
				</td>
			</tr>
		  </tbody>
		</table>
	
	</form:form>
	
	<div class="rt-box txt-c">
	
		<c:if test="${rceptAt eq 'N'}">
			<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000109'}"> <!-- 자동승인(선착순) -->
				<c:choose>
					<c:when test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000112'}">
						<c:choose>
							<c:when test="${onlineReqstNttVO.psncpa == 0 or onlineReqstNttVO.psncpa > onlineReqstNttVO.reqstNmpr}">
								<a href="javascript:void(0);" onclick="fnRegistRcept();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.reqst" /></a>
							</c:when>
							<c:otherwise>
								<a href="javascript:void(0);" onclick="fnRegistRcept();" class="wzbtn btn-basic"><spring:message code="wzwg.module.word.waitreqst" /></a>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000113'}">
						<a href="javascript:void(0);" onclick="fnRegistRcept();" class="wzbtn btn-basic"><spring:message code="wzwg.module.word.waitreqst" /></a>
					</c:when>
				</c:choose>
			</c:if>
			<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000110'}"> <!-- 수동승인 -->
				<c:if test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000112'}">
					<a href="javascript:void(0);" onclick="fnRegistRcept();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.reqst" /></a>
				</c:if>
				<c:if test="${onlineReqstNttVO.progrsSttusCode eq 'SC00000113'}">
					<a href="javascript:void(0);" onclick="fnRegistRcept();" class="wzbtn btn-save"><spring:message code="wzwg.module.word.waitreqst" /></a>
				</c:if>
			</c:if>		
		</c:if>	
		<c:if test="${rceptAt eq 'Y'}">
			<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000109'}"> <!-- 자동승인(선착순) -->
				<c:if test="${onlineReqstNttVO.progrsSttusCode ne 'SC00000114'}">
					<a href="javascript:void(0);" onclick="fnCancleRcept();" class="wzbtn btn-del fl"><spring:message code="wzwg.module.word.reqstcancl" /></a>
					<a href="javascript:void(0);" onclick="fnModifyRcept();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
			</c:if>
			<c:if test="${onlineReqstNttVO.confmMthdCode eq 'SC00000110'}"> <!-- 수동승인 -->
				<c:if test="${onlineReqstNttVO.progrsSttusCode ne 'SC00000113' and onlineReqstNttVO.progrsSttusCode ne 'SC00000114'}">
					<a href="javascript:void(0);" onclick="fnCancleRcept();" class="wzbtn btn-del fl"><spring:message code="wzwg.module.word.reqstcancl" /></a>
					<a href="javascript:void(0);" onclick="fnModifyRcept();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.stre" /></a>
				</c:if>
			</c:if>					
		</c:if>
		<a href="javascript:void(0);" id="cancle_btn" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>	
		
	</div>		






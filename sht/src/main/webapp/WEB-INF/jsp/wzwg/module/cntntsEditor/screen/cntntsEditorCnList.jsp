<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script>
	function fn_cntntsEditorForm(cntntsCnSeq){
		if(cntntsCnSeq != undefined && cntntsCnSeq != ''){
			$('#cntntsEditorFrm #cntntsCnSeq').val(cntntsCnSeq);
		}
		
		$('#cntntsEditorFrm').submit();
		
	}
	
	function fn_deletesubhomeKotraInfoCn(cntntsCnSeq){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			$('#cntntsCnSeq').val(cntntsCnSeq);
			
			$.ajax({
		        type : 'POST'
				, url : '${fn:escapeXml(wzwg_contextPath)}/mngr/module/subhome/kotraInfo/deleteKotraInfoSubHomeCnAjax.do'
				, data : $("#cntntsEditorFrm").serialize()
				, success : function (data) {
					
					if(data.head.result == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						location.reload();
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
					}
					
				}
				, error : function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
			});
		}
	}
</script>

<form name="cntntsEditorFrm" id="cntntsEditorFrm" method="post" action="${fn:escapeXml(wzwg_contextPath)}${fn:escapeXml(prefix)}/module/cntntsEditor/selectModuleCntntsEditorDecoAjax.do" target="_blank">
<input type="hidden" name="cntntsCnSeq" id="cntntsCnSeq">
<input type="hidden" name="cntntsSeq" id="cntntsSeq" value="${fn:escapeXml(paramVO.cntntsSeq)}">
</form>

		<table class="wz_cowrap">
			<colgroup>
				<col width="20%"/>
				<col width="20%"/>
				<col width="*"/>
			</colgroup>
			<c:choose>
				<c:when test="${!empty cntntsCnList }">
					<%-- <tr>
						<th><spring:message code="wzwg.cmm.word.regist" /> <spring:message code="wzwg.cmm.word.de01" /></th>
						<td>
							<c:out value="${resultVO.frstRegistPnttm }"/>
						</td>
						<td class="rt-box txt-r">
      
                            <a href="javascript:void(0);" onclick="fn_registCntntsCnInit('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.template" /> <spring:message code="wzwg.cmm.word.applc" /></a>
							<a href="javascript:void(0);" onclick="fn_modifyCntntsCnForm('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.updt" /></a>
							<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${resultVO.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
						</td>
					</tr>
					<tr class="wideth-white">
					     <th colspan="3" class="wzAdmSTit"><spring:message code="wzwg.cmm.word.cntnts" /> <spring:message code="wzwg.cmm.word.cn" /></th>
					</tr>
					<tr>
						<td	colspan="3">
							<div style="max-width:960px;">
							<c:out value="${resultVO.cntntsCn }" escapeXml="false"/>
							</div>
						</td>
					</tr> --%>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="3" class="rt-box">
							<a href="javascript:void(0);" class="mainEditBtn" onclick="fn_cntntsEditorForm();"><img src="/images/wzwg/site/mngr/layout/writeBtn.png" alt=""><spring:message code="wzwg.cmm.msg.tip.MSG0690" /></a>
							<div class="admpg-subp w100 fl txt-l block pt20 pb50"><span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.tip.MSG069" /></div>
						</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		
		<!-- 게시물 목록 -->
		<h3 class="wzAdmSTit wd100 fl"><spring:message code="wzwg.cmm.word.historycntnts" /></h3>
		<table  class="basic-table">
		<colgroup>
			<col width="50%"/>
			<col width="30%"/>
			<col width="*"/>
		</colgroup>
		<thead>
			<tr>
				<th><spring:message code="wzwg.cmm.word.writng" /> <spring:message code="wzwg.cmm.word.dt" /></th>
				<th><spring:message code="wzwg.cmm.word.wrter" /></th>
				<th><spring:message code="wzwg.cmm.word.rm" /></th>
			</tr>			
		</thead>
		<tbody>
			<c:choose>
				<c:when test="${!empty cntntsCnList }">
					<c:forEach items="${cntntsCnList }" var="cntntsCnList" varStatus="status">
						<tr>
							<td><c:out value="${cntntsCnList.frstRegistPnttm }"/></td>
							<td><c:out value="${cntntsCnList.userId }"/></td>
							<td class="rt-box">
								<a href="javascript:void(0);" onclick="fn_cntntsEditorForm('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.edit"/></a>
								<a href="javascript:void(0);" onclick="fn_deleteCntntsCn('<c:out value="${cntntsCnList.cntntsCnSeq}"/>');" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.delete" /></a>
							</td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<td colspan="3"><spring:message code="wzwg.cmm.msg.MSG097" /></td>
				</c:otherwise>
			</c:choose>
		</tbody>
		</table>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
		<c:if test="${paramVO.qesitmTyCode eq 'SC00000326'}">
		fnDscrpTyChange('<c:out value="${iemList[0].iemTyCode}" />');
		</c:if>
	});

	function fnDscrpTyChange(paramSeq){
		if(paramSeq != 'SC00000331'){
			$("#dscrpTyDiv").empty();
			$("#dscrpTyDiv").append(
				'<th><spring:message code="wzwg.cmm.word.shrtrespty" />(<spring:message code="wzwg.cmm.word.ex02" />)</th>'
				+ '<td colspan="2"><input type="text" class="w80" readonly="readonly" placeholder="<spring:message code="wzwg.cmm.msg.MSG300" />"/></td>'
			);
		}else{
			$("#dscrpTyDiv").empty();
			$("#dscrpTyDiv").append(
				'<th><spring:message code="wzwg.cmm.word.lngrespty" />(<spring:message code="wzwg.cmm.word.ex02" />)</th>'
				+ '<td colspan="2"><textarea class="wd100 p10 box-border fs15 linehgt130" rows="10" cols="50" readonly="readonly"><spring:message code="wzwg.cmm.msg.MSG301" /></textarea></td>'
			);
		}
	}
	
	/** 문항 등록 */
	function fnQesitmRegist(){
 		if(!Validator.validate(document.qesitmFrm)){
 			return;
 		}

 		$.ajax({
 			type:'POST'
 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/registOnlineQustnrQesitmAjax.do'
 			, data:$("#qesitmFrm").serialize()
 			,success:function (result){
 				$(result).find('value').each(function(){
 					if($(this).text() == "success"){
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument></spring:message>');
 						wzModalClose();
 						fnQesitmInit();
 					}else{
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.regist" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
 					}
 				})
 			}
 			, error:function (request, status, error) {
 	              alert('<spring:message code="fail.common.msg" text="error" />');
 	          }
 		});
	}
	
	/** 문항 수정 */
	function fnQesitmModify(){
		if(!Validator.validate(document.qesitmFrm)){
 			return;
 		}

 		$.ajax({
 			type:'POST'
 			, url:'<c:out value="${wzwg_contextPath}" /><c:out value="${prefix}" />/module/onlineQustnr/modifyOnlineQustnrQesitmAjax.do'
 			, data:$("#qesitmFrm").serialize()
 			,success:function (result){
 				$(result).find('value').each(function(){
 					if($(this).text() == "success"){
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
 						wzModalClose();
 						fnQesitmInit();
 					}else{
 						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG008"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.failr" /></spring:argument></spring:message>');
 					}
 				})
 			}
 			, error:function (request, status, error) {
 	              alert('<spring:message code="fail.common.msg" text="error" />');
 	          }
 		});
	}
	
	/** 항목 row 추가 */
	function fnIemAdd(){
		$(".basic > tbody:last").append(
			'<tr><th><spring:message code="wzwg.cmm.word.view" /></th>'
			+ '<td><input type="text" name="iemNm" class="w100" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" /></td>'
			+ '<td class="txt-c"><a href="javascript:void(0);" onclick="fnRowDelete(this);" class="iconOnlyBtn btn-basic btn-delete"><spring:message code="wzwg.cmm.word.delete" /></a></td>'
			+ '</tr>'
		);
	}
	
	/** 항목 row 삭제 */
	function fnRowDelete(obj){
		$(obj).parent().parent().remove();
	}
	
</script>

<form id="qesitmFrm" name="qesitmFrm" method="post">
	<input type="hidden" name="qustnrSeq" value="<c:out value="${paramVO.qustnrSeq }" />"/>
	<input type="hidden" name="qesitmTyCode" value="<c:out value="${paramVO.qesitmTyCode }" />"/>
	<input type="hidden" name="qesitmSeq" value="<c:out value="${resultVO.qesitmSeq }" />"/>
	<div class="txt-r pd_tb5 mb5">
		<c:if test="${paramVO.qesitmTyCode eq 'SC00000324' or paramVO.qesitmTyCode eq 'SC00000325' }">
			<a href="javascript:void(0);" class="wzbtn-table btn-basic" onclick="fnIemAdd();"><spring:message code="wzwg.module.word.exadd" /> </a>
		</c:if>
	</div>
	<table class="basic">
		<colgroup>
			<col width="20%" />
			<col width="60%" />
			<col width="20%" />
		</colgroup>
		<thead></thead>
		<tbody>
			<tr>
				<th><spring:message code="wzwg.module.word.qesitmnm" /></th>
				<td colspan="2"><input type="text" name="qesitmNm" id="qesitmNm" class="w70" dir="required,vmaxlen=100" value="<c:out value="${resultVO.qesitmNm }" />" title="<spring:message code="wzwg.module.word.qesitmnm" />"/></td>
			</tr>
			
			<c:choose>
			<c:when test="${paramVO.qesitmTyCode eq 'SC00000324' or paramVO.qesitmTyCode eq 'SC00000325' }">
				<c:if test="${paramVO.qesitmTyCode eq 'SC00000324'}"><input type="hidden" name="iemTyCode" value="SC00000329"/></c:if>
				<c:if test="${paramVO.qesitmTyCode eq 'SC00000325'}"><input type="hidden" name="iemTyCode" value="SC00000328"/></c:if>
				<c:choose>
					<c:when test="${!empty resultVO }">
						<c:forEach items="${iemList }" var="iemList" varStatus="status">
						<input type="hidden" name="prevIemSeqArr" value="<c:out value="${iemList.iemSeq }" />"/>
						<tr>
							<th><spring:message code="wzwg.cmm.word.ex" /></th>
							<td>
								<input type="hidden" name="iemSeqArr" value="<c:out value="${iemList.iemSeq }" />"/>
								<input type="text" name="iemNmArr" class="w100" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" value="<c:out value="${iemList.iemNm }" />"/>
							</td>
							<td class="txt-c">
							<c:choose>
								<c:when test="${status.count le 2 }">
									<div class="td-lc"><span class="fs15 fw600 red"><spring:message code="wzwg.module.word.deleteimprty" /></span></div>
								</c:when>
								<c:otherwise>
									<a href="javascript:void(0);" onclick="fnRowDelete(this);" class="iconOnlyBtn btn-basic btn-delete"><spring:message code="wzwg.cmm.word.delete" /></a>
								</c:otherwise>
							</c:choose>
							</td>
						</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<th><spring:message code="wzwg.cmm.word.ex" /></th>
							<td><input type="text" name="iemNm" class="w100" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" /></td>
							<td class="txt-c"><span class="fs15 fw600 red"><spring:message code="wzwg.module.word.deleteimprty" /></span></td>
						</tr>
						<tr>
							<th><spring:message code="wzwg.cmm.word.ex" /></th>
							<td><input type="text" name="iemNm" class="w100" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" /></td>
							<td class="txt-c"><span class="fs15 fw600 red"><spring:message code="wzwg.module.word.deleteimprty" /></span></td>
						</tr>
					</c:otherwise>
				</c:choose>
			</c:when>
			<c:when test="${paramVO.qesitmTyCode eq 'SC00000326' }">
				<input type="hidden" name="iemSeq" value="<c:out value="${iemList[0].iemSeq}" />"/>
				<tr>
					<th><spring:message code="wzwg.module.word.rspnsty" /></th>
					<td colspan="2">
						<ul class="wzForm">
							<li><label><input type="radio" name="iemTyCode" value="SC00000330" onchange="fnDscrpTyChange(this.value);" checked="checked"/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.shrtrespty" /></span></label></li>
							<li><label><input type="radio" name="iemTyCode" value="SC00000331" onchange="fnDscrpTyChange(this.value);" <c:if test="${iemList[0].iemTyCode eq 'SC00000331' }">checked="checked"</c:if>/> <span class="spanLabel"><spring:message code="wzwg.cmm.word.lngrespty" /></span></label></li>
						</ul>
					</td>
				</tr>
				<tr id="dscrpTyDiv"></tr>
			</c:when>
			<c:otherwise>
				<input type="hidden" name="iemTyCode" value="SC00000329"/>
				<tr>
					<th><spring:message code="wzwg.cmm.word.ex" /></th>
					<td><input type="text" name="iemNm" class="w100" value="<spring:message code="wzwg.cmm.word.exy" />" readonly="readonly" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" /></td>
					<td class="txt-c"><span class="fs15 fw600 red"><spring:message code="wzwg.module.word.deleteimprty" /></span></td>
				</tr>
				<tr>
					<th><spring:message code="wzwg.cmm.word.ex" /></th>
					<td><input type="text" name="iemNm" class="w100" value="<spring:message code="wzwg.cmm.word.exn" />" readonly="readonly" dir="required,vtext,vmaxlen=100" title="<spring:message code="wzwg.module.word.exnm" />" /></td>
					<td class="txt-c"><span class="fs15 fw600 red"><spring:message code="wzwg.module.word.deleteimprty" /></span></td>
				</tr>
			</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>

	<div class="rt-box">
		<c:if test="${empty resultVO }">
		<a href="javascript:void(0);" onclick="fnQesitmRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		</c:if>
		<c:if test="${!empty resultVO }">
		<a href="javascript:void(0);" onclick="fnQesitmModify();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		</c:if>
		<a href="javascript:void(0);" onclick="wzModalClose();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>
	
</form>
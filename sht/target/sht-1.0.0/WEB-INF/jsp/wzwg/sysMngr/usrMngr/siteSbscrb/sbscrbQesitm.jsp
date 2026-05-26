<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<c:set var="msg_txt01">
	<spring:message code="wzwg.cmm.cmmMsg.CMG011">
		<spring:argument><spring:message code="wzwg.cmm.word.qestn" /></spring:argument>
		<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
	</spring:message>
</c:set>

<script>

	$(document).ready(function(){
		
		var idx = 1;
		
		$("#qestnEstbsDiv select[name=qesitmSe]").each(function(){
			if($(this).has("option:selected")){
				if($(this).val() == 'O'){
					var iemIdx = this.id
					iemIdx = iemIdx.substr(iemIdx.length-1,1);
					if($('#iemDiv' +iemIdx+' input[name=iemSj]').length >= 5){
						$('#iem'+iemIdx).hide();
					}
					
				}
			}
		});
		
		
		if($('#qestnEstbsDiv select[name=qesitmSe]').length > 0){
			idx = $('#qestnEstbsDiv select[name=qesitmSe]').length + 1;
		}
		
		if($('#qestnEstbsDiv select[name=qesitmSe]').length >= 5){
			$("#qesitm_add_btn").hide();
		}
		
		/** 질문 추가 */
		$("#qesitm_add_btn").click(function(){
			
			var innerTag = "";
			innerTag += "<tr>";
			innerTag += "	<th><spring:message code="wzwg.cmm.word.qestn" /> "+idx+"</th>";
			innerTag += "	<td class='txt-l'>";
			innerTag += "		<select id='qesitmSe"+idx+"' name='qesitmSe' class='ml3 txt-control' onchange='fnQesitmSe("+idx+");'>		";
			innerTag += "			<option value='S'><spring:message code='wzwg.cmm.word.sbjct' /></option>		";
			innerTag += "			<option value='O'><spring:message code='wzwg.cmm.word.objct' /></option>	";
			innerTag += "		</select>";
			innerTag += "		<input type='text' id='qesitmSj"+idx+"' name='qesitmSj' placeholder='<c:out value="${msg_txt01}" />' class='input-control w50  ml3'>	";
			//innerTag += "		<a href='javascript:void(0);' onclick='fnQesitmSjDel("+idx+");'>	";
			//innerTag += "			<span class='wzbtn-table btn-basic'><spring:message code="wzwg.cmm.word.cn" /> <spring:message code="wzwg.cmm.word.delete" /></span>	";
			//innerTag += "		</a>	";
			innerTag += "		<a href='javascript:void(0);' id='iem"+idx+"' style='display:none;' onclick='fnAddIem("+idx+");'>	";
			innerTag += "			<span class='wzbtn btn-basic fs16 hgt40 pl15 pr15'><spring:message code="wzwg.sysMngr.word.exAdd" /></span>	";
			innerTag += "		</a>	";
			innerTag += "		<div id='iemDiv"+idx+"' class='mt10' style='display:none;'>		";
			innerTag += "			<div class='qesitm-listdiv'>				";
			innerTag += "				<p class='pb5 qesitm-listbox'>				";
			innerTag += "				<input type='text' id='iemSj1' name='iemSj' class='txt-control w50' placeholder='<spring:message code="wzwg.cmm.word.ex" />'  />";
			//innerTag += "				<button type='button' class='wzbtn-table btn-basic grey' onclick='$(this).parent().remove();'><i class='fa fa-times' aria-hidden='true'></i></button>		";
			innerTag += "				</p>		";
			innerTag += "			</div>		";
			innerTag += "		</div>		";
			innerTag += "	</td>";
			innerTag += "</tr>";
			
			
			
			
			//innerTag += "<p class='qesitm-list'><span class='qesitm-text w5'><spring:message code="wzwg.cmm.word.qestn" /> "+idx+"</span>";
			//innerTag += "	<select id='qesitmSe"+idx+"' name='qesitmSe' class='ml3 txt-control' onchange='fnQesitmSe("+idx+");'>";
			//innerTag += "		<option value='S'><spring:message code="wzwg.cmm.word.sbjct" /></option>";
			//innerTag += "		<option value='O'><spring:message code="wzwg.cmm.word.objct" /></option>";
			//innerTag += "	</select>";
			//innerTag += "	<input type='text' id='qesitmSj"+idx+"' name='qesitmSj' placeholder='<c:out value="${msg_txt01}"/>' class='input-control w50  ml3'/>";
			//innerTag += "	<a href='javascript:void(0);' onclick='fnQesitmSjDel("+idx+");'><span class='wzbtn-table btn-basic'><spring:message code="wzwg.cmm.word.cn" /> <spring:message code="wzwg.cmm.word.delete" /></span></a>";
			//innerTag += "	<a href='javascript:void(0);' id='iem"+idx+"' style='display:none;' onclick='fnAddIem("+idx+");'><span class='wzbtn-table btn-basic'><spring:message code="wzwg.cmm.word.ex" /> <spring:message code="wzwg.cmm.word.add" /></span></a>";
			//innerTag += "</p>";
			//innerTag += "<div id='iemDiv"+idx+"' style='display:none;'>";
			//innerTag += "	<div class='qesitm-listdiv'><p class='pb5 qesitm-listbox' style='margin-left:154px;'>";
			//innerTag += "		<input type='radio' checked disabled /><input type='text' id='iemSj1' name='iemSj' class='txt-control' placeholder='<spring:message code="wzwg.cmm.word.ex" /> 1' style='width:250px;' />";
			//innerTag += "	</p></div>";
			//innerTag += "</div>";
			
			$("#qesitmListDiv").append(innerTag);
			
			if(idx == 5){
				$("#qesitm_add_btn").hide();
			}
			
			idx++;
			
		});
		
	});
	
	/* 질문 삭제 */
	function fnQesitemDel(val){
		if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>')){
			return;
		}else{
			$.ajax({
		        type:'POST'
				, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/deleteSbscrbQesitmAjax.do?delQesitmSeq='+val
				, dataType: 'xml'
				, data:$("#regForm").serialize()
				, success:function (result) {
					
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value == 'success'){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.delete" /></spring:argument></spring:message>');
						$.ajax({
					        type:'POST'
							, url:'<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/selectSbscrbQesitmImport.do'
							, dataType:'html'
							, data:$("#regForm").serialize()
							, success:function (data) {
								$('#qestnEstbsDiv').html(data).find('qesitmListDiv');
							}
							, error:function (request, status, error) {
								alert('<spring:message code="fail.common.msg" text="error" />');
							}
					 	});
						
					}else{
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
					}
					
				}
				, error:function (request, status, error) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	});
		}
	}
	
	/* 질문 내용 삭제 */
	function fnQesitmSjDel(val){
		$("#qesitmSj"+val).val("");
	}
	
	/* 질문유형 변경 */
	function fnQesitmSe(idx){
		//$("#qesitmSj"+idx).val("");
		
		if($("#qesitmSe"+idx).val() == 'S'){
			/* $('#iemDiv'+idx).children().remove();
			
			var innerTag = "";
			innerTag += "<p class='pd_b5' style='margin-left:106px;'>";
			innerTag += "	<input type='radio' checked disabled /><input type='text' id='iemSj1' name='iemSj' placeholder='보기 1' style='width:250px;' />";
			innerTag += "</p>";
			
			$("#iemDiv"+idx).append(innerTag); */
			$('#iemDiv'+idx).hide();
			$('#iem'+idx).hide();
		}else{
			$('#iemDiv'+idx).show();
			$('#iem'+idx).show();
		}
	}
	
	/* 가입항목 추가 */
	function fnAddIem(idx){
		
		var iem_idx = 1;
		var iem_len = $('#iemDiv'+idx+' input[name=iemSj]').length;
		
		if(iem_len > 0){
			iem_idx = iem_len + 1;
		}else{
			iem_idx = 1;
		}
		
//		var innerTag = "<div class='qesitm-listdiv'><p class='pb5 qesitm-listbox' style='margin-left:154px;'><input type='radio' checked disabled /><input type='text' id='iemSj"+iem_idx+"' name='iemSj' class='txt-control' placeholder='<spring:message code="wzwg.cmm.word.ex" /> "+iem_idx+"' style='width:250px;' /></p></div>";
		var innerTag = "";
		innerTag += "			<div class='qesitm-listdiv'>				";
		innerTag += "				<p class='pb5 qesitm-listbox'>				";
		innerTag += "				<input type='text' id='iemSj"+iem_idx+"' name='iemSj' class='txt-control w50' placeholder='<spring:message code="wzwg.cmm.word.ex" />'  />";
		//innerTag += "				<button type='button' class='wzbtn-table btn-basic grey' onclick='$(this).parent().remove();'><i class='fa fa-times' aria-hidden='true'></i></button>";
		innerTag += "				</p>		";
		innerTag += "			</div>		";
		
		$("#iemDiv"+idx).append(innerTag);
		
		if(iem_idx >= 5){
			$('#iem'+idx).hide();
		}
	}
	
</script>

	<input type="hidden" id="delQesitmSeq" />
	<%--  
	<c:if test="${!empty qesitmList}">
		<c:forEach var="qesitmList" items="${qesitmList}" varStatus="qesitmStatus">
		<input type="hidden" id="sbscrbqesitmSeq${qesitmStatus.index + 1}" name="sbscrbqesitmSeq" value="${qesitmList.sbscrbqesitmSeq}" />
		<p class="qesitm-list">
			<span class="qesitm-text w5"><spring:message code="wzwg.cmm.word.qestn" /> ${qesitmStatus.index + 1}</span>
			<select id="qesitmSe${qesitmStatus.index + 1}" name="qesitmSe" class="ml3 txt-control" onchange="fnQesitmSe(${qesitmStatus.index + 1});">
		 		<option value="S" <c:if test="${qesitmList.qesitmSe eq 'S'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sbjct" /></option>
		 		<option value="O" <c:if test="${qesitmList.qesitmSe eq 'O'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.objct" /></option>
		 	</select>
		 	<input type="text" id="qesitmSj${qesitmStatus.index + 1}" name="qesitmSj" value="${qesitmList.qesitmSj}" placeholder="${msg_txt01}" class="input-control w50 ml3" />
			<a href="javascript:void(0);" onclick="fnQesitmSjDel('${qesitmStatus.index + 1}');"><span class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.cn" /> <spring:message code="wzwg.cmm.word.delete" /></span></a>
			<a href="javascript:void(0);" id="iem${qesitmStatus.index + 1}" style="display:none;" onclick="fnAddIem(${qesitmStatus.index + 1});"><span class="wzbtn-table btn-basic"><spring:message code="wzwg.cmm.word.ex" /> <spring:message code="wzwg.cmm.word.add" /></span></a>			
			<script>
				if($("#qesitmSe${qesitmStatus.index + 1}").val() == 'O' && $('#iemDiv${qesitmStatus.index + 1} input[name=iemSj]').length < 5){
					$("#iem${qesitmStatus.index + 1}").show();
				}
			</script>
			
			<a href="javascript:void(0);" onclick="fnQesitemDel('${qesitmList.sbscrbqesitmSeq}');"><span class="wzbtn-table btn-del"><spring:message code="wzwg.cmm.word.qestn" /> <spring:message code="wzwg.cmm.word.delete" /></span></a>
		</p>
		<div id="iemDiv${qesitmStatus.index + 1}">
		<c:if test="${qesitmList.qesitmSe eq 'O'}">
			<c:if test="${!empty iemList}">
	 		<c:forEach var="iemList" items="${iemList}" varStatus="iemStatus">
	 			<c:if test="${iemList.sbscrbqesitmSeq eq qesitmList.sbscrbqesitmSeq}">
	 			<div class="qesitm-listdiv">
	 			<p class="pb5 qesitm-listbox" style="margin-left:154px;">
	 				<input type="hidden" id="sbscrbiemSeq${iemStatus.index + 1}" name="sbscrbiemSeq" value="${iemList.sbscrbiemSeq}" />
	 				<input type="radio" checked disabled /><input type="text" id="iemSj${iemStatus.index + 1}" name="iemSj" value="${iemList.iemSj}" class="txt-control" placeholder="<spring:message code="wzwg.cmm.word.ex" /> ${iemStatus.index + 1}" style="width:250px;" />
	 			</p>
	 			</div>
	 			</c:if>
	 		</c:forEach>
			</c:if>
		</c:if>
		</div>
		</c:forEach>
	</c:if>
	
	<div id="qesitmListDiv"></div>
	
	<p class=""><a href="javascript:void(0);" class="mg10"><span class="wzbtn btn-black" id="qesitm_add_btn"><spring:message code="wzwg.cmm.word.qestn" /> <spring:message code="wzwg.cmm.word.add" /></span></a></p>
	<p class="qesitm-ex">※ <spring:message code="wzwg.cmm.msg.MSG181" /></p>

	 <%----%>
	
	<table class="basic">
		<colgroup>
			<col width="20%">
			<col width="*">
		</colgroup>
		<tbody id="qesitmListDiv">        
			<tr>
       			<th><spring:message code="wzwg.sysMngr.word.qestnAdd" /></th>
       			<td>
	                <a class="wzbtn btn-black" id="qesitm_add_btn"><spring:message code="wzwg.sysMngr.word.qestnAdd" /></a> 
					<p class="admpg-subp w100 fl mt10">
						<span class="circle_no bg-green-strong">i</span><spring:message code="wzwg.cmm.msg.MSG181" />
					</p>
				</td>
			</tr>
	
			<c:forEach var="qesitmList" items="${qesitmList}" varStatus="qesitmStatus">
			<tr>
	            <th><spring:message code="wzwg.cmm.word.qestn" /> <c:out value="${qesitmStatus.index + 1}" /></th>
	            <td class="txt-l">
	            	<input type="hidden" id="sbscrbqesitmSeq<c:out value="${qesitmStatus.index + 1}" />" name="sbscrbqesitmSeq" value="<c:out value="${qesitmList.sbscrbqesitmSeq}" />" />
	                <select id="qesitmSe<c:out value="${qesitmStatus.index + 1}" />" name="qesitmSe" class="ml3 txt-control" onchange="fnQesitmSe(<c:out value="${qesitmStatus.index + 1}" />);">		
						<option value="S" <c:if test="${qesitmList.qesitmSe eq 'S'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.sbjct" /></option>		
						<option value="O" <c:if test="${qesitmList.qesitmSe eq 'O'}">selected="selected"</c:if>><spring:message code="wzwg.cmm.word.objct" /></option>	
					</select>	
					<input type="text" id="qesitmSj<c:out value="${qesitmStatus.index + 1}" />" name="qesitmSj" placeholder="<c:out value="${msg_txt01}" />" value="<c:out value="${qesitmList.qesitmSj}" />" class="input-control w50  ml3">	
					<%-- <a href="javascript:void(0);" onclick="fnQesitmSjDel('${qesitmStatus.index + 1}');">
						<span class="wzbtn-table btn-basic">내용 삭제</span>
					</a>	 --%>
					<a href="javascript:void(0);" id="iem<c:out value="${qesitmStatus.index + 1}" />" <c:if test="${qesitmList.qesitmSe eq 'S'}">style="display:none;"</c:if> onclick="fnAddIem(<c:out value="${qesitmStatus.index + 1}" />);">
						<span class="wzbtn btn-basic fs16 hgt40 pl15 pr15"><spring:message code="wzwg.sysMngr.word.exAdd" /></span>
					</a>
					<a href="javascript:void(0);" onclick="fnQesitemDel('<c:out value="${qesitmList.sbscrbqesitmSeq}" />');">
						<span class="btn-delete iconOnlyBtn btn-basic mt0 mb0 hgt40 box-border pl15 pr15 br3" style="width:40px;"><spring:message code="wzwg.sysMngr.word.qestnDelete" /></span>
					</a>
					<div id="iemDiv${qesitmStatus.index + 1}">	
						<div class="qesitm-listdiv mt10">
							<c:if test="${qesitmList.qesitmSe eq 'O'}">
								<c:if test="${!empty iemList}">
						 		<c:forEach var="iemList" items="${iemList}" varStatus="iemStatus">
						 			<c:if test="${iemList.sbscrbqesitmSeq eq qesitmList.sbscrbqesitmSeq}">
									<p class="pb5 qesitm-listbox">
										<input type="hidden" id="sbscrbiemSeq<c:out value="${iemList.ordr}" />" name="sbscrbiemSeq" value="<c:out value="${iemList.sbscrbiemSeq}" />" />
										<input type="text" id="iemSj<c:out value="${iemList.ordr}" />" name="iemSj" class="txt-control w50" placeholder="<spring:message code="wzwg.cmm.word.ex" />" value="<c:out value="${iemList.iemSj}" />" style="width:250px;">	
										<!-- <button type="button" class='wzbtn-table btn-basic grey' onclick="$(this).parent().remove();"><i class="fa fa-times" aria-hidden="true"></i></button> -->
									</p>
									</c:if>
						 		</c:forEach>
								</c:if>
							</c:if>
						</div>
					</div>
				</td>
			</tr>
			</c:forEach>
   		</tbody>
	</table>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>

<link type="text/css" rel="stylesheet" href="/css/datepicker/ui.custom.css" />
<script type="text/javascript" src="/js/wzwg/cmm/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>

<%
	String currentYear = new java.text.SimpleDateFormat("yyyy").format(new java.util.Date());
%>

<c:set var="currentYear" value="<%=currentYear%>" />

<c:set var="rootPath" value="<%=request.getContextPath()%>" />

	<script type="text/javascript">
	
		$(document).ready(function(){
			
			checkByte('sbscrbGuidCn', 500);
			
			if('<c:out value="${resultVO.sbscrbQestnEstbsAt}" />' == 'Y'){
				$("#qestnEstbsDiv").show();
			}else{
				$("#qestnEstbsDiv").hide();				
			}
			
			if('<c:out value="${resultVO.sbscrbReqstLmttAt}" />' == 'Y'){
				$("#sbscrbLmttBgnde").prop("disabled", true);
				$("#sbscrbLmttEndde").prop("disabled", true);
			}
			
			if('<c:out value="${resultVO.sbscrbCndAgeLmttAt}" />' == 'Y'){
				$("#sbscrbAgeBeginYear").prop("disabled", true);
				$("#sbscrbAgeEndYear").prop("disabled", true);
			}
			
			$("#sbscrbLmttBgnde").setDate('<c:out value="${rootPath}" />');
			$("#sbscrbLmttEndde").setDate('<c:out value="${rootPath}" />');	
		
			/* 가입질문 사용 */
			$("#sbscrbQestnEstbsAtY").click(function(){
				$("#qestnEstbsDiv").show();
			});
		
			/* 가입질문 사용안함 */
			$("#sbscrbQestnEstbsAtN").click(function(){
				$("#qestnEstbsDiv").hide();
			});
			
			/* 가입신청받기 사용 */
			$("#sbscrbReqstLmttAtY").click(function(){
				$("#sbscrbLmttBgnde").prop("disabled", true);
				$("#sbscrbLmttEndde").prop("disabled", true);
			});
			
			/* 가입신청받기 사용안함 */
			$("#sbscrbReqstLmttAtN").click(function(){
				$("#sbscrbLmttBgnde").prop("disabled", false);
				$("#sbscrbLmttEndde").prop("disabled", false);
			});
			
			/* 가입조건연령 사용 */
			$("#sbscrbCndAgeLmttAtY").click(function(){
				$("#sbscrbAgeBeginYear").prop("disabled", true);
				$("#sbscrbAgeEndYear").prop("disabled", true);
			});
			
			/* 가입조건연령 사용안함 */
			$("#sbscrbCndAgeLmttAtN").click(function(){
				$("#sbscrbAgeBeginYear").prop("disabled", false);
				$("#sbscrbAgeEndYear").prop("disabled", false);
			});
			
			/* 가입질문 초기화 */
			$("#qestn_reset_btn").click(function(){
				if(!confirm('<spring:message code="wzwg.cmm.msg.MSG275" />')){
					return;
				}else{
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
				}
			});
			
			/** 저장하기 */
			$("#save_btn").click(function(){

				if(!Validator.validate(document.regForm)){
					return;
				}
				
				if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG007"><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>')){
					alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></spring:argument></spring:message>');
					return;
				}else{
					
					var frm = document.regForm;
					
					// 가입질문설정여부
					frm.sbscrbQestnEstbsAt.value 	= $("input[id=sbscrbQestnEstbsAtY]").is(":checked")? "Y" : "N";
					// 가입신청제한여부
					frm.sbscrbReqstLmttAt.value 	= $("input[id=sbscrbReqstLmttAtY]").is(":checked")? "Y" : "N";
					// 가입조건 성별
					frm.sbscrbCndSexdstn.value 		= $("input[id=sbscrbCndSexdstnM]").is(":checked")? "M" : $("input[id=sbscrbCndSexdstnF]").is(":checked") == true ? "F" : "" ;
					// 가입조건 연령
					frm.sbscrbCndAgeLmttAt.value 	= $("input[id=sbscrbCndAgeLmttAtY]").is(":checked")? "Y" : "N";	
					// 가입인증 - 실명인증여부
					//frm.lsftCrtfcAt.value			= $("input[name=lsftCrtfcAt]").is(":checked") == true ? "Y" : "N";
					// 가입인증 - 휴대폰인증여부
					frm.moblphonCrtfcAt.value		= $("input[name=moblphonCrtfcAt]").is(":checked")? "Y" : "N";
					// 가입인증 - 인증서인증여부
					frm.crtfctCrtfcAt.value			= $("input[name=crtfctCrtfcAt]").is(":checked")? "Y" : "N";
					
					
					if(frm.sbscrbQestnEstbsAt.value == 'Y'){
						
						var qesitmArr = new Array();
						var iemArr = new Array();
						
						for(var i = 1; i <= $('#qestnEstbsDiv select[name=qesitmSe]').length; i++){
				             
				            // 객체 생성
				            var qesitm_data = new Object();
				            // 객체 생성
				            var iem_data = new Object();
				            
				            qesitm_data.qesitmSeq 		= i;
				            qesitm_data.sbscrbqesitmSeq = $('#qestnEstbsDiv input[id=sbscrbqesitmSeq'+i+']').val();
				            qesitm_data.qesitmSe 		= $('#qestnEstbsDiv select[id=qesitmSe'+i+']').val();
				            qesitm_data.qesitmSj 		= $('#qestnEstbsDiv input[id=qesitmSj'+i+']').val();
				            
				            iem_data.qesitmSeq 			= qesitm_data.qesitmSeq;
				            
				            if(qesitm_data.qesitmSe == 'O'){
				            	iem_data.sbscrbiemSeq1 	= $('#iemDiv'+i+' input[id=sbscrbiemSeq1]').val();
				            	iem_data.sbscrbiemSeq2	= $('#iemDiv'+i+' input[id=sbscrbiemSeq2]').val();
				            	iem_data.sbscrbiemSeq3 	= $('#iemDiv'+i+' input[id=sbscrbiemSeq3]').val();
				            	iem_data.sbscrbiemSeq4 	= $('#iemDiv'+i+' input[id=sbscrbiemSeq4]').val();
				            	iem_data.sbscrbiemSeq5 	= $('#iemDiv'+i+' input[id=sbscrbiemSeq5]').val();
				            	iem_data.iem1 			= $('#iemDiv'+i+' input[id=iemSj1]').val();
				            	iem_data.iem2 			= $('#iemDiv'+i+' input[id=iemSj2]').val();
				            	iem_data.iem3 			= $('#iemDiv'+i+' input[id=iemSj3]').val();
				            	iem_data.iem4 			= $('#iemDiv'+i+' input[id=iemSj4]').val();
				            	iem_data.iem5 			= $('#iemDiv'+i+' input[id=iemSj5]').val();
				            	iem_data.iem_len 		= $('#iemDiv'+i+' input[name=iemSj]').length;
				            }
				             
				            // 리스트에 생성된 객체 삽입
				            qesitmArr.push(qesitm_data);
				            iemArr.push(iem_data);
				        }
						
						frm.qesitmArr.value = JSON.stringify(qesitmArr);
						frm.iemArr.value 	= JSON.stringify(iemArr);
						
					}
					
					var url = "";
					
					<c:choose>
						<c:when test="${empty resultVO.sbscrbinfoSeq}">
							url = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/registSbscrbInfoAjax.do";
						</c:when>
						<c:otherwise>
							url = "<c:out value="${wzwg_contextPath}" />/sysMngr/usrMngr/siteSbscrb/modifySbscrbInfoAjax.do";
						</c:otherwise>
					</c:choose>
					
					$.ajax({
				        type:'POST'
						, url:url
						, dataType: 'xml'
						, data:$("#regForm").serialize()
						, success:function (result) {
				    	  
				    	  	var value = "";
							
							$(result).find("value").each(function() {  
								value = $(this).text();  
							});
							
							if(value == 'success'){
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG004"><spring:argument><spring:message code="wzwg.sysMngr.word.sbscrbInfo" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.stre" /></spring:argument></spring:message>');
								
								var frm = document.regForm;
								frm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/siteSbscrb/selectSbscrbInfoForm.do";
								frm.submit();
							}else{
								alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
							}
				    	  
						}
						, error:function (request, status, error) {
							alert('<spring:message code="fail.common.msg" text="error" />');
						}
				 	});
				}
					
			});
			
			/** 취소 */
			$("#list_btn").click(function(){
				var frm = document.regForm;
				frm.action = "<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/siteSbscrb/selectSbscrbInfoList.do";
				frm.submit();
			});
			
			
		});
		
	</script>

                <form:form modelAttribute="resultVO" path="regForm" id="regForm" name="regForm" method="post">
					<form:hidden path="siteSeq" />
					<form:hidden path="sbscrbinfoSeq" />
					<form:hidden path="sbscrbqesitmSeq" />
					<input type="hidden" name="qesitmArr" />
					<input type="hidden" name="iemArr" />
                    
					<table summary="<spring:message code="wzwg.sysMngr.word.sbscrbInfo" />" class="basic">
						<colgroup>
							<col width="15%"/>
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.sbcrbGuidance" /></th>
								<td>
									<c:set var="msg_title_txt01"> 
							 			<spring:message code="wzwg.sysMngr.word.sbcrbGuidance" /> 
									</c:set>
									<form:textarea cssClass="w80 mg_t10 mg_b10" path="sbscrbGuidCn" id="sbscrbGuidCn" dir="required" rows="5" title="${fn:escapeXml(msg_title_txt01)}" onkeyup="fnByteCheck('sbscrbGuidCn');" />
									<p class="fr" id="div_view">0 / 500 byte</p> 
                                   	<p class="mb10">※ <spring:message code="wzwg.cmm.msg.MSG182" /></p>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.sbscrbQestn" /><br /><a href="javascript:void(0);" id="qestn_reset_btn">[<spring:message code="wzwg.cmm.word.initl" />]</a></th>
								<td>
                                    <p><input type="radio" id="sbscrbQestnEstbsAtN" name="sbscrbQestnEstbsAt" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbQestn" />" <c:if test="${resultVO.sbscrbQestnEstbsAt ne 'Y'}">checked="true"</c:if> /> <spring:message code="wzwg.cmm.msg.MSG187" /></p>
                                    <p><input type="radio" id="sbscrbQestnEstbsAtY" name="sbscrbQestnEstbsAt" value="Y" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbQestn" />" <c:if test="${resultVO.sbscrbQestnEstbsAt eq 'Y'}">checked="true"</c:if> /> <spring:message code="wzwg.cmm.msg.MSG188" /></p>
                                    <div id="qestnEstbsDiv" class="mt5">
                                    	<c:if test="${!empty resultVO.siteSeq}">
	                                    	<c:import url="${wzwg_contextPath}${prefix}/usrMngr/siteSbscrb/selectSbscrbQesitmImport.do" charEncoding="utf-8"></c:import>
                                    	</c:if>
                                    </div>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.sbscrbReqstRecve" /></th>
								<td>
                                    <c:set var="sbscrbLmttBgnde"><spring:message code="wzwg.sysMngr.word.sbscrbLmttBgnde" /></c:set>
									<c:set var="sbscrbLmttEndde"><spring:message code="wzwg.sysMngr.word.sbscrbLmttEndde" /></c:set>
									
									<c:set var="sbscrbTitle"><spring:message code="wzwg.sysMngr.word.sbscrbReqst" /></c:set>
                                    <p><input type="radio" id="sbscrbReqstLmttAtY" name="sbscrbReqstLmttAt" value="Y" dir="required" title="<c:out value='${sbscrbTitle}' />" <c:if test="${resultVO.sbscrbReqstLmttAt ne 'N'}">checked="true"</c:if> /> <spring:message code="wzwg.cmm.msg.MSG189" /></p>
                                    <%-- <p><input type="radio" id="sbscrbReqstLmttAtN" name="sbscrbReqstLmttAt" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbReqst" />" <c:if test="${resultVO.sbscrbReqstLmttAt eq 'N'}">checked="true"</c:if> /> <spring:message code="wzwg.cmm.msg.MSG190" /> <form:input path="sbscrbLmttBgnde" id="sbscrbLmttBgnde" title="${sbscrbLmttBgnde}" cssClass="form-control" cssStyle="width:100px;" readOnly="true" /> ~ <form:input path="sbscrbLmttEndde" id="sbscrbLmttEndde" title="${sbscrbLmttEndde}" cssClass="form-control" cssStyle="width:100px;" readOnly="true" /><spring:message code="wzwg.cmm.word.until" /></p> --%>
									
									<p>
									    <input type="radio" id="sbscrbReqstLmttAtN" name="sbscrbReqstLmttAt" value="N" dir="required" 
									           title="<spring:message code='wzwg.sysMngr.word.sbscrbReqst' />" 
									           <c:if test="${resultVO.sbscrbReqstLmttAt eq 'N'}">checked="checked"</c:if> /> 
									    <spring:message code="wzwg.cmm.msg.MSG190" /> 
									    <form:input path="sbscrbLmttBgnde" id="sbscrbLmttBgnde" title="${fn:escapeXml(sbscrbLmttBgnde)}" cssClass="form-control" cssStyle="width:100px;" readOnly="true" /> 
									    ~ 
									    <form:input path="sbscrbLmttEndde" id="sbscrbLmttEndde" title="${fn:escapeXml(sbscrbLmttEndde)}" cssClass="form-control" cssStyle="width:100px;" readOnly="true" />
									    <spring:message code="wzwg.cmm.word.until" />
									</p>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.sbscrbCndSexdstn" /></th>
								<td>
                            		<label><input type="radio" id="sbscrbCndSexdstnA" name="sbscrbCndSexdstn" value="" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbSexdstn" />" <c:if test="${resultVO.sbscrbCndSexdstn ne 'M' or resultVO.sbscrbCndSexdstn ne 'F'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.all02" /></label>
                            		<label><input type="radio" id="sbscrbCndSexdstnM" name="sbscrbCndSexdstn" value="M" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbSexdstn" />" <c:if test="${resultVO.sbscrbCndSexdstn eq 'M'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.male" /></label>
                            		<label><input type="radio" id="sbscrbCndSexdstnF" name="sbscrbCndSexdstn" value="F" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbSexdstn" />" <c:if test="${resultVO.sbscrbCndSexdstn eq 'F'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.female" /></label>
								</script>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.sbscrbCndAge" /></th>
								<td>
                              		<label><input type="radio" id="sbscrbCndAgeLmttAtY" name="sbscrbCndAgeLmttAt" value="Y" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbAge" />" <c:if test="${resultVO.sbscrbCndAgeLmttAt ne 'N'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.all02" /></label>
                               		<label><input type="radio" id="sbscrbCndAgeLmttAtN" name="sbscrbCndAgeLmttAt" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.sbscrbAge" />" <c:if test="${resultVO.sbscrbCndAgeLmttAt eq 'N'}">checked="true"</c:if> /></label>
                               		<c:set var="msg_title_txt02"> 
											 <spring:message code="wzwg.sysMngr.word.sbscrbAgeBgnYY02" /> 
									</c:set>
                                    <form:select path="sbscrbAgeBeginYear" id="sbscrbAgeBeginYear" title="<c:out value='${msg_title_txt02}' />" cssStyle="width:80px;" >
                                    	<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                                    	<c:forEach var="ageBgnde" step="1" begin="1930" end="${fn:escapeXml(currentYear)}">
                                    		<form:option value="${fn:escapeXml(ageBgnde)}" label="${fn:escapeXml(ageBgnde)}" />
                                    	</c:forEach>
                                    </form:select> <spring:message code="wzwg.cmm.msg.MSG185" /> 
                                    <c:set var="msg_title_txt03"> 
											 <spring:message code="wzwg.sysMngr.word.sbscrbAgeEndYY02" /> 
									</c:set>
                                    <form:select path="sbscrbAgeEndYear" id="sbscrbAgeEndYear" title="<c:out value='${msg_title_txt03}' />" cssStyle="width:80px;" >
                                    	<option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                                    	<c:forEach var="ageEndde" step="1" begin="1930" end="${fn:escapeXml(currentYear)}">
                                    		<form:option value="${fn:escapeXml(ageEndde)}" label="${fn:escapeXml(ageEndde)}" />
                                    	</c:forEach>
                                    </form:select> <spring:message code="wzwg.cmm.msg.MSG186" />
                                    <p>※ <spring:message code="wzwg.cmm.msg.MSG183" /></p>
								</script>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.crtfcMth" /></th>
								<td>
									<%-- <label class="mg_r20"><input type="checkbox" name="lsftCrtfcAt" class="va_m" value="N" dir="required" title="실명인증" 	<c:if test="${resultVO.lsftCrtfcAt eq 'Y'}">checked="true"</c:if> />실명</label> --%>
									<label><input type="checkbox" name="moblphonCrtfcAt" class="va_m" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.moblphonCrtfc" />" <c:if test="${resultVO.moblphonCrtfcAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.moblphon" /></label>
									<label><input type="checkbox" name="crtfctCrtfcAt" class="va_m" value="N" dir="required" title="<spring:message code="wzwg.sysMngr.word.crtfctCrtfc" />" <c:if test="${resultVO.crtfctCrtfcAt eq 'Y'}">checked="true"</c:if> /><spring:message code="wzwg.cmm.word.crtfct" /></label>
								</td>
							</tr>
						</tbody>
					</table>
				</form:form>
				
				<div class="rt-box">
					<a href="javascript:void(0);" id="save_btn" class="btn-a"><spring:message code="wzwg.cmm.word.tostre" /></a>
					<a href="javascript:void(0);" id="list_btn" class="btn-a"><spring:message code="wzwg.cmm.word.cancl" /></a>
				</div>

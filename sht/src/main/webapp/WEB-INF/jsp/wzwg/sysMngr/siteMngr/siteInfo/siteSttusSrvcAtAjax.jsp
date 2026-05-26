<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>


	<link href="/css/wzwg/cmm/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="/js/wzwg/cmm/jquery-ui-1.10.3.custom.js"></script>
	<script language="javascript" type="text/javascript" src="/jquery/js/jquery.form.min.js"></script>
	<script type="text/javascript" src="/smartEditor2.8.2.1/js/HuskyEZCreator.js"></script>
	
	<script type="text/javascript">
		$("#ui-datepicker-div").remove();
		$(document).ready(function(){
		    $(".datePicker").datepicker({ 		
			     dateFormat: 'yy-mm-dd',
			     monthNamesShort: ['1<spring:message code="wzwg.cmm.word.mt" />','2<spring:message code="wzwg.cmm.word.mt" />','3<spring:message code="wzwg.cmm.word.mt" />','4<spring:message code="wzwg.cmm.word.mt" />','5<spring:message code="wzwg.cmm.word.mt" />','6<spring:message code="wzwg.cmm.word.mt" />','7<spring:message code="wzwg.cmm.word.mt" />','8<spring:message code="wzwg.cmm.word.mt" />','9<spring:message code="wzwg.cmm.word.mt" />','10<spring:message code="wzwg.cmm.word.mt" />','11<spring:message code="wzwg.cmm.word.mt" />','12<spring:message code="wzwg.cmm.word.mt" />'],
			     dayNamesMin: ['<spring:message code="wzwg.cmm.word.sun01" />','<spring:message code="wzwg.cmm.word.mon01" />','<spring:message code="wzwg.cmm.word.tue01" />','<spring:message code="wzwg.cmm.word.wed01" />','<spring:message code="wzwg.cmm.word.thu01" />','<spring:message code="wzwg.cmm.word.fri01" />','<spring:message code="wzwg.cmm.word.sat01" />'],
			     weekHeader: 'Wk',
			     changeMonth: true, 	//월변경가능
			     changeYear: true, 	//년변경가능
			     yearRange:'-10:+10', 	// 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
			     showMonthAfterYear: true, 	//년 뒤에 월 표시
			     buttonImageOnly: false, //이미지표시  
			     buttonText: '<spring:message code="wzwg.cmm.msg.MSG088" />', 
			     autoSize: false	 //오토리사이즈(body등 상위태그의 설정에 따른다)
			  	});
		    
		});
		
		function fnDatePreview(){
			var bgnde = $('input[name="opertBgnde"]');
			var bgntm = $('select[name="beginTime"]');
			var endde = $('input[name="opertEndde"]');
			var endtm = $('select[name="endTime"]');

			var txtY = '<spring:message code="wzwg.cmm.word.yy" />';
			var txtM = '<spring:message code="wzwg.cmm.word.mt" />';
			var txtD = '<spring:message code="wzwg.cmm.word.de" />';
			var txtH = '<spring:message code="wzwg.cmm.word.hour" />';
			
			//console.log(bgnde.val() + '/' + bgntm.val() + '/' + endde.val() + '/' + endtm.val());	
			//console.log(txtY + txtM + txtD + txtH);
			var bgnTxt = txtY + ' ' + txtM + ' ' + txtD + ' ' + txtH;
			var endTxt = txtY + ' ' + txtM + ' ' + txtD + ' ' + txtH;
			if(bgnde.val() != ''){
				bgnTxt = bgnde.val().substring(0, 4) + txtY + ' '; 
				bgnTxt += bgnde.val().substring(5, 7) + txtM + ' '; 
				bgnTxt += bgnde.val().substring(8, 10) + txtD + ' '; 
				bgnTxt += bgntm.val() + txtH; 
			}
			
			if(endde.val() != ''){
				endTxt = endde.val().substring(0, 4) + txtY + ' '; 
				endTxt += endde.val().substring(5, 7) + txtM + ' '; 
				endTxt += endde.val().substring(8, 10) + txtD + ' '; 
				endTxt += endtm.val() + txtH; 
			}
			$('#preViewDate').html(bgnTxt + ' ~ ' + endTxt);
		}
	</script> 
	
	<table class="basic">
		<colgroup>
			<col width="13%"/>
			<col width="*"/>
		</colgroup>
		<tbody>
			<tr>
				<th colspan="2" class="wzAdmSTit"><spring:message code="wzwg.sysMngr.word.stpgeSet" /></th>
			</tr>
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.stpgeSj" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td>
					<c:set var="msg_txt03">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.cmm.word.sj" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
						</spring:message>
					</c:set>
					<input type="text" name="opertNm" class="w70" dir="required" title="<spring:message code="wzwg.sysMngr.word.stpgeSj" />" value="<c:out value="${opertVO.opertNm }" />" placeholder="<c:out value="${msg_txt03}" />"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.stpgePd" />
					<span class="necessary">
							<span></span>
							<div><spring:message code="wzwg.cmm.word.essntl" /></div>
					</span>
				</th>
				<td>
				
					<c:set var="msg_txt01">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.cmm.word.bgnde" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
						</spring:message>
					</c:set>
					
					<c:set var="msg_txt02">
						<spring:message code="wzwg.cmm.cmmMsg.CMG011">
							<spring:argument><spring:message code="wzwg.cmm.word.endde" /></spring:argument>
							<spring:argument><spring:message code="wzwg.cmm.word.choise" /></spring:argument>
						</spring:message>
					</c:set>
					
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="opertBgnde" dir="required,vdateFt=opertBgnde:opertEndde" title="<spring:message code="wzwg.cmm.word.bgnde" />" value="<c:out value="${opertVO.opertBgnde }" />" placeholder="<c:out value="${msg_txt01}" />" onchange="fnDatePreview()"/>
					<select name="beginTime" dir="required,vnum" title="<spring:message code="wzwg.sysMngr.word.beginTime" />" onchange="fnDatePreview()">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq opertVO.beginTime }">selected="selected"</c:if>><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
					~
					<input type="text" class="datePicker cal" style="width:150px;" readonly="readonly" name="opertEndde" dir="required,vdate" title="<spring:message code="wzwg.cmm.word.endde" />" value="<c:out value="${opertVO.opertEndde }" />" placeholder="<c:out value="${msg_txt02}" />" onchange="fnDatePreview()"/>
					<select name="endTime" dir="required,vnum" title="<spring:message code="wzwg.sysMngr.word.endTime" />" onchange="fnDatePreview()">
						<c:forEach begin="0" end="23" varStatus="status">
							<fmt:formatNumber var="sHour" minIntegerDigits="2" value="${status.index }"/>
							<option value="<c:out value="${sHour}" />" <c:if test="${sHour eq opertVO.endTime }">selected="selected"</c:if>><c:out value="${sHour}" /> <spring:message code="wzwg.cmm.word.hour" /></option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.stpgeWords" /></th>
				<td>
				
					<div class="serviceBox">
						
						<div class="serviceTit">
							<div>
									<spring:message code="wzwg.sysMngr.word.hmpgSrvc" /><br/>
									<span class="serStop"><spring:message code="wzwg.cmm.word.pause" /></span>
									<spring:message code="wzwg.cmm.word.guidance" />
								</div>
							</div>
							
							<div class="serviceCo">
								<textarea name="opertCn" id="opertCn" rows="20" class="w80" style="height: 420px; width: 100%;" dir="required" title="<spring:message code="wzwg.sysMngr.word.stpgeWords" />">
									<c:out value="${opertVO.opertCn }" escapeXml="false"/>
								</textarea>
										<script type="text/javascript">
											var oEditors = [];
											nhn.husky.EZCreator.createInIFrame({
											    oAppRef: oEditors,
											    elPlaceHolder: "opertCn",
											    sSkinURI: "<c:out value="${wzwg_contextPath}" />/smartEditor2.8.2.1/smartEditor2Skin.do",
											    fCreator: "createSEditor2",
											    htParams: {
													fOnBeforeUnload : function(){}
													,aAdditionalFontList : [['NanumSquareR', 'NanumSquareR']]		// 추가 글꼴 목록
													}
											});
										</script>		
							</div>
							
							
							<dl class="serviceInfo">
								<dt><spring:message code="wzwg.sysMngr.word.stpgeDt" /></dt>
								<dd>
									<c:out value="${fn:substring(resultVO.opertBgnde, 0, 4)}" /><spring:message code="wzwg.cmm.word.yy" /> 
									<c:out value="${fn:substring(resultVO.opertBgnde, 5, 7)}" /><spring:message code="wzwg.cmm.word.mt" /> 
									<c:out value="${fn:substring(resultVO.opertBgnde, 8, 10)}" /><spring:message code="wzwg.cmm.word.de" /> 
									<c:out value="${resultVO.beginTime}" /><spring:message code="wzwg.cmm.word.hour" /> 
									<span>
									~ 
									<c:out value="${fn:substring(resultVO.opertEndde, 0, 4)}" /><spring:message code="wzwg.cmm.word.yy" /> 
									<c:out value="${fn:substring(resultVO.opertEndde, 5, 7)}" /><spring:message code="wzwg.cmm.word.mt" /> 
									<c:out value="${fn:substring(resultVO.opertEndde, 8, 10)}" /><spring:message code="wzwg.cmm.word.de" /> 
									<c:out value="${resultVO.endTime}" /><spring:message code="wzwg.cmm.word.hour" />
									</span>	
								</dd>
							</dl>
							
							<div class="siteLogozone">
								<img src="<c:out value="${mngrTopLogo}" />&type=w" alt="<spring:message code="wzwg.cmm.word.sitemngr" />" />
						</div>
					</div>
							
				</td>
			</tr>
		</tbody>
	</table>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript">
$(document).ready(function(){
	$("#dplct_btn").click(function(){
		
		if($("#inputSiteKey").val() == ''){
			alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011">'+
					'<spring:argument><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.key" /></spring:argument>'+
					'<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>'+
				  '</spring:message>');
			$("#inputUserId").focus();
			return;
		}else{
			var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
			
			if(regex.test($("#inputSiteKey").val())){
				alert('<spring:message code="wzwg.sysMngr.msg.MSG054" />');
				$("#inputSiteKey").val("");
				$("#inputSiteKey").focus();
				return;
			}					
		}
		
		$("#siteKey").val($("#inputSiteKey").val());
		
		$.ajax({
	        type:'POST'
			, url: '<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoDplctCheckAjax.do'
			, dataType: 'xml'
			, data:$("#regForm").serialize()
			, success:function (result) {
	    	  
	    	  	var value = "";
				
				$(result).find("value").each(function() {  
					value = $(this).text();  
				});
				
				if(value == 'dplctN'){
					alert('<spring:message code="wzwg.sysMngr.msg.MSG053" />');
					$("#dplctYn").val("N");
					$("#siteKey").val("");
					$("#dplct_div").hide();
					$("#inputSiteKey").val("");
					$("#inputSiteKey").focus();
				}else{
					if(!confirm('<spring:message code="wzwg.sysMngr.msg.MSG052" />')) {
						$("#dplctYn").val("N");
						$("#siteKey").val("");
						$("#dplct_div").hide();
						$("#inputSiteKey").val("");
						$("#inputSiteKey").focus();
					}else{
						$("#dplctYn").val("Y");
						$("#siteKey").val($("#inputSiteKey").val());
						$("#siteKeyTmp").val($("#inputSiteKey").val());
						$("#dplct_div").show();
					}
				}
	    	  
			}
			, error:function (request, status, error) {
				alert('<spring:message code="fail.common.msg" text="error" />');
			}
	 	});
	});	
});


function fnRegist() {
    
	if(!Validator.validate(document.regForm)){
		return;
	}
	if(<c:out value="${resultCnt}" />><c:out value="${sessionScope.licenseSiteCnt}" />){
		if(!confirm('현재 사이트수(<c:out value="${resultCnt}" />개)가 라이센스에 대한 사이트(<c:out value="${sessionScope.licenseSiteCnt}" />개)수 보다 더 많습니다. 개발사 혹은 솔루션 업체에 문의 바랍니다.\n\r그래도 생성하시겠습니까?')){
			return;
		}
	}
	
 	<c:choose>
	<c:when test="${empty resultVO.siteSeq}">
	if($("#inputSiteKey").val() != ""){
		if($("#dplctYn").val() != 'Y'){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG051" />');
			return;
		}
		
		if($("#siteKeyTmp").val() != $("#inputSiteKey").val()){
			alert('<spring:message code="wzwg.sysMngr.msg.MSG051" />');
			return;
		}
	}
    document.regForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/registSiteInfo.do";
	</c:when>
	<c:otherwise>
	if($("#inputSiteKey").val() != ""){
		var prevSiteKey = '<c:out value="${resultVO.siteKey}" />';
		var siteKey = $("#inputSiteKey").val();
		
		if(prevSiteKey == siteKey){
		}else{
			if($("#dplctYn").val() != 'Y'){
				alert('<spring:message code="wzwg.sysMngr.msg.MSG051" />');
				return;
			}
			
			if($("#siteKeyTmp").val() != $("#inputSiteKey").val()){
				alert('<spring:message code="wzwg.sysMngr.msg.MSG051" />');
				return;
			}
		}
	}else{
		$("#siteKey").val("");
	}
	
	
    document.regForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/modifySiteInfo.do";
	</c:otherwise>
	</c:choose>
	document.regForm.submit();
}

function fnList() {
	document.regForm.action="<c:out value="${wzwg_contextPath}${prefix}" />/siteMngr/siteInfo/selectSiteInfoList.do";
	document.regForm.submit();
}
 
</script>

            <c:choose>
            <c:when test="${!empty paramVO.siteSeq}">
                <jsp:include page="/WEB-INF/jsp/wzwg/sysMngr/siteMngr/siteInfo/siteInfoTab.jsp"></jsp:include>
            </c:when>
            <c:otherwise>
                <!-- <h3><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.info" /></h3>
                <span style="color: red;" class="pt10 pb10 fl"><spring:message code="wzwg.cmm.msg.MSG243" /></span> -->
                <div class="wz_notice brbox bg-white br-red-strong">
			  		<ul class="wd100">
			    		<li class="admpg-subp wd100 fw600"><spring:message code="wzwg.cmm.msg.MSG243" /></li>
			    	</ul>
			    </div>
            </c:otherwise>
            </c:choose>

                <form:form modelAttribute="resultVO" id="regForm" name="regForm" method="post">
					<form:hidden path="siteSeq" name="siteSeq" />
					<input type="hidden" id="dplctYn" />
					<input type="hidden" id="siteKeyTmp" value="<c:out value="${resultVO.siteKey }" />"/>
					<input type="hidden" name="prevSiteKey" value="<c:out value="${resultVO.siteKey }" />"/>
					
					<input type="hidden" name="siteLclasGroup" value="<c:out value="${paramVO.siteLclasGroup}" />" />
					<input type="hidden" name="siteMlsfcGroup" value="<c:out value="${paramVO.siteMlsfcGroup}" />" />
					<input type="hidden" name="searchCondition" value="<c:out value="${paramVO.searchCondition}" />" />
					<input type="hidden" name="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />" />
					<input type="hidden" name="ablEnncAt" value="<c:out value="${paramVO.ablEnncAt}" />" />
					<input type="hidden" name="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
					
					<!--기본정보 table// -->
                    
					<table class="basic">
						<colgroup>
							<col width="15%"/>
							<col width="*"/>
						</colgroup>
						<tbody>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.siteNm01" /></th>
								<td >
									<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.siteNm01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									 <c:set var="msg_title_txt01"> 
											 <spring:message code="wzwg.sysMngr.word.siteNm01" /> 
									</c:set>
                                    <form:input cssClass="w70" path="siteFullNm" id="siteFullNm" dir="required" title="${fn:escapeXml(msg_title_txt01)}" placeholder="${fn:escapeXml(msg_txt01)}"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.title" /></th>
								<td >
									<c:set var="msg_txt02">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.siteAbrvNm01" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									 <c:set var="msg_title_txt02"> 
											 <spring:message code="wzwg.sysMngr.word.siteAbrvNm01" /> 
									</c:set>
                                    <form:input cssClass="w70" path="siteAbrvNm" id="siteAbrvNm" dir="required,vmaxlen=20" title="${fn:escapeXml(msg_title_txt02)}" placeholder="${fn:escapeXml(msg_txt02)}"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.dc" /></th>
								<td >
									<c:set var="msg_txt03">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.sysMngr.word.siteDc" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									 <c:set var="msg_title_txt03"> 
											 <spring:message code="wzwg.sysMngr.word.siteDc" /> 
									</c:set>
                                    <form:input cssClass="w70" path="siteDc" id="siteDc" dir="required" title="${fn:escapeXml(msg_title_txt03)}" placeholder="${fn:escapeXml(msg_txt03)}"/>
                                    <span class="wz_tableguide mt10"><spring:message code="wzwg.cmm.msg.tip.MSG001" /></span>
								</td>
							</tr>
							<tr>
								<th rowspan="3"><spring:message code="wzwg.cmm.word.adres" /></th>
								<td >
                                <form:input cssClass="w10" path="zipcode" id="zipcode" readonly="true" dir="required" />
								<a href="javascript:void(0);" onclick="execKakaoPostcode();" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.zipSch02" /></a>
								<input type="hidden" id="sample4_roadAddress" placeholder="<spring:message code="wzwg.sysMngr.word.roadnmAdres" />">
								<input type="hidden" id="sample4_jibunAddress" placeholder="<spring:message code="wzwg.sysMngr.word.lnmAdres" />">
								
								<script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
								<script>
									function execKakaoPostcode() {
										new kakao.Postcode({
											oncomplete: function(data) {
												// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
								
												// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
												// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
												var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
												var extraRoadAddr = ''; // 도로명 조합형 주소 변수
								
												// 법정동명이 있을 경우 추가한다.
												if(data.bname !== ''){
													extraRoadAddr += data.bname;
												}
												// 건물명이 있을 경우 추가한다.
												if(data.buildingName !== ''){
													extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
												}
												// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
												if(extraRoadAddr !== ''){
													extraRoadAddr = ' (' + extraRoadAddr + ')';
												}
												// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
												if(fullRoadAddr !== ''){
													fullRoadAddr += extraRoadAddr;
												}
								
												// 우편번호와 주소 정보를 해당 필드에 넣는다.
												document.getElementById("zipcode").value = data.zonecode; //5자리 기초구역번호 사용
												document.getElementById("sample4_roadAddress").value = fullRoadAddr;
												document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
												document.getElementById("adresBass").value = fullRoadAddr;
												//document.getElementById("adresDetail").value = data.jibunAddress;
								
											}
										}).open();
									}
								</script>
								</td>
							</tr>
							<tr>
								<td >
									<c:set var="msg_txt04">
										<spring:message code="wzwg.sysMngr.word.roadnmAdres" />
									</c:set>
									<c:set var="msg_title_txt04"> 
											 <spring:message code="wzwg.sysMngr.word.roadnmAdres" /> 
									</c:set>
                                    <form:input cssClass="w70" path="adresBass" id="adresBass" placeholder="${fn:escapeXml(msg_txt04)}" readonly="true"  dir="required" title="${fn:escapeXml(msg_title_txt04)}"/>
								</td>
							</tr>
							<tr>
								<td >
									<c:set var="msg_txt05">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.detailadr" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									<c:set var="msg_title_txt05"> 
											 <spring:message code="wzwg.sysMngr.word.detailAdres" /> 
									</c:set>
                                    <form:input cssClass="w70" path="adresDetail" id="adresDetail" placeholder="${fn:escapeXml(msg_txt05)}"  dir="required" title="${fn:escapeXml(msg_title_txt05)}"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.sysMngr.word.reprsntNo" /></th>
								<td>
								<c:set var="msg_title_txt06"> 
											 <spring:message code="wzwg.sysMngr.word.telnoPrevNo" /> 
									</c:set>
                                    <form:select cssClass="" path="telno1" name="telno1" title="${fn:escapeXml(msg_title_txt06)}" dir="required,vnum">
                                        <form:option value="02">02</form:option>
                                        <form:option value="031">031</form:option>
                                        <form:option value="032">032</form:option>
                                        <form:option value="033">033</form:option>
                                        <form:option value="041">041</form:option>
                                        <form:option value="042">042</form:option>
                                        <form:option value="043">043</form:option>
                                        <form:option value="044">044</form:option>
                                        <form:option value="051">051</form:option>
                                        <form:option value="052">052</form:option>
                                        <form:option value="053">053</form:option>
                                        <form:option value="054">054</form:option>
                                        <form:option value="055">055</form:option>
                                        <form:option value="061">061</form:option>
                                        <form:option value="062">062</form:option>
                                        <form:option value="063">063</form:option>
                                        <form:option value="064">064</form:option>
                                        <form:option value="060">060</form:option>
                                        <form:option value="070">070</form:option>
                                        <form:option value="010">010</form:option>
                                        <form:option value="011">011</form:option>
                                        <form:option value="016">016</form:option>
                                        <form:option value="017">017</form:option>
                                        <form:option value="018">018</form:option>
                                        <form:option value="019">019</form:option>
                                    </form:select>
                                    <c:set var="msg_title_txt10"> 
											 <spring:message code="wzwg.sysMngr.word.telnoMiddleNo" /> 
									</c:set>
									<c:set var="msg_title_txt11"> 
											 <spring:message code="wzwg.sysMngr.word.telnoEndNo" /> 
									</c:set>
                                    <form:input cssClass="" path="telno2" id="telno2" maxlength="4"  title="${fn:escapeXml(msg_title_txt10)}"  dir="required,vnum,vmaxlen=4"/>
                                    <form:input cssClass="" path="telno3" id="telno3" maxlength="4"  title="${fn:escapeXml(msg_title_txt11)}"  dir="required,vnum,vmaxlen=4"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.fax" /> <spring:message code="wzwg.cmm.word.no" /></th>
								<td>
								<c:set var="msg_title_txt07"> 
											 <spring:message code="wzwg.sysMngr.word.faxPrevNo" /> 
									</c:set>
                                    <form:select cssClass="" path="faxnum1" name="faxnum1" title="${fn:escapeXml(msg_title_txt07)}" dir="required,vnum">
                                        <form:option value="02">02</form:option>
                                        <form:option value="031">031</form:option>
                                        <form:option value="032">032</form:option>
                                        <form:option value="033">033</form:option>
                                        <form:option value="041">041</form:option>
                                        <form:option value="042">042</form:option>
                                        <form:option value="043">043</form:option>
                                        <form:option value="044">044</form:option>
                                        <form:option value="051">051</form:option>
                                        <form:option value="052">052</form:option>
                                        <form:option value="053">053</form:option>
                                        <form:option value="054">054</form:option>
                                        <form:option value="055">055</form:option>
                                        <form:option value="061">061</form:option>
                                        <form:option value="062">062</form:option>
                                        <form:option value="063">063</form:option>
                                        <form:option value="064">064</form:option>
                                        <form:option value="060">060</form:option>
                                        <form:option value="070">070</form:option>
                                    </form:select>
                                    <c:set var="msg_title_txt08"> 
											 <spring:message code="wzwg.sysMngr.word.faxMiddleNo" /> 
									</c:set>
									<c:set var="msg_title_txt09"> 
											 <spring:message code="wzwg.sysMngr.word.faxEndNo" /> 
									</c:set>
                                    <form:input cssClass="" path="faxnum2" id="faxnum2" maxlength="4" title="${fn:escapeXml(msg_title_txt08)}"  dir="required,vnum,vmaxlen=4"/>
                                    <form:input cssClass="" path="faxnum3" id="faxnum3" maxlength="4"  title="${fn:escapeXml(msg_title_txt09)}"  dir="required,vnum,vmaxlen=4"/>
								</td>
							</tr>
							<tr>
								<th><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.key" /></th>
								<td >
									<c:set var="msg_txt01">
										<spring:message code="wzwg.cmm.cmmMsg.CMG011">
											<spring:argument><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.key" /></spring:argument>
											<spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument>
										</spring:message>
									</c:set>
									
									<input type="hidden" name="siteKey" id="siteKey" value="<c:out value="${resultVO.siteKey }" />"/>
									
                                    <input type="text" id="inputSiteKey" name="inputSiteKey" class="w30" maxlength="20" placeholder="<c:out value="${msg_txt01}" />" title="<spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.key" />" value="<c:out value="${resultVO.siteKey }" />" onkeyup="$('#inputSiteKey').val(this.value.replace(/[^a-z]/gi, ''));"/>
									<a href="javascript:void(0);" id="dplct_btn" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.dplctCnfirm" /></a>
									<span id="dplct_div" style="display:none;"><spring:message code="wzwg.sysMngr.word.dplctCnfirmComt" /></span>
								</td>
							</tr>
						</tbody>
					</table>
					<!--//기본정보 table -->
				</form:form>
				
				<div class="rt-box">
					<button  onclick="fnRegist();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></button>
                    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y'}">
					<button  onclick="fnList();" class="wzbtn btn-del"><spring:message code="wzwg.cmm.word.cancl" /></button>
                    </c:if>
				</div>

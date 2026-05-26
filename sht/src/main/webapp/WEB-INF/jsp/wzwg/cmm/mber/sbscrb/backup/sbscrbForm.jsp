<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<link type="text/css" href="/css/wzwg/cmm/mber/sbscrb/style.css" rel="stylesheet" />
<script type="text/javascript" src="/js/wzwg/cmm/common.js" ></script>
<link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function(){
	
	if(document.regForm.usrtySeq.value=="") {
		alert("<spring:message code="wzwg.cmm.msg.MSG120" />");
		document.regForm.action = "/cmm/mber/sbscrb/selectSbscrbUsrTy.do";
		document.regForm.submit();
	}	
    
    /** ID 중복체크 */
    $("#dplct_btn").click(function(){
        
        if($("#inputUserId").val() == ''){
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.id01" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
            $("#inputUserId").focus();
            return;
        }else{
            var regex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
            
            if(regex.test($("#inputUserId").val())){
                alert('<spring:message code="wzwg.cmm.msg.MSG121" />');
                $("#inputUserId").val("");
                $("#inputUserId").focus();
                return;
            }                   
        }
        
        $("#userId").val($("#inputUserId").val());
        
        $.ajax({
            type:'POST'
            , url: '/cmm/mber/sbscrb/selectSbscrbUserIdDplctCeckAjax.do'
            , dataType: 'xml'
            , data:$("#regForm").serialize()
            , success:function (result) {
              
                var value = "";
                
                $(result).find("value").each(function() {  
                    value = $(this).text();  
                });
                
                if(value == 'dplctN'){
                    alert('<spring:message code="wzwg.cmm.msg.MSG119" />');
                    $("#dplctYn").val("N");
                    $("#userId").val("");
                    $("#dplct_div").hide();
                    $("#inputUserId").val("");
                    $("#inputUserId").focus();
                }else{
                    if(!confirm('<spring:message code="wzwg.cmm.msg.MSG027" />')) {
                        $("#dplctYn").val("N");
                        $("#userId").val("");
                        $("#dplct_div").hide();
                        $("#inputUserId").val("");
                        $("#inputUserId").focus();
                    }else{
                        $("#dplctYn").val("Y");
                        $("#userId").val($("#inputUserId").val());
                        $("#userIdTmp").val($("#inputUserId").val());
                        $("#dplct_div").show();
                        //$("#inputUserId").css('background', '#dddddd');
                    }
                }
              
            }
            , error:function (request, status, error) {
                alert('<spring:message code="fail.common.msg" text="error" />');
            }
        });
    });
    
    /** 저장하기 */
    $("#sbscrb_btn").click(function(){
        
        if(!confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG006"><spring:argument><spring:message code="wzwg.cmm.word.signup" /></spring:argument></spring:message>')){
            alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.cancl" text="cancle" /></spring:argument></spring:message>');
            return;
        }else{
            
            <c:if test="${paramVO.unitySbscrbYn ne 'Y'}">
                
	            if($("#userNm").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.nm02" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
            
                if($("#dplctYn").val() != 'Y'){
                    alert('<spring:message code="wzwg.cmm.msg.MSG117" />');
                    return;
                }
                
                if($("#userIdTmp").val() != $("#inputUserId").val()){
                    alert('<spring:message code="wzwg.cmm.msg.MSG117" />');
                    return;
                }
                
                if(document.regForm.password.value == "") {
                	alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.password" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
                	return;
                }
                
        		if(document.regForm.password.value != "") {
        			if(!fn_checkPassword(document.regForm.userId, document.regForm.password, document.regForm.passwordCnfirm)){
        				return;
        			}
        		}
        		
                if($("#emailId").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
				if($("#emailDomn").val() == ''){
	                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.email" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                return;
	            }
            
            	$("#emailAdres").val($("#emailId").val()+"@"+$("#emailDomn").val());            		
        		
                <c:if test="${!empty sbsFormList}">
                <c:forEach items="${sbsFormList}" var="result">
                
                
 				<c:if test="${result.mberSbsfrmCode eq 'SC00000085' && result.qesitmEstbsSe eq 'E'}">					
					
	 				if($("#bassAdres").val() != $("#bassAdres").val()){
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.basadr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                    return;
	                }
	 				if($("#detailAdres").val() != $("#detailAdres").val()){
	                    alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.detailadr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
	                    return;
	                }

				</c:if>
				
 				<c:if test="${result.mberSbsfrmCode eq 'SC00000086' && result.qesitmEstbsSe eq 'E'}">

					if($("#mTelnoF").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            }
					if($("#mTelnoC").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            }
					if($("#mTelnoL").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.cttpc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            }

 				</c:if>		
 				
 				<c:if test="${result.mberSbsfrmCode eq 'SC00000087' && result.qesitmEstbsSe eq 'E'}">			
	
					if($("#hTelnoF").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            }
					if($("#hTelnoC").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            }
					if($("#hTelnoL").val() == ''){
		                alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.mbtlnum" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.input" /></spring:argument></spring:message>');
		                return;
		            } 						

                </c:if>       
                
                </c:forEach>
                </c:if>	        		
                
                
                
            </c:if>
            
            <c:if test="${paramVO.unitySbscrbYn eq 'Y'}">
                $("#userId").val('<c:out value="${paramVO.userId}" />');
            </c:if>
            
            var rspnsArr = new Array();
            
            for(var i = 1; i <= $('#sbscrbSiteArea input[name=qesitmSeq]').length; i++){
                 
                // 객체 생성
                var rspns_data = new Object();
                
                rspns_data.sbscrbinfoSeq    = $('#sbscrbinfoSeq').val();
                rspns_data.sbscrbqesitmSeq  = $('#sbscrbSiteArea input[id=qesitmSeq'+i+']').val();
                rspns_data.qesitmSe         = $('#sbscrbSiteArea input[id=qesitmSe'+i+']').val();
                
                if(rspns_data.qesitmSe == 'S'){
                    rspns_data.sbjctRspns   = $('#sbscrbSiteArea textarea[id=sbjctRspns'+i+']').val();
                }
                
                if(rspns_data.qesitmSe == 'O'){
                    rspns_data.sbscrbiemSeq = $('#sbscrbSiteArea input[id=sbscrbiemSeq'+i+'][type=radio]:checked').val();
                }
                
                // 리스트에 생성된 객체 삽입
                rspnsArr.push(rspns_data);
            }
            
            var frm = document.regForm;
            frm.rspnsArr.value = JSON.stringify(rspnsArr);
            
            
            if($('#crtfctSeCode').val == ''){
                alert('alert('<spring:message code="wzwg.cmm.cmmMsg.CMG011"><spring:argument><spring:message code="wzwg.cmm.word.crtfc" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.progrs" /></spring:argument></spring:message>');');
                return;
            }
            
            $.ajax({
                type:'POST'
                , url: '/cmm/mber/sbscrb/registUsrSbscrbInfoAjax.do'
                , dataType: 'xml'
                , data:$("#regForm").serialize()
                , success:function (result) {
                  
                    var value = "";
                    
                    $(result).find("value").each(function() {  
                        value = $(this).text();  
                    });
                    
                    if(value == 'success'){
                        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.sbscrb" /></spring:argument></spring:message>');
                        
                        var frm = document.regForm;
                        frm.action = "/cmm/mber/sbscrb/selectSbscrbComptPage.do";
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
    $("#cancle_btn").click(function(){
        var frm = document.regForm;
        frm.action = "/loginForm.do";
        frm.submit();
    });
    
    /* 이메일 도메인 변경 */
    $("#selDomn").change(function(){
        
        if($("#selDomn").val() == "directInput"){
            $("#emailDomn").prop("disabled", false);
            $("#emailDomn").val("");
            $("#emailDomn").focus();
        }else{
            $("#emailDomn").prop("disabled", true);
            $("#emailDomn").val($("#selDomn").val());               
        }
        
    });
    
    
});


function fn_checkPassword(paramId, paramPassword, paramPasswordCnfirm){
	if (paramPassword.value != paramPasswordCnfirm.value) {
		alert("<spring:message code="wzwg.cmm.msg.MSG003" />");
		return false;
	}
	if (paramPassword.value.length < 10 || paramPassword.value.length > 16) {
		alert("<spring:message code="wzwg.cmm.msg.MSG052" />");
		return false;
	}
	if (!paramPassword.value
			.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
		alert("<spring:message code="wzwg.cmm.msg.MSG052" />");
		return false;
	}

	if (paramId.value.indexOf(paramPassword) > -1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG055" />");
		return false;
	}

	var SamePass_0 = 0; // 동일문자 카운트
	var SamePass_1 = 0; // 연속성(+) 카운드
	var SamePass_2 = 0; // 연속성(-) 카운드

	var chr_pass_0;
	var chr_pass_1;
	var chr_pass_2;

	for (var i = 0; i < paramPassword.value.length; i++) {
		chr_pass_0 = paramPassword.value.charAt(i);
		chr_pass_1 = paramPassword.value.charAt(i + 1);

		// 동일문자 카운트
		if (chr_pass_0 == chr_pass_1) {
			SamePass_0 = SamePass_0 + 1
		}

		chr_pass_2 = paramPassword.value.charAt(i + 2);
		// 연속성(+) 카운드
		if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == 1
				&& chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == 1) {
			SamePass_1 = SamePass_1 + 1
		}

		// 연속성(-) 카운드
		if (chr_pass_0.charCodeAt(0) - chr_pass_1.charCodeAt(0) == -1
				&& chr_pass_1.charCodeAt(0) - chr_pass_2.charCodeAt(0) == -1) {
			SamePass_2 = SamePass_2 + 1
		}
	}
	if (SamePass_0 > 1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG054" />");
		return false;
	}

	if (SamePass_1 > 1 || SamePass_2 > 1) {
		alert("<spring:message code="wzwg.cmm.msg.MSG056" />");
		return false;
	}
	return true;
	
}

function numkeyCheck(e) { 
    var keyValue = event.keyCode; 
    if( ((keyValue >= 48) && (keyValue <= 57)) ) {
        return true;
    } else {
        return false; 
    }
}
</script>
     

	<div class="subConall">
		 <div class="joinUs001 mg10">
			 <ul class="joinTop_ul mb40">
					<li><span>1. <spring:message code="wzwg.cmm.word.tmacnd" /> <spring:message code="wzwg.cmm.word.cnfirm" /></span></li>
					<li><span class="sign_menu_on">2. <spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /> <spring:message code="wzwg.cmm.word.input" /></span></li>
					<li><span>3. <spring:message code="wzwg.cmm.word.signup" /> <spring:message code="wzwg.cmm.word.compt" /></span></li>
			 </ul>
			 <h2><spring:message code="wzwg.cmm.word.signup" /></h2>
			 <p><spring:message code="wzwg.cmm.msg.MSG115" /></p>
			 
		     <form:form modelAttribute="paramVO" path="regForm" id="regForm" name="regForm" method="post">
		     <form:hidden path="siteSeq" />
		     <form:hidden path="sbscrbqesitmSeq" />
		     <form:hidden path="sbscrbiemSeq" />
		     <form:hidden path="sbjctRspns" />
		     <form:hidden path="crtfctSeCode" />
		     <input type="hidden" name="stplatArr" id="stplatArr" value="<c:out value="${paramVO.stplatArr}" />" />
		     <form:hidden path="userId" id="userId" name="userId" />
		     <form:hidden path="unitySbscrbYn" />
		     <input type="hidden" name="siteStplatArr" />
		     <input type="hidden" name="rspnsArr" />
		     <input type="hidden" id="dplctYn" />
		     <input type="hidden" id="userIdTmp" />	
		     <form:hidden path="usrtySeq" />
		     <form:hidden path="usrTyCode" />
		     <form:hidden path="usrgroupSeq" />			 
			 
			 <div class="joinUs_wrap pt10">
			 
			 <c:if test="${paramVO.unitySbscrbYn ne 'Y'}">
			 
			  <div class="joinUs_box pt10">	
				<h3><spring:message code="wzwg.cmm.word.bass" /> <spring:message code="wzwg.cmm.word.info" /></h3>
				<table>
					<colgroup>
						<col width="15%">
						<col width="35%">
						<col width="15%">
						<col width="35%">
					</colgroup>
					<tr>
						<th><spring:message code="wzwg.cmm.word.site" /> <spring:message code="wzwg.cmm.word.nm01" /></th>
						<td colspan="3">
							<c:out value="${siteInfoVO.siteFullNm}" />
						</td>
					</tr>
					<tr>
						<th><spring:message code="wzwg.cmm.word.mber" /> <spring:message code="wzwg.cmm.word.ty" /></th>
						<td colspan="3">
							<c:if test="${!empty usrtyList}">
		        				<c:forEach var="usrtyList" items="${usrtyList}" varStatus="status">
		        					<c:if test="${usrtyList.usrtySeq eq paramVO.usrtySeq}">
										<c:out value="${usrtyList.tyNm}" />
									</c:if>	
								</c:forEach>
							</c:if>					
						</td>
					</tr>
					<tr>
						<th><span class="red">*</span><spring:message code="wzwg.cmm.word.nm02" /></th>
						<td colspan="3">
							<form:input path="userNm" maxlength="25" onkeyup="fnKeyUpEvent('userNm', '5');" />
						</td>
					</tr>
					<tr>
						<th><span class="red">*</span>ID</th>
						<td colspan="3">
							<input type="text" id="inputUserId" name="inputUserId" maxlength="20" style="ime-mode:inactive;" onkeyup="fnKeyUpEvent('inputUserId', '6');" />
                    		<a href="javascript:void(0);" id="dplct_btn" class="id_select_bt"><span><spring:message code="wzwg.cmm.word.dplct" /> <spring:message code="wzwg.cmm.word.cnfirm" /></span></a>
                    		<span id="dplct_div" style="display:none;" class="id_select_ok">ID <spring:message code="wzwg.cmm.word.dplct" /> <spring:message code="wzwg.cmm.word.cnfirm" /> <spring:message code="wzwg.cmm.word.compt" /></span>						
						</td>
					</tr>
					<tr>
						<th><span class="red">*</span><spring:message code="wzwg.cmm.word.password" /></th>
						<td>
							<form:password path="password" maxlength="20" />
                    		<span class="pw_select_ok red"><spring:message code="wzwg.cmm.msg.MSG019" /></span>						
						</td>
						<th><span class="red">*</span><spring:message code="wzwg.cmm.word.password" /> <spring:message code="wzwg.cmm.word.cnfirm" /></th>
						<td>
							<input type="password" name="passwordCnfirm" id="passwordCnfirm" maxlength="20" autocomplete="off" />
						</td>						
					</tr>
					
					<tr>
						<th>
							<span class="red">*</span>
							E-mail
						</th>
						<td colspan="3">
		                    <form:hidden path="emailAdres" />
		                    <input type="text" id="emailId" maxlength="100" onkeyup="fnKeyUpEvent('emailId', '6');" class="w20"/>
							<span class="pd_3b">@</span>
							<input type="text" id="emailDomn" maxlength="50" onkeyup="fnKeyUpEvent('emailDomn', '6');" class="w20" disabled/>
		                    <select class="pd_3b" id="selDomn">
		                        <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
		                        <option value="naver.com">naver.com</option>
		                        <option value="gmail.com">gmail.com</option>
		                        <option value="daum.net">daum.net</option>
		                        <option value="nate.com">nate.com</option>
		                        <option value="directInput"><spring:message code="wzwg.cmm.word.drtinp" /></option>
		                    </select>						
						
						</td>
					</tr>   					
					
               <c:if test="${!empty sbsFormList}">
               <c:forEach items="${sbsFormList}" var="result">
               
               
				<c:if test="${result.mberSbsfrmCode eq 'SC00000085' && result.qesitmEstbsSe ne 'N'}">					
					
					<tr>
						<th rowspan="3">
							<c:if test="${result.qesitmEstbsSe eq 'E'}">
								<span class="red">*</span>
							</c:if>
							주소
						</th>
						<td colspan="3">
							<input type="text" class="w10" id="zip" name="zip" readonly="readonly" value="<c:out value='${infoVO.zip}'/>">
							<a href="javascript:void(0);" onclick="execKakaoPostcode();" class="id_select_bt"><span><spring:message code="wzwg.cmm.word.zip" /> <spring:message code="wzwg.cmm.word.search02" /></span></a>
		                    <script src="https://t1.kakaocdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		                    <script>
		                        function execKakaoPostcode() {
		                            new kakao.Postcode({
		                                oncomplete: function(data) {
		                                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		                    
		                                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                                    var fullAddr = ''; // 최종 주소 변수
		                                    var extraAddr = ''; // 조합형 주소 변수
		                    
		                                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                                        fullAddr = data.roadAddress;
		                    
		                                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                                        fullAddr = data.jibunAddress;
		                                    }
		                    
		                                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		                                    if(data.userSelectedType === 'R'){
		                                        //법정동명이 있을 경우 추가한다.
		                                        if(data.bname !== ''){
		                                            extraAddr += data.bname;
		                                        }
		                                        // 건물명이 있을 경우 추가한다.
		                                        if(data.buildingName !== ''){
		                                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                                        }
		                                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                                        fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                                    }
		                    
		                                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                                    document.getElementById('zip').value = data.zonecode; //5자리 새우편번호 사용
		                                    document.getElementById('bassAdres').value = fullAddr;
		                    
		                                    // 커서를 상세주소 필드로 이동한다.
		                                    document.getElementById('detailAdres').focus();
		                                }
		                            }).open();
		                        }
		                    </script>													
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<input type="text" name="bassAdres" id="bassAdres" placeholder="<spring:message code="wzwg.cmm.word.basadr" />" class="loBox w50 mlr3" readonly="readonly" value="<c:out value="${infoVO.bassAdres}" />">
						</td>
					</tr>	
					<tr>
						<td colspan="3">
							<input type="text" name="detailAdres" id="detailAdres" placeholder="<spring:message code="wzwg.cmm.word.detailadr" />" class="loBox w50 mlr3" value="<c:out value="${infoVO.detailAdres}" />" />
						</td>
					</tr>				
					
				</c:if>
					
				<c:if test="${result.mberSbsfrmCode eq 'SC00000086' && result.qesitmEstbsSe ne 'N'}">
				
					<tr>
						<th>
							<c:if test="${result.qesitmEstbsSe eq 'E'}">
								<span class="red">*</span>
							</c:if>
							연락처
						</th>
						<td colspan="3">
						
							<select name="mTelnoF" id="mTelnoF">
		                        <c:forEach items="${mTelnoList}" var="mTelno" varStatus="i">
		                            <option value="<c:out value="${mTelno.codeNm}" />" <c:if test="${infoVO.mTelnoF eq mTelno.codeNm}">selected="selected"</c:if>><c:out value="${mTelno.codeNm}" /></option>
		                        </c:forEach>
		                    </select>						
							<span class="pd_3b">-</span>
							<input type="text" name="mTelnoC" id="mTelnoC" value="<c:out value="${infoVO.mTelnoC}" />" maxlength="4" class="w10" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
							<span class="pd_3b">-</span>
							<input type="text" name="mTelnoL" id="mTelnoL" value="<c:out value="${infoVO.mTelnoL}" />" maxlength="4" class="w10" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
						</td>
					</tr>
					
				</c:if>		
				
				<c:if test="${result.mberSbsfrmCode eq 'SC00000087' && result.qesitmEstbsSe ne 'N'}">			
					
					<tr>
						<th>
							<c:if test="${result.qesitmEstbsSe eq 'E'}">
								<span class="red">*</span>
							</c:if>						
							<spring:message code="wzwg.cmm.word.moblphon" />
						</th>
						<td colspan="3">
							<select name="hTelnoF" id="hTelnoF">
		                        <c:forEach items="${hTelnoList}" var="hTelno" varStatus="i">
		                            <option value="<c:out value="${hTelno.codeNm}" />" <c:if test="${infoVO.hTelnoF eq hTelno.codeNm}">selected="selected"</c:if>><c:out value="${hTelno.codeNm}" /></option>
		                        </c:forEach>
		                    </select>
							<span class="pd_3b">-</span>
							<input type="text" name="hTelnoC" id="hTelnoC" value="<c:out value="${infoVO.hTelnoC}" />" maxlength="4" class="w10" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
							<span class="pd_3b">-</span>
							<input type="text" name="hTelnoL" id="hTelnoL" value="<c:out value="${infoVO.hTelnoL}" />" maxlength="4" class="w10" style="IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
						</td>
					</tr>
					
               </c:if>

               </c:forEach>
               </c:if>					
					
				</table>
			  </div>

			 </c:if>
			 
		      <div class="joinUs_box mt30">
		          <c:import url="/cmm/mber/sbscrb/selectSbscrbSiteStplat.do" charEncoding="utf-8" />
		      </div>
		        
		      <div id="sbscrbSiteArea" class="joinUs_box pt10" style="display:none;">
		          <c:import url="/cmm/mber/sbscrb/selectSbscrbForm.do" charEncoding="utf-8" />
		      </div>			 
			  
			 </div>
			 
			 </form:form>

			 
		     <ul class="joinUs_ul mt60">	
		     	<li><a class="sign_ftbt_on" href="javascript:void(0);" id="sbscrb_btn" style="display:none;"><spring:message code="wzwg.cmm.word.signup" /></a></li>	       
		        <li><a href="javascript:void(0);" id="cancle_btn"><spring:message code="wzwg.cmm.word.cancl" /></a></li>
		     </ul>	

		     		 
		</div><!-- 회원가입 end -->

	</div>

                
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>
<script type="text/javascript" src="/js/wzwg/cmm/jquery-checktree.js" ></script>
<link rel="stylesheet" href="/css/wzwg/cmm/jquery-checktree.css" type="text/css" />
<script type="text/javascript">
	function fn_emailChange(paramValue) {
		if(paramValue == "") {
			$("#typeInput").removeAttr("disabled");
			fn_emailDirectInput();
		} else {
			$("#typeInput").attr("disabled", true);
			$("#typeInput").val(paramValue);
			$("#emailAdres").val($("#email").val() + "@" + $("#emailType").val());
		}
	}
	
	function fn_emailDirectInput() {
		$("#emailAdres").val($("#email").val() + "@" + $("#typeInput").val());
	}
	
	function fn_passwordInit(){
		alert('<spring:message code="wzwg.cmm.cmmMsg.CMG020">'+
				'<spring:argument><spring:message code="wzwg.sysMngr.word.initlPasswd" /></spring:argument>'+
				'<spring:argument>`dnlwm20!^@`</spring:argument>'+
			  '</spring:message>');
		document.usrInfoForm.password.value = "dnlwm20!^@";
		document.usrInfoForm.passwordCnfirm.value = "dnlwm20!^@";

	}
	
	function fn_checkPassword(paramId, paramPassword, paramPasswordCnfirm){
		if (paramPassword.value != paramPasswordCnfirm.value) {
			alert('<spring:message code="wzwg.cmm.msg.MSG003" />');
			return false;
		}
		if (paramPassword.value.length < 10) {
			alert('<spring:message code="wzwg.cmm.msg.MSG052" />');
			return false;
		}
		if (!paramPassword.value
				.match(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/)) {
			alert('<spring:message code="wzwg.cmm.msg.MSG052" />');
			return false;
		}

		if (paramId.value.indexOf(paramPassword) > -1) {
			alert('<spring:message code="wzwg.cmm.msg.MSG055" />');
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
			alert('<spring:message code="wzwg.cmm.msg.MSG054" />');
			return false;
		}

		if (SamePass_1 > 1 || SamePass_2 > 1) {
			alert('<spring:message code="wzwg.cmm.msg.MSG056" />');
			return false;
		}
		return true;
		
	}
	
	function fn_modifyUsrInfo(){
		
		if(document.usrInfoForm.password.value != ""){
			if(!fn_checkPassword(document.usrInfoForm.userId, document.usrInfoForm.password, document.usrInfoForm.passwordCnfirm)){
				return;
			}
		}
        
        var rspnsArr = new Array();
        
        for(var i = 1; i <= $('#sbscrbSiteArea input[name=qesitmSeq]').length; i++){
             
            // 객체 생성
            var rspns_data = new Object();
            
            rspns_data.sbscrbinfoSeq    = $('#sbscrbinfoSeq').val();
            rspns_data.sbscrbqesitmSeq  = $('#sbscrbSiteArea input[id=qesitmSeq'+i+']').val();
            rspns_data.qesitmSe         = $('#sbscrbSiteArea input[id=qesitmSe'+i+']').val();
            rspns_data.sbscrbrspns      = $('#sbscrbSiteArea input[id=sbscrbrspns'+i+']').val();
            
            if(rspns_data.qesitmSe == 'S'){
                rspns_data.sbjctRspns   = $('#sbscrbSiteArea textarea[id=sbjctRspns'+i+']').val();
            }
            if(rspns_data.qesitmSe == 'O'){
                rspns_data.sbscrbiemSeq = $('#sbscrbSiteArea input[name=sbscrbiemSeq'+i+'][type=radio]:checked').val();
            }
            
            // 리스트에 생성된 객체 삽입
            rspnsArr.push(rspns_data);
        }
        
        var frm = document.usrInfoForm;
        frm.rspnsArr.value = JSON.stringify(rspnsArr);
		
		$.ajax({
			type:'POST'
			, url:'<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/modifyUsrInfo.do'
			, data:$("#usrInfoForm").serialize()
			,success:function (result){
				$(result).find('value').each(function(){
					if($(this).text() == "success"){
						alert('<spring:message code="wzwg.cmm.cmmMsg.CMG005"><spring:argument><spring:message code="wzwg.cmm.word.updt" /></spring:argument></spring:message>');
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
	
	function fn_cancel(){
		// document.frmSrh.siteSeq.value="";
		document.frmSrh.action='<c:out value="${wzwg_contextPath}${prefix}" />/usrMngr/usrInfo/selectUsrInfoList.do';
		document.frmSrh.submit();
	}
	
	function fnUsrTyCodeChange() {
        $.ajax({
            type:'post'
            , url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrTy/selectSiteUsrTySbscrb.do'
            , data:$("#frmCode").serialize()
            ,success:function (result){
                
                $('select[name="usrtySeq"] option').remove();
                
                var resultList = result['resultList'];
                if (resultList != null) {
                    for (var i=0; i<resultList.length; i++) {
                        var selected = ('<c:out value="${infoVO.usrtySeq}" />' == resultList[i].usrTySeq)? 'selected':'';
                        
                        $('.selUsrtySeq').append('<option value="'+resultList[i].usrTySeq+'" '+selected+'>'+resultList[i].tyNm+'</option>');
                    }   
                }
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
	}
	
	$(document).ready(function(){
	    fnFrmCodeValue('<c:out value="${infoVO.usrTyCode}" />');
	    <c:if test="${sessionScope.SYSMNGR_AT eq 'Y' }">
      //  $('input:text').attr('disabled', 'true');
       // $('input:radio').attr('disabled', 'true');
       // $('input:checkbox').attr('disabled', 'true');
       // $('.basic select').attr('disabled', 'true');
       // $('textarea').attr('disabled', 'true');
	    </c:if>
	});
	
	function fnFrmCodeValue(usrTyCode) {
        var frm = document.frmCode;
        
        frm.usrTyCode.value = usrTyCode;

        fnUsrTyCodeChange();
	}
	
	function fnUsrFormChange(usrtySeq) {
        var frm = document.frmCode;
        
        frm.usrtySeq.value = usrtySeq;
        frm.frmGubun.value = "M";
	    
        $.ajax({
            type:'post'
            , url:'<c:out value="${wzwg_contextPath}" />/mngr/usrMngr/usrInfo/selectSbscrbFormAjax.do'
            , data:$("#frmCode").serialize()
            , dataType: 'html'
            ,success:function (data){
                $('#sbscrbSiteArea').html(data);
            }
            , error:function (request, status, error) {
                  alert('<spring:message code="fail.common.msg" text="error" />');
              }
        });
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

    <form id="frmSrh" name="frmSrh" method="post">
        <input type="hidden" name="pageIndex" id="pageIndex" value="<c:out value="${paramVO.pageIndex}" />" />
        <input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${paramVO.siteSeq}" />"/>
        <input type="hidden" name="usrTyCode" id="usrTyCode" value="<c:out value="${paramVO.usrTyCode}" />"/>
        <input type="hidden" name="usrSttusCode" id="usrSttusCode" value="<c:out value="${paramVO.usrSttusCode}" />"/>
        <input type="hidden" name="usrGroupSeq" id="usrGroupSeq" value="<c:out value="${paramVO.usrGroupSeq}" />"/>
        <input type="hidden" name="searchCondition" id="searchCondition" value="<c:out value="${paramVO.searchCondition}" />"/>
        <input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${paramVO.searchKeyword}" />"/>
    </form>
            
	<form id="frmCode" name="frmCode" method="post">
        <input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${infoVO.siteSeq}" />"/>
        <input type="hidden" name="usrSeq" id="usrSeq" value="<c:out value="${infoVO.usrSeq}" />"/>
        <input type="hidden" name="usrTyCode" id="usrTyCode" />
        <input type="hidden" name="usrtySeq" id="usrtySeq" />
        <input type="hidden" name="frmGubun" id="frmGubun" />
    </form>
	<form id="usrInfoForm" name="usrInfoForm" method="post">
    <input type="hidden" name="siteSeq" id="siteSeq" value="<c:out value="${infoVO.siteSeq}" />"/>
	<input type="hidden" name="usrSeq" id="usrSeq" value="<c:out value="${infoVO.usrSeq }" />"/>
	<input type="hidden" name="userId" id="userId" value="<c:out value="${infoVO.userId }" />"/>
    <input type="hidden" name="rspnsArr" />
    
    <h3 class="wzAdmSTit  wd100 fl"><spring:message code="wzwg.sysMngr.word.mberinfoUpdt"/></h3>
	<table class="basic">
		<colgroup>
			<col width="13%"/>
			<col width="37%"/>
			<col width="13%"/>
			<col width="37%"/>
		</colgroup>
		<tbody>
               <tr>
                   <th><spring:message code="wzwg.sysMngr.word.signupDe" /></th>
                   <td colspan="3">
                       <c:out value="${infoVO.sbscrbPnttm }"/>
                   </td>
               </tr>
               <tr>
                   <th><spring:message code="wzwg.sysMngr.word.siteNm01" /></th>
                   <td colspan="3">
                       <c:out value="${infoVO.siteFullNm }"/>
                   </td>
               </tr>
                <c:if test="${infoVO.usrtySeq ne nAdminUsrtySeq and infoVO.usrtySeq ne sAdminUsrtySeq }">
			<tr>
				<th><spring:message code="wzwg.sysMngr.word.mberSttus" /></th>
				<td colspan="3">
					<select id="usrSttusCode" name="usrSttusCode">
                    <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                    <c:forEach items="${usrSttusList}" var="codeVO">
                        <option value="<c:out value="${codeVO.code}" />" <c:if test="${codeVO.code eq infoVO.usrSttusCode}">selected</c:if>><c:out value="${codeVO.codeNm}" /></option>
                    </c:forEach>
                    </select>
				</td>
			</tr>
            <tr>
                <th><spring:message code="wzwg.sysMngr.word.mberTy" /></th>
                <td colspan="3">
                    <select id="usrTyCode" name="usrTyCode" onchange="fnFrmCodeValue(this.value)">
                    <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                    <c:forEach items="${usrTyCdList}" var="codeVO">
                        <option value="<c:out value="${codeVO.code}" />" <c:if test="${codeVO.code eq infoVO.usrTyCode}">selected</c:if>><c:out value="${codeVO.codeNm}" /></option>
                    </c:forEach>
                    </select>
                    <span class="i-block vert-m mr15 br-top1 br-rgt1 br-lft0 br-btm0 brsolid br-black" style="width: 7px;height: 7px;transform: rotate(45deg);"></span>
                    <select id="usrtySeq" name="usrtySeq" class="selUsrtySeq" onchange="fnUsrFormChange(this.value)">
                    </select>
                    <span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG076" /></span>
                </td>
            </tr>
            <tr>
                <th><spring:message code="wzwg.sysMngr.word.mberGroup" /></th>
                <td colspan="3">
                    <select id="usrGroupSeq" name="usrGroupSeq">
                    <option value=""><spring:message code="wzwg.cmm.word.choise" /></option>
                    <c:forEach items="${usrGroupList}" var="result">
                        <option value="<c:out value="${result.usrGroupSeq}" />" <c:if test="${result.usrGroupSeq eq infoVO.usrGroupSeq}">selected</c:if>><c:out value="${result.usrGroupNm}" /></option>
                    </c:forEach>
                    </select>
                    <span class="wz_tableguide wd100 fl mt10"><spring:message code="wzwg.cmm.msg.tip.MSG077" /></span>
                </td>
            </tr>
            </c:if>
             <c:if test="${infoVO.usrtySeq eq nAdminUsrtySeq}">
       		 <input type="hidden" name="usrtySeq" id="usrtySeq" value="<c:out value="${infoVO.usrtySeq}" />"/>
             </c:if>
			<tr>
				<th><spring:message code="wzwg.cmm.word.nm02" /></th>
				<td colspan="3">
					<c:out value="${infoVO.userNm }"/>
				</td>
			</tr>
			<tr>
				<th><spring:message code="wzwg.cmm.word.id02" /></th>
				<td colspan="3">
					<c:out value="${infoVO.userId }"/>
				</td>
			</tr>
               <c:if test="${!empty sbsFormList}">
               <c:forEach items="${sbsFormList}" var="result">
               <c:if test="${result.mberSbsfrmCode eq 'SC00000085' && result.qesitmEstbsSe ne 'N'}">
               <!-- 주소 -->
              <tr>
                <th rowspan="3"><spring:message code="wzwg.cmm.word.adres" /></th>
                <td colspan="3">
                    <input type="text" class="sBox" id="zip" name="zip" readonly="readonly" value="<c:out value='${infoVO.zip}'/>"><a href="javascript:void(0);" onclick="execKakaoPostcode();" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.zipSch02" /></a>
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
                <td colspan="3"><input class="loBox" type="text" name="bassAdres" id="bassAdres" placeholder="<spring:message code="wzwg.cmm.word.basadr" />" style="width:50%;" readonly="readonly" value="<c:out value="${infoVO.bassAdres}" />"><span class="adSm"><spring:message code="wzwg.sysMngr.word.roadnmLnmBasadr" /></span></td>
               </tr>
                <tr>
                <td colspan="3"><input type="text" name="detailAdres" id="detailAdres" placeholder="<spring:message code="wzwg.cmm.word.detailadr" />" class="loBox" style="width:50%;" value="<c:out value="${infoVO.detailAdres}" />" /><span class="adSm"><spring:message code="wzwg.cmm.word.detailadr" /></span></td>
               </tr>
               </c:if>
               <c:if test="${result.mberSbsfrmCode eq 'SC00000086' && result.qesitmEstbsSe ne 'N'}">
               <!-- 연락처 -->
               <tr>
                <th><spring:message code="wzwg.cmm.word.telno" /></th>
                <td colspan="3">
                    <select name="mTelnoF" style="width:100px;">
                        <option value=""><spring:message code="wzwg.cmm.word.unsel" /></option>
                        <c:forEach items="${mTelnoList}" var="mTelno" varStatus="i">
                            <option value="<c:out value="${mTelno.codeNm}" />" <c:if test="${infoVO.mTelnoF eq mTelno.codeNm}">selected="selected"</c:if>><c:out value="${mTelno.codeNm}" /></option>
                        </c:forEach>
                    </select>
                    <input type="text" name="mTelnoC" value="<c:out value="${infoVO.mTelnoC}" />" maxlength="4" style="width:100px;IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                    <input type="text" name="mTelnoL" value="<c:out value="${infoVO.mTelnoL}" />" maxlength="4" style="width:100px;IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                </td>
               </tr>
               </c:if>
               <c:if test="${result.mberSbsfrmCode eq 'SC00000087' && result.qesitmEstbsSe ne 'N'}">
               <!-- 휴대폰 -->
               <tr>
                <th><spring:message code="wzwg.cmm.word.moblphon" /></th>
                <td colspan="3">
                    <select name="hTelnoF" style="width:100px;">
                        <c:forEach items="${hTelnoList}" var="hTelno" varStatus="i">
                            <option value="<c:out value="${hTelno.codeNm}" />" <c:if test="${infoVO.hTelnoF eq hTelno.codeNm}">selected="selected"</c:if>><c:out value="${hTelno.codeNm}" /></option>
                        </c:forEach>
                    </select>
                    <input type="text" name="hTelnoC" value="<c:out value="${infoVO.hTelnoC}" />" maxlength="4" style="width:100px;IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                    <input type="text" name="hTelnoL" value="<c:out value="${infoVO.hTelnoL}" />" maxlength="4" style="width:100px;IME-MODE:disabled;" onkeypress="return numkeyCheck(event);" />
                </td>
               </tr>
               </c:if>
               <c:if test="${result.mberSbsfrmCode eq 'SC00000088' && result.qesitmEstbsSe ne 'N'}">
               <tr>
                   <th><spring:message code="wzwg.cmm.word.email" /></th>
                   <td colspan="3">
                       <c:set var="email" value="${fn:split(infoVO.emailAdres, '@')}"/>
                       <c:forEach items="${email }" var="emailData" varStatus="status">
                           <c:if test="${status.count == 1 }"><c:set var="email1" value="${emailData }"/></c:if>
                           <c:if test="${status.count == 2 }"><c:set var="email2" value="${emailData }"/></c:if>
                       </c:forEach>
                       <input type="text" name="email" id="email" value="<c:out value="${email1 }" />"/>
                       <span class="mg_r5 mg_15">@</span>
                       <select onchange="fn_emailChange(this.value);" name="emailType" id="emailType">
                           <option value=""><spring:message code="wzwg.cmm.word.drtinp" /></option>
                           <option value="naver.com">naver.com</option>
                           <option value="daum.com">daum.com</option>
                           <option value="gmail.com">gmail.com</option>
                           <option value="hanmail.net">hanmail.net</option>
                           <option value="dreamwiz.com">dreamwiz.com</option>
                       </select>
                       <input type="text" name="typeInput" id="typeInput" class="txt" onchange="fn_emailDirectInput();" value="<c:out value="${email2 }" />"/>
                       <input type="hidden" name="emailAdres" id="emailAdres" value="<c:out value="${infoVO.emailAdres }" />"/>
                   </td>
               </tr>
               </c:if>
               </c:forEach>
               </c:if>
			<tr>
				<th><spring:message code="wzwg.cmm.word.password02" /></th>
				<td>
					<input type="password" name="password" id="password" value="" class="txt" autocomplete="off"/>
					<a href="javascript:void(0);" onclick="fn_passwordInit();" class="wzbtn-table btn-basic"><spring:message code="wzwg.sysMngr.word.paawdInitl" /></a>
					<p id="passwordChkTxt" class="admpg-subp w100 fl mt10">
                        <span class="circle_no bg-green-strong vert-m">i</span><spring:message code="wzwg.cmm.msg.MSG152" />
                    </p>
                    <p class="admpg-subp w100 fl">
                        <span class="wz_tableguide mt5 pl15"><spring:message code="wzwg.cmm.msg.MSG052" /></span>
                    </p>
				</td>
				<th><spring:message code="wzwg.sysMngr.word.passwd02Cnfirm" /></th>
				<td class="vert-t">
					<input type="password" name="passwordCnfirm" id="passwordCnfirm" value="" class="txt" autocomplete="off"/>
				</td>
			</tr>
            <c:if test="${paramVO.siteSeq ne '10000000001' and sessionScope.SYSMNGR_AT eq 'Y' and infoVO.usrtySeq eq '10000000307'}">
            <tr>
                <th><spring:message code="wzwg.sysMngr.word.mngrAuthor" /></th>
                <td colspan="3">
                <ul id="tree" class="wzForm"> 
                   <c:forEach items="${mngrMenuList['MENU_LIST']}" var="oneDepth" varStatus="status">
                    <c:if test="${empty oneDepth.upperMenuSeq or oneDepth.upperMenuSeq eq '0' }"> 
					<li>
					<label>
					<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${oneDepth.mngrMenuSeq}" />" <c:if test="${oneDepth.mngrAuthAt eq 'Y'}"> checked="checked"</c:if>/>
					<span class="spanLabel"><c:out value="${oneDepth.mngrMenuNm}" /></span></label>
				
						<ul>
							    <c:forEach items="${mngrMenuList['MENU_LIST']}" var="twoDepth" varStatus="status">
       								<c:if test="${oneDepth.mngrMenuSeq eq twoDepth.upperMenuSeq}"> 
							<li>
							<label>
							<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${twoDepth.mngrMenuSeq}" />"   <c:if test="${twoDepth.mngrAuthAt eq 'Y'}"> checked="checked"</c:if>/>
							<span class="spanLabel"><c:out value="${twoDepth.mngrMenuNm}" /></span></label>
							<ul>
							  <c:forEach items="${mngrMenuList['MENU_LIST']}" var="threeDepth" varStatus="status">
        									<c:if test="${twoDepth.mngrMenuSeq eq threeDepth.upperMenuSeq}"> 
								<li>
								<label>
								<input type="checkbox" name="mngrMenuSeqArry" value="<c:out value="${threeDepth.mngrMenuSeq}" />"   <c:if test="${threeDepth.mngrAuthAt eq 'Y'}"> checked="checked"</c:if>/>
								<span class="spanLabel"><c:out value="${threeDepth.mngrMenuNm}" /></span></label>
								</li>
								 </c:if>
								 </c:forEach>
							</ul>
							</li>
						</c:if>
						</c:forEach>
						</ul>
					</li> 
					</c:if>
				  </c:forEach>
				</ul> 
                </td>
            </tr>
            </c:if>
		</tbody>
	</table>
	<script>
		$('#tree').checktree();
		$("#tree li").css("float","none");
		$("#tree li").css("line-height","22px");
		$("#tree ul").css("padding","revert");
		</script>
       <div id="sbscrbSiteArea">
         <c:import url="${wzwg_contextPath}/cmm/mber/sbscrb/selectSbscrbForm.do" charEncoding="utf-8">
         <c:param name="usrtySeq" value="${infoVO.usrtySeq}" />
         <c:param name="frmGubun" value="M" />
         </c:import>
       </div>
	</form>
	<div class="rt-box">
		<a href="javascript:void(0);" onclick="fn_modifyUsrInfo();" class="wzbtn btn-save"><spring:message code="wzwg.cmm.word.stre" /></a>
		<a href="javascript:void(0);" onclick="fn_cancel();" class="wzbtn btn-basic"><spring:message code="wzwg.cmm.word.list" /></a>
	</div>

<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script>
function fnNiceCrtfc() {
    window.name ="crtfc_window";
    
    window.open('', 'crtfcModuleChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

    var frm = document.frmCrtfc;
    
    frm.EncodeData.value = '<c:out value="${niceCrtfcKeyMap.sEncData}" />';
    frm.action = "https://nice.checkplus.co.kr/CheckPlusSafeModel/checkplus.cb";
    frm.target = "crtfcModuleChk";
    frm.submit();
}

function fnSnsAuthPopup(popUrl) {
    window.name ="crtfc_window";
    window.open(popUrl, 'crtfcModuleChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
}

function fnNaver() { 
	if('<c:out value="${naverAuthUrl}" />' == ''){
		alert(wz_msg('wzwg.cmm.msg.MSG454'));
	}else{
    fnSnsAuthPopup('<c:out value="${naverAuthUrl}" />');
	}
}

function fnGoogle() { 
	if('<c:out value="${googleAuthUrl}" />' == ''){
		alert(wz_msg('wzwg.cmm.msg.MSG454'));
	}else{
    fnSnsAuthPopup('<c:out value="${googleAuthUrl}" />');
	}
}

function fnFacebook() {
    fnSnsAuthPopup('<c:out value="${facebookAuthUrl}" />');
}

function fnKakao() { 
	if('<c:out value="${kakaoClientId}" />' == ''){
		alert(wz_msg('wzwg.cmm.msg.MSG454'));
	}else{
    window.name ="crtfc_window";
    
    window.open('', 'crtfcModuleChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

    var frm = document.frmCrtfc;

    frm.action = 'https://kauth.kakao.com/oauth/authorize';
    frm.client_id.value = '<c:out value="${kakaoClientId}" />';
    frm.redirect_uri.value = '<c:out value="${kakaoRedirectUrl}" />';
    frm.response_type.value = 'code';
    frm.target = "crtfcModuleChk";
    frm.method = 'get';
    frm.submit();
	}
}

function fnNiceCrtfcTest() {
    window.name ="crtfc_window";
    
    window.open('', 'crtfcModuleChk', 'width=500, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');

    var frm = document.frmCrtfc;
    
    frm.EncodeData.value = '<c:out value="${niceCrtfcKeyMap.sEncData}" />';
    frm.action = "<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbCrtfcResultTest.do";
    frm.target = "crtfcModuleChk";
    frm.submit();
}
var crtfcRetUrl = null;
var crtfcRetPage = {
        sbscrb : function() {
            return '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbForm.do';   
        },
        recrtfc : function() {
            return '<c:out value="${wzwg_contextPath}" />/cmm/mber/recrtfc/updateRecrtfc.do';   
        },
        searchId : function() {
            return '<c:out value="${wzwg_contextPath}" />/cmm/mber/search/searchId.do';
        },
        searchPw : function() {
            return '<c:out value="${wzwg_contextPath}" />/cmm/mber/search/searchPwCrtfcForm.do';
        },
        login : function() {

            fnEstbsPass = function() {
                actionSnsLogin();
            }   
            
            return '';
        }
}

var crtfcMd = null;

function fnCrtfcModuleSetting(retPage) {
    
    crtfcRetUrl = eval('crtfcRetPage.'+retPage+'()');
    
    crtfcMd = {
    <c:forEach var="result" items="${crtfcEstbsList}" varStatus="status">
    <c:out value="${result.usrMngrestbsCode}" /> : function(){
        fnCrtfctSeCodeSetter('<c:out value="${result.usrMngrestbsCode}" />');
//         return eval('fnNiceCrtfc()');
        return eval('<c:out value="${result.usrMngrestbsCodeFunc}" />()');
    }
    <c:if test="${!status.last}">,</c:if>
    </c:forEach>
    };
}

function fnCrtfc(uceCode) { 
    if (uceCode) {
        eval('crtfcMd.'+uceCode+'()');    
    } else {
        alert('<spring:message code="wzwg.cmm.cmmMsg.CMG013"><spring:argument><spring:message code="wzwg.cmm.word.mngr" /></spring:argument><spring:argument><spring:message code="wzwg.cmm.word.quest" /></spring:argument></spring:message>');
    }
    
}

function fnCrtfcRetMessage(msg) {
    return alert(msg);
}

function fnCrtfctSeCodeSetter(crtfctSeCode) {
    $('#crtfctSeCode').val(crtfctSeCode);
}

function fnEstbsPass() {
    var frm = document.stplatFrm;
    
    frm.action = crtfcRetUrl;
    frm.submit();
}

function fnEstbsPassTest() {
    fnEstbsPass();
}

function actionSnsLogin() {
    $.ajax({
        type:'POST'
        , url: '<c:out value="${wzwg_contextPath}" />/actionSnsLogin.do'
        , dataType:'html'
        , data:$("#stplatFrm").serialize()
        , success:function (result) {
            fnLoginCallback(result);
        }
        , error:function (request, status, error) {
            alert('<spring:message code="fail.common.msg" text="error" />');
        }
    });
}

function fnLoginCallback(result) {
    
    var value = "";
    
    $(result).find("value").each(function() {  
        value = $(this).text();  
    });
    
    var frm = document.loginForm;
    
    if(value == 'success'){
        <c:if test="${empty header.referer}">
        frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
        </c:if>
        <c:if test="${not empty header.referer}">
        <c:if test="${fn:indexOf(header.referer, '/loginForm.do')>-1 || fn:indexOf(header.referer, '/cmm/mber/')>-1 ||  fn:indexOf(header.referer, '/searchPwForm.do')>-1 ||  fn:indexOf(header.referer, '/searchIdForm.do')>-1}">
             frm.action = "<c:out value="${wzwg_contextPath}" />/index.do";
            </c:if>
            <c:if test="${fn:indexOf(header.referer, '/loginForm.do')<0 && fn:indexOf(header.referer, '/cmm/mber/')<0 && fn:indexOf(header.referer, '/searchPwForm.do')<0 && fn:indexOf(header.referer, '/searchIdForm.do')<0}">
         frm.action = "<c:out value="${header.referer}" />";
         </c:if> 
        </c:if>
       
        frm.submit();
    } else if (value == 'pwupdt') {
        frm.action = '<c:out value="${wzwg_contextPath}" />/pwUpdtForm.do';
        frm.submit();
    }else if (value == 'snsNaverFail') {
    	 if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG022"><spring:argument><spring:message code="wzwg.cmm.word.naver" /></spring:argument></spring:message>')) {
             frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do';
             frm.submit();
         } 
    }else if (value == 'snsKakaoFail') {
	   	 if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG022"><spring:argument><spring:message code="wzwg.cmm.word.kakao" /></spring:argument></spring:message>')) {
	         frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do';
	         frm.submit();
	     } 
	}else if (value == 'snsGoogleFail') {
	   	 if (confirm('<spring:message code="wzwg.cmm.cmmMsg.CMG022"><spring:argument><spring:message code="wzwg.cmm.word.google" /></spring:argument></spring:message>')) {
	         frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/sbscrb/selectSbscrbUsrTy.do';
	         frm.submit();
	     } 
	} else if (value == 'OUT_RECRTFC') {
        if (confirm('<spring:message code="wzwg.cmm.msg.MSG012" />\n<spring:message code="wzwg.cmm.msg.MSG071" />\n<spring:message code="wzwg.cmm.msg.MSG072" />')) {
            frm.action = '<c:out value="${wzwg_contextPath}" />/cmm/mber/recrtfc/recrtfcForm.do';
            frm.submit();
        }
    } else if (value == 'stplatupdt') {
    	alert(wz_msg('wzwg.cmm.msg.MSG336'));
        frm.action = '<c:out value="${wzwg_contextPath}" />/modifyStplatUpdtForm.do';
        frm.submit();
    }else if (value == 'passFiveFail') {
    	alert(wz_msg('wzwg.cmm.msg.MSG455')); 
    }else {
        if(value == 'fail'){
            alert(wz_msg('wzwg.cmm.msg.MSG043'));
        } else {
            alert(value);
        }
    }
}
</script>
            
<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
<form name="frmCrtfc" method="post">
    <input type="hidden" name="m" value="checkplusSerivce">
    <input type="hidden" name="EncodeData">     <!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
    <input type="hidden" name="crtfcSe">
    <input type="hidden" name="crtfcSns">
    
    <input type="hidden" name="client_id">
    <input type="hidden" name="redirect_uri">
    <input type="hidden" name="response_type">
    <input type="hidden" name="scope">
</form>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
	
	<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
	<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js" charset="utf-8"></script>
</head>

<body>

	<div id="naver_id_login" style="display:none;"></div>

	<script type="text/javascript">
			
		//네이버아이디로그인 시작
		var naver_id_login = new naver_id_login("5wbdNDCvKFJW5YuX37Yd", "http://seki-builder.com:8080/cmm/mber/login/naverCrtfcAjax.do");
	
		var state = naver_id_login.getUniqState();
		naver_id_login.setState(state);
		naver_id_login.init_naver_id_login();	// 로그인 시작(버튼생성)
		naver_id_login.get_naver_userprofile("naverSignInCallback()");	// 네이버아이디로그인 결과를 네이버에서 전달받은 경우
		location.replace(naver_id_login_url); // 네이버아이디로그인 페이지로 바로 이동
		
		// 네이버 사용자정보 가져오기
		function naverSignInCallback(){
			
			var id = naver_id_login.getProfileData('id');
			//var enc_id = naver_id_login.getProfileData('enc_id');
			
			$.ajax({
				  type : 'POST'
				, dataType: 'xml'
				, url : '/cmm/mber/login/selectUsrSnsCnfirm.do'
				, data: "snsCrtfcId="+id+"&snsCrtfcSe=N"
				, success:function (result) {
					
					var value = "";
					
					$(result).find("value").each(function() {  
						value = $(this).text();  
					});
					
					if(value != ""){	// 가입이 되어 있는 경우
						opener.actionLogin();
					}else{				// 가입이 되어있지 않은 경우
						opener.location.replace("/cmm/mber/sbscrb/selectSbscrbMain.do");
					}
				
					self.close();
				}
				, error:function (data) {
					alert('<spring:message code="fail.common.msg" text="error" />');
				}
		 	}); 
			
		}
		
	</script>

</body>
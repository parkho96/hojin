<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp" %>

<script type="text/javascript" src="/js/wzwg/cmm/jquery-latest.min.js"></script>
 
<script>

var FaceBookApp = {
     FBScopes: {scope: 'public_profile'},
     accessToken: '',
     // 초기화 함수
     init: function(d, s, id) {
          window.fbAsyncInit = function() {
               FB.init({
                    appId : '1324245840932831',		// Api Key
                    xfbml : true,
                    version : 'v2.6'
               });
          };
 
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) {return;}
          js = d.createElement(s); js.id = id;
          js.src = "//connect.facebook.net/ko_KR/sdk.js";
          fjs.parentNode.insertBefore(js, fjs);
     },
     statusChangeCallback: function(response) {
          FaceBookApp.accessToken = response.authResponse.accessToken;
 
          // 연결 성공
          if (response.status === 'connected') {
               // 연결 성공시 실행할 코드
               FaceBookApp.FBsigninCallback();
          // 인증 거부
          } else if (response.status === 'not_authorized') {
        	  
          // 그 밖..
          } else {
        	  
          }
     },
     FBsigninCallback: function() {
          FB.api('/me?fields=id', function(response) {
				var id = response.id;
				var token = FaceBookApp.accessToken;
               
				// 실행할 코드
				alert("facebook id : " + id);
          });
     }
};

// 초기화 실행
FaceBookApp.init(document, 'script', 'facebook-jssdk');

</script>

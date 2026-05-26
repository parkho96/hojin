package egovframework.wzwg.cmm.util.snsAPI.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import egovframework.wzwg.cmm.util.snsAPI.service.GoogleAPIService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("GoogleAPIService")
public class GoogleAPIServiceImpl extends EgovAbstractServiceImpl implements GoogleAPIService {
    
    @Resource(name="SnsKeyMngrService")
    protected SnsKeyMngrService snsKeyMngrService;
    
    @Autowired
    private HttpServletRequest req;

    // 세션 키 상수 정의
    private final static String SESSION_CLIENT_ID = "GOOGLE_CLIENT_ID";
    private final static String SESSION_CLIENT_SECRET = "GOOGLE_CLIENT_SECRET";
    private final static String SESSION_REDIRECT_URI = "GOOGLE_REDIRECT_URI";
    private final static String SESSION_STATE = "oauth_state";

    public String getAuthorizationUrl(HttpSession session) {
        String retUrl = "";
        try {
            // 1. DB에서 키 정보 조회
            SnsKeyMngrVO paramVO = new SnsKeyMngrVO();
            paramVO.setSnsTyCode("SC00000436");
        	if(session.getAttribute("SITE_SEQ") != null) {
        		paramVO.setSiteSeq(session.getAttribute("SITE_SEQ").toString());
        	}
            SnsKeyMngrVO snsKeyMngrVO = snsKeyMngrService.selectSnsKeyMngr(paramVO);
            
            if(snsKeyMngrVO != null) {
                // 2. 리다이렉트 URI 생성
                String siteUrl = req.getRequestURL().toString().replaceAll(req.getRequestURI(), "");
                siteUrl = siteUrl + "/cmm/mber/login/googleCrtfcAjax.do";    
                
                // 3. 세션에 정보 저장 (static 대신 사용)
                session.setAttribute(SESSION_CLIENT_ID, snsKeyMngrVO.getClientId());
                session.setAttribute(SESSION_CLIENT_SECRET, snsKeyMngrVO.getClientSecret());
                session.setAttribute(SESSION_REDIRECT_URI, siteUrl);
                
                // CSRF 방지를 위한 state 생성 및 저장
                String state = UUID.randomUUID().toString();
                session.setAttribute(SESSION_STATE, state);

                // 4. 권한 요청 URL 생성
                retUrl = "https://accounts.google.com/o/oauth2/v2/auth?scope=email&access_type=offline&include_granted_scopes=true&"
                        + "state=" + state
                        + "&redirect_uri=" + siteUrl
                        + "&response_type=code"
                        + "&client_id=" + snsKeyMngrVO.getClientId();
            }
        }catch(SQLException e){
    		log.error("SQLException",e);
    	}catch(NullPointerException e){
    		log.error("NullPointerException",e);
    	}catch(NumberFormatException e){
    		log.error("NumberFormatException",e);
    	}catch(IllegalFormatException e){
    		log.error("IllegalFormatException",e);
    	}
        return retUrl;
    }

    public String getUserProfile(HttpServletRequest request) throws IOException, InterruptedException, ExecutionException {
        HttpSession session = request.getSession();
        
        // 세션에서 저장된 정보 가져오기
        String clientId = (String) session.getAttribute(SESSION_CLIENT_ID);
        String clientSecret = (String) session.getAttribute(SESSION_CLIENT_SECRET);
        String redirectUri = (String) session.getAttribute(SESSION_REDIRECT_URI);
        String storedState = (String) session.getAttribute(SESSION_STATE);
        
        // State 검증 (보안 강화)
        String paramState = request.getParameter("state");
        if (storedState == null || !storedState.equals(paramState)) {
            log.error("State 값이 일치하지 않습니다.");
            return null;
        }

        String code = request.getParameter("code");
        RestTemplate restTemplate = new RestTemplate(); 
        
        // 3. Access Token 요청
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        
        MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
        parameters.add("code", code);
        parameters.add("client_id", clientId);
        parameters.add("client_secret", clientSecret);
        parameters.add("redirect_uri", redirectUri);
        parameters.add("grant_type", "authorization_code");
        
        HttpEntity<MultiValueMap<String, String>> restRequest = new HttpEntity<>(parameters, headers);
        
        try {
            ResponseEntity<Map> response = restTemplate.postForEntity("https://oauth2.googleapis.com/token", restRequest, Map.class);
            Map<String, Object> responseBody = response.getBody();
            String idToken = (String) responseBody.get("id_token");
            
            // 4. Token 정보를 이용해 사용자 프로필 조회 (OkHttp 대신 RestTemplate 활용)
            String tokenInfoUrl = "https://oauth2.googleapis.com/tokeninfo?id_token=" + idToken;
            return restTemplate.getForObject(tokenInfoUrl, String.class);
            
        }catch (HttpClientErrorException | HttpServerErrorException e) {
            log.error("Google API 호출 중 HTTP 에러 발생: 상태코드={}, 응답={}", e);
        } catch (Exception e) {
            log.error("토큰 요청 및 프로필 조회 중 에러", e);
        }
        return null;
    }
}
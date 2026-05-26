package egovframework.wzwg.cmm.util.snsAPI.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.scribejava.apis.NaverApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import egovframework.wzwg.cmm.util.snsAPI.service.NaverAPIService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("NaverAPIService")
public class NaverAPIServiceImpl extends EgovAbstractServiceImpl implements NaverAPIService {
    
    @Resource(name="SnsKeyMngrService")
    protected SnsKeyMngrService snsKeyMngrService;
 
    @Autowired
    private HttpServletRequest req;

    private final static String PROFILE_API_URL = "https://openapi.naver.com/v1/nid/me";
    private static final String SESSION_STATE = "oauth_state";
    
    // 세션에 저장할 키 값 정의
    private static final String NAVER_CLIENT_ID = "NAVER_CLIENT_ID";
    private static final String NAVER_CLIENT_SECRET = "NAVER_CLIENT_SECRET";
    private static final String NAVER_REDIRECT_URI = "NAVER_REDIRECT_URI";

    /**
     * 인증 URL 생성 및 관련 정보를 세션에 저장
     */
    public String getAuthorizationUrl(HttpSession session) {
        String retUrl = "";
        String state = UUID.randomUUID().toString();
        session.setAttribute(SESSION_STATE, state);

        try {
            SnsKeyMngrVO paramVO = new SnsKeyMngrVO();
            paramVO.setSnsTyCode("SC00000433");
        	if(session.getAttribute("SITE_SEQ") != null) {
        		paramVO.setSiteSeq(session.getAttribute("SITE_SEQ").toString());
        	}
            SnsKeyMngrVO snsKeyMngrVO = snsKeyMngrService.selectSnsKeyMngr(paramVO);
            
            if(snsKeyMngrVO != null) {
                // 1. Redirect URI 결정
                String siteUrl = req.getRequestURL().toString().replaceAll(req.getRequestURI(), "");
                String redirectUri = "";
                if(req.getRequestURI().startsWith("/loginForm.do") || req.getRequestURI().startsWith("/searchIdForm.do")){
                    redirectUri = siteUrl + "/cmm/mber/login/naverCrtfcAjax.do";    
                } else {
                    redirectUri = siteUrl + "/cmm/mber/sbscrb/snsNaver.do";
                }

                // 2. 중요 정보를 세션에 저장 (static 변수 대체)
                session.setAttribute(NAVER_CLIENT_ID, snsKeyMngrVO.getClientId());
                session.setAttribute(NAVER_CLIENT_SECRET, snsKeyMngrVO.getClientSecret());
                session.setAttribute(NAVER_REDIRECT_URI, redirectUri);

                // 3. OAuth 서비스 빌드
                OAuth20Service oauthService = new ServiceBuilder(snsKeyMngrVO.getClientId())
                        .apiSecret(snsKeyMngrVO.getClientSecret())
                        .callback(redirectUri)
                        .build(NaverApi.instance());

                retUrl = oauthService.getAuthorizationUrl(state);
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

    /**
     * 세션에 저장된 정보를 사용하여 Access Token 획득
     */
    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException {
        String sessionState = (String) session.getAttribute(SESSION_STATE);
        
        if(StringUtils.equals(sessionState, state)) {
            // 세션에서 정보 추출
            String clientId = (String) session.getAttribute(NAVER_CLIENT_ID);
            String clientSecret = (String) session.getAttribute(NAVER_CLIENT_SECRET);
            String redirectUri = (String) session.getAttribute(NAVER_REDIRECT_URI);

            OAuth20Service oauthService = new ServiceBuilder(clientId)
                    .apiSecret(clientSecret)
                    .callback(redirectUri)
                    .build(NaverApi.instance());
            
            oauthService.getAuthorizationUrl(state);
            
            return oauthService.getAccessToken(code);
        }
        return null;
    }

    /**
     * 세션에 저장된 정보를 사용하여 프로필 정보 획득
     */
    public String getUserProfile(HttpSession session, OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException {
        String clientId = (String) session.getAttribute(NAVER_CLIENT_ID);
        String clientSecret = (String) session.getAttribute(NAVER_CLIENT_SECRET);

        OAuth20Service oauthService = new ServiceBuilder(clientId)
                .apiSecret(clientSecret)
                .build(NaverApi.instance());
        
        OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL);
        oauthService.signRequest(oauthToken, request);
        Response response = oauthService.execute(request);
        return response.getBody();
    }
}

package egovframework.wzwg.cmm.util.snsAPI.service.impl;

import java.io.IOException;
import java.util.UUID;
import java.util.concurrent.ExecutionException;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import com.github.scribejava.apis.FacebookApi;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

import egovframework.wzwg.cmm.util.snsAPI.service.FacebookAPIService;


@Service("FacebookAPIService")
public class FacebookAPIServiceImpl extends EgovAbstractServiceImpl implements FacebookAPIService {
    
    private final static String CLIENT_ID = "548916528840059";
    private final static String CLIENT_SECRET = "0730951761640dcd8c818ab3e70a0d65";
    private final static String REDIRECT_URI = "https://sr.wiz-builder.com/sns/crtfc/SC00000437";
    private final static String SESSION_STATE = "oauth_state";

    private final static String PROFILE_API_URL = "https://graph.facebook.com/v2.5/me";
    
    public String getAuthorizationUrl(HttpSession session) {

        OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
                .apiSecret(CLIENT_SECRET)
                .defaultScope("public_profile,email")
                .callback(REDIRECT_URI)
                .build(FacebookApi.instance());

        return oauthService.getAuthorizationUrl();
    }

    public OAuth2AccessToken getAccessToken(String code) throws IOException, InterruptedException, ExecutionException {

        OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
              .apiSecret(CLIENT_SECRET)
              .callback(REDIRECT_URI)
              .build(FacebookApi.instance());
        
        OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
        return accessToken;
    }
    
    private String generateRandomString() {
        return UUID.randomUUID().toString();
    }
    
    private void setSession(HttpSession session,String state) {
        session.setAttribute(SESSION_STATE, state);     
    }

    private String getSession(HttpSession session) {
        return (String) session.getAttribute(SESSION_STATE);
    }
    
    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException {

        OAuth20Service oauthService = new ServiceBuilder(CLIENT_ID)
              .apiSecret(CLIENT_SECRET)
              .build(FacebookApi.instance());


        OAuthRequest authRequest = new OAuthRequest(Verb.GET, PROFILE_API_URL);
        oauthService.signRequest(oauthToken, authRequest);
        Response response = oauthService.execute(authRequest);
        return response.getBody();
    }

}

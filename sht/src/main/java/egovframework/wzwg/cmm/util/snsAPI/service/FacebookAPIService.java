package egovframework.wzwg.cmm.util.snsAPI.service;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import jakarta.servlet.http.HttpSession;

import com.github.scribejava.core.model.OAuth2AccessToken;


public interface FacebookAPIService {
    
    public String getAuthorizationUrl(HttpSession session);

    public OAuth2AccessToken getAccessToken(String code) throws IOException, InterruptedException, ExecutionException;
    
    public String getUserProfile(OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException;
}

package egovframework.wzwg.cmm.util.snsAPI.service;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import jakarta.servlet.http.HttpSession;

import com.github.scribejava.core.model.OAuth2AccessToken;


public interface NaverAPIService {
    
    public String getAuthorizationUrl(HttpSession session);
    
    public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException, InterruptedException, ExecutionException;
    
    public String getUserProfile(HttpSession session, OAuth2AccessToken oauthToken) throws IOException, InterruptedException, ExecutionException;
}

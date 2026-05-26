package egovframework.wzwg.cmm.util.snsAPI.service;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


public interface GoogleAPIService {
    
    public String getAuthorizationUrl(HttpSession session);

    // public OAuth2AccessToken getAccessToken(String code) throws IOException, InterruptedException, ExecutionException;
    
    public String getUserProfile(HttpServletRequest request) throws IOException, InterruptedException, ExecutionException;
}

package egovframework.wzwg.cmm.conectCtrl.service;

import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;

public interface ConectCtrlService {
    
    public RequestAcqsDataVO baseSiteInfoCheck(HttpServletRequest request, String siteUrl, String siteKey) throws Exception;
    public Map<String, ConectCtrlVO> selectSiteUrlBySiteSeq(String siteUrl) throws Exception;
    public Map<String, String> selectSiteSeqBySysSiteSeq(String siteUrl) throws Exception;
	
}

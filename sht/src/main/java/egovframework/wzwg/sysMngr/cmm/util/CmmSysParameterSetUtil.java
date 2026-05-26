package egovframework.wzwg.sysMngr.cmm.util;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.util.CmmSessionUtil;

public class CmmSysParameterSetUtil {

	public CmmSysParameterSetUtil() {
		super();
	}

    @Resource(name="egovMessageSource")
    static EgovMessageSource egovMessageSource;
    
    // 시스템관리자URL 패턴
    private static String SYSMNGR_URL_PREFIX = "/sysMngr";
    
    // URL 패턴으로 시스템관리자인지 관리자인지 판단
    public static boolean getUrlBySysMngr(HttpServletRequest request) {
        
    	String reqUrl = request.getRequestURI();
    	
    	String subUrl = reqUrl.substring(reqUrl.indexOf("/"), reqUrl.length());
    	
    	boolean retChk = false;
    	
    	if (subUrl.indexOf(SYSMNGR_URL_PREFIX) == 0) {
    		return true;
    	}
    	
    	return retChk;
    }

    
    public static String getUrlWzwgContext(HttpServletRequest request) {
        String wzwgContext = "";
        
        if(!CmmSessionUtil.getSessionValue(request, "siteKey").equals("")) {
        	wzwgContext = "/"+CmmSessionUtil.getSessionValue(request, "siteKey");
        }
    	return wzwgContext;
    }
//    // 시스템관리자 사이트SEQ 리턴
//    public static String getUrlParameterBySiteSeq(HttpServletRequest request) {
//    	
//    	String paramRequest
//    }

}

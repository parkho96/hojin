package egovframework.wzwg.cmm.util;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;

public class CmmSessionUtil {

	public CmmSessionUtil() {
		super();
	}

    @Resource(name="egovMessageSource")
    static EgovMessageSource egovMessageSource;
    
    // 사이트ID
    private static String SITE_SEQ = "SITE_SEQ";
    
    private static String DOMN_SEQ = "DOMN_SEQ";
    
    // 사이트명
    private static String SITE_NM = "SITE_NM";
    
    // 사용자ID
    private static String USER_ID = "USER_ID";
    
    // 메뉴ID
    private static String MENU_NO = "menuNo";
    
    // 시스템사용자구분
    private static String SYSMNGR_AT = "SYSMNGR_AT";

    // 세션에서 접속자 사이트ID를 가져옴
    public static String getSessionSiteSeq(HttpServletRequest request) {
        
        return getSessionValue(request, SITE_SEQ);
    }
    
    // 세션에서 접속자 도메인 SEQ를 가져옴
    public static String getSessionDomnSeq(HttpServletRequest request) {
        
        return getSessionValue(request, DOMN_SEQ);
    }


    // 세션에 사이트ID 등록
    public static void setSessionSiteSeq(HttpServletRequest request, String value) {
        
        setSessionValue(request, SITE_SEQ, value);
    }

    // 세션에서 접속자 사이트명을 가져옴
    public static String getSessionSiteNm(HttpServletRequest request) {
        
        return getSessionValue(request, SITE_NM);
    }
    
    // 세션에 사이트명 등록
    public static void setSessionSiteNm(HttpServletRequest request, String value) {
        
        setSessionValue(request, SITE_NM, value);
    }
    
    
    // 세션에 도메인 Seq 등록
    public static void setSessionDomnSeq(HttpServletRequest request, String value) {
        
        setSessionValue(request, DOMN_SEQ, value);
    }
    
    
    // 세션에서 로그인 정보를 가져옴
    public static CmmLoginVO getLoginVO() {

        return (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
    }

    // 세션에서 접속자 ID를 가져옴
    public static String getSessionUserId() {
        
        CmmLoginVO loginVO = getLoginVO();
        
        if (loginVO != null) {
            return loginVO.getUserId();
        }
        
        return null;
    }

    // 세션에서 접속자 ID를 가져옴
    public static String getSessionUserNm() {
        
        CmmLoginVO loginVO = getLoginVO();
        
        if (loginVO != null) {
            return loginVO.getUserNm();
        }
        
        return null;
    }

    // 세션에서 요청한 메뉴ID를 가져옴
    public static String getSessionMenuNo(HttpServletRequest request) {
        
        return getSessionValue(request, MENU_NO);
    }

    // 요청한 메뉴ID를 가져옴
//    public static String getRequestMenuNo(HttpServletRequest request) {
//        
//        return StringUtils.defaultString((String)request.getParameter(MENU_NO));
//    }
    
    public static String getSessionValue(HttpServletRequest request, String name) {
        HttpSession session = request.getSession();
        
        return StringUtils.defaultString((String)session.getAttribute(name));
    }
    
    public static boolean getSessionBooleanValue(HttpServletRequest request, String name) {
        HttpSession session = request.getSession();
        
        boolean retVal = false;
        
        if (session.getAttribute(name) != null) {
            retVal = (boolean)session.getAttribute(name);
        }
        
        return retVal;
    }
    
    public static void setSessionValue(HttpServletRequest request, String name, String value) {
        HttpSession session = request.getSession();
        
        session.removeAttribute(name);
        session.setAttribute(name, value);
    }
	
	public static String getSessionValue(HttpServletRequest request, String name, String defaultValue) {
		HttpSession session = request.getSession();
		
		return StringUtils.defaultString((String)session.getAttribute(name), defaultValue);
	}
	
	// 관리자 prefix 반환
	public static String getSessionMngrSitePrefix(HttpServletRequest request) {
		String value="";
		if(!getSessionSysMngrAt(request)){
			if(request.getRequestURI().indexOf("/mngr") > -1){
				value = Globals.MNGR_PREFIX;
			} 
		}else{
			value = Globals.SYSMNGR_PREFIX;
		}
		
		return value;
	}
	
	// 시스템사용자 구분을 반환한다
	public static boolean getSessionSysMngrAt(HttpServletRequest request) {
		
		String sysmngrAt = StringUtils.defaultString(getSessionValue(request, SYSMNGR_AT));
		
		if ("Y".equals(sysmngrAt)) {
			return true;
		} else {
			return false;
		}
	}
    
    public static void setSessionValue(HttpServletRequest request, String name, boolean value) {
        HttpSession session = request.getSession();
        
        session.removeAttribute(name);
        session.setAttribute(name, value);
    }

}

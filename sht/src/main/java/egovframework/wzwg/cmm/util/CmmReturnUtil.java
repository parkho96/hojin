package egovframework.wzwg.cmm.util;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.conectCtrl.service.RequestAcqsDataVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;


public class CmmReturnUtil {

	public CmmReturnUtil() {
		super();
	}
    
    // 페이지 리턴
    public static boolean getSendRedirect(HttpServletResponse response, String retUrl) throws Exception {
        response.sendRedirect(retUrl);
        
        return false;
    }
    
    // 페이지 리턴
    public static boolean getSendForward(HttpServletRequest request, HttpServletResponse response, String retUrl) throws Exception {
        
        RequestDispatcher rd = request.getRequestDispatcher(retUrl);
        rd.forward(request, response);
        return false;
    }
    
    // 페이지 리턴
    public static boolean getSendRedirect(HttpServletRequest request, HttpServletResponse response, RequestAcqsDataVO radVO) throws Exception {
        response.sendRedirect(radVO.getRetUrl());
        
        return false;
    }
    
    // 페이지 리턴
    public static boolean getSendRedirect(HttpServletRequest request, HttpServletResponse response, String retUrl, String errCd) throws Exception {
        request.setAttribute("ERROR_INFO.errCd", errCd);
        request.setAttribute("ERROR_INFO.retUrl", retUrl);
        
        
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/wzwg/cmm/errorForward.jsp");
        rd.forward(request, response);
        return false;
    }
    
    /// 호출 URL에 따라 메인페이지를 리턴한다
    public static String returnMainPage(HttpServletRequest request) {
    	
        // 요청URL
        String reqUrl = StringUtils.defaultString(request.getRequestURI());
        String mainPage = "";
        String wzwgContext =CmmSysParameterSetUtil.getUrlWzwgContext(request);
        if(!CmmSessionUtil.getSessionSysMngrAt(request)){
                // 요청URL에 따라 리턴 페이지가 결정됨
          mainPage = (reqUrl.indexOf("/actionMngr") > -1)? wzwgContext+Globals.URL_PREFIX+Globals.MNGR_PREFIX+Globals.MNGR_MAIN_PAGE:Globals.MAIN_PAGE;
        }else{
          mainPage = (reqUrl.indexOf("/actionMngr") > -1)? wzwgContext+Globals.URL_PREFIX+Globals.SYSMNGR_PREFIX+Globals.MNGR_MAIN_PAGE:Globals.MAIN_PAGE;
        }
        
        if (mainPage.startsWith("/")) {
            return "redirect:" + mainPage;
        } else {
            return "redirect:"+mainPage;
        }
    }

}

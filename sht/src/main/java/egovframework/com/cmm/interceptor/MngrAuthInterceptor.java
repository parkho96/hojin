package egovframework.com.cmm.interceptor;

import java.util.Enumeration;

import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */

@Component("mngrAuthInterceptor")
public class MngrAuthInterceptor implements HandlerInterceptor {

	private static final Log LOG = LogFactory.getLog(MngrAuthInterceptor.class.getName());
	
	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Resource(name="MngrAuthService")
	private MngrAuthService mngrAuthService;     
	
	@Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		 
		
		Enumeration<String> params = request.getParameterNames();
		String strParam = request.getQueryString();
//		while(params.hasMoreElements()) {
//		    String name = (String)params.nextElement();
//		    String value = request.getParameter(name);
//		    strParam += name + "=" + value + "&";
//		}
//		
		HttpSession session = request.getSession();
		
 
		boolean isReturn = true;
        try {
            // 요청URL
            String reqUrl = request.getRequestURI();
            
            CmmSessionUtil.getSessionSysMngrAt(request);
            
            if (CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT") 
                    || CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")) {
                
                if (CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")) {
                    return true;
                }
                
                if (reqUrl.indexOf("/WEB-INF/jsp/") < 0) {
                	SiteMngrMenuVO paramVO = new SiteMngrMenuVO();
                	if(strParam !=null && !strParam.equals("")) {
                		reqUrl = reqUrl+"?"+strParam;
                	}
                	                			 
        			if(reqUrl.startsWith(wzwgContext)) {
        				reqUrl =  reqUrl.replaceFirst(wzwgContext, "");
        			}
                	paramVO.setMenuLinkUrl(reqUrl);
                	
                	SiteMngrMenuVO resultVO = new SiteMngrMenuVO();
                	resultVO = siteMngrMenuService.selectSiteMngrMenuUrlByAuthSeq(paramVO);
                	if(resultVO !=null && resultVO.getMngrMenuSeq() != null) {

                		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
                		resultVO.setUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
                		SiteMngrMenuVO result = new SiteMngrMenuVO();
                		result = siteMngrMenuService.selectSiteMngrUsrSeqByAuthSeq(resultVO);
                		if(result == null || result.getMngrMenuSeq() ==null) {
                			handleAuthError(request, response, wzwgContext);
                            return false;
                		}else {
                			if(session.getAttribute("mngrMenuSeq") != null) {
                				session.removeAttribute("mngrMenuSeq");
                			}
                			session.setAttribute("mngrMenuSeq", result.getMngrMenuSeq());
                		}
                	}else {
                		SiteMngrMenuVO resultMenuVO = new SiteMngrMenuVO();
                		resultMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
                		resultMenuVO.setUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
                		if(session.getAttribute("mngrMenuSeq") != null) {
                			resultMenuVO.setMngrMenuSeq((String)session.getAttribute("mngrMenuSeq"));
                			SiteMngrMenuVO result = new SiteMngrMenuVO();
                    		result = siteMngrMenuService.selectSiteMngrUsrSeqByAuthSeq(resultMenuVO);
                    		if(result == null || result.getMngrMenuSeq() ==null) {
                    			handleAuthError(request, response, wzwgContext);
                                return false;
                    		}else {
                    			if(session.getAttribute("mngrMenuSeq") != null) {
                    				session.removeAttribute("mngrMenuSeq");
                    			}
                    			session.setAttribute("mngrMenuSeq", result.getMngrMenuSeq());
                    		}
                		}else {
                			handleAuthError(request, response, wzwgContext);
                            return false;
                		}
                	}
                }
            } else {
            	handleAuthError(request, response, wzwgContext);
                isReturn = false;
            }
        } catch (NullPointerException e) {
        	handleAuthError(request, response, wzwgContext);
            isReturn = false;
        }  catch (NumberFormatException e) {
        	handleAuthError(request, response, wzwgContext);
            isReturn = false;
        }
        
        
        return isReturn;
	}
	
	// 에러 처리 전용 메서드
	private void handleAuthError(HttpServletRequest request, HttpServletResponse response, String wzwgContext) throws Exception {
	    if (request == null || response == null) return;
	    
	    request.setAttribute("message", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
	    String path = (wzwgContext != null ? wzwgContext : "") + "/mngr/selectDashboardMain.do";
	    
	    RequestDispatcher rd = request.getRequestDispatcher(path);
	    if (rd != null) {
	        rd.forward(request, response);
	    }
	}
}

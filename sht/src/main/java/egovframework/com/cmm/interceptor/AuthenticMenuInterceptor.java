package egovframework.com.cmm.interceptor;

import java.util.Iterator;
import java.util.Set;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.interceptor.service.AuthenticService;
import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlService;
import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlVO;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
//import egovframework.wzwg.site.mngr.subsite.service.SubSiteInfoService;
//import egovframework.wzwg.subsite.menu.service.SubSiteMenuAuthorService;
//import egovframework.wzwg.subsite.menu.service.SubSiteMenuVO;

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

@Component("authMenuInterceptor")
public class AuthenticMenuInterceptor implements HandlerInterceptor {

	private static final Log LOG = LogFactory.getLog(AuthenticMenuInterceptor.class.getName());
	
	private Set<String> pasageURL;
	
	public void setPasageURL(Set<String> pasageURL) {
		this.pasageURL = pasageURL;
	}
	
	// 로그인 URL
	private Set<String> defaultLoginUrl;
	
	public void setDefaultLoginUrl(Set<String> defaultLoginUrl) {
		this.defaultLoginUrl = defaultLoginUrl;
	}

	// 메인 페이지 URL
	private Set<String> defaultIndexUrl;

	public void setDefaultIndexUrl(Set<String> defaultIndexUrl) {
		this.defaultIndexUrl = defaultIndexUrl;
	}

    @Resource(name = "AuthenticService")
    private AuthenticService authenticService;
    
    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	
    
    @Resource(name="AuthCtrlService")
    private AuthCtrlService authCtrlService;
//    @Resource(name="SubSiteMenuAuthorService")
//    protected SubSiteMenuAuthorService subSiteMenuAuthorService;
//    
//    @Resource(name="SubSiteInfoService")
//    protected SubSiteInfoService subSiteInfoService;
    
 
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {

		HttpSession session = request.getSession();
		String requestUrl = request.getRequestURI();
		int sysMngrCnt = (CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")||CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT"))? 1:0;
		
		if (getPasageUrlCheck(requestUrl) || requestUrl.endsWith(".jsp") || requestUrl.endsWith(".JSP")) { 
										
		} else {
			Object menuSeq = session.getAttribute("menuSeq");
			
			if(menuSeq != null) {
				
				AuthCtrlVO paramVO = new AuthCtrlVO();
		        
				paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
				paramVO.setMenuSeq(menuSeq.toString());
        
		        // 리턴 정보를 가지고 있을거임
		        ModelAndView retModel = new ModelAndView();
		        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
		        retModel.addObject("retUrl", "/index.do");
		        
		        // 사이트컨텐츠SEQ
		        String sitecntntsSeq = authCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO); 
        
				CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
				// 게시판 권한
				CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
				cntntsAuthVO.setSitecntntsSeq(sitecntntsSeq);
				cntntsAuthVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

				if(loginVO != null){
					cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
				} else {
					cntntsAuthVO.setUsrSeq("0");
				}		

				CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);
				
				
				if(nttAuthVO != null && session.getAttribute("subMenuSeq") == null) {
					modelAndView.addObject("nttAuthVO", 		nttAuthVO);
				}
												
			}			    	 

		} 
//		String requestURI = request.getRequestURI();
//		String siteId = CmmSessionUtil.getSessionSiteId(request);
//		if(requestURI.indexOf("/cmngr")< 0 && requestURI.indexOf("/selectImageView.do")<0 && requestURI.indexOf("/selectThumbImageView.do")<0  && requestURI.indexOf("Excel.do")<0){
//		
//		LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//		if(loginVO !=null){
//		HttpSession session = request.getSession();
//		String menuNo = CmmMenuNoUtil.getUrlByMenuNo(request);
//		if(menuNo.equals("")){
//		menuNo = StringUtils.nvl((String)session.getAttribute("menuNo"),"");
//		}
//		
//		String cmntUsrSe = (String)session.getAttribute("cmntUsrSe");
//		 
//		String cmntSiteId = CmmCmntUtil.getUrlByCmntId(request);
//		String cmntMenuId = CmmCmntUtil.getUrlByCmntMenuId(request);
//		
//		if(cmntSiteId.equals("")){
//			cmntSiteId = (String)session.getAttribute("cmntSiteId");
//		}
//		if(cmntMenuId.equals("")){
//			cmntMenuId = (String)session.getAttribute("cmntMenuId");
//		}
//		if(requestURI.indexOf("/cmnt")>-1){
//			if(requestURI.indexOf("/index.do") < 0){
//				if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")|| cmntUsrSe.equals("CUSR001")) {
//					modelAndView.addObject("authorMngrCd", "Y");
//				}else{
//					modelAndView.addObject("authorMngrCd", "N");
//				}
//			}
//		}
//		
//		if(!StringUtils.nvl(cmntMenuId,"").equals("")){
//			 
//
//			EgovMap paramMap = new EgovMap();
//			
//			paramMap.put("cmntSiteId", cmntSiteId);
//			paramMap.put("cmntMenuId", cmntMenuId);	
//			paramMap.put("usrTySe", cmntUsrSe);
//			paramMap.put("authorSe", "W");
//			 
//			
//			int menuAuthChk = authenticService.selectMenuCmntAuthenticChk(paramMap);
//			
//			if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")|| cmntUsrSe.equals("CUSR001")) {
//				modelAndView.addObject("authorMngrCd", "Y");
//			}else{
//				modelAndView.addObject("authorMngrCd", "N");
//			}
//			if(menuAuthChk > 0){
//				modelAndView.addObject("authorCd", "Y");
//			} else { 
//				modelAndView.addObject("authorCd", "N");
//			}
//		}
//		
//		if (!"".equals(menuNo)) {
//	
//			EgovMap paramMap = new EgovMap();
//			
//			paramMap.put("userSeq", loginVO.getUserSeq());
//			paramMap.put("menuNo", menuNo);	
//			paramMap.put("userTyId", loginVO.getUserTyId());
//			paramMap.put("authorCd", "W");
//			paramMap.put("siteId", siteId);
//			
//			
//			int menuCntnAuthChk = authenticService.selectMenuCntntAuthenticChk(paramMap);
//			if(loginVO !=null){
//				if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")) {
//					modelAndView.addObject("authorMngrCd", "Y");
//				}else{
//					if(menuCntnAuthChk >0){
//						modelAndView.addObject("authorMngrCd", "Y");
//					}else{
//						modelAndView.addObject("authorMngrCd", "N");
//					}
//				}
//			}else{
//					    modelAndView.addObject("authorMngrCd", "N");
//			}
//				
//				int menuAuthChk = authenticService.selectMenuAuthenticChk(paramMap);
//				if(menuAuthChk > 0){
					//modelAndView.addObject("authorCd", "Y");
//				}else{
//					modelAndView.addObject("authorCd", "N");
//				}
//				 
//			}
//		}
//		} 
	}
	/**
	private boolean urlPatternCheck(HttpServletRequest request) {
		
		String requestURI = request.getRequestURI(); //요청 URI

		boolean isPermittedURL = false; 
		
		for(Iterator<String> it = this.permittedURL.iterator(); it.hasNext();){
			String urlPattern = request.getContextPath() + (String) it.next();

			LOG.debug(requestURI + ", " + Pattern.matches(urlPattern, requestURI));
			if(Pattern.matches(urlPattern, requestURI)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
				isPermittedURL = true;
			}
		}
		
		return isPermittedURL;
	}
	
	**/
	private boolean getPasageUrlCheck(String callUrl) {

        AntPathMatcher m = new AntPathMatcher();
        
        for(Iterator<String> it = this.pasageURL.iterator(); it.hasNext();){
            String configUrl = (String)it.next();
            
            LOG.debug("* configUrl : " + configUrl + ", callUrl : " + callUrl);
            
            if (m.match(configUrl, callUrl)) {
                return true;
            }
        }
        
        return false;
    }

}

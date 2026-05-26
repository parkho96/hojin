package egovframework.com.cmm.interceptor;

import java.util.Iterator;
import java.util.Set;
import java.util.regex.Pattern;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.interceptor.service.AuthenticService;
import egovframework.wzwg.cmm.util.CmmSessionUtil;

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

@Component("authCmntInterceptor")
public class AuthenticCmntInterceptor implements HandlerInterceptor {

	private static final Log LOG = LogFactory.getLog(AuthenticCmntInterceptor.class.getName());
	
	private Set<String> permittedURL;
	
	public void setPermittedURL(Set<String> permittedURL) {
		this.permittedURL = permittedURL;
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
    
	/**
	 * 세션에 계정정보(LoginVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(LoginVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
//	public boolean preHandle(HttpServletRequest request,
//			HttpServletResponse response, Object handler) throws Exception {
//			  
//		       
//			LOG.debug(111222);
//			// 접근 권한이 없는 페이지 확인
//		//	if (urlPatternCheck(request)) {
//		//		return true;
//		//	}
//			LOG.debug("접근권한 패스");
//			LoginVO loginVO = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//			String siteId = CmmSessionUtil.getSessionSiteId(request);
//			HttpSession session = request.getSession();
//			String menuNo = CmmMenuNoUtil.getUrlByMenuNo(request);
//			if(menuNo.equals("")){
//			menuNo = StringUtils.nvl((String)session.getAttribute("menuNo"),"");
//			}
//			String requestURI = request.getRequestURI();
//			if( requestURI.startsWith("/index.do")
//			|| requestURI.startsWith("/message")  
//			|| requestURI.startsWith("/dggb/module/image/")
//			|| requestURI.indexOf("actionLogin.do")>-1
//			|| requestURI.startsWith("/errorForward.do")
//			|| requestURI.startsWith("/indexModule.do")
//			|| requestURI.startsWith("/uat/uia/egovLoginUsr.do") 			
//			|| requestURI.indexOf("/login/LoingForm.do")>-1
//			|| requestURI.indexOf("/login/loginForm.do")>-1
//			|| requestURI.indexOf("/login/mberLoginForm.do")>-1
//			|| requestURI.indexOf("logout.do")>-1
//			|| requestURI.indexOf("login.do")>-1
//			|| requestURI.startsWith("/dggb/cmm/mber/mberSbscrb/")
//			|| requestURI.startsWith("/dggb/cmm/mber/mberInfo/")
//			|| requestURI.indexOf("Popup")>-1
//			|| requestURI.startsWith("/dggb/module/onlineQustnr/registQustnrResponseIem")
//			|| requestURI.startsWith("/dggb/mngr/cmm/actionLogin.do")
//			|| requestURI.indexOf("actionSSOLogin.do") >-1
//			|| requestURI.indexOf("actionSSOFailLogin.do") >-1
//			|| requestURI.indexOf("/selectImageView.do")>-1
//			|| requestURI.indexOf("/actionLogout.do")>-1
//			|| requestURI.indexOf("/selectThumbImageView.do")>-1
//			|| requestURI.indexOf("Excel.do")>-1
//			|| requestURI.indexOf("/policy/")>-1
//			|| requestURI.indexOf("/downFile.do")>-1
//			|| requestURI.indexOf("/cnvrFileDown.do")>-1
//			|| requestURI.indexOf("/FileDown.do")>-1
//			|| requestURI.indexOf("/workIndex.do")>-1
//			|| requestURI.indexOf("/workIndexPreview.do")>-1
//			|| requestURI.indexOf("/selectAppImageView.do")>-1
//			|| requestURI.indexOf("/selectOrignlImageView.do") >-1
//			|| requestURI.indexOf("/siteMap.do")>-1
//			|| requestURI.indexOf("/unitySearch/")>-1
//			|| requestURI.indexOf("/actionMain.do")>-1
//			|| requestURI.indexOf("selectSchulCntntsMapViewAjax.do") >-1
//			){
//				return true;
//			}
//			
//			
//			
//			EgovMap paramMap2 = new EgovMap();
//			 if(loginVO ==null){
//			paramMap2.put("menuNo", menuNo);	
//			paramMap2.put("userTyId", "7");
//			paramMap2.put("authorCd", "R");
//			int menuAuthChk2 = authenticService.selectMenuAuthenticChk(paramMap2);
//				if(menuAuthChk2 > 0){
//					return true;
//				}
//			 }
//			String cmntUsrSe = (String)session.getAttribute("cmntUsrSe");
//			if(requestURI.startsWith("/cmnt")){
//				if(requestURI.indexOf("/index.do")>-1){
//					return true;
//				}
//				
//				
//			}
//			String cmntSiteId = CmmCmntUtil.getUrlByCmntId(request);
//			String cmntMenuId = CmmCmntUtil.getUrlByCmntMenuId(request);
//			
//			if(cmntSiteId.equals("")){
//				cmntSiteId = (String)session.getAttribute("cmntSiteId");
//			}
//			if(cmntMenuId.equals("")){
//				cmntMenuId = (String)session.getAttribute("cmntMenuId");
//			}
//			
//			if(requestURI.indexOf("/cmngr")> -1){
//				if(loginVO !=null){
//					if(requestURI.startsWith("/dggb/unityMngr")){
//						if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002") ) {
//							return true;
//						}
//					}
//				}
//				if(cmntUsrSe !=null && cmntUsrSe.equals("CUSR001")){
//					return true;
//				}else{
//					if(cmntSiteId !=null && !cmntSiteId.equals("")){
//					response.sendRedirect("/message/authCmntReadError.do");
//					}else{
//						response.sendRedirect("/message/authReadError.do");	
//					}
//					return false;
//				}
//			}
//			
//			if(loginVO !=null){
//				if(requestURI.startsWith("/dggb/unityMngr")){
//					if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001")) {
//						return true;
//					}else{
//						response.sendRedirect("/message/noSessionMngrError.do");
//						return false;
//					}
//				}
//				if (!StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") && !StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002") ) {
//				 
//					if(loginVO.getConfmCode().equals("UCC003")){
//						response.sendRedirect("/message/noAuthError.do?type=1");
//						return false;
//					}
//					
//					if(loginVO.getConfmCode().equals("UCC001")){
//						response.sendRedirect("/message/noAuthError.do?type=2");
//						return false;
//					}
//				}
//			}
//			
//			if(!StringUtils.nvl(cmntMenuId,"").equals("")){
//				if(loginVO !=null){
//					if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")) {
//						return true;
//					}
//				}
//
//				EgovMap paramMap = new EgovMap();
//				
//				paramMap.put("cmntSiteId", cmntSiteId);
//				paramMap.put("cmntMenuId", cmntMenuId);	
//				paramMap.put("usrTySe", cmntUsrSe);
//				
//				if(requestURI.indexOf("/regist")>-1|| requestURI.indexOf("/modify")>-1){
//					paramMap.put("authorSe", "W");
//				}else if(requestURI.indexOf("/select") >-1 ||requestURI.indexOf("/sub.do") >-1){
//					paramMap.put("authorSe", "R");
//				}else{
//					return true;
//				}
//				
//				int menuAuthChk = authenticService.selectMenuCmntAuthenticChk(paramMap);
//				int menuCntnAuthChk = authenticService.selectMenuCntntAuthenticChk(paramMap);
//				
//				if(menuCntnAuthChk >0){
//					return true;
//				} 
//				
//				if(menuAuthChk > 0){
//					return true;
//				} else { 
//					if(paramMap.get("authorSe").equals("W")){
//						response.sendRedirect("/message/authCmntWriteError.do");
//					}else{
//						response.sendRedirect("/message/authCmntReadError.do");
//					}
//					return false;
//				}
//			}
//			// 로그인 사용자
//			if (loginVO != null) {
//				LOG.debug("로그인 정보 O"); 
//				// 관리자 계정이면 전부 패스
//				if(requestURI.startsWith("/dggb/mngr")){
//					if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")) {
//						return true;
//					}else{
//						response.sendRedirect("/message/authReadMngrError.do");
//						return false;
//					}
//				}
//				
//			
//						
//				// 메뉴NO가 있으면 권한과 메뉴NO 기준으로 접근여부 판단
//				if (!"".equals(menuNo)) {
//					if(loginVO !=null){
//						if (StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC001") || StringUtils.nvl(loginVO.getMngrSeCode(),"").equals("ASC002")) {
//							return true;
//						}
//					}
//					EgovMap paramMap = new EgovMap();
//					
//					paramMap.put("userId", loginVO.getId());
//					paramMap.put("menuNo", menuNo);	
//					paramMap.put("userTyId", loginVO.getUserTyId());
//					paramMap.put("userSeq", loginVO.getUserSeq());   
//					paramMap.put("siteId", siteId);
//					
//					
//					int menuAuthChkCntnt =authenticService.selectMenuCntntAuthenticChk(paramMap);
//					
//					if(menuAuthChkCntnt > 0){
//						return true;
//					} 
//					if(requestURI.indexOf("/regist")>-1|| requestURI.indexOf("/modify")>-1){
//						paramMap.put("authorCd", "W");
//					}else if(requestURI.indexOf("/select") >-1 ||requestURI.indexOf("/subMenu.do") >-1){
//						paramMap.put("authorCd", "R");
//					}else{
//						return true;
//					}
//					int menuAuthChk = authenticService.selectMenuAuthenticChk(paramMap);
//	
//					if(menuAuthChk > 0){
//						return true;
//					} else {
//						// 권한이 없으면 튕긴
//						//ModelAndView modelAndView = new ModelAndView("redirect:/index.do");			
//						//throw new ModelAndViewDefiningException(modelAndView);
//						if(paramMap.get("authorCd").equals("W")){
//							response.sendRedirect("/message/authWriteError.do");
//						}else{
//							response.sendRedirect("/message/authReadError.do");
//						}
//						return false;
//					}
//				}
//				
//				return true;
//			} else {
//				EgovMap paramMap = new EgovMap();
//				paramMap.put("menuNo", menuNo);	
//				paramMap.put("userTyId", 7);
//				if(requestURI.indexOf("/regist")>-1|| requestURI.indexOf("/modify")>-1){
//					paramMap.put("authorCd", "W");
//				}else if(requestURI.indexOf("/select") >-1 ||requestURI.indexOf("/subMenu.do") >-1){
//					paramMap.put("authorCd", "R");
//				} 
//					int menuAuthChk = authenticService.selectMenuAuthenticChk(paramMap);
//					//ModelAndView modelAndView = new ModelAndView("redirect:/index.do");			
//					//throw new ModelAndViewDefiningException(modelAndView);
//					if(menuAuthChk > 0){
//						return true;
//					}else{
//						if(requestURI.startsWith("/dggb/mngr")){
//								response.sendRedirect("/message/noSessionMngrError.do");
//								return false;
//						}
//						response.sendRedirect("/message/noSessionError.do");
//						return false;
//					}
//			} 
//	}
	
	
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
		
		HttpSession session = request.getSession();

		String cmntAuthR ="N";
		String cmntAuthW ="N";
		if(session.getAttribute("cmntAuthR") != null && session.getAttribute("cmntAuthR").toString().equals("Y")){
			cmntAuthR ="Y";
		}
		if(session.getAttribute("cmntAuthW") != null && session.getAttribute("cmntAuthW").toString().equals("Y")){
			cmntAuthW ="Y";
		}
		
		if (CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT") 
		        || CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT") 
		        || CmmSessionUtil.getSessionBooleanValue(request, "cmntMngrAt")) {
			cmntAuthR ="Y";
			cmntAuthW ="Y";
		}
		
		modelAndView.addObject("cmntAuthR",cmntAuthR);
		modelAndView.addObject("cmntAuthW",cmntAuthW);
		
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

}

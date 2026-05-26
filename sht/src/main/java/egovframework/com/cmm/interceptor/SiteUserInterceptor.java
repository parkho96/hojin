package egovframework.com.cmm.interceptor;
 
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.util.UrlPathHelper;

import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.cmm.service.CmmRecrtfcService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyStplatAgreService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
 
/**
 * 사용자IP 체크 인터셉터
 * @author 유지보수팀 이기하
 * @since 2013.03.28
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일     수정자          수정내용
 *  ----------  --------    ---------------------------
 *  2013.03.28	이기하          최초 생성 
 *  </pre>
 */

public class SiteUserInterceptor implements HandlerInterceptor {
    
    private Set<String> pasageURL;
    
    public void setPasageURL(Set<String> pasageURL) {
        this.pasageURL = pasageURL;
    }
    
	@Resource(name="CmmLoginService")
	private CmmLoginService loginService;
    
    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;

    @Resource(name="UsrPrefcesService")
    private UsrPrefcesService usrPrefcesService;
    
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	@Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;
	
    @Resource(name="SiteMenuService")
    private SiteMenuService siteMenuService;
    
    @Resource(name="SbscrbCrtfcEstbsService")
    private SbscrbCrtfcEstbsService sbscrbCrtfcEstbsService;
    
    @Resource(name="CmmRecrtfcService")
    private CmmRecrtfcService recrtfcService;
    
    @Resource(name="CmmSbscrbService")
    private CmmSbscrbService sbscrbService;
    
    @Resource(name="CmmMyStplatAgreService")
    private CmmMyStplatAgreService cmmMyStplatAgreService;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;
    
    @Resource(name="MngrAuthService")
    private MngrAuthService mngrAuthService;
    
 
    private final boolean UNITY_MEMBER_AT = false; // 통합아니면 unity 제거
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	        String url = request.getRequestURL().toString();
	        String siteSeq=CmmSessionUtil.getSessionSiteSeq(request);
	        String usrId = CmmSessionUtil.getSessionUserId();
	        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
			UrlPathHelper urlPathHelper = new UrlPathHelper();
	    	String   nowUri  = urlPathHelper.getOriginatingRequestUri(request);
	        String usrSeq ="";
	        if(loginVO != null) {
	        	usrSeq = loginVO.getUsrSeq();
	       
				String siteKey = CmmSessionUtil.getSessionValue(request, "siteKey");
				
			
				loginVO.setSiteSeq(siteSeq);
				
				int siteUsrExgist = loginService.selectSiteUsrCrtfcCnt(loginVO);
				String reprsntSiteSeq = "";
				if(UNITY_MEMBER_AT) {
					reprsntSiteSeq = EgovProperties.getProperty("reprsnt.site.seq");
					loginVO.setSiteSeq(reprsntSiteSeq);
				}
				
				if(siteUsrExgist ==0) {
					
					boolean nadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");
					
					RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
					
					if(attributes != null) {
						attributes.removeAttribute("NADMIN_AT", RequestAttributes.SCOPE_SESSION);
					}		    	 
				
					if(UNITY_MEMBER_AT) {
						if(!nadminAt) {
							CmmLoginVO cmmLoginVO = loginService.selectSiteUsrinfo(loginVO);
							
							if(cmmLoginVO != null && cmmLoginVO.getUsrSeq() != null && !siteSeq.equals("10000000001") && !cmmLoginVO.getUsrtySeq().equals("10000000307")) {
								CmmSbscrbVO sbscrbVO = new CmmSbscrbVO();
								sbscrbVO.setUsrSeq(cmmLoginVO.getUsrSeq());
								sbscrbVO.setSiteSeq(siteSeq);
								sbscrbVO.setUsrSttusCode(cmmLoginVO.getSiteUsrSttusCode());
								sbscrbVO.setUseAt(cmmLoginVO.getUseAt());
								sbscrbVO.setUserId(cmmLoginVO.getUserId());
								sbscrbVO.setUsrgroupSeq(cmmLoginVO.getUsrgroupSeq());
								//sbscrbVO.setUsrTyCode(cmmLoginVO.getUsrTyCode());
								sbscrbVO.setUsrtySeq(cmmLoginVO.getUsrtySeq());
								//sbscrbService.registSiteUsrSbscrbInfo(sbscrbVO);
							}
						}
					}
				
				}
				
				if(loginVO != null) {
					
					String transSiteYn = CmmSessionUtil.getSessionValue(request, "transSiteYn"); 
					
					if(transSiteYn.equals("Y")) { 
						if(UNITY_MEMBER_AT) {
							loginVO.setSiteSeq(reprsntSiteSeq); 
						}
						CmmLoginVO resultVO = loginService.actionMergeTransLogin(loginVO);
						if(resultVO != null) { 
							
							String result=   actionLoginProcess(resultVO, request);
						}
						
					}
				}
		    
	        }
	 
	        
	       String OtherLoginAt = String.valueOf(request.getSession().getAttribute("OtherLoginAt"));
	       if(OtherLoginAt != null) {
	    	   request.getSession().removeAttribute("OtherLoginAt");
	    	   request.setAttribute("OtherLoginMsg", OtherLoginAt);
	       }
	    
	    return true;
	    
	}
	
	private String actionLoginProcess(CmmLoginVO resultVO
            , HttpServletRequest request) throws Exception {
		String returnMsg = "success";
    	try{
        CmmSessionUtil.setSessionValue(request, "loginVO", null);
        
        RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        
        if( attributes != null ) {
            attributes.removeAttribute("loginVO", RequestAttributes.SCOPE_SESSION); 
            attributes.removeAttribute("NADMIN_AT", RequestAttributes.SCOPE_SESSION);
            attributes.removeAttribute("SYSMNGR_AT", RequestAttributes.SCOPE_SESSION);  
            attributes.removeAttribute("subSiteMngr", RequestAttributes.SCOPE_SESSION);        	
        }
        
        HttpSession session = request.getSession(true);
        if (resultVO != null) {

			boolean nAdminChk = (Globals.AUTH_NORMAL_ADMIN.equals(resultVO.getUsrtySeq()))? true:false; 
			if (nAdminChk) {
				if( attributes != null ) {
					attributes.setAttribute("NADMIN_AT", nAdminChk, RequestAttributes.SCOPE_SESSION);
				}
				MngrAuthVO mngrAuthVO = new MngrAuthVO();
				mngrAuthVO.setSiteSeq(resultVO.getSiteSeq());
				mngrAuthVO.setUsrSeq(resultVO.getUsrSeq());
				List<MngrAuthVO> mngrAuthList = mngrAuthService.selectMngrConAuthUsr(mngrAuthVO);
				resultVO.setMngrAuthList(mngrAuthList);
				
				if( attributes != null ) {
					attributes.setAttribute("NADMIN_AT", nAdminChk, RequestAttributes.SCOPE_SESSION);
				}
				SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
				siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
				SysMngrSiteInfoVO  siteInfo = siteInfoService.selectSiteInfoDetail(siteInfoVO);
				SiteMenuVO siteMenuVO = new SiteMenuVO();
				siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
				String topLogo =  siteMenuService.selectSiteTopLogo(siteMenuVO);
				
				request.getSession().setAttribute("loginVO", resultVO);
				if( attributes != null ) {
					attributes.setAttribute("loginVO", resultVO, RequestAttributes.SCOPE_SESSION);
				}
				session.setAttribute("mngrSiteNm", siteInfo.getSiteFullNm());
				session.setAttribute("mngrTopLogo", topLogo);
			} else{ 

                request.getSession().setAttribute("loginVO", resultVO);
                if( attributes != null ) {
                	attributes.setAttribute("loginVO", resultVO, RequestAttributes.SCOPE_SESSION);
                }

                // 약관 가져오기
                SiteStplatInfoVO searchVO = new SiteStplatInfoVO();
                
                searchVO.setUsrSeq(resultVO.getUsrSeq());
                searchVO.setSiteSeq(resultVO.getSiteSeq());
                searchVO.setStplatTyCode(Globals.ESSNTL_STPLAT_CODE_USRJOIN);
                
                List<SiteStplatInfoVO> resultList = sbscrbService.selectSiteStplatList(searchVO);

                // 비교
                if (resultList != null) {
                	
                	boolean chk = true;
                	
                	if(resultList.size() > 0){
                		chk = false;
                	}
                	 
                }

			}
			return returnMsg;
		}
          
    	}catch(NullPointerException e){ 
    		returnMsg = "fail";
    	}catch(SQLException e){ 
    		returnMsg = "fail";
    		returnMsg = "fail";
    	}catch(NumberFormatException e){ 
    		returnMsg = "fail";
    	}catch(IOException e){ 
    		returnMsg = "fail";
    	}
		return returnMsg;
    }
}

package egovframework.wzwg.cmm.mber.myPage.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyPageService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;

@Controller
public class CmmMyPageController {

    @Resource(name="CmmMyPageService")
    private CmmMyPageService cmmMyPageService;

    @Resource(name="SysMngrSbscrbQesitmService")
    private SysMngrSbscrbQesitmService sbscrbQesitmService;
    
    @Resource(name="CmmSbscrbService")
	private CmmSbscrbService cmmSbscrbService;
    
    @Resource(name="SiteUsrGroupService")
    private SiteUsrGroupService siteUsrGroupService;
    
    @Resource(name="UsrTySbscrbFormService")
    private UsrTySbscrbFormService usrTySbscrbFormService;
    
	@Resource(name="SysMngrSbscrbInfoService")
	private SysMngrSbscrbInfoService sbscrbInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;

    @Resource(name="SysMngrUsrInfoService")
    private SysMngrUsrInfoService usrInfoService;
    
    @Resource(name="CmmLoginService")
    private CmmLoginService loginService;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;
    
    
    @RequestMapping(value={"/cmm/mber/myPage/selectMyPageMain.do","/{siteKey}/cmm/mber/myPage/selectMyPageMain.do"})
    public String selectMyPageMain(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        CmmLoginVO getVO = CmmSessionUtil.getLoginVO();
        
        if (getVO != null) {
            return "forward:"+wzwgContext+"/cmm/mber/myPage/selectMyPageForm.do"; 
        } else {
            model.addAttribute("message", "fail.common.login");
            return "forward:"+wzwgContext+"/loginForm.do";
        }
    }
    
    @RequestMapping(value= {"/cmm/mber/myPage/selectMyPageCrtfc.do","/{siteKey}/cmm/mber/myPage/selectMyPageCrtfc.do"})
    public String selectMyPageCrtfc(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        CmmLoginVO getVO = CmmSessionUtil.getLoginVO();
        getVO.setPassword(paramVO.getPassword());
        
        CmmLoginVO crtfcVO = loginService.actionLogin(getVO);
        
        if (crtfcVO != null) {
            return "redirect:"+wzwgContext+"/cmm/mber/myPage/selectMyPageForm.do"; 
        } else {
            model.addAttribute("message", "fail.common.login");
            return "forward:"+wzwgContext+"/cmm/mber/myPage/selectMyPageMain.do";
        }
    }
    
	@RequestMapping(value= {"/cmm/mber/myPage/selectMyPageForm.do","/{siteKey}/cmm/mber/myPage/selectMyPageForm.do"})
	public String selectMyPageForm(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
	    
        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		paramVO.setFrmGubun("M");
	    
		if (loginVO != null) {
		    
		    String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		    
    	    paramVO.setSiteSeq(siteSeq);
    	    paramVO.setUserId(loginVO.getUserId());
    	    paramVO.setUsrSeq(loginVO.getUsrSeq());
    	    paramVO.setUsrtySeq(loginVO.getUsrtySeq());
    
	        SysMngrUsrInfoVO usrInfoVO = new SysMngrUsrInfoVO();
	        usrInfoVO.setSiteSeq(siteSeq);
	        usrInfoVO.setUsrSeq(loginVO.getUsrSeq());

	        SysMngrUsrInfoVO infoVO = usrInfoService.selectUsrInfoDetail(usrInfoVO);
	        
	        if(infoVO != null) {
	        	paramVO.setCrtfctSeCode(infoVO.getCrtfctSeCode());
	        	model.addAttribute("infoVO", infoVO);
	        	model = cmmSbscrbService.getSiteSbscrbForm(model, paramVO);
	        }
	        
		} else {
		    model.addAttribute("message", "fail.common.login");
		    return "forward:"+wzwgContext+"/cmm/mber/myPage/selectMyPageMain.do";
		}

		return "wzwg/cmm/mber/myPage/myPageForm"; 
	}
	
	@RequestMapping(value= {"/cmm/mber/myPage/modifyUsrInfoAjax.do","/{siteKey}/cmm/mber/myPage/modifyUsrInfoAjax.do"})
	public ModelAndView modifyUsrInfoAjax(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("sbscrbVO") SysMngrSbscrbVO sbscrbVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
	    
	    paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	    paramVO.setUsrSeq(loginVO.getUsrSeq());
		
		int modifyResult = cmmMyPageService.modifyMyPageUsrInfo(paramVO);
		
        sbscrbVO.setSiteSeq(paramVO.getSiteSeq());
        sbscrbVO.setUsrSeq(paramVO.getUsrSeq());
        sbscrbVO.setLastUpdusrId(loginVO.getUserId());
        if(sbscrbVO.getRspnsArr() != null){
        	sbscrbVO.setRspnsArr(sbscrbVO.getRspnsArr().replaceAll("&amp;", "&"));
        	sbscrbVO.setRspnsArr(sbscrbVO.getRspnsArr().replaceAll("&quot;", "'"));
        	sbscrbVO.setRspnsArr(sbscrbVO.getRspnsArr().replaceAll("&apos;", "'"));
		}
        modifyResult = sbscrbInfoService.modifySbscrbInforspns(sbscrbVO);
        
        java.util.Enumeration params = request.getParameterNames();
		String usrlogParam = "";
		boolean bBadWord= false;
		while ( params.hasMoreElements() ) {
			String name = (String)params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if(!name.startsWith("password") && !name.startsWith("hTel")){
			usrlogParam =usrlogParam+"&"+name+"="+value;
			}
		}
		usrlogParam = usrlogParam.substring(1);
    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
    	siteUsrLogVO.setFrstRegisterId(paramVO.getUserId()); 
    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	siteUsrLogVO.setUsrChngCode("SC00000449");
    	String usrSeq = loginVO.getUsrSeq();
    	siteUsrLogVO.setUsrlogParam(usrlogParam);
    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
    	siteUsrLogVO.setUsrlogUsrSeq(usrSeq);
    	siteUsrLogVO.setUsrSeq(usrSeq);
    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
		
        return CmmAjaxUtil.getAjaxReturnCmmMap(modifyResult);
	}	

    @RequestMapping(value= {"/cmm/mber/myPage/modifyUsrSecsnAjax.do","/{siteKey}/cmm/mber/myPage/modifyUsrSecsnAjax.do"})
    public ModelAndView modifyUsrSttusSecsn(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
        //paramVO.setSiteSeq(loginVO.getSiteSeq());
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setUsrSeq(loginVO.getUsrSeq());
        paramVO.setLastUpdusrId(loginVO.getUserId());
        
        int result = cmmMyPageService.modifyUsrSecsn(paramVO);

        HttpSession session = request.getSession();
        
        if(result > 0) {

			java.util.Enumeration params = request.getParameterNames();
			String usrlogParam = "";
			boolean bBadWord= false;
			while ( params.hasMoreElements() ) {
			String name = (String)params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if(!name.startsWith("password") && !name.startsWith("hTel")){
			usrlogParam =usrlogParam+"&"+name+"="+value;
			}
			}
			usrlogParam = usrlogParam.substring(1);
			CmmLoginVO resultVO2 = new CmmLoginVO(); 
			SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
			siteUsrLogVO.setConectIp(request.getRemoteAddr());
			siteUsrLogVO.setFrstRegisterId(paramVO.getUserId()); 
			siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			siteUsrLogVO.setUsrChngCode("SC00000028");
			String usrSeq = loginVO.getUsrSeq();
			siteUsrLogVO.setUsrlogParam(usrlogParam);
			siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
			siteUsrLogVO.setUsrlogUsrSeq(usrSeq);
			siteUsrLogVO.setUsrSeq(usrSeq);
			siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);

        	CmmSessionUtil.setSessionValue(request, "loginVO", null);
        	CmmSessionUtil.setSessionValue(request, "userId", null);
        	session.removeAttribute("loginVO");
        	session.removeAttribute("SADMIN_AT");
        	session.removeAttribute("NADMIN_AT");
        	session.removeAttribute("SYSMNGR_AT"); 
        	session.invalidate();
        	
        	RequestAttributes attributes = RequestContextHolder.getRequestAttributes();
        	
        	if( attributes != null ) {
                attributes.removeAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
                attributes.removeAttribute("userId", RequestAttributes.SCOPE_SESSION);
                attributes.removeAttribute("SADMIN_AT", RequestAttributes.SCOPE_SESSION);
                attributes.removeAttribute("NADMIN_AT", RequestAttributes.SCOPE_SESSION);
                attributes.removeAttribute("SYSMNGR_AT", RequestAttributes.SCOPE_SESSION);      	        		        		
        	}

        }

		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }	
}

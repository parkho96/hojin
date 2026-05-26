package egovframework.wzwg.cmm.mber.sbscrb.web;

import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.crtfc.CmmNiceCrtfcUtil;
import egovframework.wzwg.cmm.mber.cmm.service.CmmRecrtfcService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.snsAPI.service.NaverAPIService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;

@Controller
public class CmmSbscrbController {
	
    /**
     * @uml.property  name="cmmSbscrbService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="CmmSbscrbService")
	private CmmSbscrbService cmmSbscrbService;
    
    /**
     * @uml.property  name="loginService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="CmmLoginService")
   	private CmmLoginService loginService;
    
	/**
     * @uml.property  name="sbscrbInfoService"
     * @uml.associationEnd  readOnly="true"
     */
	@Resource(name="SysMngrSbscrbInfoService")
	private SysMngrSbscrbInfoService sbscrbInfoService;
	
	/**
     * @uml.property  name="sysMngrUsrTyService"
     * @uml.associationEnd  readOnly="true"
     */
	@Resource(name="SysMngrUsrTyService")
	private SysMngrUsrTyService sysMngrUsrTyService;
	
    /**
     * @uml.property  name="siteUsrGroupService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="SiteUsrGroupService")
    private SiteUsrGroupService siteUsrGroupService;
    
    /**
     * @uml.property  name="codeService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    /**
     * @uml.property  name="sbscrbCrtfcEstbsService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="SbscrbCrtfcEstbsService")
    private SbscrbCrtfcEstbsService sbscrbCrtfcEstbsService;
    
    /**
     * @uml.property  name="recrtfcService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="CmmRecrtfcService")
    private CmmRecrtfcService recrtfcService;
    
    @Resource(name="NaverAPIService")
    private NaverAPIService naverAPIService;
    
    /**
     * @uml.property  name="siteStplatSimpService"
     * @uml.associationEnd  readOnly="true"
     */
/*    @Resource(name="SiteStplatSimpService")
    private SiteStplatSimpService siteStplatSimpService;*/

	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;   
    
    @Resource(name="SnsKeyMngrService")
    protected SnsKeyMngrService snsKeyMngrService;
    
    
    
	@RequestMapping(value={"/cmm/mber/sbscrb/selectSbscrbStplat.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbStplat.do"})
	public String selectSbscrbStplat(
			@ModelAttribute("paramVO") CmmSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);
        if (paramVO != null) {
            boolean chkVal = getUsrSbscrbInfoDataCheck(paramVO, 1);

            if (!chkVal) {
                model.addAttribute("errCd", "mber.sbscrb.info.error");
                model.addAttribute("retUrl", "/cmm/mber/sbscrb/selectSbscrbMain.do");

                return "wzwg/cmm/errorStringMsgForward"; 
            
            }
        }
		
		SiteStplatInfoVO searchVO = new SiteStplatInfoVO();
		
		searchVO.setSiteSeq(siteSeq);
		searchVO.setStplatTyCode(Globals.ESSNTL_STPLAT_CODE_USRJOIN);
		
		/*
		List<SiteStplatInfoVO> resultList = cmmSbscrbService.selectSiteStplatList(searchVO);
		
		if (resultList.isEmpty()) {
		    
		    SiteStplatInfoVO resultVO = siteStplatSimpService.selectStplatSimpByJoin(searchVO);
		    
		    if (resultVO == null) {
	            model.addAttribute("message", "ESSNTL_STPLAT_ERR_01");
	            model.addAttribute("retUrl", Globals.USR_LOGINFORM_URL);
	            
	            return "wzwg/cmm/errorMsgForward";
		    } else {

		        model.addAttribute("resultVO", resultVO);
		    }
		}
		*/
		
		List<SiteStplatInfoVO> resultList = siteStplatInfoService.selectStplatInfoUsrList(searchVO);
		
		if(resultList.isEmpty()){
            model.addAttribute("message", "ESSNTL_STPLAT_ERR_01");
            model.addAttribute("retUrl", Globals.USR_LOGINFORM_URL);
            
            return "wzwg/cmm/errorMsgForward";
		}
		
		model.addAttribute("resultList", resultList);
		
		model.addAttribute("paramVO", paramVO);

//		model = recrtfcService.getCrtfcEstbsAndNiceModule(request, model);
		
		return "wzwg/cmm/mber/sbscrb/sbscrbStplat"; 
	}
    
    @RequestMapping(value={"/cmm/mber/sbscrb/selectSbscrbUsrTy.do","/cmm/mber/sbscrb/selectSbscrbMain.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbUsrTy.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbMain.do"})
    public String selectSbscrbUsrTy(
           @ModelAttribute("paramVO") CmmSbscrbVO paramVO
           , HttpServletRequest request
           , HttpServletResponse response
           , ModelMap model) 
           throws Exception {
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);
        
        List<CmmSbscrbVO> sysUsrTyList = cmmSbscrbService.selectSysSbscrbUsrTy(paramVO);
        
        List<CmmSbscrbVO> siteUsrTyList = cmmSbscrbService.selectSiteSbscrbUsrTyList(paramVO);
        
        model.addAttribute("sysUsrTyList", sysUsrTyList);
        model.addAttribute("siteUsrTyList", siteUsrTyList);
        
        model.addAttribute("paramVO", paramVO);
        
        return "wzwg/cmm/mber/sbscrb/sbscrbUsrTy"; 
    }
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/selectSbscrbCrtfcResult.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbCrtfcResult.do"})
    public String selectSbscrbCrtfcResult (
       @ModelAttribute("paramVO") CmmSbscrbVO paramVO
       , HttpServletRequest request
       , HttpServletResponse response
       , ModelMap model) 
       throws Exception {

        HashMap<String, String> niceSuccessMap = CmmNiceCrtfcUtil.getNiceCrtfcDupInfo(request);

        model.addAttribute("niceSuccessMap", niceSuccessMap);
        
        return "wzwg/cmm/mber/sbscrb/sbscrbUsrCrtfcResult"; 
    }
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/selectSbscrbCrtfcFail.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbCrtfcFail.do"})
    public String selectSbscrbCrtfcFail (
       @ModelAttribute("paramVO") CmmSbscrbVO paramVO
       , HttpServletRequest request
       , HttpServletResponse response
       , ModelMap model) 
       throws Exception {

        HashMap<String, String> niceSuccessMap = CmmNiceCrtfcUtil.getNiceCrtfcError();
        
        model.addAttribute("niceSuccessMap", niceSuccessMap);
        
        return "wzwg/cmm/mber/sbscrb/sbscrbUsrCrtfcResult"; 
    }
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/selectSbscrbCrtfcResultTest.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbCrtfcResultTest.do"})
    public String selectSbscrbCrtfcResultTest(
       @ModelAttribute("paramVO") CmmSbscrbVO paramVO
       , HttpServletRequest request
       , HttpServletResponse response
       , ModelMap model) 
       throws Exception {

        HashMap<String, String> niceSuccessMap = CmmNiceCrtfcUtil.getNiceCrtfcDupInfoTest();

        model.addAttribute("niceSuccessMap", niceSuccessMap);
        
        return "wzwg/cmm/mber/sbscrb/sbscrbUsrCrtfcResult"; 
    }
    
    @RequestMapping(value={"/cmm/mber/sbscrb/selectSbscrbForm.do","/selectSbscrbForm.do","/mngr/usrMngr/usrInfo/selectSbscrbFormAjax.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbForm.do","/{siteKey}/selectSbscrbForm.do","/{siteKey}/mngr/usrMngr/usrInfo/selectSbscrbFormAjax.do"})
    public String selectSbscrbForm(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request
            , @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO
            , ModelMap model
        ) throws Exception{

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        String frmGubun = StringUtils.defaultString(paramVO.getFrmGubun());
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

        if (!"M".equals(frmGubun)) {
        	   int chk=  sbscrbCrtfcEstbsService.selectSbscrbCrtfcEstbsByUsrTyChk(secVO);
        	if(chk > 0 && paramVO != null) {
                boolean chkVal = getUsrSbscrbInfoDataCheck(paramVO, 2);
            
                if (!chkVal) {
                    model.addAttribute("errCd", "mber.sbscrb.info.error");
                    model.addAttribute("retUrl", "/cmm/mber/sbscrb/selectSbscrbMain.do");
                    return "wzwg/cmm/errorStringMsgForward"; 
                }
            
       
          
          
            CmmLoginVO siteUsrInfo = cmmSbscrbService.selectSiteUsrCrtfc(paramVO);
            
            if (siteUsrInfo != null) {
                
                siteUsrInfo = loginService.getSiteUsrInfoCrtfc(siteUsrInfo);
                
                String errMsg = siteUsrInfo.getErrMsg();
                
                if (!"".equals(errMsg)) {
                    if (Globals.USR_RE_CRTFC.equals(errMsg)) {
                        request.setAttribute("userId", siteUsrInfo.getUserId());
                        
                        return "forward:"+wzwgContext+"/cmm/mber/recrtfc/recrtfcForm.do";
                    } else {
                        
                        model.addAttribute("sbscrbFail", true);
                        
                        return "wzwg/cmm/mber/sbscrb/sbscrbComptPage";
                    }
                } else {
                    model.addAttribute("unityUsr", true);
                    model.addAttribute("infoVO", siteUsrInfo);
                }

                CmmLoginVO nowSiteUsrInfo = cmmSbscrbService.selectSiteUsrCrtfcBySiteSeq(paramVO);
                if (nowSiteUsrInfo != null) {
//                    if (paramVO.getSiteSeq().equals(siteUsrInfo.getSiteSeq())) {
                        
                    model.addAttribute("message", "cop.usr.regist.msg");
                    
                    return "forward:"+wzwgContext+"/loginForm.do";
//                    }
                }
                paramVO.setUserId(siteUsrInfo.getUserId());
            }
            }
        }
        
        model = cmmSbscrbService.getSiteSbscrbForm(model, paramVO);
        
        return "wzwg/cmm/mber/sbscrb/sbscrbForm";
    }

    @RequestMapping(value= {"/cmm/mber/sbscrb/registUsrSbscrbInfoAjax.do","/{siteKey}/cmm/mber/sbscrb/registUsrSbscrbInfoAjax.do"})
    public ModelAndView registUsrSbscrbInfo(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
    	 int result = 0;
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        secVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        int chk=  sbscrbCrtfcEstbsService.selectSbscrbCrtfcEstbsByUsrTyChk(secVO);
        
        String bassGroupSeq = cmmSbscrbService.selectSiteUsrTyCheck(paramVO);
        paramVO.setUsrgroupSeq(bassGroupSeq); 
 	    if(chk > 0 && paramVO != null) {
            boolean chkVal = getUsrSbscrbInfoDataCheck(paramVO, 2);
        
            if (!chkVal) {
                return CmmAjaxUtil.getAjaxReturnCmmMsgCode("mber.sbscrb.info.error");
            }
        
       
        
        String idCheck = cmmSbscrbService.selectSbscrbUserIdDplctCeck(paramVO);
            
        if("dplctN".equals(idCheck)) {
            
            result = 0;
            
        } else {
            
            result = cmmSbscrbService.registUsrSbscrbInfo(paramVO);

            result = registSbscrbInforspns(paramVO);            
            
        }
 	   }else{
            if(paramVO != null) {
 		        paramVO.setUsrgroupSeq(bassGroupSeq);
 		        paramVO.setUsrSttusCode("SC00000027");
 		        System.out.println("bassGroupSeq2 : "+paramVO.getUsrgroupSeq());
 		        result = cmmSbscrbService.registUsrSbscrbInfo(paramVO);
 		        result = registSbscrbInforspns(paramVO);            
            }
 	   }
        java.util.Enumeration params = request.getParameterNames();
		String usrlogParam = "";
		boolean bBadWord= false;
		while ( params.hasMoreElements() ) {
			String name = (String)params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if(!name.equals("password") && !name.startsWith("hTel")){
			usrlogParam =usrlogParam+"&"+name+"="+value;
			}
		}
		usrlogParam = usrlogParam.substring(1);
    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
        if (paramVO != null) {
    	    siteUsrLogVO.setFrstRegisterId(paramVO.getUserId()); 
        }
    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	siteUsrLogVO.setUsrChngCode("SC00000020");
    	String usrSeq = cmmSbscrbService.selectUserSeq(paramVO); 
    	siteUsrLogVO.setUsrlogParam(usrlogParam);
    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
    	siteUsrLogVO.setUsrlogUsrSeq(usrSeq);
    	siteUsrLogVO.setUsrSeq(usrSeq);
    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/registUnityUsrSbscrbInfoAjax.do","/{siteKey}/cmm/mber/sbscrb/registUnityUsrSbscrbInfoAjax.do"})
    public ModelAndView registUnityUsrSbscrbInfoAjax(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{

        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setUnitySbscrbYn("Y");
        
        int result = 0;
            
        result = cmmSbscrbService.registUnityUsrSbscrbInfo(paramVO);
        
        result = registSbscrbInforspns(paramVO);        
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    private int registSbscrbInforspns(CmmSbscrbVO paramVO) throws Exception {
        
        if(paramVO != null) {
            paramVO.setFrstRegisterId(paramVO.getUserId());

            if(paramVO.getRspnsArr() != null){
                paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&amp;", "&"));
                paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&quot;", "'"));
                paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&apos;", "'"));
            }
        }
        
        return sbscrbInfoService.registSbscrbInforspns(paramVO);  
    }
    
    @RequestMapping(value={"/cmm/mber/sbscrb/selectSbscrbComptPage.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbComptPage.do"})
    public String selectSbscrbComptPageTemplt(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        return "wzwg/cmm/mber/sbscrb/sbscrbComptPage"; 
    }
    
    private boolean getUsrSbscrbInfoDataCheck(CmmSbscrbVO paramVO, int sbscrbStep) {
    	// paramVO null 체크 추가 (Sparrow 대응)
        if (paramVO == null) {
            return false;
        }

        if (sbscrbStep >= 2) {
            if (StringUtils.isEmpty(paramVO.getStplatArr())) return false;
            if (StringUtils.isEmpty(paramVO.getCrtfctDn())) return false;
        }

        if (sbscrbStep >= 1) {
            
            CmmSbscrbVO sbscrbVO = cmmSbscrbService.selectSiteSbscrbUsrTy(paramVO);
            
            if (sbscrbVO != null) {
                
                String ucrtfcEstbsCode = StringUtils.defaultString(sbscrbVO.getUcrtfcEstbsCode());

                if (!ucrtfcEstbsCode.equals(Globals.CRTFC_ESTBS_PASS)) {
                    if (StringUtils.isEmpty(paramVO.getUsrTyCode())) return false;
                    if (StringUtils.isEmpty(paramVO.getUsrtySeq())) return false;
                }
            } else {
                return false;
            }
        }
        
        return true;
    }

	@RequestMapping(value= {"/cmm/mber/sbscrb/selectSbscrbUsrInfoAjax.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbUsrInfoAjax.do"})
	public ModelAndView selectSbscrbUsrInfo(
			@ModelAttribute("paramVO") CmmSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		result = cmmSbscrbService.selectSbscrbUsrInfo(paramVO);
		
		return CmmAjaxUtil.getAjaxReturnCmmMap(result);
	}

	@RequestMapping(value= {"/cmm/mber/sbscrb/selectSbscrbUserIdDplctCeckAjax.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbUserIdDplctCeckAjax.do"})
	public ModelAndView selectSbscrbUserIdDplctCeck(
//			@RequestParam(value="userId", required=false) String userId
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{ 

//		CmmSbscrbVO cmmSbscrbVO = new CmmSbscrbVO();
		
		if("".equals(paramVO.getSiteSeq()) || paramVO.getSiteSeq() == null) {
			paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		}
		
		String result = cmmSbscrbService.selectSbscrbUserIdDplctCeck(paramVO);
		
		return CmmAjaxUtil.getAjaxReturnCmmMsgCode(result);
	}
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/modifyUsrSbscrbInfoAjax.do","/{siteKey}/cmm/mber/sbscrb/modifyUsrSbscrbInfoAjax.do"})
    public ModelAndView modifyUsrSbscrbInfoAjax(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{

        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        int result = 0;
        
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        if(paramVO.getRspnsArr() != null){
    		paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&amp;", "&"));
    		paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&quot;", "'"));
    		paramVO.setRspnsArr(paramVO.getRspnsArr().replaceAll("&apos;", "'"));
		}
        
        result = sbscrbInfoService.modifySbscrbInforspns(paramVO);

        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value={"/cmm/mber/sbscrb/selectSbscrbCrtfc.do","/{siteKey}/cmm/mber/sbscrb/selectSbscrbCrtfc.do"})
    public String selectSbscrbCrtfc(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO
            , HttpServletRequest request 
            , ModelMap model)
            throws Exception {

        model = recrtfcService.getCrtfcEstbsAndNiceModule(request, model, secVO);

        return "wzwg/cmm/mber/sbscrb/sbscrbCrtfc"; 
    }
    
    @RequestMapping(value= {"/cmm/mber/sbscrb/snsNaver.do","/{siteKey}/cmm/mber/sbscrb/snsNaver.do"})
    public String snsNaver(  
    		@ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO
            , HttpServletRequest request
            , HttpServletResponse response
            , HttpSession session
            , ModelMap model)
            throws Exception {
    	if(request.getParameter("code") != null && request.getParameter("state") != null) {
    		
	    	String usrProfile = naverAPIService.getUserProfile(session, naverAPIService.getAccessToken(session, request.getParameter("code").toString(), request.getParameter("state").toString())); 
	    	JSONParser jsonParser = new JSONParser();
	        
	        org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject)jsonParser.parse(usrProfile);
	        String name = StringUtils.defaultString((String)((org.json.simple.JSONObject)jsonObject.get("response")).get("name"));
	        String id = StringUtils.defaultString((String)((org.json.simple.JSONObject)jsonObject.get("response")).get("id"));
	        paramVO.setCrtfc_name(name); 
	        paramVO.setCrtfctDn(id);
	        model.addAttribute("paramVO" , paramVO);
	    }
        return "wzwg/cmm/mber/sbscrb/snsNaver"; 
    }
    
}

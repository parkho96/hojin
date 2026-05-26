package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class SysMngrSiteAdmController {
	
	@Resource(name="CmmSbscrbService")
	private CmmSbscrbService cmmSbscrbService;
    
    @Resource(name="CmmLoginService")
   	private CmmLoginService loginService;
    
	@Resource(name="SysMngrSbscrbInfoService")
	private SysMngrSbscrbInfoService sbscrbInfoService;
	
	@Resource(name="SysMngrSbscrbQesitmService")
	private SysMngrSbscrbQesitmService sbscrbQesitmService;
	
	@Resource(name="SysMngrUsrInfoService")
	private SysMngrUsrInfoService usrInfoService;
	
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
    
    @Resource(name="MngrAuthService")
    private MngrAuthService mngrAuthService;
    
    @Resource(name="UsrTySbscrbFormService")
    private UsrTySbscrbFormService usrTySbscrbFormService;
    
    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="SiteUsrGroupService")
    private SiteUsrGroupService siteUsrGroupService;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;
    
	@Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
    
	/**
	 * ㅁ 시스템 - 관리자 신규등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectMngrInfoNewSbscrbForm.do")
	public String selectMngrNewSbscrbForm(
			 @ModelAttribute("paramVO") CmmSbscrbVO paramVO
			, @ModelAttribute("mngrAuthVO") MngrAuthVO mngrAuthVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
        model.addAttribute("mngrAuthList", mngrAuthService.selectMngrConAuthList(mngrAuthVO));
        model.addAttribute("mngrMenuList", siteMngrMenuService.selectSiteMenuMngrList(siteMngrMenuVO));
        
		return "wzwg/sysMngr/siteMngr/siteInfo/siteMngrNewSbscrbForm";
	}
	
	@RequestMapping(value="/**/siteMngr/siteInfo/selectMngrInfoList.do")
	public String selectMngrInfoList(
			@ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
			, HttpServletRequest request
			, HttpSession session 
			, ModelMap model
		) throws Exception{
		
		SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
		boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
		if(sysMngrAt != true){
			/** 사이트 시퀀스 */
			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);
			
			sysMngrSiteInfoVO.setSiteSeq(siteSeq);
			SysMngrSiteInfoVO siteInfoDetail = siteInfoService.selectSiteInfoDetail(sysMngrSiteInfoVO);
			
			model.addAttribute("siteInfoDetail",siteInfoDetail);
			
		}else{
			
			// 사이트 정보 목록
			sysMngrSiteInfoVO.setFirstIndex(0);
			sysMngrSiteInfoVO.setRecordCountPerPage(100000);
			List<SysMngrSiteInfoVO> siteInfoList = siteInfoService.selectSiteInfoList(sysMngrSiteInfoVO);
			
			model.addAttribute("siteInfoList", siteInfoList);
		}

		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
        String usrtySeq=  EgovProperties.getProperty("Globals.login.auth.normalAdmin");
        paramVO.setUsrtySeq(usrtySeq);
        
		// 사이트 정보 카운트
		Integer usrInfoCnt = usrInfoService.selectUsrInfoListCnt(paramVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = usrInfoService.selectUsrInfoList(paramVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		// 회원유형 코드 목록
        List<CmmCodeVO> usrTyCdList = codeService.selectCmmCodeList("USR_TY_CODE");
        model.addAttribute("usrTyCdList", usrTyCdList);
		
		// 회원상태 코드 목록
        List<CmmCodeVO> usrSttusList = codeService.selectCmmCodeList("USR_STTUS_CODE");
        model.addAttribute("usrSttusList", usrSttusList);

      for(int i=0;i<usrInfoList.size();i++){ 
    	String usrSeq   = usrInfoList.get(i).getUsrSeq();
    			
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
	if(!usrlogParam.equals("")){
	usrlogParam = usrlogParam.substring(1);
	}
	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
	siteUsrLogVO.setConectIp(request.getRemoteAddr());
	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	siteUsrLogVO.setUsrChngCode("SC00000448"); 
	siteUsrLogVO.setUsrlogParam(usrlogParam);
	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
	siteUsrLogVO.setUsrSeq(usrSeq);
	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
    }
        List<SiteUsrGroupVO> usrGroupCode = siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq());
        
        model.addAttribute("usrGroupCode", usrGroupCode);
        
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/mngrInfoList";
	}
	
	/**
	 * ㅁ 시스템 - 관리자 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectMngrSbscrbInfoForm.do")
	public String selectMngrSbscrbForm(
			 @ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
//		boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
//		if(sysMngrAt != true){
//			/** 사이트 시퀀스 */
//			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
//			paramVO.setSiteSeq(siteSeq);
//		}
		
		
		SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
		siteInfoVO.setSiteSeq(paramVO.getSiteSeq());
		siteInfoVO = siteInfoService.selectSiteInfoDetail(siteInfoVO);
		
		SysMngrUsrInfoVO usrInfoVO = new SysMngrUsrInfoVO();
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        usrInfoVO.setPageIndex(paramVO.getPageIndex());
        usrInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        usrInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
        usrInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
        
		// 사이트 정보 목록
		SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
		sysMngrSiteInfoVO.setFirstIndex(0);
		sysMngrSiteInfoVO.setRecordCountPerPage(100000);
		
		// 사이트 정보 카운트
		Integer usrInfoCnt = usrInfoService.selectUsrInfoListCnt(usrInfoVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = usrInfoService.selectUsrInfoList(usrInfoVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
		
		model.addAttribute("siteInfoVO", siteInfoVO);
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteSbscrbForm";
	}
	
	/**
	 * ㅁ 회원가입 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/registMngrSbscrbInfo.do")
	public ModelAndView registMngrSbscrbInfo(
			@ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("mngrAuthVO") MngrAuthVO mngrAuthVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		ModelAndView ajaxModel 		= new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder 	= new AjaxXmlBuilder();
		
		int result = 0;
		
		if("Y".equals(paramVO.getUnitySbscrbYn())){
			paramVO.setCrtfctSeCode(Globals.USR_STTUS_CRTFC_CODE);
		}
		
		if(("10000000001").equals(paramVO.getSiteSeq())) {
			paramVO.setUsrtySeq(Globals.AUTH_SUPER_ADMIN);
			
		}else {
		paramVO.setUsrtySeq(Globals.AUTH_NORMAL_ADMIN);
		}
		result = cmmSbscrbService.registMngrSbscrbInfo(paramVO, mngrAuthVO);
		
		paramVO.setFrstRegisterId(paramVO.getUserId());
		
		if(result > 0){
    		ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", String.valueOf("success")).toString());
		}else{
			ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", String.valueOf("fail")).toString());
		}
		
		return ajaxModel;
	}
	
	/**
	 * ㅁ 사이트 관리자 가입 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/registMngrSiteSbscrbInfo.do")
	public ModelAndView registMngrSiteSbscrbInfo(
			@ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , @ModelAttribute("mngrAuthVO") MngrAuthVO mngrAuthVO
            , @ModelAttribute("siteMngrMenuVO") SiteMngrMenuVO siteMngrMenuVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		ModelAndView ajaxModel 		= new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder 	= new AjaxXmlBuilder();
		
		int result = 0;
		
		paramVO.setUnitySbscrbYn("Y");
		
		paramVO.setFrstRegisterId(paramVO.getUserId());
		
		SysMngrUsrInfoVO usrInfoVO = new SysMngrUsrInfoVO();
		usrInfoVO.setUsrSeq(paramVO.getUsrSeq());
		usrInfoVO = usrInfoService.selectUsrInfoDetail(usrInfoVO);

		if(usrInfoVO != null) {
			paramVO.setUserId(usrInfoVO.getUserId());
		}
		
		result = cmmSbscrbService.registMngrSbscrbInfo(paramVO, mngrAuthVO);
		paramVO.setFrstRegisterId(paramVO.getUserId());
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
		if(!usrlogParam.equals("")){
		usrlogParam = usrlogParam.substring(1);
		}
		String usrSeq = cmmSbscrbService.selectUserSeq(paramVO);
    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
    	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
    	siteUsrLogVO.setLinkageAt("N");
    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	siteUsrLogVO.setUsrChngCode("SC00000020"); 
    	siteUsrLogVO.setUsrlogParam(usrlogParam);
    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
    	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
    	siteUsrLogVO.setUsrSeq(usrSeq);
    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO); 
    	siteMngrMenuVO.setUsrSeq(String.valueOf(result));
    	siteMngrMenuVO.setSiteSeq(paramVO.getSiteSeq());
    	siteMngrMenuVO.setUserId(paramVO.getUserId());
    	siteMngrMenuService.registSiteMenuAuth(siteMngrMenuVO);
		if(result > 0){
    		ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", String.valueOf("success")).toString());
		}else{
			ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", String.valueOf("fail")).toString());
		}
		
		return ajaxModel;
	}
	
	@RequestMapping(value="/**/siteMngr/siteInfo/modifyMngrInfoForm.do")
	public String modifyMngrInfoForm(
            @ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
            , @ModelAttribute("mngrAuthVO") MngrAuthVO mngrAuthVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
	    
		SysMngrUsrInfoVO infoVO = usrInfoService.selectUsrInfoDetail(paramVO);
		
		model.addAttribute("infoVO", infoVO);
		
		List<SiteUsrGroupVO> usrGroupList = siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq());
		
		model.addAttribute("usrGroupList", usrGroupList);
        
        // 회원유형 코드 목록
        List<CmmCodeVO> usrTyCdList = codeService.selectCmmCodeList("USR_TY_CODE");
        model.addAttribute("usrTyCdList", usrTyCdList);
        
        /** 사용자 유형 리스트 조회(SYSCODE) */
        List<CmmCodeVO> usrSttusList = codeService.selectCmmCodeList("USR_STTUS_CODE");
        model.addAttribute("usrSttusList", usrSttusList);
        
        //전화번호코드 목록 조회
        List<CmmCodeVO> hTelnoList = codeService.selectCmmCodeList("HTELCD");
        model.addAttribute("hTelnoList", hTelnoList);

        //휴대폰번호코드 목록 조회
        List<CmmCodeVO> mTelnoList = codeService.selectCmmCodeList("MTELCD");
        model.addAttribute("mTelnoList", mTelnoList);
        
        UsrTySbscrbFormVO sbsFormVO = new UsrTySbscrbFormVO();
        
        // 사이트 가입 필수 문항
        sbsFormVO.setGrpcode("MBER_SBSCRB_FORM");
        sbsFormVO.setCode(infoVO.getUsrTyCode());
        
        List<UsrTySbscrbFormVO> sbsFormList = usrTySbscrbFormService.selectUsrTySbscrbFormList(sbsFormVO);
        model.addAttribute("sbsFormList", sbsFormList);
        
        String nAdminUsrtySeq=  EgovProperties.getProperty("Globals.login.auth.normalAdmin");
        model.addAttribute("nAdminUsrtySeq", nAdminUsrtySeq);
        String sAdminUsrtySeq=  EgovProperties.getProperty("Globals.login.auth.superAdmin");
        model.addAttribute("sAdminUsrtySeq", sAdminUsrtySeq);
        
        if (CmmSessionUtil.getSessionSysMngrAt(request) || Globals.AUTH_NORMAL_ADMIN.equals(infoVO.getUsrtySeq())) {
            mngrAuthVO.setSiteSeq(infoVO.getSiteSeq());
            mngrAuthVO.setUsrSeq(infoVO.getUsrSeq());
           // model.addAttribute("mngrAuthList", mngrAuthService.selectMngrConAuthList(mngrAuthVO));
    		SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
    		siteMngrMenuVO.setSiteSeq(infoVO.getSiteSeq());
    		siteMngrMenuVO.setUsrSeq(infoVO.getUsrSeq());
            model.addAttribute("mngrMenuList", siteMngrMenuService.selectSiteMenuMngrList(siteMngrMenuVO));
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
		if(!usrlogParam.equals("")){
		usrlogParam = usrlogParam.substring(1);
		}
  	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
  	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
  	siteUsrLogVO.setConectIp(request.getRemoteAddr());
  	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
  	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
  	siteUsrLogVO.setUsrChngCode("SC00000451"); 
  	siteUsrLogVO.setUsrlogParam(usrlogParam);
  	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
  	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
  	siteUsrLogVO.setUsrSeq(infoVO.getUsrSeq());
  	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);

		return "wzwg/sysMngr/siteMngr/siteInfo/mngrInfoModifyForm";
		
	}
}


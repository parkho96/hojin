package egovframework.wzwg.site.mngr.cmnt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;
import egovframework.wzwg.module.cmnt.service.CmntMenuService;
import egovframework.wzwg.module.cmnt.service.CmntMenuVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;

@Controller
public class SiteCmntInfoController {
	
	@Resource(name="SiteCmntInfoService")
	private SiteCmntInfoService siteCmntInfoService;
	  
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
	
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;
	
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="SysMngrUsrInfoService")
	private SysMngrUsrInfoService usrInfoService;
	
   @Resource(name="CmntMenuService")
   	private CmntMenuService cmntMenuService;
    
    @Resource(name="ModuleBbsUnityBassInfoService")
   	private ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    @Resource(name="CmntMenuAuthService")
  	private CmntMenuAuthService cmntMenuAuthService;
      
    
    @RequestMapping(value={"/**/cmnt/info/selectCmntInfoList.do","/{siteKey}/**/cmnt/info/selectCmntInfoList.do"})
	public String selectCmntInfoList (
		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		 
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 사이트 정보 목록
		int resultCnt = siteCmntInfoService.selectSiteCmntInfoCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt);
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("resultList", siteCmntInfoService.selectSiteCmntInfoList(paramVO));
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paramVO", paramVO);
		model.addAttribute("cmntApprovalCodeList", codeService.selectCodeInfoList("CMNT_APPROVAL_CODE"));
		model.addAttribute("usrgroupList", siteUsrGroupService.selectSiteUsrGroupCode(siteSeq));
		return "wzwg/site/mngr/cmnt/cmntInfoList";
	}
    
    @RequestMapping(value={"/**/cmnt/info/registCmntInfoForm.do","/{siteKey}/**/cmnt/info/registCmntInfoForm.do"})
   	public String registCmntInfoForm (
   		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
   		model.addAttribute("cmntOpenCodeList", codeService.selectCodeInfoList("CMNT_OPEN_CODE"));
   		return "wzwg/site/mngr/cmnt/cmntInfoForm";
   	}
    
    @RequestMapping(value="/**/cmnt/info/registCmntInfoMngr.do")
   	public String registCmntInfoMngr (
   		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
   		String cmntSeq  = siteCmntInfoService.selectSiteCmntSeq(paramVO);
   		paramVO.setCmntSeq(cmntSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setFrstRegisterId(loginVO.getUserId());
   		siteCmntInfoService.registSiteCmntInfo(paramVO);
   		paramVO.setCmntApprovalCode("SC00000339");
   		siteCmntInfoService.modifySiteCmntInfoApproval(paramVO);
   		
   		CmntMenuAuthVO cmntMenuAuthVO = new CmntMenuAuthVO();
		
   		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
   		moduleBbsVO.setBbsNm("공지사항");
   		moduleBbsVO.setBbsDc("공지사항");
   		moduleBbsVO.setListScrinCode("L");
   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
   		moduleBbsVO.setCmntUseAt("Y");
   		moduleBbsVO.setAtchFilePosblAt("Y");
   		moduleBbsVO.setAtchFilePosblCo("3");
   		moduleBbsVO.setListNumCode("P");
	   	String bbs_seq =bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
	   	CmntMenuVO cmntMenuVO = new CmntMenuVO();
	   	cmntMenuVO.setMenuSeq(cmntMenuService.selectCmntMenuSeq());
   		cmntMenuAuthVO.setMenuSeq(cmntMenuVO.getMenuSeq());
	   	cmntMenuVO.setBbsSeq(bbs_seq);
	   	cmntMenuVO.setMenuOrdr("1");
	   	cmntMenuVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
	   	cmntMenuVO.setSiteSeq(siteSeq);
	   	cmntMenuVO.setCmntSeq(String.valueOf(cmntSeq));
	   	cmntMenuVO.setMenuNm("공지사항");
	   	cmntMenuAuthVO.setSiteSeq(siteSeq);
	   	cmntMenuAuthVO.setCmntSeq(String.valueOf(cmntSeq));
		cmntMenuService.registCmntMenu(cmntMenuVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000339");
   		cmntMenuAuthVO.setAuthSe("C");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000339");
   		cmntMenuAuthVO.setAuthSe("R");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000340");
   		cmntMenuAuthVO.setAuthSe("C");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000340");
   		cmntMenuAuthVO.setAuthSe("R");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO); 
   		return "redirect:"+wzwgContext+"/mngr/cmnt/info/selectCmntInfoList.do";
   	}
    
	@RequestMapping(value="/**/cmnt/info/selectCmntInfoExgistAjax.do")
	public ModelAndView selectCmntInfoExgistAjax(
		@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		ModelAndView model = new ModelAndView();
    	model.setViewName("jsonView"); 
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
    	model.addObject("result", siteCmntInfoService.selectSiteCmntInfoNm(paramVO));
        model.addObject("paramVO", paramVO);
		return model;
	}
	
	
	@RequestMapping(value="/**/cmnt/info/searchCmntMngrAjax.do")
	public String selectUsrInfoList(
			@ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(5);
        paginationInfo.setPageSize(5);
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
        
		// 사이트 정보 카운트
		Integer usrInfoCnt = usrInfoService.selectUsrInfoListCnt(paramVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = usrInfoService.selectUsrInfoList(paramVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
        
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
		
		return "wzwg/site/mngr/cmnt/searchCmntMngr";
	}
	
	@RequestMapping(value={"/**/cmnt/info/selectCmntInfo.do","/{siteKey}/**/cmnt/info/selectCmntInfo.do"})
   	public String selectCmntInfo (
   		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
   	 	
   	   SiteCmntInfoVO resultVO =  siteCmntInfoService.selectSiteCmntInfo(paramVO);
   	   model.addAttribute("resultVO", resultVO);
   		model.addAttribute("cmntApprovalCodeList", codeService.selectCodeInfoList("CMNT_APPROVAL_CODE"));
   		model.addAttribute("cmntOpenCodeList", codeService.selectCodeInfoList("CMNT_OPEN_CODE"));
   		return "wzwg/site/mngr/cmnt/cmntInfo";
   	}
	
	@RequestMapping(value="/**/cmnt/info/modifyCmntInfoMngr.do")
   	public String modifyCmntInfoMngr (
   		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setLastUpdusrId(loginVO.getUserId());
   		siteCmntInfoService.modifySiteCmntInfoApproval(paramVO);
   		return "redirect:"+wzwgContext+"/mngr/cmnt/info/selectCmntInfoList.do";
   	}
	
	@RequestMapping(value="/**/cmnt/info/deleteCmntInfoMngr.do")
   	public String deleteCmntInfoMngr (
   		@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setLastUpdusrId(loginVO.getUserId());
   		siteCmntInfoService.deleteSiteCmntInfo(paramVO);
   		return "redirect:"+wzwgContext+"/mngr/cmnt/info/selectCmntInfoList.do";
   	}
	
	@RequestMapping(value="/**/cmnt/info/allApprovalCmntMngrAjax.do")
   	public ModelAndView allApprovalCmntMngrAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setLastUpdusrId(loginVO.getUserId());
   		if(paramVO.getChkAppvlArr() !=null){
   			for(int i =0;i<paramVO.getChkAppvlArr().length;i++){
   				paramVO.setCmntSeq(paramVO.getChkAppvlArr()[i]);
   				siteCmntInfoService.modifySiteCmntInfoApproval(paramVO);
   			}
   		}
   		return model;
   	}
	
		@RequestMapping(value="/**/cmnt/info/modifySiteCmntOrdrAjax.do")
    public String modifySiteCmntOrdrAjax(
            @ModelAttribute("paramVO") SiteCmntInfoVO paramVO
            , HttpServletRequest request
            , Model model ) throws Exception {
        
    	CmmLoginVO loginVO = (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setLastUpdusrId(loginVO.getUserId());
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        int result = siteCmntInfoService.modifySiteCmntOrdr(paramVO);
        
        if(result > 0)
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        else
            return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
    }
	
}

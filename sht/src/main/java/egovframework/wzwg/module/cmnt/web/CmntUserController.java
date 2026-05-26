package egovframework.wzwg.module.cmnt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.cmnt.service.CmntUserService;
import egovframework.wzwg.module.cmnt.service.CmntUserVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Controller
public class CmntUserController {
	 
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="SiteCmntInfoService")
	private SiteCmntInfoService siteCmntInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService; 

    @Resource(name="CmntUserService")
	private CmntUserService cmntUserService;
    
	
    @RequestMapping(value= {"/module/cmnt/usr/{cmntSeq}","/{siteKey}/module/cmnt/usr/{cmntSeq}"})
    public String selectCmntMain(
    		@PathVariable(value = "cmntSeq") String cmntSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	SiteCmntInfoVO paramVO = new SiteCmntInfoVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq); 
			paramVO.setCmntSeq(cmntSeq); 
			model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		 	model.addAttribute("provision", siteCmntInfoService.selectSiteCmntInfoProvision(paramVO));
		return "wzwg/module/cmnt/cmntUsr";
    }

	
	@RequestMapping(value= {"/module/cmnt/usr/templt/{cmntSeq}","/{siteKey}/module/cmnt/usr/templt/{cmntSeq}"})
	public String selectCmntMainTemplt(
			@PathVariable(value = "cmntSeq") String cmntSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		SiteCmntInfoVO paramVO = new SiteCmntInfoVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq); 
			paramVO.setCmntSeq(cmntSeq); 
			model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		 	model.addAttribute("provision", siteCmntInfoService.selectSiteCmntInfoProvision(paramVO));
		return "wzwg/module/cmnt/cmntUsr";
	}
	
	@RequestMapping(value= {"/module/cmnt/selectCmntUserProvisionFormAjax.do","/{siteKey}/module/cmnt/selectCmntUserProvisionFormAjax.do"})
	public String selectCmntUserProvisionFormAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		model.addAttribute("provision", siteCmntInfoService.selectSiteCmntInfoProvision(paramVO));
		return "wzwg/module/cmnt/cmntProvision";
	}
	
	@RequestMapping(value= {"/module/cmnt/selectCmntUserRegistFormAjax.do","/{siteKey}/module/cmnt/selectCmntUserRegistFormAjax.do"})
	public String selectCmntUserRegistFormAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		return "wzwg/module/cmnt/cmntUserRegist";
	}
	
	@RequestMapping(value= {"/module/cmnt/selectCmntUsrRegistAjax.do","/{siteKey}/module/cmnt/selectCmntUsrRegistAjax.do"})
	public ModelAndView selectCmntUserRegistAjax(
			@ModelAttribute("paramVO") CmntUserVO paramVO
			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   	 	CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		paramVO.setUsrSeq(loginVO.getUsrSeq());
		cmntUserService.registCmntUser(paramVO);
		SiteCmntInfoVO siteCmntInfo = new SiteCmntInfoVO();
		siteCmntInfo.setSiteSeq(siteSeq);
		siteCmntInfo.setCmntSeq(paramVO.getCmntSeq());
		SiteCmntInfoVO siteCmntInfoVO =	siteCmntInfoService.selectSiteCmntInfo(siteCmntInfo);
		if(siteCmntInfoVO.getCmntAppvlCode().equals("SC00000335")){
			paramVO.setApprvlCode("SC00000339");
			cmntUserService.apprvlCmntUser(paramVO);
		}
		return model;
	}
	
	
	@RequestMapping(value={"/cmnt/mngr/selectCmntUserMngrAjax.do","/{siteKey}/cmnt/mngr/selectCmntUserMngrAjax.do"})
	public String selectCmntUserMngrAjax(
			@ModelAttribute("paramVO") CmntUserVO paramVO
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
		int usrCnt = cmntUserService.selectCmntUserTotCnt(paramVO);
		
		// 사용자 정보 목록
		List<CmntUserVO> usrList = cmntUserService.selectCmntUserList(paramVO);
		
		paginationInfo.setTotalRecordCount(usrCnt);
        
		model.addAttribute("paramVO", paramVO);
		model.addAttribute("usrInfoCnt", usrCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrList);
		model.addAttribute("approvalCodeList", codeService.selectCodeInfoList("CMNT_APPROVAL_CODE"));
		return "wzwg/module/cmnt/cmntUserMngrList";
	}
	
	@RequestMapping(value= {"/cmnt/mngr/allApprovalCmntUserMngrAjax.do","/{siteKey}/cmnt/mngr/allApprovalCmntUserMngrAjax.do"})
   	public ModelAndView allApprovalCmntUserMngrAjax (
   			@ModelAttribute("paramVO")CmntUserVO paramVO
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
   				paramVO.setUsrSeq(paramVO.getChkAppvlArr()[i]);
   				cmntUserService.apprvlCmntUser(paramVO);
   			}
   		}
   		return model;
   	}
	
	@RequestMapping(value= {"/cmnt/mngr/allDeleteCmntUserMngrAjax.do","/{siteKey}/cmnt/mngr/allDeleteCmntUserMngrAjax.do"})
   	public ModelAndView allDeleteCmntUserMngrAjax (
   			@ModelAttribute("paramVO")CmntUserVO paramVO
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
   				paramVO.setUsrSeq(paramVO.getChkAppvlArr()[i]);
   				cmntUserService.deleteCmntUser(paramVO);
   			}
   		}
   		return model;
   	}
	
	@RequestMapping(value= {"/cmnt/mngr/modifyApprovalCmntUserMngrAjax.do","/{siteKey}/cmnt/mngr/modifyApprovalCmntUserMngrAjax.do"})
   	public ModelAndView modifyApprovalCmntUserMngrAjax (
   			@ModelAttribute("paramVO")CmntUserVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setLastUpdusrId(loginVO.getUserId()); 
   		
   		if(paramVO.getUsrSeqArr() !=null){
   			for(int i =0;i<paramVO.getUsrSeqArr().length;i++){
   				paramVO.setUsrSeq(paramVO.getUsrSeqArr()[i]);
   				paramVO.setApprvlCode(paramVO.getApprvlCodeArr()[i]);
   				cmntUserService.apprvlCmntUser(paramVO);
   			}
   		}
   		return model;
   	}
	
}

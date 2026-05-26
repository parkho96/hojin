package egovframework.wzwg.sysMngr.usrMngr.usrTy.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class SysMngrUsrTyController {
	
	@Resource(name="SysMngrUsrTyService")
	private SysMngrUsrTyService sysMngrUsrTyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
    
    @Resource(name="UsrTySbscrbFormService")
    private UsrTySbscrbFormService usrTySbscrbFormService;
    
    @Resource(name="SysMngrSbscrbInfoService")
    private SysMngrSbscrbInfoService sbscrbInfoService;
    
    @Resource(name="SiteUsrGroupService")
    private SiteUsrGroupService siteUsrGroupService;
    
	/**
	 * 사용자 유형 리스트조회
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrTy/selectUsrTyList.do","/{siteKey}/mngr/usrMngr/usrTy/selectUsrTyList.do"})
	public String selectUsrTyList(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, HttpServletRequest request
			, Model model){
	    
        sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

        /** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(sysMngrUsrTyVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sysMngrUsrTyVO.getPageUnit());
        paginationInfo.setPageSize(sysMngrUsrTyVO.getPageSize());
       
        sysMngrUsrTyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        sysMngrUsrTyVO.setLastIndex(paginationInfo.getLastRecordIndex());
        sysMngrUsrTyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = sysMngrUsrTyService.selectSysMngrUsrTyTotCnt(sysMngrUsrTyVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
				
		List<SysMngrUsrTyVO> usrTyList = sysMngrUsrTyService.selectUsrTyList(sysMngrUsrTyVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("usrTyList", usrTyList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/usrMngr/usrTy/UsrTyList";
		
	}
	
	/**
	 * 사용자 유형 등록 폼
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrTy/registUsrTyForm.do","/{siteKey}/mngr/usrMngr/usrTy/registUsrTyForm.do"})
	public String registUsrTyForm(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, HttpServletRequest request
			, Model model) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	    
		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("USR_TY_CODE");
		model.addAttribute("codeList", codeList);
        
        /** 사용자 그룹 */
        List<SiteUsrGroupVO> groupList = siteUsrGroupService.selectSiteUsrGroupCode(siteSeq);
        model.addAttribute("groupList", groupList);
		
		return "wzwg/sysMngr/usrMngr/usrTy/UsrTyRegistForm";
		
	}
	
	/**
	 * 사용자 등록 (DB입력)
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */ 
	@RequestMapping(value= {"/mngr/usrMngr/usrTy/registUsrTy.do","/{siteKey}/mngr/usrMngr/usrTy/registUsrTy.do"})
	public ModelAndView registUsrTy(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, @ModelAttribute("sbscrbVO")SysMngrSbscrbVO siteSbscrbVO
			, HttpServletRequest request
			, Model model) throws Exception {
		
		sysMngrUsrTyVO.setUserId(CmmSessionUtil.getSessionUserId());
		sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		int registResult = sysMngrUsrTyService.registUsrTy(sysMngrUsrTyVO, siteSbscrbVO);
		
        return CmmAjaxUtil.getAjaxReturnCmmMap(registResult);
		
	}

	/**
	 * 사용자 유형 상세조회
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrTy/selectUsrTyDetail.do","/{siteKey}/mngr/usrMngr/usrTy/selectUsrTyDetail.do"})
	public String selectUsrTyDetail(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, HttpServletRequest request
			, Model model){
	    
        sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		sysMngrUsrTyVO = sysMngrUsrTyService.selectUsrTyDetail(sysMngrUsrTyVO);
		model.addAttribute("sysMngrUsrTyVO", sysMngrUsrTyVO);
		
		return "wzwg/sysMngr/usrMngr/usrTy/UsrTyDetail";
		
	}

	/**
	 * 사용자 유형 수정 폼
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrTy/modifyUsrTyForm.do","/{siteKey}/mngr/usrMngr/usrTy/modifyUsrTyForm.do"})
	public String modifyUsrTyForm(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, HttpServletRequest request
			, Model model) throws Exception{
	    
	    String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	    
        sysMngrUsrTyVO.setSiteSeq(siteSeq);
		
		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("USR_TY_CODE");
		model.addAttribute("codeList", codeList);

		sysMngrUsrTyVO = sysMngrUsrTyService.selectUsrTyDetail(sysMngrUsrTyVO);
		model.addAttribute("sysMngrUsrTyVO", sysMngrUsrTyVO);
        
        /** 사용자 그룹 */
        List<SiteUsrGroupVO> groupList = siteUsrGroupService.selectSiteUsrGroupCode(siteSeq);
        model.addAttribute("groupList", groupList);
		
		return "wzwg/sysMngr/usrMngr/usrTy/UsrTyModifyForm";
		
	}
	
	/**
	 * 사용자 유형 수정 (DB입력)
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrTy/modifyUsrTy.do","/{siteKey}/mngr/usrMngr/usrTy/modifyUsrTy.do"})
	public ModelAndView modifyUsrTy(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
            , @ModelAttribute("sbscrbVO")SysMngrSbscrbVO siteSbscrbVO
			, HttpServletRequest request
			, Model model) throws Exception {
        
        sysMngrUsrTyVO.setUserId(CmmSessionUtil.getSessionUserId());
        sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		int modifyResult = sysMngrUsrTyService.modifyUsrTy(sysMngrUsrTyVO, siteSbscrbVO);
		
        return CmmAjaxUtil.getAjaxReturnCmmMap(modifyResult);
	}
	
	/**
	 * 사용자 유형 삭제 (USE_AT = 'N'으로 변경)
	 * @param sysMngrUsrTyVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrTy/deleteUsrTy.do","/{siteKey}/mngr/usrMngr/usrTy/deleteUsrTy.do"})
	public ModelAndView deleteUsrTy(
			@ModelAttribute("paramVO")SysMngrUsrTyVO sysMngrUsrTyVO
			, HttpServletRequest request
			, Model model){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		sysMngrUsrTyVO.setUserId(loginVO.getUserId());
		sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		int deleteResult = sysMngrUsrTyService.deleteUsrTy(sysMngrUsrTyVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
		
	}
    
    /**
     * 사용자 유형 리스트조회
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value={"/mngr/usrMngr/usrTy/selectUsrTySbscrbFormList.do","/{siteKey}/mngr/usrMngr/usrTy/selectUsrTySbscrbFormList.do"})
    public String selectUsrTySbscrbFormList(
            @ModelAttribute("paramVO") UsrTySbscrbFormVO paramVO
            , @ModelAttribute("sysMngrUsrTyVO") SysMngrUsrTyVO sysMngrUsrTyVO
            , HttpServletRequest request
            , Model model) throws Exception{
        
        paramVO.setGrpcode("MBER_SBSCRB_FORM");
        
        List<UsrTySbscrbFormVO> resultList = usrTySbscrbFormService.selectUsrTySbscrbFormList(paramVO);
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultVO", paramVO);
        
        return "wzwg/sysMngr/usrMngr/usrTy/usrTySbscrbForm";
    }
    
    /**
     * 사이트회원가입양식 수정
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value={"/mngr/usrMngr/usrTy/modifySiteUsrTySbscrb.do","/{siteKey}/mngr/usrMngr/usrTy/modifySiteUsrTySbscrb.do"})
    public ModelAndView modifySiteUsrTySbscrb(
            @ModelAttribute("SysMngrSbscrbVO") SysMngrSbscrbVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        String userId = CmmSessionUtil.getSessionUserId();
        
        paramVO.setFrstRegisterId(userId);
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        int result = sbscrbInfoService.modifySiteUsrTySbscrb(paramVO);   // 수정
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    /**
     * 사이트회원가입양식 수정
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value={"/mngr/usrMngr/usrTy/selectSiteUsrTySbscrb.do","/{siteKey}/mngr/usrMngr/usrTy/selectSiteUsrTySbscrb.do"})
    public ModelAndView selectSiteUsrTySbscrb(
            @ModelAttribute("paramVO") SysMngrUsrTyVO paramVO
            , HttpServletRequest request) throws Exception {
        
        List<SysMngrUsrTyVO> resultList = sysMngrUsrTyService.selectSiteUsrTySbscrb(paramVO);   // 수정

        ModelAndView model = new ModelAndView();
        
        model.setViewName("jsonView");
        model.addObject("resultList", resultList);
        
        return model;
    }
	
}

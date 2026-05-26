package egovframework.wzwg.site.mngr.cntnts.cntntsInfo.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;

@Controller
public class CntntsInfoController {
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
    
    @Resource(name="SiteMenuService")
    private SiteMenuService menuService;
	
	@Resource(name="SysModuleInfoService")
	private SysModuleInfoService moduleInfoService;
	
	@Autowired
	HttpServletRequest req;

	/**
	 * ㅁ 모듈 전체 목록
	 * @param ApiVO
	 * @return
	 */
	@ModelAttribute("moduleAllList")
	private List<SysModuleInfoVO> selectModuleAllList() throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(req); 
		return moduleInfoService.selectSysModuleInfoAllList(siteSeq);
	}

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록
	 * @param ApiVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntntsInfo/selectCntntsInfoList.do","/{siteKey}/**/cntnts/cntntsInfo/selectCntntsInfoList.do"})
	public String selectCntntsInfoListList (
		@ModelAttribute("paramVO") CntntsInfoVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		String defaultOrdr = StringUtils.defaultString(paramVO.getFrstRegistPnttmOrdr());
		
		// 기본정렬 셋팅
		if ("".equals(defaultOrdr)) {
		    paramVO.setFrstRegistPnttmOrdr("D");
		}
		
		List<CntntsInfoVO> siteSubCntntsInfoList = cntntsInfoService.selectCntntsInfoList(paramVO);
		
		// 사이트 정보 목록
		Integer resultCnt = cntntsInfoService.selectCntntsInfoListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
		SiteMenuVO menuParamVO = new SiteMenuVO();
		menuParamVO.setSiteSeq(siteSeq);
		
		//HashMap<String, String> menuPathList = menuService.selectSiteMenuPathList(menuParamVO);
		List<SiteMenuVO> menuPathList = menuService.selectSiteMenuPathList(menuParamVO);
		
		HashMap<String, String> menuPathCheckMap = new HashMap<String, String>();
        

        if (!menuPathList.isEmpty()) {
            
            for (int i=0; i<menuPathList.size(); i++) {
                SiteMenuVO getVO = menuPathList.get(i);
                
                String menuPath = StringUtils.defaultString(menuPathCheckMap.get(getVO.getSitecntntsSeq()));
                
                menuPath = ("".equals(menuPath))? getVO.getMenuNmPath():menuPath+","+getVO.getMenuNmPath();
                
                menuPathCheckMap.put(getVO.getSitecntntsSeq(), menuPath);
            }
        }
		
		model.addAttribute("resultList", siteSubCntntsInfoList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("menuPathList", menuPathList);
		model.addAttribute("menuPathCheck", menuPathCheckMap);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/site/mngr/cntnts/cntntsInfo/cntntsInfoList";
	}

//    /**
//     * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 등록/수정 폼
//     * @param CntntsInfoVO
//     * @return
//     */
//    @RequestMapping(value="/mngr/cntnts/cntntsInfo/cntntsInfoForm.do")
//    public String selectcntntsInfoForm (
//        @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
//        , HttpServletRequest request
//        , Model model ) throws Exception {
//        
//        SysMngrSysModuleInfoVO moduleVO = new SysMngrSysModuleInfoVO();
//        moduleVO.setSysmoduleSeq(paramVO.getSysmoduleSeq());
//        
//        moduleVO = moduleInfoService.selectSysModuleInfoDetail(moduleVO);
//
//        String mdVoNm = StringUtils.defaultString(moduleVO.getModuleVo());
//        
//        if ("".equals(mdVoNm)) {
//            // 패키지 클래스가 존재하지 않을때 에러
//            model.addAttribute("message", egovMessageSource.getMessage("module.no.such.pckage"));
//            model.addAttribute("retUrl", "/mngr/cntnts/cntntsInfo/cntntsInfoList.do");
//            
//            return "dggb/cmm/retPage/errorForward";
//        }
//        
//        model.addAttribute("moduleVO", moduleVO);
//        model.addAttribute("cntntsInfoVO", paramVO);
//        model.addAttribute("paramVO", paramVO);
//        
//        return "redirect:/mngr/cntnts/module/bbs/unity/selectBbsInc.do";
//    }

//  /**
//   * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 등록/수정 폼
//   * @param CntntsInfoVO
//   * @return
//   */
//  @RequestMapping(value="/mngr/cntnts/cntntsInfo/cntntsInfoForm.do")
//  public String selectcntntsInfoForm (
//      @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
//      , HttpServletRequest request
//      , Model model ) throws Exception {
//      
//      SysMngrSysModuleInfoVO moduleVO = new SysMngrSysModuleInfoVO();
//      moduleVO.setSysmoduleSeq(paramVO.getSysmoduleSeq());
//      
//      moduleVO = moduleInfoService.selectSysModuleInfoDetail(moduleVO);
//
//      String mdVoNm = StringUtils.defaultString(moduleVO.getModuleVo());
//      
//      if ("".equals(mdVoNm)) {
//          // 패키지 클래스가 존재하지 않을때 에러
//          model.addAttribute("message", egovMessageSource.getMessage("module.no.such.pckage"));
//          model.addAttribute("retUrl", "/mngr/cntnts/cntntsInfo/cntntsInfoList.do");
//          
//          return "dggb/cmm/retPage/errorForward";
//      }
//
//      try {
//          Class voClass = Class.forName(mdVoNm);
//          Object voObj = voClass.newInstance();
//          
//          model.addAttribute("resultVO", voObj);
//      } catch (Exception e) {
//          e.printStackTrace();
//          // 패키지 클래스가 존재하지 않을때 에러
//          model.addAttribute("message", egovMessageSource.getMessage("module.no.such.pckage"));
//          model.addAttribute("retUrl", "/mngr/cntnts/cntntsInfo/cntntsInfoList.do");
//          
//          return "dggb/cmm/retPage/errorForward";
//      }
//      
//      model.addAttribute("moduleVO", moduleVO);
//      model.addAttribute("cntntsInfoVO", paramVO);
//      model.addAttribute("paramVO", paramVO);
//
//      return "wzwg/site/mngr/cntnts/cntntsInfo/cntntsInfoForm";
//  }
	  
    /**
     * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 등록/수정 폼
     * @param ApiVO
     * @return
     */
    @RequestMapping(value={"/**/cntnts/cntntsInfo/selectCntntsInfoForm.do","/{siteKey}/**/cntnts/cntntsInfo/selectCntntsInfoForm.do"})
    public String selectcntntsInfoForm (
        @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        SysModuleInfoVO moduleVO = new SysModuleInfoVO();
        
        // 등록 대상 모듈
        String srhModuleSeq = StringUtils.defaultString(paramVO.getSysmoduleSeq());
        
        srhModuleSeq = ("".equals(srhModuleSeq))? Globals.BASE_MODULE_SEQ:srhModuleSeq; 
        
        moduleVO.setSysmoduleSeq(srhModuleSeq);
        
        moduleVO = moduleInfoService.selectSysModuleInfoDetail(moduleVO);
  
        String mdVoNm = StringUtils.defaultString(moduleVO.getModuleVo());
        
        if ("".equals(mdVoNm)) {
            // 패키지 클래스가 존재하지 않을때 에러
            model.addAttribute("message", egovMessageSource.getMessage("module.no.such.pckage"));
            model.addAttribute("retUrl", "/mngr/cntnts/cntntsInfo/cntntsInfoList.do");
            
            return "dggb/cmm/retPage/errorForward";
        }
//  
//        try {
//            Class voClass = Class.forName(mdVoNm);
//            Object voObj = voClass.newInstance();
//            
//            model.addAttribute("resultVO", voObj);
//        } catch (Exception e) {
//            e.printStackTrace();
//            // 패키지 클래스가 존재하지 않을때 에러
//            model.addAttribute("message", egovMessageSource.getMessage("module.no.such.pckage"));
//            model.addAttribute("retUrl", "/mngr/cntnts/cntntsInfo/cntntsInfoList.do");
//            
//            return "dggb/cmm/retPage/errorForward";
//        }
        
        model.addAttribute("moduleVO", moduleVO);
        model.addAttribute("cntntsInfoVO", paramVO);
        model.addAttribute("paramVO", paramVO);
  
        return "wzwg/site/mngr/cntnts/cntntsInfo/cntntsInfoForm";
    }

    /**
     * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 등록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/cntnts/cntntsInfo/registCntntsInfo.do")
    public ModelAndView registBbsBassInfo (
            @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        String cntntsSeq = "";
        
        String moduleTyCode = StringUtils.defaultString(paramVO.getModuleTyCode());
        
        if (Globals.API_MODULE_TY_CODE.equals(moduleTyCode)) {

            // 이전에 모듈 정보가 등록되지 않았으면 실패
            cntntsSeq = CmmSessionUtil.getSessionSiteSeq(request);
        } else {
            // 이전에 모듈 정보가 등록되지 않았으면 실패
            cntntsSeq = CmmSessionUtil.getSessionValue(request, "regist_sysModuleSeq");
        }
        
        if ("".equals(cntntsSeq)) {
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
        
        Integer result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        paramVO.setCntntsSeq(cntntsSeq); 
        if (loginVO != null) {
            paramVO.setFrstRegisterId(loginVO.getUserId());
        }
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        result = cntntsInfoService.registCntntsInfoDefaultAuth(paramVO);    // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }

    /**
     * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 삭제
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/cntnts/cntntsInfo/deleteCntntsInfo.do")
    public ModelAndView deleteCntntsInfo (
            @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        Integer result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if (loginVO != null) {
            paramVO.setLastUpdusrId(loginVO.getUserId());
        }
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        result = cntntsInfoService.deleteCntntsInfo(paramVO);    // 삭제
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }

    /**
     * ㅁ 컨텐츠정보 폼 - 컨텐츠 정보 삭제
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/cntnts/cntntsInfo/deleteCntntsInfoArr.do")
    public ModelAndView deleteCntntsInfoArr (
            @ModelAttribute("cntntsInfoVO") CntntsInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        Integer result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if (loginVO != null) {
            paramVO.setLastUpdusrId(loginVO.getUserId());
        }
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        result = cntntsInfoService.deleteCntntsInfoArr(paramVO);    // 삭제
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
    
    
    
    
    
    /**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록
	 * @param ApiVO
	 * @return
	 */
	@RequestMapping(value={"/**/cntnts/cntntsInfo/selectCntntsInfoDashboard.do","/{siteKey}/**/cntnts/cntntsInfo/selectCntntsInfoDashboard.do"})
	public String selectCntntsInfoDashboard (
		@ModelAttribute("paramVO") CntntsInfoVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		List<CntntsInfoVO> dashboardList = cntntsInfoService.selectCntntsDashboardCnt(paramVO);
		
		Map<String, CntntsInfoVO> moduleCntMap = new HashMap<>();
		
        for (CntntsInfoVO vo : dashboardList) {
            moduleCntMap.put(vo.getModuleKey(), vo);
        }
		
		model.addAttribute("moduleCntMap", moduleCntMap);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/site/mngr/cntnts/cntntsInfo/cntntsInfoDashboard";
	}
    
}

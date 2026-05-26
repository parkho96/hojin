package egovframework.wzwg.module.cntntsEditor.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsBassInfoService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsCnService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutService;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;

@Controller
public class ModuleCntntsEditorCnController {
	@Resource(name="ModuleCntntsCnService")
	ModuleCntntsCnService moduleCntntsCnService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	@Resource(name="SiteLayoutService")
    private SiteLayoutService siteLayoutService;
	
    /** 사이트 메뉴 **/
    @Resource(name="SiteMenuService")
    private SiteMenuService siteMenuService;
    
    @Resource(name="ModuleCntntsBassInfoService")
	ModuleCntntsBassInfoService moduleCntntsBassInfoService;
    
    @Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
    
    
    /** 사이트 메뉴 **/
    
    @Resource(name="SysModuleInfoService")
	private SysModuleInfoService sysModuleInfoService;
    
    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
    
    
	/**
	 * 컨텐츠 데이터 리스트
	 */
	@RequestMapping(value="/**/module/cntntsEditor/selectCntntsCnListAjax.do")
	public String selectCntntsCnListAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
        /** =================== paging 시작 ============================== */
		/*PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = moduleCntntsCnService.selectCntntsCnTotCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt);*/
		
        /** =================== paging 끝 =============================== */
		
		/** 컨텐츠 리스트를 나눠서 적용.
		 *  첫번째 인덱스(0) 따로, 나머지 리스트 따로 출력한다. */
		List<ModuleCntntsVO> cntntsCnList = moduleCntntsCnService.selectModuleCntntsCnList(paramVO);

		//if(!(cntntsCnList.size() == 0)){
		//	ModuleCntntsVO resultVO = cntntsCnList.get(0);
		//	cntntsCnList.remove(0);
		//	model.addAttribute("resultVO",resultVO);
		//}
		
		model.addAttribute("cntntsCnList", cntntsCnList);
		/*model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);*/
		
//		return "wzwg/module/cntntsEditor/cn/cntntsEditorCnList";
		return "wzwg/module/cntntsEditor/screen/cntntsEditorCnList";
	}
	
	
	
	
	/**
	 * 관리자 - 컨텐츠에디터 폼
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/cntntsEditor/selectModuleCntntsEditorDecoAjax.do"})
	public String selectModuleCntntsEditorDecoAjax(
			@ModelAttribute("paramVO")SiteTemplateScreenVO paramVO
			, @ModelAttribute("mdCntntsVO") ModuleCntntsVO mdCntntsVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		paramVO.setSiteSeq(siteSeq);
		paramVO.setDomnSeq(domnSeq); 
		
		SiteTemplateScreenVO templateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(paramVO);
		
		SiteScreenVO siteScreenVO = new SiteScreenVO();
		siteScreenVO.setSiteSeq(siteSeq);
		siteScreenVO.setTemplateSeq(templateScreenVO.getTemplateSeq());
		
		/* 에디터 링크 편집을 위해서 메뉴리스트 호출 추가 */
		SiteMenuVO MenuVO = new  SiteMenuVO();
		MenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		MenuVO.setMngrSiteMenuSe("N");
		model.addAttribute("menuList", siteMenuService.selectSiteMenuList(MenuVO));
		
		String siteKey = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		SysModuleInfoVO moduleInfoVO = new SysModuleInfoVO();
		moduleInfoVO.setSysmoduleSeq("10000000240");
		moduleInfoVO = sysModuleInfoService.selectSysModuleInfoDetail(moduleInfoVO);
		model.addAttribute("subMainName", moduleInfoVO.getModuleNm());
		model.addAttribute("moduleInfoVO", moduleInfoVO);
		
		
		ModuleCntntsVO cntntnsInfoVO = moduleCntntsBassInfoService.selectCntntsBassInfoDetail(mdCntntsVO);
		model.addAttribute("cntntnsInfoVO", cntntnsInfoVO);
		
		//CntntsInfoVO cntntnsInfoVO = getSubHomeCntntsInfoVO(siteSeq);
		//model.addAttribute("cntntnsInfoVO", cntntnsInfoVO);
		
		
		//model.addAttribute("url", "/WEB-INF/jsp/kotra/module/subhome/kotrainfo/subhomeKotraInfo.jsp");
		model.addAttribute("url", "/WEB-INF/jsp/wzwg/module/cntntsEditor/screen/screenCntntsEditorDeco.jsp");
		model.addAttribute("subHomeCnUrl", siteKey + "/module/cntntsEditor/cntntsCnModuleEditorImport.do");
		//model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
		//model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/footerMenu.jsp");
		
		model.addAttribute("menuSeq", "dummy");
		
		
		String retUrl = "wzwg/module/cntntsEditor/screen/cntntsEditorScreenMngr";
		return retUrl;
	}
	
	/**
	 * 관리자 - 컨텐츠 에디터 편집화면 내용불러오기
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/cntntsEditor/cntntsCnModuleEditorImport.do"})
	public String cntntsCnModuleEditorImport(
			@ModelAttribute("paramVO")ModuleCntntsVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		if(!("").equals(paramVO.getCntntsCnSeq())){

			/** 사이트 시퀀스 입력 */
			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);
			
			ModuleCntntsVO cntntsVO = moduleCntntsCnService.selectModuleCntntsCnDetail(paramVO);
			model.addAttribute("cntntsVO", cntntsVO);
			
		}
		
		return "wzwg/module/cntntsEditor/screen/cntntnsCnEditor";
	}
	
	
	
	
	
	
	/**
	 * 컨텐츠 데이터 등록 폼
	 */
	@RequestMapping(value="/**/module/cntntsEditor/registModuleCntntsCnFormAjax.do")
	public String registModuleCntntsCnFormAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		String retUrl = "wzwg/module/cntntsEditor/cn/cntntsEditorCnForm";

		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		ModuleCntntsVO resultVO = moduleCntntsCnService.selectModuleCntntsCnDetail(paramVO);
		model.addAttribute("resultVO", resultVO);
		
		ModuleCntntsVO tmplatVO = moduleCntntsCnService.selectModuleCntntsCnTmplatDetail(paramVO);
		model.addAttribute("tmplatVO", tmplatVO);
		
		List<ModuleCntntsVO> cntntsCnList = moduleCntntsCnService.selectModuleCntntsCnList(paramVO);
		model.addAttribute("cntntsCnList",cntntsCnList);
		
		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		/* 2019.04.09 조원권 수정 1:기존 네이버에디터, 2:컨텐츠 에디터 */
		if("2".equals(paramVO.getCntntsVer())){
			retUrl = "wzwg/module/cntntsEditor/screen/cntntsEditorCnForm";
			
			/* 에디터 링크 편집을 위해서 메뉴리스트 호출 추가 */
			SiteMenuVO MenuVO = new  SiteMenuVO();
			MenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			MenuVO.setMngrSiteMenuSe("N");
			model.addAttribute("menuList", siteMenuService.selectSiteMenuList(MenuVO));
		}
		
//		return "wzwg/module/cntntsEditor/cn/cntntsEditorCnForm";
//		return "wzwg/module/cntntsEditor/screen/cntntsEditorCnForm";
		return retUrl;
	}

	/**
	 * 컨텐츠 데이터 등록 
	 */
	@RequestMapping(value="/**/module/cntntsEditor/registModuleCntntsCnAjax.do")
	public String registModuleCntntsCnAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

		int registResult = moduleCntntsCnService.registModuleCntntsCnAjax(paramVO);
		//registResult = moduleCntntsBassInfoService.modifyModuleCntntsTmplatAjax(paramVO); //선택한 컨텐츠 템플릿 저장은 추후 다시 구현
		
		
		
		if(registResult > 0){
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("cntntsCnSeq", paramVO.getCntntsCnSeq()).returnJsp(model);
		}else{
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
    
    /**
     * 컨텐츠 데이터 삭제 
     */
    @RequestMapping(value="/**/module/cntntsEditor/deleteModuleCntntsCnAjax.do")
    public ModelAndView deleteModuleCntntsCnAjax(
            @ModelAttribute("paramVO") ModuleCntntsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int deleteResult = moduleCntntsCnService.deleteModuleCntntsCnAjax(paramVO);
        
        if(deleteResult > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
    
    /**
     * 컨텐츠 내용 적용된 템플릿으로 초기화 
     */
    @RequestMapping(value="/**/module/cntntsEditor/registModuleCntntsCnTemplatInitAjax.do")
    public ModelAndView registModuleCntntsCnTemplatInitAjax(
            @ModelAttribute("paramVO") ModuleCntntsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{


        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setSiteSeq(siteSeq);
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = moduleCntntsCnService.registModuleCntntsCnTemplatInitAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("cntntsCnSeq", paramVO.getCntntsCnSeq()).returnModelAndView();
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnModelAndView();
        }
        /*if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }*/
    }
    
    
    //이하 컨텐츠 에디터 화면 관련 
    
    /**
     * 컨텐츠 레이아웃 팝업 호출
     */
    @RequestMapping(value="/**/module/cntntsEditor/screen/selectSiteLayoutAjax.do")
    public String selectSiteLayoutAjax(
    		@ModelAttribute("paramVO") ModuleCntntsVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
    	
    	
    	return "wzwg/module/cntntsEditor/screen/siteLayout";
    }
    
    /**
     * 컨텐츠 위젯 모듈 팝업
     */
    @RequestMapping(value="/**/module/cntntsEditor/screen/selectLayoutContentsPopupAjax.do")
	public String selectLayoutContentsPopupAjax(
			@ModelAttribute("paramVO")SiteLayoutVO paramVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
		//paramVO.setCategory("board");
		if("100".equals(paramVO.getWidth())){
			paramVO.setHeight("");
		}
		List<SiteLayoutVO> contentsList = siteLayoutService.selectLayoutContentsList(paramVO);
		model.addAttribute("contentsList", contentsList);
		
		if("100".equals(paramVO.getWidth())){
			paramVO.setHeight("M");
		}
		model.addAttribute("paramVO", paramVO);
		return "wzwg/module/cntntsEditor/screen/siteLayoutContentsPopup";
	}
    
    /**
     * 컨텐츠 위젯 모듈 팝업
     */
    @RequestMapping(value="/**/module/cntntsEditor/screen/selectVariableContentsPopup.do")
    public String selectVariableContentsPopup(
    		@ModelAttribute("paramVO")SiteLayoutVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	//paramVO.setCategory("board");
    	/*if(paramVO.getWidth().equals("100")){
    		paramVO.setHeight("");
    	}*/
    	List<SiteLayoutVO> widgetList = siteLayoutService.selectContentsWidgetList(paramVO);
    	model.addAttribute("widgetList", widgetList);
    	
    	/*if(paramVO.getWidth().equals("100")){
    		paramVO.setHeight("M");
    	}*/
    	model.addAttribute("paramVO", paramVO);
    	return "wzwg/module/cntntsEditor/screen/variableContentsPopup";
    }
    
    /**
     * 테이블 스킨 팝업 호출
     */
    @RequestMapping(value="/**/module/cntntsEditor/screen/selectTableSkinAjax.do")
    public String selectTableSkinAjax(
    		@ModelAttribute("paramVO") ModuleCntntsVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
    	
    	
    	return "wzwg/module/cntntsEditor/screen/tableSkin";
    }
    
    /**
	 * 선택 템플릿 조회 
	 */
	@RequestMapping(value="/**/module/cntntsEditor/selectCntntsCnAjax.do")
	public ModelAndView selectCntntsCnAjax(
			@ModelAttribute("paramVO") CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request 
		) throws Exception{

		ModelAndView model = new ModelAndView();
		
		cntntsTmplatVO = cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);
		
		model.setViewName("jsonView");
		model.addObject("cntntsCnVO", cntntsTmplatVO);
		
		return model;
	}
}

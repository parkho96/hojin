package egovframework.wzwg.module.tabMenu.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class ModuleTabMenuInfoController {
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** ModuleTabMenuInfoService */
    @Resource(name="ModuleTabMenuInfoService")
    protected ModuleTabMenuInfoService tabMenuInfoService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    
    /**
	 * ㅁ 탭메뉴 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/tabMenu/selectTabMenuInc.do","/{siteKey}/**/module/tabMenu/selectTabMenuInc.do", "/**/module/tabMenu/selectBbsInc.do",})
	public String selectTabMenuInc(
			@ModelAttribute("paramVO") ModuleTabMenuInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	List<CntntsInfoVO> resultList = tabMenuInfoService.selectTabMenuInfoList(paramVO.getSiteSeq());
    	
    	/*
    	if(paramVO.getBbsSeq() == null && resultList.size() > 0){
    		paramVO.setBbsSeq(resultList.get(0).getCntntsSeq());
    	}
    	*/
    	
		paramVO.setTabSeq((String) request.getParameter("cntntsSeq"));
		
		model.addAttribute("tabMenuList", resultList);

		//ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		
		//moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);
		
		//paramVO.setCssSeq(moduleBbsCssVO.getCssSeq());	

		//moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);		
		
		//model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);

    	String reqUrl = request.getRequestURI();
    	String mngrAt = "N";

    	if(reqUrl.indexOf("/mngr/") > -1 || reqUrl.indexOf("/sysMngr/") > -1) {
    		if(reqUrl.indexOf("/mngr/screen/") == -1 || reqUrl.indexOf("/sysMngr/screen/") == -1) {
    			mngrAt = "Y";
    		}
    	}
	
    	model.addAttribute("mngrAt", mngrAt);
		
		return "wzwg/module/tabmenu/info/tabMenuInc"; 
	}
	
	/**
	 * ㅁ 탭메뉴 - 기본정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/tabMenu/selectTabMenuInfoAjax.do", "/**/module/tabMenu/tabMenuFormAjax.do", "/**/module/tabMenu/tabFormAjax.do"})
	public String selectTabMenuInfo(
			@ModelAttribute("paramVO") ModuleTabMenuInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	//List<ModuleBbsVO> formList = tabMenuInfoService.selectBbsFormList(paramVO.getSiteSeq());
    	//model.addAttribute("formList", formList);
		
		ModuleTabMenuInfoVO resultVO = new ModuleTabMenuInfoVO();
		
		// 게시판 기본정보
		resultVO = tabMenuInfoService.selectTabMenuInfoDetail(paramVO);
    
		if(resultVO != null){
		    resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/module/tabmenu/info/tabMenuForm"; 
	}

	/**
	 * ㅁ 탭메뉴 - 기본정보 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/modifyTabMenuInfoAjax.do")
	public ModelAndView modifyTabMenuInfo(
			@ModelAttribute("paramVO") ModuleTabMenuInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = tabMenuInfoService.modifyTabMenuBassInfo(paramVO);	// 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
	}
	
	/**
	 * ㅁ 탭메뉴 - 기본정보 수정(cssNm)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/modifyTabMenuCssNmAjax.do")
	public ModelAndView modifyTabMenuCssNm(
			@ModelAttribute("paramVO") ModuleTabMenuInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = tabMenuInfoService.modifyTabMenuCssNm(paramVO);	// 저장
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

    /**
     * ㅁ 탭메뉴 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/tabMenu/registTabMenuInfoAjax.do")
    public ModelAndView registTabMenuInfo(
            @ModelAttribute("paramVO") ModuleTabMenuInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
        
        if (loginVO != null) {
            paramVO.setFrstRegisterId(loginVO.getUserId());
        }
    
        result = tabMenuInfoService.registTabMenuBassInfo(paramVO);   // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
}

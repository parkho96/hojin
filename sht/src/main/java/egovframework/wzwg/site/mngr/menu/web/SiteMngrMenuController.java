package egovframework.wzwg.site.mngr.menu.web;

import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

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
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
@Slf4j
public class SiteMngrMenuController {
	
	@Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
	
	@Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
	
	@Resource(name="SysModuleInfoService")
	private SysModuleInfoService sysModuleInfoService;
	
	@Resource(name="CntntsAuthService")
	private CntntsAuthService cntntsAuthService;
	    
	@Resource(name="SiteUsrGroupService")
	private SiteUsrGroupService siteUsrGroupService;
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/sysMngr/siteMngr/menu/selectSiteMngrMenuMngrList.do","/{siteKey}/sysMngr/siteMngr/menu/selectSiteMngrMenuMngrList.do"})
	public String selectSiteMngrMenuMngrList(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		
		
		return "wzwg/site/mngr/mngrMenu/siteMenuList";
	}
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/selectSiteMngrMenuMngrListAjax.do","/{siteKey}/sysMngr/siteMngr/menu/selectSiteMenuMngrMngrListAjax.do"})
	public String selectSiteMngrMenuMngrListAjax(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMngrMenuService.selectSiteMenuMngrList(siteMngrMenuVO);
		
		model.addAttribute("resultList", siteMenuList);
		
		return "wzwg/site/mngr/mngrMenu/siteMenuListAjax";
	}
	
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/registSiteMngrMenuMngrFrmAjax.do","/{siteKey}/sysMngr/siteMngr/menu/registSiteMngrMenuMngrFrmAjax.do"})
	public String registSiteMngrMenuMngrFrmAjax(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMngrMenuService.registSiteMenuMngrInfo(siteMngrMenuVO);
		
		model.addAttribute("resultList", siteMenuList);
		
		return "wzwg/site/mngr/mngrMenu/siteMenuRegistAjaxFrm";
	}
	

	@RequestMapping(value= {"/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrFrmAjax.do","/{stieKey}/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrFrmAjax.do"})
	public String modifySiteMngrMenuMngrFrmAjax(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMngrMenuService.registSiteMenuMngrInfo(siteMngrMenuVO);
		model.addAttribute("subMenuCnt", siteMngrMenuService.selectSubMenuCnt(siteMngrMenuVO));
		model.addAttribute("resultList", siteMenuList);
		model.addAttribute("resultVO", siteMngrMenuService.selectSiteMenu(siteMngrMenuVO));
		
		return "wzwg/site/mngr/mngrMenu/siteMenuModifyAjaxFrm";
	}
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/siteMenuMngrCntntListAjax.do","/{siteKey}/sysMngr/siteMngr/menu/siteMenuMngrCntntListAjax.do"})
	public   String siteMenuCntntList(
			@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("menuCntntList", siteMngrMenuService.selectSiteMenuCntntList(siteMngrMenuVO));
		
		return "wzwg/site/mngr/mngrMenu/siteMenuCntntList";
	}

	
	
	/**
	 * 사이트 메뉴 등록
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/registSiteMngrMenuMngrAjax.do","/{siteKey}/sysMngr/siteMngr/menu/registSiteMngrMenuMngrAjax.do"})
	public  ModelAndView registSiteMenuMngr(
			HttpServletRequest request
			, @ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
			, SysModuleInfoVO paramVO
			, HttpServletResponse response
			, Model model ) throws Exception {
		ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMngrMenuVO.setUserId(loginVO.getUserId());
		String menuLv ="1";
		siteMngrMenuVO.setSiteSeq(siteSeq);
		int menuOrdrInt = 1;
		siteMngrMenuVO.setMngrMenuSeq(siteMngrMenuService.seletSiteMenuSeq());
		if(siteMngrMenuService.selectMaxMenuOrdr(siteMngrMenuVO) !=null){
		 menuOrdrInt = siteMngrMenuService.selectMaxMenuOrdr(siteMngrMenuVO)+1;
		}
		SiteMngrMenuVO upperVO  = new SiteMngrMenuVO();
		if(siteMngrMenuVO.getUpperMenuSeq() != null && !"".equals(siteMngrMenuVO.getUpperMenuSeq())){
			SiteMngrMenuVO siteUpperMenuVO  = new SiteMngrMenuVO();
			siteUpperMenuVO.setMngrMenuSeq(siteMngrMenuVO.getUpperMenuSeq());
			siteUpperMenuVO.setSiteSeq(siteSeq);
			upperVO =siteMngrMenuService.selectSiteMenu(siteUpperMenuVO);
			menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
		//	menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
			if((Integer.parseInt(upperVO.getMenuLv())+1) >3){
				ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxMenuLv").toString());
				return ajaxModel;
			}
			
			String sysmoduleSeq = siteMngrMenuVO.getSysmoduleSeq();
			String menuTyCode = siteMngrMenuVO.getMenuTyCode();
			if(sysmoduleSeq == null || (sysmoduleSeq.trim().isEmpty() && (menuTyCode == null || menuTyCode.trim().isEmpty()))) {
				if((Integer.parseInt(upperVO.getMenuLv())+1) >2){
					ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxGroupLv").toString());
					return ajaxModel;
				}
			}
		//	siteMenuService.modifySiteMenuPlusOrdr(upperVO);
		}else{
			siteMngrMenuVO.setUpperMenuSeq("0");
		}
		
		if("SC00000033".equals(siteMngrMenuVO.getMenuTyCode())){
			siteMngrMenuVO.setMenuLinkUrl(sysModuleInfoService.selectSysModuleInfoDetail(paramVO).getUsrPageUrl());
		}
		siteMngrMenuVO.setMenuLv(menuLv);
		siteMngrMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));
		if("link".equals(siteMngrMenuVO.getSysmoduleSeq())){
			siteMngrMenuVO.setSysmoduleSeq("");
		}
		if("888888888888".equals(siteMngrMenuVO.getSysmoduleSeq())){
			siteMngrMenuVO.setMenuLinkUrl("/index.do#.anc_"+siteMngrMenuVO.getMngrMenuSeq());
		}
		siteMngrMenuService.registSiteMenu(siteMngrMenuVO);
		ajaxModel.addObject("ajaxXml",xmlBuilder.addItem("result", "success").toString());
		return ajaxModel;
	}
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrAjax.do","/{siteKey}/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrAjax.do"})
	public ModelAndView modifySiteMenuMngr(
			HttpServletRequest request
			, @ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
			, SysModuleInfoVO paramVO
			, HttpServletResponse response
			, Model model ) throws Exception {	
		ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
		try{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		String menuLv ="1";
		siteMngrMenuVO.setSiteSeq(siteSeq);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMngrMenuVO.setUserId(loginVO.getUserId());
		int menuOrdrInt =Integer.parseInt(siteMngrMenuVO.getMenuOrdr());
		SiteMngrMenuVO upperVO  = new SiteMngrMenuVO();
		if(siteMngrMenuVO.getUpperMenuSeq() != null && !"".equals(siteMngrMenuVO.getUpperMenuSeq())){
			SiteMngrMenuVO siteUpperMenuVO  = new SiteMngrMenuVO();
			siteUpperMenuVO.setMngrMenuSeq(siteMngrMenuVO.getUpperMenuSeq());
			siteUpperMenuVO.setSiteSeq(siteSeq);
			upperVO =siteMngrMenuService.selectSiteMenu(siteUpperMenuVO);
			menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
			//menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
			if((Integer.parseInt(upperVO.getMenuLv())+1) >3){
				ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxMenuLv").toString());
				return ajaxModel;
			}
			 
			
			String sysmoduleSeq = siteMngrMenuVO.getSysmoduleSeq();
			String menuTyCode = siteMngrMenuVO.getMenuTyCode();
			if(!"link".equals(menuTyCode) && (sysmoduleSeq == null || (sysmoduleSeq.trim().isEmpty() && (menuTyCode == null || menuTyCode.trim().isEmpty())))) {
				if((Integer.parseInt(upperVO.getMenuLv())+1) >2){
					ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxGroupLv").toString());
					return ajaxModel;
				}
			}
			//siteMenuService.modifySiteMenuPlusOrdr(upperVO);
		} 
		 if(!"link".equals(siteMngrMenuVO.getMenuTyCode())){
			siteMngrMenuVO.setMenuLinkUrl("");
		}  
		 siteMngrMenuVO.setMenuTyCode("");
		siteMngrMenuVO.setMenuLv(menuLv);
		siteMngrMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));
		siteMngrMenuService.modifySiteMenu(siteMngrMenuVO);
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	} 
		ajaxModel.addObject("ajaxXml",xmlBuilder.addItem("result", "success").toString());
		return ajaxModel;
	}
 
	
//	/**
//	 * 사이트 메뉴 등록
//	 * @param siteMenuVO
//	 * @param request
//	 * @param model
//	 * @return
//	 * @throws Exception 
//	 */
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrOrdrAjax.do","/{stieKey}/sysMngr/siteMngr/menu/modifySiteMngrMenuMngrOrdrAjax.do"})
	public ModelAndView  modifySiteMngrMenuMngrOrdrAjax(
			HttpServletRequest request
			, HttpServletResponse response
			, @ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMngrMenuVO.setUserId(loginVO.getUserId()); 
		siteMngrMenuService.modifySiteMenuMngrOrdr(siteMngrMenuVO);
		
		ModelAndView model = new ModelAndView();
    	model.setViewName("jsonView"); 
		
		return model;
	}
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/deleteSiteMngrMenuMngrAjax.do","/{siteKey}/sysMngr/siteMngr/menu/deleteSiteMngrMenuMngrAjax.do"})
	public ModelAndView deleteSiteMenuMngrAjax(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		siteMngrMenuVO.setUserId(CmmSessionUtil.getSessionUserId());
		
		ModelAndView model = new ModelAndView();
		
		if(siteMngrMenuService.selectSubMenuCnt(siteMngrMenuVO)<1){
			siteMngrMenuService.deleteSiteMenu(siteMngrMenuVO);
			model.addObject("msg","success" );
		}else{
			model.addObject("msg","fail" );	
		}
    	model.setViewName("jsonView"); 
		
		return model;
	}
	
	@RequestMapping(value= {"/sysMngr/siteMngr/menu/deleteSiteMngrMenuLowAjax.do","/{siteKey}/sysMngr/siteMngr/menu/deleteSiteMngrMenuLowAjax.do"})
	public ModelAndView deleteSiteMenuLowAjax(
		@ModelAttribute("paramVO")SiteMngrMenuVO siteMngrMenuVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		String result = "success"; 
				
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMngrMenuVO.setSiteSeq(siteSeq);
		siteMngrMenuVO.setUserId(CmmSessionUtil.getSessionUserId());
		
		try {
			siteMngrMenuService.deleteSiteMenuLow(siteMngrMenuVO);
		} catch(NullPointerException e){			
			result = "fail"; 
	   	}catch(NumberFormatException e){	   	 
	   	 	result = "fail"; 
	   	}catch(IllegalFormatException e){	   	 
	   	 	result = "fail"; 
	   	}catch(ArrayIndexOutOfBoundsException e){	   	 
	   	 	result = "fail"; 
	   	}catch(SQLException e){	   	 
	   	 	result = "fail"; 
	   	}  
		
		return CmmAjaxUtil.getAjaxReturn(result);
	}
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/sysMngr/siteMngr/menu/selectSiteMngrMenuByUsrGroup.do","/{siteKey}/sysMngr/siteMngr/menu/selectSiteMngrMenuByUsrGroup.do"})
	public String selectSiteMenuByUsrGroup(
		@ModelAttribute("paramVO")SiteMngrMenuVO  paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
        
        /** 사이트 시퀀스 */
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setSiteSeq(siteSeq);

        // 그룹 목록
        List<SiteUsrGroupVO> usrGroupList = siteUsrGroupService.selectSiteUsrGroupAllList(siteSeq);
        model.addAttribute("usrGroupList", usrGroupList);
        
        // 메뉴 목록
        List<SiteMngrMenuVO> resultList = siteMngrMenuService.selectSiteMenuList(paramVO);
        model.addAttribute("resultList", resultList);
        
        // 메뉴에 설정된 권한을 조회하기 위한 조건 설정
    //    String usrgroupSeq = StringUtils.defaultString(paramVO.getSrhUsrGroupSeq());
//        if ("".equals(usrgroupSeq)) {
//            if (usrGroupList != null && usrGroupList.size() > 0) {
//                usrgroupSeq = usrGroupList.get(0).getUsrGroupSeq();
//            }
//        }
        
//        CntntsAuthVO setAuthVO = new CntntsAuthVO();
//        setAuthVO.setSiteSeq(siteSeq);
//        setAuthVO.setUsrgroupSeq(usrgroupSeq);
        // 검색조건 없을때 기본 회원그룹 셋팅하기 위해 한번 더 넣어줌
       // paramVO.setSrhUsrGroupSeq(usrgroupSeq);

        // 기본 회원그룹
//        String baseUsrgroupSeq = Globals.BASE_SITE_USRGROUPSEQ;
//        String[] baseUsrgroupArr = baseUsrgroupSeq.split(":");
//        setAuthVO.setNmbrUsrGroupSeq(baseUsrgroupArr);
//        model.addAttribute("baseUsrgroupSeq", baseUsrgroupSeq);
//        
//        // 해당 회원그룹 설정된 권한 목록
//        List<CntntsAuthVO> authList = cntntsAuthService.selectCntntsAuthAllList(setAuthVO);
//        model.addAttribute("authList", authList);
        model.addAttribute("paramVO", paramVO);
		
		return "wzwg/site/mngr/mngrMenu/siteMenuUsrGroup";
	}
    
	/**
    @RequestMapping(value= {"/mngr/menu/registSiteMenuByUsrGroup.do","/{siteKey}/mngr/menu/registSiteMenuByUsrGroup.do"})
    public ModelAndView registSiteMenuByUsrGroup (
        @ModelAttribute("paramVO") CntntsAuthVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        int retVal = siteMngrMenuService.registSiteMenuByUsrGroup(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(retVal);
    }
	
	**/
	/*
	
	*//**
	 * ㅁ 사이트 메뉴 단일모듈 관리자 URL 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *//*
	
	@RequestMapping(value="/mngr/menu/selectSiteMenuMngrUrlAjax.do")
	public ModelAndView selectSiteMenuMngrUrlAjax(
		@ModelAttribute("paramVO")SiteMenuVO paramVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		SysModuleInfoVO resultVO = sysModuleInfoService.selectSysModuleInfoDetail(paramVO);
		
		    if(resultVO != null) {
		    	return CmmAjaxUtil.getAjaxReturn(resultVO.getMngrPageUrl());
		    }else {
		    	return CmmAjaxUtil.getAjaxReturn("fail");
		    }
		
		
	}
	
	*/
	
	
	@RequestMapping(value= {"/mngr/menu/selectMngrLocationView.do"})
	public   String selectMngrLocationView(
			@ModelAttribute("resultVO")SiteMngrMenuVO siteMngrMenuVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model ) throws Exception {
		
		
		 siteMngrMenuVO = siteMngrMenuService.selectSiteMngrMenuNm(siteMngrMenuVO);
		
		 model.addAttribute("resultVO", siteMngrMenuVO);
		
		return "wzwg/cmm/decorators/mngr/decoMngrLocationInc";
	}
}

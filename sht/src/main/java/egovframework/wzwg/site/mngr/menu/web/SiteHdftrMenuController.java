package egovframework.wzwg.site.mngr.menu.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuVO;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class SiteHdftrMenuController {
	
	@Resource(name="SiteHdftrMenuService")
	private SiteHdftrMenuService siteHdftrMenuService;
	 
	@Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;
	
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
   
    @Resource(name="LinkGrpInfoService")
    private SiteLinkGrpInfoService linkGrpInfoService;

	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;
	
	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
	@Resource(name = "ModuleUploadFileService")
	protected ModuleUploadFileService fileService;
	

	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/menu/selectSiteHdMenuMngrList.do","/{siteKey}/mngr/menu/selectSiteHdMenuMngrList.do"})
	public String selectSiteHdMenuMngrList(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		
		return "wzwg/site/mngr/menu/siteHdMenuList";
	}
	
	@RequestMapping(value={"/mngr/menu/selectSiteMenuRegistFrmMngr.do","/{siteKey}/mngr/menu/selectSiteMenuRegistFrmMngr.do"})
	public String selectSiteMenuRegistFrmMngr(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("siteHdftrMenuVO", siteHdftrMenuVO);
		model.addAttribute("hdftrMenuTyCodeList", codeService.selectCmmCodeList("HDFTRMENU_TY_CODE"));
        model.addAttribute("linkGrpList",linkGrpInfoService.selectLinkGrpInfoAll(siteSeq));
		
        /* moo0506 메뉴목록 추가 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteSeq);
		//siteMenuVO.setMenuListSe("ADMIN");
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));
		
		/** 사이트 약관 조회 */
		SiteStplatInfoVO searchVO = new SiteStplatInfoVO();
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(10000);
		searchVO.setSiteSeq(siteSeq);
		List<SiteStplatInfoVO> stplatList = siteStplatInfoService.selectSiteStplatInfoList(searchVO);
		model.addAttribute("stplatList", stplatList);
		
		return "wzwg/site/mngr/menu/siteMenuRegistFrm";
	}
	
	
	@RequestMapping(value= {"/mngr/menu/selectSiteHdftrMenuRegistAjax.do","/{siteKey}/mngr/menu/selectSiteHdftrMenuRegistAjax.do"})
	public ModelAndView selectSiteHdftrMenuRegistAjax(
			@ModelAttribute("searchVO")SiteHdftrMenuVO siteHdftrMenuVO
			,HttpServletRequest request
			, MultipartHttpServletRequest multiRequest
			, Model model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteHdftrMenuVO.setUserId(loginVO.getUserId());
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		siteHdftrMenuVO.setDefaultAt("N");
		
		int registResult = 0;
		
		String menuty = "";
		
		if("SC00000081".equals(siteHdftrMenuVO.getHdftrCode())) {
			menuty = "header";
		}else if("SC00000082".equals(siteHdftrMenuVO.getHdftrCode())){
			menuty = "footer";
		}
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		resultList = fileUtil.parseFileInf(file, "HFMN_", 0, "Globals.hfmenuFilePath", "Globals.WhiteImgFileExt", multiRequest, menuty, null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			siteHdftrMenuVO.setIconFileId(fileService.insertFileInfs(resultList));
	    		}
	    	}
	    }
		
 	    if(siteHdftrMenuVO.getLognN() != null && "Y".equals(siteHdftrMenuVO.getLognN())){
			siteHdftrMenuVO.setLgnAt("N");
			registResult += siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO); 
		}
		
		if(siteHdftrMenuVO.getLognY() != null && "Y".equals(siteHdftrMenuVO.getLognY())){
			siteHdftrMenuVO.setLgnAt("Y");
			registResult += siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO); 
		}
 	    
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        return ajaxModel;

	} 
	
	@RequestMapping(value="/**/menu/siteHdftrMenuJsonAjax.do")
    public ModelAndView scrinMenuJsonAjax (
        @ModelAttribute("paramVO") SiteHdftrMenuVO paramVO
        , HttpServletRequest request ) throws Exception {
    
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        if (siteSeq == null) {
            siteSeq = ""; 
        }
        SiteMenuVO siteMenuVO = new SiteMenuVO();
        paramVO.setSiteSeq(siteSeq); 
        siteMenuVO.setSiteSeq(siteSeq);
        // 컨텐츠 데이터를 가져옴
        List<SiteHdftrMenuVO> resultList = null;
        if("10000000001".equals(siteSeq)) {
        	resultList = getSysmngrFakeMenu(paramVO);
        }else {
        	resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);
        }

        ModelAndView model = new ModelAndView();
    
        model.setViewName("jsonView");
        
        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addObject("hdftrMenuData", resultList);
        
        if(siteSeq.equals("10000000001")) {
        	model.addObject("footerLogo","/images/wzwg/sysmngr/sysmngr_tmp_logo_footer.png");
        	model.addObject("footerLogoReplcText","SysMngr footer logo image");
        	
        }else {
        	model.addObject("footerLogo",siteMenuService.selectSiteFooterLogo(siteMenuVO));
        	model.addObject("footerLogoReplcText",CmmSessionUtil.getSessionValue(request, "footerLogoReplcText"));
        }
        
        return model;
    }
	 
	 private List<SiteHdftrMenuVO> getSysmngrFakeMenu(SiteHdftrMenuVO paramVO) throws Exception{
		 String lgnAt = paramVO.getLgnAt();
		 List<SiteHdftrMenuVO> resultList = new ArrayList<SiteHdftrMenuVO>();
		 
		 if(lgnAt.equals("Y")) {
			//로그인전
			 SiteHdftrMenuVO menuVO2 = new SiteHdftrMenuVO();
			 menuVO2.setHdftrmenuNm("마이페이지");
			 menuVO2.setHdftrmenuDc("마이페이지");
			 menuVO2.setHdftrmenuTyCode("SC00000080");//현재창
			 menuVO2.setHdftrmenuTyNm("현재창");
			 menuVO2.setHdftrmenuLinkUrl("#");
			 menuVO2.setMenuTySe("N");
			 resultList.add(menuVO2);
			 SiteHdftrMenuVO menuVO1 = new SiteHdftrMenuVO();
			 menuVO1.setHdftrmenuNm("로그아웃");
			 menuVO1.setHdftrmenuDc("로그아웃");
			 menuVO1.setHdftrmenuTyCode("SC00000080");//현재창
			 menuVO1.setHdftrmenuTyNm("현재창");
			 menuVO1.setHdftrmenuLinkUrl("#");
			 menuVO1.setMenuTySe("N");
			 resultList.add(menuVO1);
		 }else {
			 //로그인후
			 SiteHdftrMenuVO menuVO1 = new SiteHdftrMenuVO();
			 menuVO1.setHdftrmenuNm("로그인");
			 menuVO1.setHdftrmenuDc("로그인");
			 menuVO1.setHdftrmenuTyCode("SC00000080");//현재창
			 menuVO1.setHdftrmenuTyNm("현재창");
			 menuVO1.setHdftrmenuLinkUrl("#");
			 menuVO1.setMenuTySe("N");
			 resultList.add(menuVO1);
		 }
		 return resultList;
	 }
	
	@RequestMapping(value={"/mngr/menu/selectSiteMenuModifyFrmMngr.do","/{siteKey}/mngr/menu/selectSiteMenuModifyFrmMngr.do"})
	public String selectSiteMenuModifyFrmMngr(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("siteHdftrMenuVO", siteHdftrMenuService.selectSiteHdftrMenu(siteHdftrMenuVO));
		model.addAttribute("hdftrMenuTyCodeList", codeService.selectCmmCodeList("HDFTRMENU_TY_CODE"));
		model.addAttribute("linkGrpList",linkGrpInfoService.selectLinkGrpInfoAll(siteSeq));
		
		/* moo0506 메뉴목록 추가 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteSeq);
		//siteMenuVO.setMenuListSe("ADMIN");
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));

		/** 사이트 약관 조회 */
		SiteStplatInfoVO searchVO = new SiteStplatInfoVO();
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(10000);
		searchVO.setSiteSeq(siteSeq);
		List<SiteStplatInfoVO> stplatList = siteStplatInfoService.selectSiteStplatInfoList(searchVO);
		model.addAttribute("stplatList", stplatList);
		
		return "wzwg/site/mngr/menu/siteMenuModifyFrm";
	}
	
	
	@RequestMapping(value= {"/mngr/menu/selectSiteHdftrMenuModifyAjax.do","/{siteKey}/mngr/menu/selectSiteHdftrMenuModifyAjax.do"})
	public ModelAndView selectSiteHdftrMenuModifyAjax(
			@ModelAttribute("searchVO")SiteHdftrMenuVO siteHdftrMenuVO
			, HttpServletRequest request
			, MultipartHttpServletRequest multiRequest
			, Model model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteHdftrMenuVO.setUserId(loginVO.getUserId());
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		
		String menuty = "";
		
		if("SC00000081".equals(siteHdftrMenuVO.getHdftrCode())) {
			menuty = "header";
		}else if("SC00000082".equals(siteHdftrMenuVO.getHdftrCode())){
			menuty = "footer";
		}
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		resultList = fileUtil.parseFileInf(file, "HFMN_", 0, "Globals.hfmenuFilePath", "Globals.WhiteImgFileExt", multiRequest, menuty, null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			siteHdftrMenuVO.setIconFileId(fileService.insertFileInfs(resultList));
	    		}
	    	}
	    }
		
 	   int registResult = siteHdftrMenuService.modifySiteHdftrMenu(siteHdftrMenuVO);
 	    
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;

	} 
	
	@RequestMapping(value= {"/mngr/menu/deleteSiteHdftrMenuAjax.do","/{siteKey}/mngr/menu/deleteSiteHdftrMenuAjax.do"})
	public ModelAndView deleteSiteHdftrMenuAjax(
			@ModelAttribute("searchVO")SiteHdftrMenuVO siteHdftrMenuVO
			,HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteHdftrMenuVO.setUserId(loginVO.getUserId());
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		
		siteHdftrMenuService.deleteSiteHdftrMenuMngr(siteHdftrMenuVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        
        return ajaxModel;

	} 
	
	@RequestMapping(value= {"/mngr/menu/modifySiteHdftrMenuOrdrAjax.do","/{siteKey}/mngr/menu/modifySiteHdftrMenuOrdrAjax.do"})
	public ModelAndView modifySiteHdftrMenuOrdrAjax(
			@ModelAttribute("searchVO")SiteHdftrMenuVO siteHdftrMenuVO
			,HttpServletRequest request
			, Model model
			){
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteHdftrMenuVO.setLastUpdusrId(loginVO.getUserId());
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		
		int registResult = siteHdftrMenuService.modifySiteHdftrMenuOrdr(siteHdftrMenuVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;

	} 
	
	@RequestMapping(value= {"/mngr/menu/selectSiteHdLgnNMenuMngrListAjax.do","/{siteKey}/mngr/menu/selectSiteHdLgnNMenuMngrListAjax.do"})
	public String selectSiteHdLgnNMenuMngrList(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		siteHdftrMenuVO.setHdftrCode("SC00000081");
		siteHdftrMenuVO.setLgnAt("N");
		model.addAttribute("resultList", siteHdftrMenuService.selectSiteHdftrMenuList(siteHdftrMenuVO));
		return "wzwg/site/mngr/menu/siteHdMenuAjaxList";
	}
	
	@RequestMapping(value= {"/mngr/menu/selectSiteHdLgnYMenuMngrListAjax.do","/{siteKey}/mngr/menu/selectSiteHdLgnYMenuMngrListAjax.do"})
	public String selectSiteHdHdLgnYMenuMngrList(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		siteHdftrMenuVO.setHdftrCode("SC00000081");
		siteHdftrMenuVO.setLgnAt("Y");
		model.addAttribute("resultList", siteHdftrMenuService.selectSiteHdftrMenuList(siteHdftrMenuVO));
		return "wzwg/site/mngr/menu/siteHdMenuAjaxList";
	}
	   
	@RequestMapping(value={"/mngr/menu/selectSiteFtrMenuMngrList.do","/{siteKey}/mngr/menu/selectSiteFtrMenuMngrList.do"})
	public String selectSiteFtrMenuMngrList(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		
		
		model.addAttribute("siteHdftrMenuList", siteHdftrMenuService.selectSiteHdftrMenuList(siteHdftrMenuVO));
		
		return "wzwg/site/mngr/menu/siteFtrMenuList";
	}
	
	@RequestMapping(value= {"/mngr/menu/selectSiteFtrLgnNMenuMngrListAjax.do","/{siteKey}/mngr/menu/selectSiteFtrLgnNMenuMngrListAjax.do"})
	public String selectSiteFtrLgnNMenuMngrListAjax(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		siteHdftrMenuVO.setHdftrCode("SC00000082");
		siteHdftrMenuVO.setLgnAt("N");
		model.addAttribute("resultList", siteHdftrMenuService.selectSiteHdftrMenuList(siteHdftrMenuVO));
		return "wzwg/site/mngr/menu/siteFtrMenuAjaxList";
	}
	
	@RequestMapping(value= {"/mngr/menu/selectSiteFtrLgnYMenuMngrListAjax.do","/{siteKey}/mngr/menu/selectSiteFtrLgnYMenuMngrListAjax.do"})
	public String selectSiteFtrLgnYMenuMngrListAjax(
		@ModelAttribute("paramVO")SiteHdftrMenuVO siteHdftrMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteHdftrMenuVO.setSiteSeq(siteSeq);
		siteHdftrMenuVO.setHdftrCode("SC00000082");
		siteHdftrMenuVO.setLgnAt("Y");
		model.addAttribute("resultList", siteHdftrMenuService.selectSiteHdftrMenuList(siteHdftrMenuVO));
		return "wzwg/site/mngr/menu/siteFtrMenuAjaxList";
	}
	
	/**
	 * 번역 여부 중복체크
	 * @param siteHdftrMenuVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/menu/selectSiteHdftrMenuTrnslatChkAjax.do","/{siteKey}/mngr/menu/selectSiteHdftrMenuTrnslatChkAjax.do"})
	public ModelAndView selectSiteHdftrMenuTrnslatChk(
			@ModelAttribute("searchVO")SiteHdftrMenuVO paramVO
			,HttpServletRequest request
			, Model model
			){
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		int chkResult = siteHdftrMenuService.selectSiteHdftrMenuTrnslatChk(paramVO);
		
		if(chkResult > 0){
			return CmmAjaxUtil.getAjaxReturn("fail");
		}else{
			return CmmAjaxUtil.getAjaxReturn("success");
		}

	} 
	
}

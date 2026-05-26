package egovframework.wzwg.module.sideQuick.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.sideQuick.service.ModuleSideQuickService;
import egovframework.wzwg.module.sideQuick.service.ModuleSideQuickVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Controller
public class ModuleSideQuickController {
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	/** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    @Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;
    
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
    
    @Resource(name = "ModuleSideQuickService")
    private ModuleSideQuickService sideQuickService;
    
	private String sideQuickModuleSeq = "10000000217";
	
	/**
     * 사이드퀵 관리자 
     */
    @RequestMapping(value="/**/module/sideQuick/selectSideQuickList.do")
    public String selectSideQuickList(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		paramVO = sideQuickService.selectSideQuickStbs(siteSeq);
		model.addAttribute("quickStbsVO", paramVO);
		
    	ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
    	moduleBbsVO.setSysmoduleSeq(sideQuickModuleSeq);
    	List<ModuleBbsCssVO> cssList = bbsCmmnService.selectSysmoduleBbsCssList(moduleBbsVO);
    	model.addAttribute("cssList", cssList);
    	
    	List<ModuleSideQuickVO> linkList = sideQuickService.selectSideQuickLinkList(siteSeq);
    	model.addAttribute("linkList", linkList);
    	
    	//model.addAttribute("paramVO", paramVO);
    	return "wzwg/module/sideQuick/sideQuickList";
    }
    
    
    /**
     * 사이드퀵 관리자 링크 목록
     */
    @RequestMapping(value="/**/module/sideQuick/selectSideQuickLinkListAjax.do")
    public String selectSideQuickLinkListAjax(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	
    	
    	List<ModuleSideQuickVO> linkList = sideQuickService.selectSideQuickLinkList(siteSeq);
    	model.addAttribute("linkList", linkList);
    	
    	//model.addAttribute("paramVO", paramVO);
    	return CmmJsonAjaxResponser.getInstance().setResultCode("success")
    			.setResultJsp("linkListJsp", "wzwg/module/sideQuick/sideQuickLinkList")
    			.setBodyData("linkList", linkList)
    			.returnJsp(model);
    }
    
    
    /**
     * 사이드퀵 정보 저장
     */
    @RequestMapping(value="/**/module/sideQuick/registSideQuickStbsAjax.do")
    public String registSideQuickStbsAjax(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	CmmLoginVO loginVO = (CmmLoginVO) request.getSession().getAttribute("loginVO");
    	paramVO.setSiteSeq(siteSeq);
    	paramVO.setQmenuRelmCode("");
    	//paramVO.setQmenuetNm("");
    	//paramVO.setQmenuetDc("");
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    	}
    	
    	int result = sideQuickService.registSideQuickStbs(paramVO);
    	String resultCode = "";
    	String qmenuetSeq = "";
    	if(result > 0){
    		resultCode = "success";
    		qmenuetSeq = paramVO.getQmenuetSeq();
    	}else{
    		resultCode = "fail";
    	}
    	
    	//model.addAttribute("paramVO", paramVO);
    	return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("qmenuetSeq", qmenuetSeq).returnJsp(model);
    }
    
    /**
     * 사이드퀵 정보 변경
     */
    @RequestMapping(value="/**/module/sideQuick/modifySideQuickStbsAjax.do")
    public String modifySideQuickStbsAjax(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	CmmLoginVO loginVO = (CmmLoginVO) request.getSession().getAttribute("loginVO");
    	paramVO.setSiteSeq(siteSeq);
    	//paramVO.setFrstRegisterId(loginVO.getUserId());
    	if (loginVO != null) {
    		paramVO.setLastUpdusrId(loginVO.getUserId());
    	}
    	
    	int result = sideQuickService.modifySideQuickStbs(paramVO);
    	String resultCode = "";
    	if(result > 0){
    		resultCode = "success";
    	}else{
    		resultCode = "fail";
    	}
    	
    	//model.addAttribute("paramVO", paramVO);
    	return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
    }
    
    /**
     * 사이드퀵 - 링크 등록 폼
     */
    @RequestMapping(value="/**/module/sideQuick/selectSideQuickRegistFormAjax.do")
    public String selectSideQuickRegistFormAjax(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
    	/*ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
    	moduleBbsVO.setSysmoduleSeq(sideQuickModuleSeq);
    	List<ModuleBbsCssVO> cssList = bbsCmmnService.selectSysmoduleBbsCssList(moduleBbsVO);
    	model.addAttribute("cssList", cssList);*/
    	
    	/* moo0506 메뉴목록 추가 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteSeq);
		//siteMenuVO.setMenuListSe("ADMIN");
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));
		
    	model.addAttribute("paramVO", paramVO);
    	return "wzwg/module/sideQuick/sideQuickRegistForm";
    }
    
    /**
	 * 사이트퀵 - 링크 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/sideQuick/registSideQuickLinkAjax.do")
	public String registSideQuickLinkAjax(
			@ModelAttribute("paramVO") ModuleSideQuickVO paramVO
			, HttpServletRequest request
			, final MultipartHttpServletRequest multiRequest
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		//HttpServletRequest request = (HttpServletRequest)multiRequest;
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<ModuleUploadFileVO> resultList = new ArrayList<ModuleUploadFileVO>();
		String atchFileId = "";
	    
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (files.get("iconFile") != null && files.get("iconFile").isEmpty() == false) {
	    	//resultList = fileUtil.parseFileInf(files, "NTT_", 0, "", "");
	    	resultList = fileUtil.parseFileInf(files, "SIDEQUICK_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "sidequick", null, siteSeq);
			atchFileId = fileService.insertFileInfs(resultList);
			paramVO.setMenuImagePath("/module/upload/file/selectImageView.do?atchFileId=" + atchFileId + "&fileSn=0");
			paramVO.setMenuImageUseAt("Y");
	    }
			    
		HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		//result = nttCmmnService.registNttInfo(paramVO);	// 저장
		paramVO.setImageReplcText("");
		paramVO.setMenuSttusCode("Y");
		result = sideQuickService.registQuickLinkInfo(paramVO);
		
		String resultCode = "";
		if(result > 0){
			resultCode = "success";
		}else{
			resultCode = "fail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
	
	 /**
     * 사이드퀵 - 링크 수정 폼
     */
    @RequestMapping(value="/**/module/sideQuick/selectSideQuickModifyFormAjax.do")
    public String selectSideQuickModifyFormAjax(
    		@ModelAttribute("paramVO")ModuleSideQuickVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
    	/*ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
    	moduleBbsVO.setSysmoduleSeq(sideQuickModuleSeq);
    	List<ModuleBbsCssVO> cssList = bbsCmmnService.selectSysmoduleBbsCssList(moduleBbsVO);
    	model.addAttribute("cssList", cssList);*/
    	
		ModuleSideQuickVO quickVO = sideQuickService.selectSideQuickLinkInfo(paramVO);
		model.addAttribute("quickVO", quickVO);
		
    	/* moo0506 메뉴목록 추가 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(siteSeq);
		//siteMenuVO.setMenuListSe("ADMIN");
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));
		
    	model.addAttribute("paramVO", paramVO);
    	return "wzwg/module/sideQuick/sideQuickModifyForm";
    }
    
    /**
	 * 사이트퀵 - 링크 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/sideQuick/modifySideQuickLinkAjax.do")
	public String modifySideQuickLinkAjax(
			@ModelAttribute("paramVO") ModuleSideQuickVO paramVO
			, HttpServletRequest request
			, final MultipartHttpServletRequest multiRequest
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		//HttpServletRequest request = (HttpServletRequest)multiRequest;
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<ModuleUploadFileVO> resultList = new ArrayList<ModuleUploadFileVO>();
		String atchFileId = "";
	    
		
		Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (files.get("iconFile") != null && files.get("iconFile").isEmpty() == false) {
	    	//resultList = fileUtil.parseFileInf(files, "NTT_", 0, "", "");
	    	resultList = fileUtil.parseFileInf(files, "SIDEQUICK_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "sidequick", null, siteSeq);
			atchFileId = fileService.insertFileInfs(resultList);
			paramVO.setMenuImagePath("/module/upload/file/selectImageView.do?atchFileId=" + atchFileId + "&fileSn=0");
			paramVO.setMenuImageUseAt("Y");
	    }
			    
		HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		//result = nttCmmnService.registNttInfo(paramVO);	// 저장
		//paramVO.setImageReplcText("");
		//paramVO.setMenuSttusCode("Y");
		result = sideQuickService.modifySideQuickLinkInfo(paramVO);
		
		String resultCode = "";
		if(result > 0){
			resultCode = "success";
		}else{
			resultCode = "fail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
	
	/**
	 * 사이트퀵 - 링크 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/sideQuick/deleteSideQuickLinkAjax.do")
	public String deleteSideQuickLinkAjax(
			@ModelAttribute("paramVO") ModuleSideQuickVO paramVO
			, HttpServletRequest request
			, ModelMap model
			) throws Exception{
		
		int result = 0;
		//HttpServletRequest request = (HttpServletRequest)multiRequest;
		//String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		//result = nttCmmnService.registNttInfo(paramVO);	// 저장
		//paramVO.setImageReplcText("");
		//paramVO.setMenuSttusCode("Y");
		result = sideQuickService.deleteSideQuickLinkInfo(paramVO);
		
		String resultCode = "";
		if(result > 0){
			resultCode = "success";
		}else{
			resultCode = "fail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
	
	/**
	 * 사이트퀵 - 링크 순서변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/sideQuick/modifySideQuickLinkOrdrAjax.do")
	public String modifySideQuickLinkOrdrAjax(
			@ModelAttribute("paramVO") ModuleSideQuickVO paramVO
			, HttpServletRequest request
			, String command
			, ModelMap model
			) throws Exception{
		
		int result = 0;
		//HttpServletRequest request = (HttpServletRequest)multiRequest;
		//String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		//paramVO.setSiteSeq(siteSeq);
		
		ModuleSideQuickVO quickVO = sideQuickService.selectSideQuickLinkInfo(paramVO);
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if (loginVO != null) {
			quickVO.setLastUpdusrId(loginVO.getUserId());
		}
		//paramVO.setLastUpdusrId(loginVO.getUserId());
		
		//result = nttCmmnService.registNttInfo(paramVO);	// 저장
		//paramVO.setImageReplcText("");
		//paramVO.setMenuSttusCode("Y");
		if(command != null) {
			result = sideQuickService.modifySideQuickLinkInfoOrdr(quickVO, command);
		}
		
		String resultCode = "";
		if(result > 0){
			resultCode = "success";
		}else{
			resultCode = "fail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
	
	
	
	/**
	 * 사이트퀵 - 링크 순서변경
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/sideQuick/selectSideQuickUsrListAjax.do")
	public String selectSideQuickUsrListAjax(
			@ModelAttribute("paramVO") ModuleSideQuickVO paramVO
			, HttpServletRequest request
			, ModelMap model
			) throws Exception{
		
		/** 사이트 시퀀스 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	paramVO = sideQuickService.selectSideQuickStbs(siteSeq);
    	model.addAttribute("quickVO", paramVO);
    	
    	List<ModuleSideQuickVO> linkList = sideQuickService.selectSideQuickLinkList(siteSeq);
    	model.addAttribute("linkList", linkList);
    	
    	//model.addAttribute("paramVO", paramVO);
    	return "wzwg/module/sideQuick/sideQuickUsrView";
    			
	}
}

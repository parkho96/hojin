package egovframework.wzwg.module.popup.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
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
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.popup.service.ModulePopupInfoService;
import egovframework.wzwg.module.popup.service.ModulePopupInfoVO;
import egovframework.wzwg.module.popup.service.ModulePopupTmplatVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;

@Controller
public class ModulePopupInfoController {
	
	@Resource(name="ModulePopupInfoService")
	ModulePopupInfoService modulePopupInfoService;

    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
    
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;

	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

    @ModelAttribute("siteLclasGroupList")
    public List<SiteGroupVO> getSiteClList() throws Exception {
        
        SiteGroupVO paramVO = new SiteGroupVO();
        
        paramVO.setOdr("2");
        paramVO.setUpperGrpSeq("10000000011");
        
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return resultList;
    }

    @ModelAttribute("siteMlsfcGroupList")
    public List<SiteGroupVO> getSiteMlList() throws Exception {
        
        SiteGroupVO paramVO = new SiteGroupVO();
        
        // 1차
        paramVO.setOdr("2");
        paramVO.setUpperGrpSeq("10000000012");
        
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return resultList;
    }

	@RequestMapping(value={"/**/module/popup/selectModulePopupList.do","/{siteKey}/**/module/popup/selectModulePopupList.do"})
	public String selectModulePopupList(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			){
		
		modulePopupVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(modulePopupVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(modulePopupVO.getPageUnit());
        paginationInfo.setPageSize(modulePopupVO.getPageSize());
       
        modulePopupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        modulePopupVO.setLastIndex(paginationInfo.getLastRecordIndex());
        modulePopupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = modulePopupInfoService.selectPopupTotCnt(modulePopupVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        
		List<ModulePopupInfoVO> resultList = modulePopupInfoService.selectModulePopupList(modulePopupVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/popup/popupList";
	}
	
	@RequestMapping(value="/**/module/popup/selectModulePrevewPopup.do")
	public String selectModulePrevewPopup(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			){
		
		ModulePopupInfoVO resultVO = modulePopupInfoService.selectModulePopupDetail(modulePopupVO);
		model.addAttribute("resultVO", resultVO);

		if("SC00000072".equals(resultVO.getPopupTyCode())) {
			
			ModulePopupTmplatVO tmplatVO = modulePopupInfoService.selectPopupTmplatDetail(resultVO.getTmplatSeq());
			model.addAttribute("tmplatVO", tmplatVO);
		}
		
		return "wzwg/module/popup/popupPrevew";
	}

	@RequestMapping(value="/**/module/popup/selectPopupTyChangeAjax.do")
	public String selectPopupTyChangeAjax(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			){
		
		String returnPage = "";
		
		if(("SC00000413").equals(modulePopupVO.getPopupTyCode())){
			returnPage = "wzwg/module/popup/popupTyImage";
		}else if(("SC00000414").equals(modulePopupVO.getPopupTyCode())){
			returnPage = "wzwg/module/popup/popupTyDirect";
		}else{
			
        	List<ModulePopupTmplatVO> tmplatList = modulePopupInfoService.selectPopupTmplatList();
        	model.addAttribute("tmplatList", tmplatList);

			returnPage = "wzwg/module/popup/popupTyTmplat";
		}
		
    	if(!("").equals(modulePopupVO.getPopupSeq())){

    		ModulePopupInfoVO resultVO = modulePopupInfoService.selectModulePopupDetail(modulePopupVO);
    		model.addAttribute("resultVO", resultVO);
    		
    	}
    	
		return returnPage;
	}
	
	@RequestMapping(value={"/**/module/popup/registModulePopupForm.do","/{siteKey}/**/module/popup/registModulePopupForm.do"})
	public String registModulePopupForm(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			) throws Exception{
        
        /** 사이트 대분류(1차분류) 리스트 */
        SiteGroupVO paramVO = new SiteGroupVO();
        paramVO.setOdr("1");
        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(paramVO);
        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
        
        /** 사용자 유형 리스트 조회(SYSCODE) */
        List<CmmCodeVO> codeList = codeService.selectCmmCodeList("POPUP_TY_CODE");
        model.addAttribute("codeList", codeList);
        
        List<ModulePopupTmplatVO> tmplatList = modulePopupInfoService.selectPopupTmplatList();
        model.addAttribute("tmplatList", tmplatList);
		
		return "wzwg/module/popup/popupRegistForm";
	}
	
	@RequestMapping(value="/**/module/popup/registModulePopupAjax.do")
	public ModelAndView registModulePopupAjax(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
		modulePopupVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		modulePopupVO.setUserId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
                resultList = fileUtil.parseFileInf(file, "POP_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "popup", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			if("thumbFile".equals(resultList.get(0).getName())) {
	    				modulePopupVO.setThumbFileId(fileService.insertFileInfs(resultList));
	    			} else if("atchFile".equals(resultList.get(0).getName())) {
	    				modulePopupVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    			}
	    		}	    		
	    	}
	    }
 	    
 	    modulePopupVO.setPopupSj(CmmXssUtil.unscript(modulePopupVO.getPopupSj()));
 	   	modulePopupVO.setPopupSjCn(CmmXssUtil.unscript(modulePopupVO.getPopupSjCn()));
 	    modulePopupVO.setPopupCn(CmmXssUtil.unscript(modulePopupVO.getPopupCn()));
 	   
		int result = modulePopupInfoService.registModulePopup(modulePopupVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	@RequestMapping(value={"/**/module/popup/modifyModulePopupForm.do","/{siteKey}/**/module/popup/modifyModulePopupForm.do"})
	public String modifyModulePopupForm(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			) throws Exception{

        /** 사이트 대분류(1차분류) 리스트 */
        SiteGroupVO paramVO = new SiteGroupVO();
        paramVO.setOdr("1");
        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(paramVO);
        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
        
		ModulePopupInfoVO resultVO = modulePopupInfoService.selectModulePopupDetail(modulePopupVO);

		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("POPUP_TY_CODE");

		model.addAttribute("resultVO", resultVO);
		model.addAttribute("codeList", codeList);
        
        List<ModulePopupTmplatVO> tmplatList = modulePopupInfoService.selectPopupTmplatList();
        model.addAttribute("tmplatList", tmplatList);
		
		return "wzwg/module/popup/popupModifyForm";
	}
	
	@RequestMapping(value="/**/module/popup/modifyModulePopupAjax.do")
	public ModelAndView modifyModulePopupAjax(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
		modulePopupVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		modulePopupVO.setUserId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
                resultList = fileUtil.parseFileInf(file, "POP_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "popup", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			if("thumbFile".equals(resultList.get(0).getName())) {
	    				modulePopupVO.setThumbFileId(fileService.insertFileInfs(resultList));
	    			} else if("atchFile".equals(resultList.get(0).getName())) {
	    				modulePopupVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    			}
	    		}	    		
	    	}
	    }

 	    modulePopupVO.setPopupSj(CmmXssUtil.unscript(modulePopupVO.getPopupSj()));
 	   	modulePopupVO.setPopupSjCn(CmmXssUtil.unscript(modulePopupVO.getPopupSjCn()));
 	    modulePopupVO.setPopupCn(CmmXssUtil.unscript(modulePopupVO.getPopupCn()));
 	    
		int result = modulePopupInfoService.modifyModulePopup(modulePopupVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	@RequestMapping(value="/**/module/popup/deleteModulePopupAjax.do")
	public ModelAndView deleteModulePopupAjax(
			@ModelAttribute("paramVO")ModulePopupInfoVO modulePopupVO
			, HttpServletRequest request
			, Model model
			){
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		modulePopupVO.setUserId(loginVO.getUserId());
		
		int result = modulePopupInfoService.deleteModulePopup(modulePopupVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}

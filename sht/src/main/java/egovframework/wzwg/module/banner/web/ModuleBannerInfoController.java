package egovframework.wzwg.module.banner.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.banner.service.ModuleBannerInfoService;
import egovframework.wzwg.module.banner.service.ModuleBannerInfoVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;

@Controller
public class ModuleBannerInfoController {
	
	 /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
    
    @Resource(name="ModuleBannerInfoService")
    public ModuleBannerInfoService bannerInfoService;

	/** 사이트 그룹 */
    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

    @Resource(name="SysMngrSiteAdiInfoService")
    public SysMngrSiteAdiInfoService sysMngrSiteAdiInfoService;
    /**
     * ㅁ 팝업관리 - 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/banner/selectModuleBannerInfoList.do")
    public String selectBannerMngrList(
            @ModelAttribute("paramVO") ModuleBannerInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception {

        paramVO.setPageUnit(propertyService.getInt("pageUnit"));
        paramVO.setPageSize(propertyService.getInt("pageSize"));

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());

        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        // 배너 목록
        List<ModuleBannerInfoVO> resultList = bannerInfoService.selectModuleBannerInfoList(paramVO);
        
        // 배너 총 갯수
        Integer resultCnt = bannerInfoService.selectBannerInfoTotCnt(paramVO);
        
        paginationInfo.setTotalRecordCount(resultCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", resultCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/module/banner/bannerInfoList";
    }
	
	
	/**
	 * 등록폼
	 */
    @RequestMapping(value="/**/module/banner/registModuleBannerInfoForm.do")
	public String registModuleBannerForm(
			@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {

		/** 사이트 대분류(1차분류) 리스트 */
        SiteGroupVO groupVO = new SiteGroupVO();
        groupVO.setOdr("1");
        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(groupVO);
        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
		
		return "wzwg/module/banner/bannerInfoRegistForm";
	}
	
    /**
	 * 수정폼
	 */
    @RequestMapping(value="/**/module/banner/modifyModuleBannerInfoForm.do")
	public String registModuleBannerDetail(
			@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {

		/** 사이트 대분류(1차분류) 리스트 */
        SiteGroupVO groupVO = new SiteGroupVO();
        groupVO.setOdr("1");
        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(groupVO);
        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
		
    	ModuleBannerInfoVO resultVO = bannerInfoService.selectModuleBannerInfoDetail(paramVO);
    	model.addAttribute("resultVO", resultVO);
		
		return "wzwg/module/banner/bannerInfoModifyForm";
	}
	
	/**
	 * 등록
	 * @throws Exception 
	 */
    @RequestMapping(value="/**/module/banner/registModuleBannerInfoAjax.do")
	public ModelAndView registModuleBannerInfoAjax(
			@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
			, HttpServletRequest request
			, MultipartHttpServletRequest multiRequest
			, Model model
			) throws Exception{
		
    	/** 사이트시퀀스 입력 */
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		resultList = fileUtil.parseFileInf(file, "BNR_", 0, "Globals.mdFilePath", "Globals.WhiteImgFileExt", multiRequest, "banner", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    				paramVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    		}	    		
	    	}
	    }
 	     	        
 	    
		int result = bannerInfoService.registModuleBannerInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 수정
	 */
    @RequestMapping(value="/**/module/banner/modifyModuleBannerInfoAjax.do")
	public ModelAndView modifyModuleBannerInfoAjax(
			@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
			, HttpServletRequest request
			, MultipartHttpServletRequest multiRequest
			, Model model
			) throws Exception {
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		resultList = fileUtil.parseFileInf(file, "BNR_", 0, "Globals.mdFilePath", "Globals.WhiteImgFileExt", multiRequest, "banner", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    				paramVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    		}	    		
	    	}
	    }
		
		int result = bannerInfoService.modifyModuleBannerInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 삭제
	 */
    @RequestMapping(value="/**/module/banner/deleteModuleBannerInfoAjax.do")
	public ModelAndView deleteModuleBannerInfoAjax(
			@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
    	CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	paramVO.setLastUpdusrId(loginVO.getUserId());
    	
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		int result = bannerInfoService.deleteModuleBannerInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
    
    /**
     * 진행중인 배너 목록
     */
    @RequestMapping(value="/**/module/banner/selectModuleBannerProgrsListAjax.do")
    public ModelAndView selectModuleBannerProgrsListAjax(
    		@ModelAttribute("paramVO")ModuleBannerInfoVO paramVO
    		, HttpServletRequest request
    		, Model model
    		) throws Exception {
    	
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	paramVO.setSiteSeq(siteSeq);
    	
    	SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
        sysMngrSiteAdiInfoVO.setSiteSeq(siteSeq);
        SysMngrSiteAdiInfoVO SysMngrSiteAdiInfo = new SysMngrSiteAdiInfoVO();
        SysMngrSiteAdiInfo = sysMngrSiteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
    	paramVO.setBannerLclCode(SysMngrSiteAdiInfo.getSiteLclasGroup());
        paramVO.setBannerMclCode(SysMngrSiteAdiInfo.getSiteMlsfcGroup());
    	
    	List<ModuleBannerInfoVO> bannerList = bannerInfoService.selectModuleMainBannerList(paramVO);

    	return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("list", bannerList).returnModelAndView();
    }
}

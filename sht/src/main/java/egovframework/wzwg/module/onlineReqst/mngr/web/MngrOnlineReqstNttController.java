package egovframework.wzwg.module.onlineReqst.mngr.web;

import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;


@Controller
public class MngrOnlineReqstNttController {
	
    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;	

    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    protected CmmCodeService codeService;

	@Resource(name="egovMessageSource")
	protected EgovMessageSource egovMessageSource;
	
    @Resource(name="MngrOnlineReqstNttService")
    protected MngrOnlineReqstNttService mngrOnlineReqstNttService;
    
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;    

	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
    
	@Resource(name="SysMngrUsrTyService")
	private SysMngrUsrTyService sysMngrUsrTyService;


	/*
	 * 온라인신청 정보 목록
	 */
    @RequestMapping(value= {"/mngr/module/onlineReqst/selectOnlineReqstNttListAjax.do","/{siteKey}/mngr/module/onlineReqst/selectOnlineReqstNttListAjax.do"})
    public String selectOnlineReqstNttList(
            @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));
    	
    	model.addAttribute("reqpscList", codeService.selectCmmCodeList("REQST_PS_CODE"));

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
    	
    	if(paramVO.getPageUnit() > 0) {
    		paramVO.setPageUnit(paramVO.getPageUnit());
    	} else {
    		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
    	}

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = mngrOnlineReqstNttService.selectOnlineReqstNttList(paramVO);
		int totCnt = Integer.parseInt((String)map.get("totCnt"));		
		
    	paginationInfo.setTotalRecordCount(totCnt);
    	
    	/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    	model.addAttribute("totCnt", totCnt);
    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	
        return "wzwg/module/onlineReqst/mngr/onlineReqstNttList";
    }      
    
	/*
	 * 온라인신청 정보 등록 폼
	 */
    @RequestMapping(value= {"/mngr/module/onlineReqst/registOnlineReqstNttFormAjax.do","/{siteKey}/mngr/module/onlineReqst/registOnlineReqstNttFormAjax.do"})
    public String registOnlineReqstNttForm(
    		@ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 
    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));	

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));   	
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    	}
    	
    	//model.addAttribute("usrGroupList", siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq()));

    	/********************* 회원유형 리스트 조회 ***************************/
		SysMngrUsrTyVO sysMngrUsrTyVO = new SysMngrUsrTyVO();
		sysMngrUsrTyVO.setUseAt("Y");
		sysMngrUsrTyVO.setFirstIndex(0);
		sysMngrUsrTyVO.setRecordCountPerPage(100000);
		sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

    	model.addAttribute("usrtyList", sysMngrUsrTyService.selectUsrTyList(sysMngrUsrTyVO));
    	/************************************************************/

        return "wzwg/module/onlineReqst/mngr/onlineReqstNttRegist";
    }    
    
	/*
	 * 온라인신청 정보 등록
	 */
    @RequestMapping(value= {"/mngr/module/onlineReqst/registOnlineReqstNttAjax.do","/{siteKey}/mngr/module/onlineReqst/registOnlineReqstNttAjax.do"})
    public ModelAndView resistOnlineReqstNtt(
            final MultipartHttpServletRequest multiRequest
            , @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   
    	
    	int result = 0;


        List<ModuleUploadFileVO> resultList = null;
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

    	if (!files.isEmpty()) {
    		resultList = fileUtil.parseFileInf(files, "REQ_", 0, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", null, CmmSessionUtil.getSessionSiteSeq(request));
    		if(resultList.size() > 0) {
    			String atchFileId =  fileService.insertFileInfs(resultList);
    			paramVO.setAtchFileId(atchFileId);
			}
    	}

    	
    	HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 	    
    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    		paramVO.setLastUpdusrId(loginVO.getUserId());
    	}
    	paramVO.setReqstnttSeq(mngrOnlineReqstNttService.selectNextReqstNttSeq(paramVO));
    	paramVO.setReqstnttCn(CmmXssUtil.unscript(paramVO.getReqstnttCn()));
    	
	    result = mngrOnlineReqstNttService.resistOnlineReqstNtt(paramVO);

		if(result > 0) {
			return CmmAjaxUtil.getAjaxReturn(paramVO.getReqstnttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }   

	/*
	 * 온라인신청 정보 수정 폼
	 */
    @RequestMapping(value= {"/mngr/module/onlineReqst/modifyOnlineReqstNttFormAjax.do","/{siteKey}/mngr/module/onlineReqst/modifyOnlineReqstNttFormAjax.do"})
    public String modifyOnlineReqstNttForm(
            @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 
    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));	
    	
    	model.addAttribute("reqpscList", codeService.selectCmmCodeList("REQST_PS_CODE"));

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));   	
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    	}
    	
    	//model.addAttribute("usrGroupList", siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq()));
    	
    	/********************* 회원유형 리스트 조회 ***************************/
		SysMngrUsrTyVO sysMngrUsrTyVO = new SysMngrUsrTyVO();
		sysMngrUsrTyVO.setUseAt("Y");
		sysMngrUsrTyVO.setFirstIndex(0);
		sysMngrUsrTyVO.setRecordCountPerPage(100000);
		sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

    	model.addAttribute("usrtyList", sysMngrUsrTyService.selectUsrTyList(sysMngrUsrTyVO));
    	/************************************************************/

    	
    	MngrOnlineReqstNttVO onlineReqstNttVO = mngrOnlineReqstNttService.selectOnlineReqstNttDetail(paramVO);
    	
    	List<MngrOnlineReqstNttVO> trgterUsrtyList = mngrOnlineReqstNttService.selectOnlineReqstNttTrgterList(paramVO);
    	
    	model.addAttribute("trgterUsrtyList", trgterUsrtyList);
    	model.addAttribute("onlineReqstNttVO", onlineReqstNttVO);

        return "wzwg/module/onlineReqst/mngr/onlineReqstNttModify";
    }     
    
	/*
	 * 온라인신청 정보 수정
	 */
    @RequestMapping(value= {"/mngr/module/onlineReqst/modifyOnlineReqstNttAjax.do","/{siteKey}/mngr/module/onlineReqst/modifyOnlineReqstNttAjax.do"})
    public ModelAndView modifyOnlineReqstNtt(
            final MultipartHttpServletRequest multiRequest
            , @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   
    	
    	int result = 0;

      List<ModuleUploadFileVO> resultList = null;
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

    	if (!files.isEmpty()) {
			if ("".equals(StringUtils.defaultString(paramVO.getAtchFileId()))) {
				resultList = fileUtil.parseFileInf(files, "REQ_", 0, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", paramVO.getAtchFileId(), CmmSessionUtil.getSessionSiteSeq(request));
				if(resultList != null) {
					if(resultList.size() > 0) {
						String atchFileId =  fileService.insertFileInfs(resultList);
						paramVO.setAtchFileId(atchFileId);
					}
				}
			} else {
			    ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			    fvo.setAtchFileId(paramVO.getAtchFileId());
			    int cnt = fileService.getMaxFileSN(fvo);
			    resultList = fileUtil.parseFileInf(files, "REQ_", cnt, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", paramVO.getAtchFileId(), CmmSessionUtil.getSessionSiteSeq(request));
			    
			    if(resultList != null) {
					if(resultList.size() > 0) {
						fileService.updateFileInfs(resultList);
					}
				}
			}	    		
    	}
    	
    	HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 	    
    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
    	if (loginVO != null) {
    		paramVO.setLastUpdusrId(loginVO.getUserId());
    	}
    	paramVO.setReqstnttCn(CmmXssUtil.unscript(paramVO.getReqstnttCn()));
    	
	    result = mngrOnlineReqstNttService.modifyOnlineReqstNtt(paramVO);
	    
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(paramVO.getReqstnttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}    	
    }     
    
	/*
	 * 온라인신청 정보 삭제
	 */
	@RequestMapping(value= {"/mngr/module/onlineReqst/deleteOnlineReqstNttAjax.do","/{siteKey}/mngr/module/onlineReqst/deleteOnlineReqstNttAjax.do"})
	public ModelAndView deleteOnlineReqstNtt(
            @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		if(paramVO.getReqstnttSeqChkStr() == null){
			result = mngrOnlineReqstNttService.deleteOnlineReqstNtt(paramVO);	
		}else{
			result = mngrOnlineReqstNttService.deleteCheckOnlineReqstNtt(paramVO);
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}    
	
	/*
	 * 온라인신청 정보 상세
	 */
	@RequestMapping(value= {"/mngr/module/onlineReqst/selectOnlineReqstNttDetailAjax.do","/{siteKey}/mngr/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"})
	public String selectOnlineReqstNttDetail(
            @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
		) throws Exception{ 

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 
    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));	
    	
    	model.addAttribute("reqpscList", codeService.selectCmmCodeList("REQST_PS_CODE"));

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));   	
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    	}
    	
    	model.addAttribute("usrGroupList", siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq()));
    	
    	MngrOnlineReqstNttVO onlineReqstNttVO = mngrOnlineReqstNttService.selectOnlineReqstNttDetail(paramVO);
    	
    	model.addAttribute("onlineReqstNttVO", onlineReqstNttVO);

    	return "wzwg/module/onlineReqst/mngr/onlineReqstNttDetail";
    }  
	
	/*
	 * 온라인신청 정보 상세 미리보기(일정 - 모듈연결)
	 */
	@RequestMapping(value= {"/mngr/module/onlineReqst/selectOnlineReqstNttPreviewAjax.do","/{siteKey}/mngr/module/onlineReqst/selectOnlineReqstNttPreviewAjax.do"})
	public String selectOnlineReqstNttPreview(
            @ModelAttribute("paramVO") MngrOnlineReqstNttVO paramVO
            , HttpServletRequest request
            , ModelMap model
		) throws Exception{ 

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
 
    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));	
    	
    	model.addAttribute("reqpscList", codeService.selectCmmCodeList("REQST_PS_CODE"));

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));   	
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    	}
    	
    	model.addAttribute("usrGroupList", siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq()));
    	
    	MngrOnlineReqstNttVO onlineReqstNttVO = mngrOnlineReqstNttService.selectOnlineReqstNttDetail(paramVO);
    	
    	model.addAttribute("onlineReqstNttVO", onlineReqstNttVO);

    	return "wzwg/module/onlineReqst/mngr/onlineReqstPreview";
    } 
	
}    
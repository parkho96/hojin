package egovframework.wzwg.module.onlineReqst.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;


@Controller
public class ModuleOnlineReqstNttController {
	
    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;	

    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    protected CmmCodeService codeService;

	@Resource(name="egovMessageSource")
	protected EgovMessageSource egovMessageSource;
	
    @Resource(name="ModuleOnlineReqstNttService")
    protected ModuleOnlineReqstNttService moduleOnlineReqstNttService;
    
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;    

	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;	

	/*
	 * 온라인신청 정보 목록
	 */
    @RequestMapping(value= {"/module/onlineReqst/selectOnlineReqstNttListAjax.do","/{siteKey}/module/onlineReqst/selectOnlineReqstNttListAjax.do"})
    public String selectOnlineReqstNttList(
            @ModelAttribute("paramVO") ModuleOnlineReqstNttVO paramVO
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
		
		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}else{
			paramVO.setUsrSeq("0");
		}
		
		List<ModuleOnlineReqstNttVO> resultList = moduleOnlineReqstNttService.selectOnlineReqstNttList(paramVO);
		int totCnt = moduleOnlineReqstNttService.selectOnlineReqstNttListTotCnt(paramVO);
		
    	paginationInfo.setTotalRecordCount(totCnt);
    	
    	/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    	model.addAttribute("totCnt", totCnt);
    	model.addAttribute("resultList", resultList);
    	model.addAttribute("paginationInfo", paginationInfo);
    	
        return "wzwg/module/onlineReqst/onlineReqstNttList";
    }      

	/*
	 * 온라인신청 정보 상세
	 */
	@RequestMapping(value= {"/module/onlineReqst/selectOnlineReqstNttDetailAjax.do","/{siteKey}/module/onlineReqst/selectOnlineReqstNttDetailAjax.do"})
	public String selectOnlineReqstNttDetail(
            @ModelAttribute("paramVO") ModuleOnlineReqstNttVO paramVO
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
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    	}
    	
    	model.addAttribute("usrGroupList", siteUsrGroupService.selectSiteUsrGroupCode(paramVO.getSiteSeq()));
    	
    	ModuleOnlineReqstNttVO onlineReqstNttVO = moduleOnlineReqstNttService.selectOnlineReqstNttDetail(paramVO);
    	
    	model.addAttribute("onlineReqstNttVO", onlineReqstNttVO);
    	
    	ModuleUploadFileVO fileVO = new ModuleUploadFileVO(); 
    	
    	fileVO.setAtchFileId(onlineReqstNttVO.getAtchFileId());
		
		List<ModuleUploadFileVO> fileList = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", fileList);

    	return "wzwg/module/onlineReqst/onlineReqstNttDetail";

    }  	
}    
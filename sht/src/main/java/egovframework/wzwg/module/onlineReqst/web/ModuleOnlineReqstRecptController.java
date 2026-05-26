package egovframework.wzwg.module.onlineReqst.web;

import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
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
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttVO;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstRceptService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstRceptVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;


@Controller
public class ModuleOnlineReqstRecptController {
	
    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;	

    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    protected CmmCodeService codeService;

	@Resource(name="egovMessageSource")
	protected EgovMessageSource egovMessageSource;
	
    @Resource(name="ModuleOnlineReqstRceptService")
    protected ModuleOnlineReqstRceptService moduleOnlineReqstRceptService;
    
    @Resource(name="ModuleOnlineReqstNttService")
    protected ModuleOnlineReqstNttService moduleOnlineReqstNttService;
    
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;    

	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;	

	/*
	 * 온라인신청접수 상세보기
	 */
    @RequestMapping(value= {"/module/onlineReqst/selectOnlineReqstRceptDetailAjax.do","/{siteKey}/module/onlineReqst/selectOnlineReqstRceptDetailAjax.do"})
    public String selectOnlineReqstRceptDetail(
            @ModelAttribute("paramVO") ModuleOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	model.addAttribute("reqcmcList", codeService.selectCmmCodeList("REQST_CM_CODE"));	
    	
    	model.addAttribute("reqpscList", codeService.selectCmmCodeList("REQST_PS_CODE"));
    	
    	model.addAttribute("reqcscList", codeService.selectCmmCodeList("REQST_CS_CODE"));
    	
    	ModuleOnlineReqstNttVO onlineReqstNttParamVO = new ModuleOnlineReqstNttVO();
    	
    	onlineReqstNttParamVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
    	onlineReqstNttParamVO.setReqstSeq(paramVO.getReqstSeq());
    	if (loginVO != null) {
    		onlineReqstNttParamVO.setUsrSeq(loginVO.getUsrSeq()); 
    	}
    	onlineReqstNttParamVO.setReqstnttSeq(paramVO.getReqstnttSeq());

    	ModuleOnlineReqstNttVO onlineReqstNttVO = moduleOnlineReqstNttService.selectOnlineReqstNttDetail(onlineReqstNttParamVO);	
    	
    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));   	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq()); 
    	}
    	paramVO.setReqstnttSeq(paramVO.getReqstnttSeq());
    	
    	ModuleOnlineReqstRceptVO onlineReqstRceptVO = new ModuleOnlineReqstRceptVO();
    	//SiteUsrGroupVO siteUsrGroupVO = new SiteUsrGroupVO();

    	//siteUsrGroupVO = moduleOnlineReqstRceptService.selectSiteUsrGroupInfo(paramVO);
    	
    	if (loginVO != null) {
    		onlineReqstRceptVO.setUserNm(loginVO.getUserNm());
    	}
    	
    	String rceptAt = moduleOnlineReqstRceptService.selectOnlineReqstRceptAt(paramVO);
    	
    	if("Y".equals(rceptAt)) {
    		onlineReqstRceptVO = moduleOnlineReqstRceptService.selectOnlineReqstRceptDetail(paramVO);
    	}
    	
    	//onlineReqstRceptVO.setUsrGroupSeq(siteUsrGroupVO.getUsrGroupSeq());
    	//onlineReqstRceptVO.setUsrGroupNm(siteUsrGroupVO.getUsrGroupNm());
    	
    	model.addAttribute("rceptAt", rceptAt);
    	
    	model.addAttribute("onlineReqstNttVO", onlineReqstNttVO);	
    	
    	model.addAttribute("onlineReqstRceptVO", onlineReqstRceptVO);	


    	return "wzwg/module/onlineReqst/onlineReqstRceptDetail";    		
    }  	

	/*
	 * 온라인신청 정보 등록
	 */
    @RequestMapping(value= {"/module/onlineReqst/registOnlineReqstRceptAjax.do","/{siteKey}/module/onlineReqst/registOnlineReqstRceptAjax.do"})
    public ModelAndView registOnlineReqstRcept(
            final MultipartHttpServletRequest multiRequest
            , @ModelAttribute("paramVO") ModuleOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   

    	int result = 0;

        List<ModuleUploadFileVO> resultList = null;
		
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

    	if (!files.isEmpty()) {
    		resultList = fileUtil.parseFileInf(files, "RCEPT_", 0, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", null, CmmSessionUtil.getSessionSiteSeq(request));
    		if(resultList.size() > 0) {
    			String atchFileId =  fileService.insertFileInfs(resultList);
    			paramVO.setAtchFileId(atchFileId);
			}
    	}

    	HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		ModuleOnlineReqstNttVO onlineReqstNttVO = new ModuleOnlineReqstNttVO();
		
		onlineReqstNttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
		onlineReqstNttVO.setReqstSeq(paramVO.getReqstSeq());
		if (loginVO != null) {
			onlineReqstNttVO.setUsrSeq(loginVO.getUsrSeq()); 
		}
		onlineReqstNttVO.setReqstnttSeq(paramVO.getReqstnttSeq());

		onlineReqstNttVO = moduleOnlineReqstNttService.selectOnlineReqstNttDetail(onlineReqstNttVO);
		
		String isOk = "N";

		if (onlineReqstNttVO != null) {
			if("SC00000109".equals(onlineReqstNttVO.getConfmMthdCode())) {// 자동승인(선착순)
		    	if("SC00000112".equals(onlineReqstNttVO.getProgrsSttusCode())) { // 접수중
		    		paramVO.setConfmSttusCode("SC00000118"); // 완로
		    		isOk = "Y";
		    	}
				if("SC00000113".equals(onlineReqstNttVO.getProgrsSttusCode())) { // 접수완료(승인처리중) : 정원 초과
					paramVO.setConfmSttusCode("SC00000116"); // 대기
					isOk = "Y";
				}
	    	}
			if("SC00000110".equals(onlineReqstNttVO.getConfmMthdCode())) {// 수동승인
				paramVO.setConfmSttusCode("SC00000115"); // 접수
				isOk = "Y";
			}
		}

		if("Y".equals(isOk)) {
	    	if (loginVO != null) {
		    	paramVO.setUsrSeq(loginVO.getUsrSeq());
		    	paramVO.setUserId(loginVO.getUserId());
		    	paramVO.setUserNm(loginVO.getUserNm());
		    	paramVO.setFrstRegisterId(loginVO.getUserId());
		    	paramVO.setLastUpdusrId(loginVO.getUserId());
	    	}
	
		    result = moduleOnlineReqstRceptService.registOnlineReqstRcept(paramVO);
		}

		if(result > 0) {
			return CmmAjaxUtil.getAjaxReturn(paramVO.getReqstnttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }  
    
	/*
	 * 온라인신청 정보 수정
	 */
    @RequestMapping(value= {"/module/onlineReqst/modifyOnlineReqstRceptAjax.do","/{siteKey}/module/onlineReqst/modifyOnlineReqstRceptAjax.do"})
    public ModelAndView modifyOnlineReqstRcept(
            final MultipartHttpServletRequest multiRequest
            , @ModelAttribute("paramVO") ModuleOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {   
    	
    	int result = 0;

    	List<ModuleUploadFileVO> resultList = null;

	    final Map<String, MultipartFile> files = multiRequest.getFileMap();

    	if (!files.isEmpty()) {
    		
			if (paramVO.getAtchFileId() == null || "".equals(paramVO.getAtchFileId())) {
				resultList = fileUtil.parseFileInf(files, "RCEPT_", 0, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", paramVO.getAtchFileId(), CmmSessionUtil.getSessionSiteSeq(request));
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
			    resultList = fileUtil.parseFileInf(files, "RCEPT_", cnt, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "onlineReqst", paramVO.getAtchFileId(), CmmSessionUtil.getSessionSiteSeq(request));
			    
			    if(resultList != null) {
					if(resultList.size() > 0) {
						fileService.updateFileInfs(resultList);
					}
				}
			    
			}	    		

    	}
  	
    	HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		ModuleOnlineReqstNttVO onlineReqstNttVO = new ModuleOnlineReqstNttVO();
		
		onlineReqstNttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request)); 
		onlineReqstNttVO.setReqstSeq(paramVO.getReqstSeq());
		if (loginVO != null) {
			onlineReqstNttVO.setUsrSeq(loginVO.getUsrSeq()); 
		}
		onlineReqstNttVO.setReqstnttSeq(paramVO.getReqstnttSeq());		
		
		onlineReqstNttVO = moduleOnlineReqstNttService.selectOnlineReqstNttDetail(onlineReqstNttVO);

    	if (loginVO != null) {
	    	paramVO.setUsrSeq(loginVO.getUsrSeq());
	    	paramVO.setUserId(loginVO.getUserId());
	    	paramVO.setUserNm(loginVO.getUserNm());
	    	paramVO.setLastUpdusrId(loginVO.getUserId());
    	}

	    result = moduleOnlineReqstRceptService.modifyOnlineReqstRcept(paramVO, onlineReqstNttVO);

		if(result > 0) {
			return CmmAjaxUtil.getAjaxReturn(paramVO.getRceptSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }      

}    
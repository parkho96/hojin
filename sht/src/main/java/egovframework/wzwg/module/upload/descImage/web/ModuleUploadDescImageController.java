package egovframework.wzwg.module.upload.descImage.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteFileProvdService;

@Controller
public class ModuleUploadDescImageController {
	@Resource(name = "ModuleUploadFileService")
    private ModuleUploadFileService fileService;
    
    @Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;

    @Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

	@Resource(name="SysMngrSiteFileProvdService")
	private SysMngrSiteFileProvdService siteFileProvdService;
	
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil moduleUploadFileUtil;
	
    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/module/upload/descImage/selectDescImageInc.do")
    public String selectDescImageInc(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO
    		, HttpServletRequest request
    		, @RequestParam Map<String, Object> commandMap
    		, ModelMap model
    	) throws Exception {

    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	//System.out.println("\n\n\n\n\n\n여기옵니다\n\n\n\n\n\n");
		String atchFileId = StringUtils.defaultString((String)commandMap.get("param_atchFileId"));
		String updateFlag = StringUtils.defaultString((String)commandMap.get("param_updateFlag"));
		String posblAtchFileNumber = StringUtils.defaultString((String)commandMap.get("param_atchFileNumber"));
		String helpAt = StringUtils.defaultString((String)commandMap.get("param_helpAt"));
		String sitecntntsSeq = StringUtils.defaultString((String)commandMap.get("param_sitecntntsSeq"));
		String cntntsSeq = StringUtils.defaultString((String)commandMap.get("param_cntntsSeq"));
		

		fileVO.setAtchFileId(atchFileId == "" ? fileVO.getAtchFileId() : atchFileId);
		fileVO.setUpdateFlag(updateFlag == "" ? "N" : updateFlag);
		fileVO.setPosblAtchFileNumber(posblAtchFileNumber);
		fileVO.setHelpAt(helpAt);
		fileVO.setSitecntntsSeq(sitecntntsSeq);
		fileVO.setCntntsSeq(cntntsSeq);
		
		List<ModuleUploadFileVO> estbsExtsnList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		// 이미지 유형만 허용하도록 변경
		List<ModuleUploadFileVO> resultList = new ArrayList<>();
		for (ModuleUploadFileVO moduleUploadFileVO : estbsExtsnList) {
			if(moduleUploadFileVO.getFileTyCode().equals("SC00000063")) {
				resultList.add(moduleUploadFileVO);
			}
		}
		
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/upload/descImage/descImageInc";
    }
    
    /**
     * 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/module/upload/descImage/selectDescImageList.do")
    public String selectDescImageList(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	SysMngrSiteAdiInfoVO resultVO = new SysMngrSiteAdiInfoVO();
    	resultVO.setSiteSeq(fileVO.getSiteSeq());
    	
    	resultVO = siteAdiInfoService.selectSiteAdiInfoDetail(resultVO);
    	
    	long siteFileSize = 0;
    	
    	if(resultVO != null && "Y".equals(resultVO.getFileProvdAt())){
    		siteFileSize = moduleUploadFileUtil.getFolderSize(request, resultVO.getFileCpctySe());
    		long fileProvdMg = Long.valueOf(resultVO.getFileProvdMg()).longValue();
    		
    		if(siteFileSize > fileProvdMg){
    			model.addAttribute("fileProvdExcess", "Y");
    		}
    	}
    	
    	List<ModuleUploadFileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", fileVO.getUpdateFlag());
		model.addAttribute("posblAtchFileNumber", fileVO.getPosblAtchFileNumber());
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/module/upload/descImage/descImageList";
    }
    
    /**
     * 첨부파일에 대한 삭제를 처리한다.
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/module/upload/descImage/deleteDescImageInfs.do")
    public ModelAndView deleteDescImageInfs(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	int resultDel = 0;
    	int result = 0;
    	
    	ModuleUploadFileVO resultVO = new ModuleUploadFileVO();
    	
    	resultVO = fileService.selectFileInf(fileVO);
    	
    	if(resultVO != null){
    		// 물리파일 삭제
    		String filePath = resultVO.getFileStreCours() + resultVO.getStreFileNm();
    		String thumbFilePath = resultVO.getThumbStreCours() + resultVO.getThumbFileNm();
    		
    		resultDel = ModuleUploadFileUtil.deleteFile(thumbFilePath);	// 썸네일
    		resultDel = ModuleUploadFileUtil.deleteFile(filePath);		// 원본
    	}
    	if(resultDel > 0){
    		result = fileService.deleteFileInf(fileVO);
    	}
	    
	    if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    /**
     * 첨부파일에 대한 설명 업데이트
     * 
     * @param fileVO
     * @param returnUrl
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/module/upload/descImage/updateImageFileDc.do")
    public ModelAndView updateImageFileDc(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    		) throws Exception {
    	
    	int result = 0;
    	
    	result = fileService.updateFileDc(fileVO);
    	
    	if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn("success");
    	}else{
    		return CmmAjaxUtil.getAjaxReturn("fail");
    	}
    }
}

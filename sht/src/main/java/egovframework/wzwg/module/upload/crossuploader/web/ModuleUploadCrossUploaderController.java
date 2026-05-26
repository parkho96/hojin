package egovframework.wzwg.module.upload.crossuploader.web;

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

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteFileProvdService;

@Controller
public class ModuleUploadCrossUploaderController {
	
	@Resource(name="ModuleUploadFileService")
    private ModuleUploadFileService fileService;
    
    @Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;

    @Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

	@Resource(name="SysMngrSiteFileProvdService")
	private SysMngrSiteFileProvdService siteFileProvdService;
	
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil moduleUploadFileUtil;
    
    
	/** crossuploader uploadForm 호출 */
    @RequestMapping("/**/module/upload/crossuploader/uploadForm.do")
    public String uploadForm(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO,
            HttpServletRequest request,
            @RequestParam Map<String, Object> commandMap,
            ModelMap model
        ) throws Exception {
        
    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
		String posblAtchFileNumber 	= StringUtils.defaultString((String)commandMap.get("param_atchFileNumber"));
		String sitecntntsSeq 		= StringUtils.defaultString((String)commandMap.get("param_sitecntntsSeq"));
		String cntntsSeq 			= StringUtils.defaultString((String)commandMap.get("param_cntntsSeq"));
		String mvpSe				= StringUtils.defaultString((String)commandMap.get("param_mvpSe"));
		

		fileVO.setPosblAtchFileNumber(posblAtchFileNumber);
		fileVO.setSitecntntsSeq(sitecntntsSeq);
		fileVO.setCntntsSeq(cntntsSeq);
		fileVO.setMvpSe(mvpSe);
    	
    	List<ModuleUploadFileVO> resultList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		model.addAttribute("resultList", resultList);
		
		SysMngrSiteAdiInfoVO resultVO = new SysMngrSiteAdiInfoVO();
		resultVO.setSiteSeq(fileVO.getSiteSeq());
		resultVO = siteAdiInfoService.selectSiteAdiInfoDetail(resultVO);
		model.addAttribute("resultVO", resultVO);
    	
        return "wzwg/module/upload/crossuploader/uploadForm";
    }
    
    /** crossuploader downloadForm 호출 */
    @RequestMapping("/**/module/upload/crossuploader/downloadForm.do")
    public String downloadForm(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO,
            HttpServletRequest request,
            @RequestParam Map<String, Object> commandMap,
            ModelMap model
        ) throws Exception {
    	
		String atchFileId = StringUtils.defaultString((String)commandMap.get("param_atchFileId"));
		fileVO.setAtchFileId(atchFileId);
		
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
        
        return "wzwg/module/upload/crossuploader/downloadForm";
    }

    /** crossuploader modifyForm 호출 */
    @RequestMapping("/**/module/upload/crossuploader/modifyForm.do")
    public String modifyForm(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO,
            HttpServletRequest request,
            @RequestParam Map<String, Object> commandMap,
            ModelMap model
        ) throws Exception {
        
    	String atchFileId 			= StringUtils.defaultString((String)commandMap.get("param_atchFileId"));
    	String posblAtchFileNumber 	= StringUtils.defaultString((String)commandMap.get("param_atchFileNumber"));
    	String sitecntntsSeq 		= StringUtils.defaultString((String)commandMap.get("param_sitecntntsSeq"));
		String cntntsSeq 			= StringUtils.defaultString((String)commandMap.get("param_cntntsSeq"));
		String mvpSe				= StringUtils.defaultString((String)commandMap.get("param_mvpSe"));
		
		fileVO.setAtchFileId(atchFileId);
		fileVO.setPosblAtchFileNumber(posblAtchFileNumber);
		fileVO.setSitecntntsSeq(sitecntntsSeq);
		fileVO.setCntntsSeq(cntntsSeq);
		fileVO.setMvpSe(mvpSe);
		
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
		
		ModuleUploadFileVO fvo = new ModuleUploadFileVO();
	    fvo.setAtchFileId(atchFileId);
	    model.addAttribute("idx", fileService.getMaxFileSN(fvo));
	    
		List<ModuleUploadFileVO> resultList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultVO", resultVO);
		
        return "wzwg/module/upload/crossuploader/modifyForm";
    }
	
}

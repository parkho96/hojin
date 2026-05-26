package egovframework.wzwg.module.upload.file.web;

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

import egovframework.com.cmm.service.EgovProperties;
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
public class ModuleUploadFileController {
	
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
    @RequestMapping("/**/module/upload/file/selectFileInc.do")
    public String selectFileInfs(
    		@ModelAttribute("fileVO") ModuleUploadFileVO fileVO
    		, HttpServletRequest request
    		, @RequestParam Map<String, Object> commandMap
    		, ModelMap model
    	) throws Exception {

    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
		String atchFileId = StringUtils.defaultString((String)commandMap.get("param_atchFileId"));
		String updateFlag = StringUtils.defaultString((String)commandMap.get("param_updateFlag"));
		String posblAtchFileNumber = StringUtils.defaultString((String)commandMap.get("param_atchFileNumber"));
		String helpAt = StringUtils.defaultString((String)commandMap.get("param_helpAt"));
		String sitecntntsSeq = StringUtils.defaultString((String)commandMap.get("param_sitecntntsSeq"));
		String cntntsSeq = StringUtils.defaultString((String)commandMap.get("param_cntntsSeq"));
		//String bbsSe = StringUtils.defaultString((String)commandMap.get("param_bbsSe"));
		String usemode = StringUtils.defaultString((String)commandMap.get("param_usemode"));
		
		if("".equals(sitecntntsSeq) || sitecntntsSeq == null) {
			sitecntntsSeq = fileVO.getSitecntntsSeq();
		}
		
		fileVO.setAtchFileId(atchFileId == "" ? null : atchFileId);
		fileVO.setUpdateFlag(updateFlag == "" ? "N" : updateFlag);
		fileVO.setPosblAtchFileNumber(posblAtchFileNumber);
		fileVO.setHelpAt(helpAt);
		fileVO.setSitecntntsSeq(sitecntntsSeq);
		fileVO.setCntntsSeq(cntntsSeq);
		fileVO.setUsemode(usemode);
		
		List<ModuleUploadFileVO> resultList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		model.addAttribute("resultList", resultList);
		//model.addAttribute("bbsSe", bbsSe);
		model.addAttribute("imgFileExt", EgovProperties.getProperty("Globals.WhiteImgFileExt"));
		
		return "wzwg/module/upload/file/fileInc";
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
    @RequestMapping("/**/module/upload/file/selectFileList.do")
    public String selectFileList(
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
		
		return "wzwg/module/upload/file/fileList";
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
    @RequestMapping("/**/module/upload/file/deleteFileInfs.do")
    public ModelAndView deleteFileInf(
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
     * 이미지 첨부파일에 대한 목록을 조회한다.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
    /*@RequestMapping("/module/upload/file/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("fileVO") ModuleUploadFileVO fileVO, @RequestParam Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
		List<ModuleUploadFileVO> result = fileService.selectImageFileList(fileVO);
		
		model.addAttribute("fileList", result);
	
		return "wzwg/module/upload/file/imageFileList";
    }
*/    
    /**
     * 첨부파일에 대한 목록을 조회해서 아이콘으로 표시.
     * 
     * @param fileVO
     * @param atchFileId
     * @param sessionVO
     * @param model
     * @return
     * @throws Exception
     */
   /* @RequestMapping("/module/upload/file/selectFileInfsIcon.do")
    public String selectFileInfsIcon(@ModelAttribute("fileVO") ModuleUploadFileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
		List<ModuleUploadFileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "wzwg/module/upload/file/fileListIcon";
    }*/
    
}

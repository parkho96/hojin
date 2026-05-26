package egovframework.wzwg.module.upload.file.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

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
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUsrFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUsrFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteFileProvdService;

@Controller
public class ModuleUsrFileController {
	
    @Resource(name = "ModuleUsrFileService")
    private ModuleUsrFileService fileService;
    
    @Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;

    @Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

	@Resource(name="SysMngrSiteFileProvdService")
	private SysMngrSiteFileProvdService siteFileProvdService;
	
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil moduleUploadFileUtil;
    
	 /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
    
    @RequestMapping({"/**/module/upload/usr/file/selectFileStore.do","/{siteKey}/**/module/upload/usr/file/selectFileStore.do"})
    public String selectFileStore(
    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	 
		
		return "wzwg/module/upload/usr/file/selectFileStore";
    }
    
    @RequestMapping("/**/module/upload/usr/file/selectFileListAjax.do")
    public String selectFileList(
    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	fileVO.setPageUnit(propertyService.getInt("pageUnit"));
    	fileVO.setPageSize(propertyService.getInt("pageSize"));

         PaginationInfo paginationInfo = new PaginationInfo();

         paginationInfo.setCurrentPageNo(fileVO.getPageIndex());
         paginationInfo.setRecordCountPerPage(fileVO.getPageUnit());
         paginationInfo.setPageSize(fileVO.getPageSize());

         fileVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
         fileVO.setLastIndex(paginationInfo.getLastRecordIndex());
         fileVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
         
    	
    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	List<ModuleUsrFileVO> result = fileService.selectUsrFileList(fileVO);
    	int resultCnt = fileService.selectUsrFileCnt(fileVO);
    	paginationInfo.setTotalRecordCount(resultCnt);
    	
    	/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("fileList", result);
		model.addAttribute("ctgryList", fileService.selectUsrFilectgryList(fileVO)); 
		model.addAttribute("resultCnt", resultCnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/upload/usr/file/selectFileList";
    }
    
    @RequestMapping("/**/module/upload/usr/file/selectFileEditorListAjax.do")
    public String selectFileEditorList(
    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {

    	fileVO.setPageUnit(5);
    	fileVO.setPageSize(5);

         PaginationInfo paginationInfo = new PaginationInfo();

         paginationInfo.setCurrentPageNo(fileVO.getPageIndex());
         paginationInfo.setRecordCountPerPage(fileVO.getPageUnit());
         paginationInfo.setPageSize(fileVO.getPageSize());

         fileVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
         fileVO.setLastIndex(paginationInfo.getLastRecordIndex());
         fileVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
         
    	
    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	List<ModuleUsrFileVO> result = fileService.selectUsrFileList(fileVO);
    	int resultCnt = fileService.selectUsrFileCnt(fileVO);
    	paginationInfo.setTotalRecordCount(resultCnt);
		model.addAttribute("fileList", result);
		model.addAttribute("ctgryList", fileService.selectUsrFilectgryList(fileVO)); 
		model.addAttribute("resultCnt", resultCnt);
        model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/upload/usr/file/selectFileEditorList";
    }
    
    
    @RequestMapping("/**/module/upload/usr/file/selectCtgryListAjax.do")
    public String selectCtgryList(
    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		model.addAttribute("ctgryList", fileService.selectUsrFilectgryList(fileVO)); 
		
		return "wzwg/module/upload/usr/file/selectCtgryList";
    }
    
   
    @RequestMapping("/**/module/upload/usr/file/deleteFileAjax.do")
    public ModelAndView deleteFileAjax(
    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	int resultDel = 0;
    	int result = 0;
    	fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	ModuleUsrFileVO resultVO = new ModuleUsrFileVO();
    	
    	resultVO = fileService.selectUsrFile(fileVO);
    	
    	if(resultVO != null){
    		// 물리파일 삭제
    		String filePath = resultVO.getFileStreCours() + resultVO.getStreFileNm(); 
    		
    		resultDel = ModuleUploadFileUtil.deleteFile(filePath);		// 원본 
    	}
    	
    	if(resultDel > 0){
    		 fileService.deleteUsrFile(fileVO);
    	}
	    
	    if(resultDel > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    @RequestMapping("/**/module/upload/usr/file/uploadFileAjax.do")
    public ModelAndView uploadImage(
            final MultipartHttpServletRequest multiRequest,
            @ModelAttribute("paramVO") ModuleUsrFileVO paramVO,
            ModelMap model
        ) throws Exception {
    	
        List<ModuleUploadImageVO> result = null;
        String usrimgId = "";
        
        HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(multiRequest));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
    	
        
        List<ModuleUsrFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	file.put(entry.getKey(), entry.getValue());
	    	if (!file.isEmpty()) {
	    		resultList = moduleUploadFileUtil.parseUsrFileInf(file, "FILE_", 0, "Globals.mdFilePath", "Globals.WhiteFileExt", multiRequest, "file",  CmmSessionUtil.getSessionSiteSeq(multiRequest));
	    	}
	    }
 	    if(resultList != null) {
 	    	if(resultList.size() > 0) {
		        for(int i =0;i <resultList.size();i++){
		        	ModuleUsrFileVO moduleUsrFile = resultList.get(i);
		    		
		        	moduleUsrFile.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(multiRequest));
					if (loginVO != null) {
						moduleUsrFile.setFrstRegisterId(loginVO.getUserId());
					}
		        	moduleUsrFile.setFilectgrySeq(paramVO.getFilectgrySeq());
		        	moduleUsrFile.setUsrfileNm(paramVO.getUsrfileNm());
		        	fileService.insertUsrFile(moduleUsrFile);
		        }
 	    	}
 	    }
          if(result == null){
        	  model.addAttribute("msg", egovMessageSource.getMessage("wzwg.cmm.msg.MSG501"));
          }else{
        	  model.addAttribute("msg", "");
          }
       return new ModelAndView("jsonView", model);
    }
    
    @RequestMapping("/**/module/upload/usr/file/registCtgryFileAjax.do")
    public ModelAndView registCtgry( 
            @ModelAttribute("paramVO") ModuleUsrFileVO paramVO,
             HttpServletRequest request,
            ModelMap model
        ) throws Exception {
    	
        List<ModuleUploadImageVO> result = null;
        String usrimgId = "";
        
        HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
    	fileService.insertUsrFilectgry(paramVO);
          
       return  CmmAjaxUtil.getAjaxReturn("success");
    }
    
    @RequestMapping("/**/module/upload/usr/file/deleteCtgryFileAjax.do")
    public ModelAndView deleteCtgry( 
            @ModelAttribute("paramVO") ModuleUsrFileVO paramVO,
             HttpServletRequest request,
            ModelMap model
        ) throws Exception {
    	
        List<ModuleUploadImageVO> result = null;
        String usrimgId = "";
        
        HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
    	fileService.deleteUsrFilectgry(paramVO);
          
       return  CmmAjaxUtil.getAjaxReturn("success");
    }
}

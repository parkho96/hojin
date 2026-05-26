package egovframework.wzwg.module.upload.image.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageService;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;


@Controller
@SuppressWarnings("unused")
public class ModuleUploadImageController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="ModuleUploadImageService")
    public ModuleUploadImageService imageUploadService;
    
    @Resource(name = "ModuleUploadImageUtil")
    private ModuleUploadImageUtil imageUploadUtil;
    
    @Resource(name="egovMessageSource")
    private EgovMessageSource egovMessageSource;
    
    /** 이미지 목록 */
    @RequestMapping("/**/module/upload/image/imageForm.do")
    public String imageForm(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if(loginVO != null){

            boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(loginVO.getUsrtySeq()))? true:false;

            // 슈퍼관리자 = 슈퍼관리자 사이트일때만
            if(sAdminChk && Globals.SUPER_SITE_SEQ.equals(paramVO.getSiteSeq())){
                paramVO.setUsrTySe("Y");
            }else{
                paramVO.setUsrTySe("N");
            }
                
        }   
        
        List<ModuleUploadImageVO> imageList = imageUploadService.selectImageList(paramVO);
        model.addAttribute("imageList", imageList);
        
        return "wzwg/module/upload/image/imageForm";
    }
    
    /** 이미지 목록 */
    @RequestMapping({"/**/module/upload/imageStore/imageForm.do","/{siteKey}/**/module/upload/imageStore/imageForm.do"})
    public String imageStoreForm(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if(loginVO != null){

            boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(loginVO.getUsrtySeq()))? true:false;

            // 슈퍼관리자 = 슈퍼관리자 사이트일때만
            if(sAdminChk && Globals.SUPER_SITE_SEQ.equals(paramVO.getSiteSeq())){
                paramVO.setUsrTySe("Y");
            }else{
                paramVO.setUsrTySe("N");
            }
                
        }   
        
        List<ModuleUploadImageVO> imageList = imageUploadService.selectImageList(paramVO);
        model.addAttribute("imageList", imageList);
        
        List<ModuleUploadImageVO> searchSiteList = imageUploadService.selectSearchSiteList(paramVO);
        model.addAttribute("searchSiteList", searchSiteList);
        
        return "wzwg/module/upload/image/imageStoreForm";
    }
    
    @RequestMapping({"/**/module/upload/imageStore/imageNewForm.do","/{siteKey}/**/module/upload/imageStore/imageNewForm.do"})
    public String imageNewForm(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if(loginVO != null){

            boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(loginVO.getUsrtySeq()))? true:false;

            // 슈퍼관리자 = 슈퍼관리자 사이트일때만
            if(sAdminChk && Globals.SUPER_SITE_SEQ.equals(paramVO.getSiteSeq())){
                paramVO.setUsrTySe("Y");
            }else{
                paramVO.setUsrTySe("N");
            }
                
        }   
        
        List<ModuleUploadImageVO> imageList = imageUploadService.selectImageList(paramVO);
        model.addAttribute("imageList", imageList);
        
        List<ModuleUploadImageVO> searchSiteList = imageUploadService.selectSearchSiteList(paramVO);
        model.addAttribute("searchSiteList", searchSiteList);
        
        return "wzwg/module/upload/image/imageStoreNewForm";
    }
    
    /** 이미지 목록 */
    @RequestMapping("/**/module/upload/image/selectImageList.do")
    public String selectImageList(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            @RequestParam(value="scrollPageIdx", required=false) String scrollPageIdx,
            @RequestParam(value="searchFolderId", required=false) String searchFolderId,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
        
    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){

			boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(loginVO.getUsrtySeq()))? true:false;

            // 슈퍼관리자 = 슈퍼관리자 사이트일때만
            if(sAdminChk && Globals.SUPER_SITE_SEQ.equals(paramVO.getSiteSeq())){
				paramVO.setUsrTySe("Y");
			}else{
				paramVO.setUsrTySe("N");
			}
				
		}	

		int result = 0;
		
        if(paramVO.getScrollPageIdx() > 0){
        	result = 20 * paramVO.getScrollPageIdx();
        }
        
        if(searchFolderId != null && paramVO.getImgfolderId() == null){
        	paramVO.setSearchFolderId(searchFolderId);
        }else{
        	paramVO.setSearchFolderId(paramVO.getImgfolderId());
        }
        
		paramVO.setScrollPageIdx(result);

		List<ModuleUploadImageVO> imageList = imageUploadService.selectImageList(paramVO);
        model.addAttribute("imageList", imageList);
        
        model.addAttribute("imageVO", paramVO);
        
        return "wzwg/module/upload/image/imageList";
    }
    
    /** 폴더 목록 */
    @RequestMapping("/**/module/upload/image/selectFolderList.do")
    public String selectFolderList(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
        
    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){

			boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(loginVO.getUsrtySeq()))? true:false;
			
			// 슈퍼관리자 = 슈퍼관리자 사이트일때만
			if(sAdminChk && Globals.SUPER_SITE_SEQ.equals(paramVO.getSiteSeq())){
				paramVO.setUsrTySe("Y");
			}else{
				paramVO.setUsrTySe("N");
			}
				
		}	
		
    	List<ModuleUploadImageVO> folderList = imageUploadService.selectFolderList(paramVO);
        model.addAttribute("folderList", folderList);
        
        List<ModuleUploadImageVO> subFolderList = imageUploadService.selectSubFolderList(paramVO);
        model.addAttribute("subFolderList", subFolderList);
        
        if(folderList.size() > 0){
        	model.addAttribute("totCnt", folderList.get(0).getTotCnt());
        }else{
        	model.addAttribute("totCnt", 0);
        } 
        model.addAttribute("paramVO", paramVO);
        
        return "wzwg/module/upload/image/folderList";
    }
    
    /** 폴더 생성 */
    @RequestMapping("/**/module/upload/image/registFolder.do")
    public String registFolder(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
    	
    	imageUploadService.registFolder(paramVO);
            
        return "forward:"+wzwgContext+"/module/upload/image/selectFolderList.do";
    }
    
    /** 폴더 수정 */
    @RequestMapping("/**/module/upload/image/modifyFolder.do")
    public String modifyFolder(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		//paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
    	
    	imageUploadService.modifyFolder(paramVO);
            
        return "forward:"+wzwgContext+"/module/upload/image/selectFolderList.do";
    }
    
    /** 폴더 삭제 */
    @RequestMapping("/**/module/upload/image/deleteFolder.do")
    public String deleteFolder(
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            HttpServletRequest request,
            ModelMap model
        ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	//paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	imageUploadService.deleteFolder(paramVO);
            
        return "forward:"+wzwgContext+"/module/upload/image/selectFolderList.do";
    }
    
    /** 이미지 업로드 */
    @RequestMapping("/**/module/upload/image/uploadImage.do")
    public ModelAndView uploadImage(
    		HttpServletRequest request,
    		HttpSession rsess,
            final MultipartHttpServletRequest multiRequest,
            @ModelAttribute("paramVO") ModuleUploadImageVO paramVO,
            ModelMap model
        ) throws Exception {
    	
        List<ModuleUploadImageVO> result = null;
        String usrimgId = "";
    	System.out.println("rsess: "+rsess);
    //	System.out.println("rsess get: "+rsess.getAttribute("SITE_SEQ"));
        HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		System.out.println("CmmSessionUtil.getSessionSiteSeq(request) : "+CmmSessionUtil.getSessionSiteSeq(request));
		
		 session = multiRequest.getSession();
		 
		 System.out.println("CmmSessionUtil.getSessionSiteSeq(multiRequest) : "+CmmSessionUtil.getSessionSiteSeq(request));
		 
		 
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
    	
    	// 폴더 권한 체크 : 1. 시스템관리자에서 접근시 모든권한 허용 2. 자신의 사이트에서 개설된 사이트일 경우만 허용
    	// return 1 : 권한있음 그외는 오류
    	int useFolderAuth = imageUploadService.selectFolderImageCheck(paramVO);
    	
    	if(useFolderAuth != 1) {
    		model.addAttribute("msg", egovMessageSource.getMessage("wzwg.cmm.msg.MSG416"));
    	    return new ModelAndView("jsonView", model);
    	}
    	
    	
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
  Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
 	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
        	paramVO.setUsrimgId(imageUploadService.getNextUsrimgId());
        	
        	result = imageUploadUtil.parseFileInf(file, paramVO, multiRequest);
        	
        	if(result != null){
        		usrimgId = imageUploadService.uploadImage(result);
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
    
    
    
}
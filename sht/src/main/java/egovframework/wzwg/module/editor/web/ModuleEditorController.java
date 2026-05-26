package egovframework.wzwg.module.editor.web;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleEditorController {
	
	/** editorForm 호출 */
    @RequestMapping("/**/module/editor/editorForm.do")
    public String editorForm(
            HttpServletRequest request,
            @RequestParam Map<String, Object> commandMap,
            ModelMap model
        ) throws Exception {
		
    	model.addAttribute("editorNm", 			StringUtils.defaultString((String)commandMap.get("param_editorNm")));
		model.addAttribute("editorTy", 			StringUtils.defaultString((String)commandMap.get("param_editorTy")));
		model.addAttribute("editorSe", 			EgovProperties.getProperty("Globals.editorEstbs"));
    	
        return "wzwg/module/editor/editorForm";
    }
    	
    /**
     * wizOnEditor 파일 업로드
     */
    @RequestMapping(value="/**/module/wizOnEditor/uploadImageAjax.do")
	public ModelAndView uploadImageAjax(
			 MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
    	CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
    	//if(loginVO == null) {
    	//	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").setResultCode("err001").returnModelAndView();
    	//}

    	
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);//저장폴더에 사이트 시퀀스로 구별(컨텐츠 이관목적) 2019.08.08 조원권
    	
    	if("".equals(siteSeq) && request.getHeader("REFERER") != null && request.getHeader("REFERER").indexOf("/wizonEditor/sample.jsp") > -1){
    		siteSeq = "sampletest";
    	}
		
		
		String serverPath = request.getSession().getServletContext().getRealPath("/");
	    //파일 기본경로 _ 상세경로
	    String webPath = EgovProperties.getProperty("Globals.editorImageStorePath") + "multiupload/" + siteSeq + "/";

	    
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
	    String today = formatter.format(new java.util.Date());
	    
	    ArrayList<String> srcList = new ArrayList<>();
        
	    List<MultipartFile> multiFileList = multiRequest.getFiles("woeImage");
	    
	    for (MultipartFile srcFile : multiFileList) {
 	    	String filename = srcFile.getOriginalFilename();
 	       
 	        //파일 확장자
 	        String filename_ext = "";
 	        if (filename != null && filename.lastIndexOf(".") != -1) {
 	        	filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
 	        }
 	       
 	        String fileContentType = srcFile.getContentType();
 	       
 	        long fileSize = srcFile.getSize();
 	        
 	    	String realFileNm = today + UUID.randomUUID().toString() + "." + filename_ext;
 	        String saveDir = serverPath + webPath;
 	        String saveFilePath = saveDir + realFileNm;
 	       
 	        File saveFolder = new File(saveDir);
 	        if (!saveFolder.exists() || saveFolder.isFile()) {
 	        	if(!saveFolder.mkdirs()) {
 	        		log.info(saveFolder+" : directory make fail ");
 	        	}
 	        }
 	       
 	        File saveFile = new File(saveFilePath);
 	       
 	    	srcFile.transferTo(saveFile);
 	    	
 	    	srcList.add(webPath + realFileNm);
	    }
	  //final Map<String, MultipartFile> files = multiRequest.getFileMap();
	  //Iterator<String> itr = files.keySet().iterator();// entrySet().iterator();
 	    //while (itr.hasNext()) {
 	    //	MultipartFile srcFile = files.get(itr.next());
 	    //	String filename = srcFile.getOriginalFilename();
 	    //   
 	    //    //파일 확장자
 	    //    String filename_ext = filename.substring(filename.lastIndexOf(".") + 1);
 	    //   
 	    //    String fileContentType = srcFile.getContentType();
 	    //   
 	    //    long fileSize = srcFile.getSize();
 	    //    
 	    //	String realFileNm = today + UUID.randomUUID().toString() + "." + filename_ext;
 	    //    String saveDir = serverPath + webPath;
 	    //    String saveFilePath = saveDir + realFileNm;
 	    //   
 	    //    File saveFolder = new File(saveDir);
 	    //    if (!saveFolder.exists() || saveFolder.isFile()) {
 	    //    	if(!saveFolder.mkdirs()) {
 	    //    		LOG.info(saveFolder+" : directory make fail ");
 	    //    	}
 	    //    }
 	    //   
 	    //    File saveFile = new File(saveFilePath);
 	    //   
 	    //	srcFile.transferTo(saveFile);
 	    //	
 	    //	srcList.add(webPath + realFileNm);
	    //}
 	    
 	   return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("srcList", srcList).returnModelAndView();
	}
}

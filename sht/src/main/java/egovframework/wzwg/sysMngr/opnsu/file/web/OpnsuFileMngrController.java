package egovframework.wzwg.sysMngr.opnsu.file.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileMngrService;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;


@Controller
@Slf4j
public class OpnsuFileMngrController {
	
    @Resource(name = "OpnsuFileMngrService")
    private OpnsuFileMngrService fileService;


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
    @RequestMapping("/**/opnsu/file/selectFileInc.do")
    public String selectFileInfs(
    		@ModelAttribute("fileVO") OpnsuFileVO fileVO
    		, @RequestParam Map<String, Object> commandMap
    		, ModelMap model
    	) throws Exception {
    	
		String atchFileId = StringUtils.defaultString((String)commandMap.get("param_atchFileId"));
		String updateFlag = StringUtils.defaultString((String)commandMap.get("param_updateFlag"));

		fileVO.setAtchFileId(atchFileId == "" ? fileVO.getAtchFileId() : atchFileId);
		fileVO.setUpdateFlag(updateFlag == "" ? "N" : updateFlag);
		
		return "wzwg/sysMngr/opnsu/file/fileInc";
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
    @RequestMapping("/**/opnsu/file/selectFileList.do")
    public String selectFileList(
    		@ModelAttribute("fileVO") OpnsuFileVO fileVO
    		, ModelMap model
    	) throws Exception {

    	List<OpnsuFileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", fileVO.getUpdateFlag());
		model.addAttribute("fileListCnt", result.size());
		
		return "wzwg/sysMngr/opnsu/file/fileList";
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
    @RequestMapping("/**/opnsu/file/deleteFileInfs.do")
    public ModelAndView deleteFileInf(
    		@ModelAttribute("fileVO") OpnsuFileVO fileVO
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {
    	
    	int result = 0;
    	
	    result = fileService.deleteFileInf(fileVO);
	    
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
    @RequestMapping("/**/opnsu/file/selectImageFileInfs.do")
    public String selectImageFileInfs(@ModelAttribute("fileVO") OpnsuFileVO fileVO, @RequestParam Map<String, Object> commandMap,
	    //SessionVO sessionVO,
	    ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
		List<OpnsuFileVO> result = fileService.selectImageFileList(fileVO);
		
		model.addAttribute("fileList", result);
	
		return "wzwg/sysMngr/opnsu/file/imageFileList";
    }
    
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
    @RequestMapping("/**/opnsu/file/selectFileInfsIcon.do")
    public String selectFileInfsIcon(@ModelAttribute("fileVO") OpnsuFileVO fileVO, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
		List<OpnsuFileVO> result = fileService.selectFileInfs(fileVO);
	
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "N");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "wzwg/sysMngr/opnsu/file/fileListIcon";
    }
    
    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = {"/opnsu/file/fileDown.do","/{siteKey}/opnsu/file/fileDown.do"})    
    public void cvplFileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
	
	    OpnsuFileVO fileVO = new OpnsuFileVO();
	    fileVO.setAtchFileId(atchFileId);
	    fileVO.setFileSn(fileSn);
	    OpnsuFileVO fvo = fileService.selectFileInf(fileVO);

	    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";
	
			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(fvo.getOrignlFileNm(), request, response);
			response.setContentLength(fSize);
	
			try (
				BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
				BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			){
			    FileCopyUtils.copy(in, out);
			    out.flush();
			} catch (RuntimeException e2) {
				log.error("RuntimeException",e2);
			} catch (FileNotFoundException e) {
				log.error("FileNotFoundException",e);
			} catch (IOException e) {
				log.error("IOException",e);
			}

	    } else {
			response.setContentType("application/x-msdownload");
	
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fvo.getOrignlFileNm() + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }
    }
    
    /**
     * 브라우저 구분 얻기.
     * 
     * @param request
     * @return
     */
    private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        if (header != null) {
			if (header.indexOf("Trident") > -1) {
				return "MSIE";
			} else if(header.indexOf("MSIE") > -1) {
				return "MSIE";
			} else if (header.indexOf("Chrome") > -1) {
				return "Chrome";
			} else if (header.indexOf("Opera") > -1) {
				return "Opera";
			} else if (header.indexOf("Firefox") > -1) {
				return "Firefox";
			}
		}
	    return "";
	}
    
    /**
     * Disposition 지정하기.
     * 
     * @param filename
     * @param request
     * @param response
     * @throws Exception
     */
    private void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
    	String browser = getBrowser(request);
	
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
	
		if (browser.equals("MSIE")) {
		    encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
		    encodedFilename = "\"" + new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
		    StringBuffer sb = new StringBuffer();
		    for (int i = 0; i < filename.length(); i++) {
			char c = filename.charAt(i);
			if (c > '~') {
			    sb.append(URLEncoder.encode("" + c, "UTF-8"));
			} else {
			    sb.append(c);
			}
		    }
		    encodedFilename = sb.toString();
		} else {
		    //throw new RuntimeException("Not supported browser");
		    throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);
	
		if ("Opera".equals(browser)){
		    response.setContentType("application/octet-stream;charset=UTF-8");
		}
    }        
}

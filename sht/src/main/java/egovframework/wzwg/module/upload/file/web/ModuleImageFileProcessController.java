package egovframework.wzwg.module.upload.file.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.IllegalFormatException;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;


/**
 * @Class Name : EgovImageProcessController.java
 * @Description :
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 4. 2.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 4. 2.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
@Controller
public class ModuleImageFileProcessController {

	@Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
	
	@Autowired
	HttpServletRequest request;
	
    private static final Logger LOG = Logger.getLogger(ModuleImageFileProcessController.class.getName());

    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     *
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/**/module/upload/file/selectImageView.do")
    public void getImageInf(@RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		String noImgType = (String)commandMap.get("type");
		
		ModuleUploadFileVO vo = new ModuleUploadFileVO();
	
		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);
	
		ModuleUploadFileVO fvo = fileService.selectFileInf(vo);
	
		// 2011.10.10 보안점검 후속조치
		File file = null;
		FileInputStream fis = null;
	
		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		//ServletOutputStream sStream = null;
		
		try {
		    file = new File(fvo.getThumbStreCours(), fvo.getThumbFileNm());
		    fis = new FileInputStream(file);
	
		    in = new BufferedInputStream(fis);
		    bStream = new ByteArrayOutputStream();
	
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
			bStream.write(imgByte);
		    }
	
			String type = "";
		
			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
			    if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
				type = "image/jpeg";
			    } else {
				type = "image/" + fvo.getFileExtsn().toLowerCase();
			    }
			  //  type = "image/" + fvo.getFileExtsn().toLowerCase();
		
			} else {
			    LOG.debug("Image fileType is null.");
			}
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			//sStream = response.getOutputStream();
			
			//response.getOutputStream().flush();
			
			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();
	
			// 2011.10.10 보안점검 후속조치 끝
		}catch(NullPointerException e){
			LOG.error("NullPointerException",e);
			defaultNoImage(response, noImgType);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   		defaultNoImage(response, noImgType);
	   	} finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
			if (in != null) {
				try {
					in.close();
				} catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
		}
    }
    
    private void defaultNoImage(HttpServletResponse response, String noImgType) {
    	
    	FileInputStream fis = null;
    	BufferedInputStream in = null;
    	
    	try {
    		String webRoot = "";
    		if (request.getSession() != null) {
    			webRoot = request.getSession().getServletContext().getRealPath("");
    		}
    		
    		if (webRoot != null && webRoot.length() > 0) {
    			String lastPoint = webRoot.substring(webRoot.length()-1, webRoot.length());
    			if("/".equals(lastPoint) || "\\".equals(lastPoint)) {
    				webRoot = webRoot.substring(0, webRoot.length()-1);
    			}
    		}
    		
    		String noImgPath = "";
    		
    		if(noImgType == null || "".equals(noImgType)) {
    			noImgPath = "/images/wzwg/site/noImg/noImageLogo_s.jpg";
    		}else {
    			noImgPath = "/images/wzwg/site/noImg/noImageLogo_"+noImgType+".jpg";
    		}
    		
    		File file = null;
    	
    		
    		ByteArrayOutputStream bStream = null;
    		file = new File(FilenameUtils.separatorsToSystem(webRoot + noImgPath));
   			fis = new FileInputStream(file);
   			
		    in = new BufferedInputStream(fis);
		    bStream = new ByteArrayOutputStream();
	
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
			bStream.write(imgByte);
		    }
	
			String type = "image/jpeg";
		
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			//sStream = response.getOutputStream();
			
			//response.getOutputStream().flush();
			
			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (RuntimeException e2) {
			// TODO: handle exception
			LOG.error("RuntimeException",e2);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			LOG.error("FileNotFoundException",e);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			LOG.error("IOException",e);
		}finally {
			try {
				if(response.getOutputStream() != null) {
					response.getOutputStream().close();
				}
				
				if(fis != null) {
					fis.close();
				}
				
				if(in != null) {
					in.close();
				}
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				LOG.error("IOException",e);
			}
		}
    }
    
    /**
     * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
     *
     * @param atchFileId
     * @param fileSn
     * @param sessionVO
     * @param model
     * @param response
     * @throws Exception
     */
    @RequestMapping(value="/**/module/upload/file/selectOrignlImageView.do")
    public void getOrignlImageInf(@RequestParam Map<String, Object> commandMap, HttpServletResponse response) throws Exception {

		String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		String noImgType = (String)commandMap.get("type");
	
		ModuleUploadFileVO vo = new ModuleUploadFileVO();
	
		vo.setAtchFileId(atchFileId);
		vo.setFileSn(fileSn);
	
		ModuleUploadFileVO fvo = fileService.selectFileInf(vo);
	
		// 2011.10.10 보안점검 후속조치
		File file = null;
		FileInputStream fis = null;
	
		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		//ServletOutputStream sStream = null;
		
		try {
		    file = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		    fis = new FileInputStream(file);
	
		    in = new BufferedInputStream(fis);
		    bStream = new ByteArrayOutputStream();
	
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
			bStream.write(imgByte);
		    }
	
			String type = "";
		
			if (fvo.getFileExtsn() != null && !"".equals(fvo.getFileExtsn())) {
			    if ("jpg".equals(fvo.getFileExtsn().toLowerCase())) {
				type = "image/jpeg";
			    } else {
				type = "image/" + fvo.getFileExtsn().toLowerCase();
			    }
			    
		
			} else {
			    LOG.debug("Image fileType is null.");
			}
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			//sStream = response.getOutputStream();
			
			//response.getOutputStream().flush();
			
			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
			response.getOutputStream().close();
	
			// 2011.10.10 보안점검 후속조치 끝
		}catch(NullPointerException e){
			LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   		defaultNoImage(response, noImgType);
	   	}finally {
			if (bStream != null) {
				try {
					bStream.close();
				} catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
			if (in != null) {
				try {
					in.close();
				} catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
			if (fis != null) {
				try {
					fis.close();
				}catch(NullPointerException e){
					LOG.error("NullPointerException",e);
			   	}catch(NumberFormatException e){
			   		LOG.error("NumberFormatException",e);
			   	}catch(IllegalFormatException e){
			   		LOG.error("IllegalFormatException",e);
			   	}catch(ArrayIndexOutOfBoundsException e){
			   		LOG.error("ArrayIndexOutOfBoundsException",e);
			   	}catch(IOException e){
			   		LOG.error("IOException",e);
			   	}
			}
		}
    }
}

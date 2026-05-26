package egovframework.wzwg.module.upload.image.web;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.IllegalFormatException;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageService;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;


/**
 * 파일 다운로드를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.3.25  이삼섭          최초 생성
 *
 * Copyright (C) 2009 by MOPAS  All right reserved.
 * </pre>
 */
@Controller
public class ModuleUploadImageUtilController {
	
    @Resource(name = "ModuleUploadImageService")
    private ModuleUploadImageService imageUploadService;
    
    @Autowired
	HttpServletRequest request;
    
    private static final Logger LOG = Logger.getLogger(ModuleUploadImageUtilController.class.getName());
    
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

    /** 이미스토어 다운로드 저작권 이슈로 삭제 2026.01.23 */
    
    /** 이미지 상세정보 */
    @RequestMapping("/**/module/upload/image/selectImageDetail.do")
    public void selectImageDetail(
    		ModelMap model
    		, @RequestParam Map<String, Object> commandMap
    		, HttpServletRequest request
    		, HttpServletResponse response
    	) throws Exception {

		String usrimgId = (String)commandMap.get("usrimgId");
		String noImgType = (String)commandMap.get("type");
		
		ModuleUploadImageVO vo = new ModuleUploadImageVO();
	
		vo.setUsrimgId(usrimgId);
	
		ModuleUploadImageVO fvo = imageUploadService.selectImageDetail(vo);
	
		// 2011.10.10 보안점검 후속조치
		File file = new File(fvo.getImageStreCours(), fvo.getStreImageNm());

		try (
			FileInputStream fis = new FileInputStream(file);
			BufferedInputStream in = new BufferedInputStream(fis);
			ByteArrayOutputStream bStream = new ByteArrayOutputStream();
		){
	
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
		    	bStream.write(imgByte);
		    }
	
			String type = "";
		
			if (fvo.getImageExtsn() != null && !"".equals(fvo.getImageExtsn())) {
			    if ("jpg".equals(fvo.getImageExtsn().toLowerCase())) {
			    	type = "image/jpeg";
			    } else {
			    	type = "image/" + fvo.getImageExtsn().toLowerCase();
			    }
		
			} else {
			    LOG.debug("Image fileType is null.");
			}
		
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());
			
			try (OutputStream out = response.getOutputStream()) {
	            bStream.writeTo(out);
	            out.flush();
	        }
	
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
	   	}
    }
    
    
    /** 이미지 삭제 */
    @RequestMapping("/**/module/upload/image/deleteImage.do")
    public ModelAndView deleteImage(
    		@ModelAttribute("paramVO") ModuleUploadImageVO vo
    		, final MultipartHttpServletRequest multiRequest
    		, ModelMap model
    	) throws Exception {

    	int result = 0;
    	
    	result = imageUploadService.deleteImage(vo);
	    
	   // String filePath = vo.getImageStreCours()+vo.getStreImageNm();
    	
    	//ModuleUploadImageUtil.deleteFile(filePath);
	    	
    	if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}

    }
    
    private void defaultNoImage(HttpServletResponse response, String noImgType) {
    	// 1. Session 및 Context 체크
        HttpSession session = request.getSession(false); // false: 없으면 새로 만들지 않음
        if (session == null || session.getServletContext() == null) {
            LOG.error("Session or ServletContext is null");
            return; 
        }

        // 2. RealPath 체크 (가장 빈번한 null 발생 지점)
        String webRoot = session.getServletContext().getRealPath("/");
        if (webRoot == null) {
            LOG.error("Cannot find WebRoot path");
            return;
        }

        // 3. 경로 정규화 (기존 substring 로직을 File 객체로 대체하여 안전하게 처리)
        File rootFile = new File(webRoot);
        String normalizedRoot = rootFile.getAbsolutePath();

        String noImgPath = (noImgType == null || "".equals(noImgType)) 
                           ? "/images/wzwg/site/noImg/noImageLogo_s.jpg" 
                           : "/images/wzwg/site/noImg/noImageLogo_" + noImgType + ".jpg";

		File file = new File(FilenameUtils.separatorsToSystem(webRoot + noImgPath));

    	try (
			FileInputStream fis = new FileInputStream(file);
	        BufferedInputStream in = new BufferedInputStream(fis);
	        ByteArrayOutputStream bStream = new ByteArrayOutputStream();
		){
		    int imgByte;
		    while ((imgByte = in.read()) != -1) {
		    	bStream.write(imgByte);
		    }
	
			String type = "image/jpeg";
			
			response.setHeader("Content-Type", type);
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
		} catch (RuntimeException e2) {
			LOG.error("F_RuntimeException",e2);
		} catch (FileNotFoundException e) {
			LOG.error("F_FileNotFoundException",e);
		} catch (IOException e) {
			LOG.error("F_IOException",e);
		}
    }
    
}

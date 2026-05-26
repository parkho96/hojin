package egovframework.wzwg.module.upload.file.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.IllegalFormatException;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.file.service.ModuleUsrFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUsrFileVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;


@Controller
public class ModuleUploadFileDownloadController {
	
    @Resource(name = "ModuleUploadFileService")
    private ModuleUploadFileService fileService;
    
    @Resource(name = "ModuleUsrFileService")
    private ModuleUsrFileService usrFileService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;
    
    @Resource(name="CntntsInfoService")
    protected CntntsInfoService cntntsInfoService;
    
    private static final Logger LOG = Logger.getLogger(ModuleUploadFileDownloadController.class.getName());
    
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
	    encodedFilename = "\"" + sb.toString() + "\"" ;
	} else {
	    //throw new RuntimeException("Not supported browser");
	    throw new IOException("Not supported browser");
	}
	
	response.setHeader("Content-Disposition", dispositionPrefix + encodedFilename);

	if ("Opera".equals(browser)){
	    response.setContentType("application/octet-stream;charset=UTF-8");
	}
    }

    /**
     * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
     * 
     * @param commandMap
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = {"/module/upload/file/fileDown.do","/{siteKey}/module/upload/file/fileDown.do"})    
    public void cvplFileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String atchFileId = (String)commandMap.get("atchFileId");
		String fileSn = (String)commandMap.get("fileSn");
		
		CntntsInfoVO cntntsInfoVO = cntntsInfoService.selectBbsAtchFileIdCheck(atchFileId);
		if(cntntsInfoVO != null && cntntsInfoVO.getSitecntntsSeq() != null) {
			//게시판에서 사용되는 파일로 체크가 된다면 fileBBSDown 으로 프로세스 변경
			commandMap.put("sitecntntsSeq", cntntsInfoVO.getSitecntntsSeq());
			fileBBSDown(commandMap, request, response);
			return ;
		}

	    ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
	    fileVO.setAtchFileId(atchFileId);
	    fileVO.setFileSn(fileSn);
	    ModuleUploadFileVO fvo = fileService.selectFileInf(fileVO);

	    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";
	
			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(fvo.getOrignlFileNm(), request, response);
			response.setContentLength(fSize);
	
			/*
			 * FileCopyUtils.copy(in, response.getOutputStream());
			 * in.close(); 
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
	
			try (
				BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
				BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
			){
				FileCopyUtils.copy(in, out);
			    out.flush();
			} catch (IOException e) {
			    LOG.error("파일 입출력 오류", e);
			} catch (Exception e) {
			    LOG.error("기타 예상치 못한 오류", e);
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

    
    @RequestMapping(value = {"/module/upload/usr/file/fileDown.do","/{siteKey}/module/upload/usr/file/fileDown.do"})    
    public void usrFileDownload(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String usrfileSeq = (String)commandMap.get("usrfileSeq"); 
	
	//	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	//	if (isAuthenticated) {
	
		    ModuleUsrFileVO fileVO = new ModuleUsrFileVO();
		    fileVO.setUsrfileSeq(usrfileSeq); 
		    fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		    ModuleUsrFileVO fvo = usrFileService.selectUsrFile(fileVO);
	
		    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
		    int fSize = (int)uFile.length();
	
		    if (fSize > 0) {
				String mimetype = "application/x-msdownload";
		
				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(fvo.getOrignlFileNm(), request, response);
				response.setContentLength(fSize);
		
				/*
				 * FileCopyUtils.copy(in, response.getOutputStream());
				 * in.close(); 
				 * response.getOutputStream().flush();
				 * response.getOutputStream().close();
				 */
				
				try (
					BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
					BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
				){
					FileCopyUtils.copy(in, out);
				    out.flush();
				} catch (IOException e) {
				    LOG.error("파일 입출력 오류", e);
				} catch (Exception e) {
				    LOG.error("기타 예상치 못한 오류", e);
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
    
	    @RequestMapping("/**/module/upload/usr/file/selectPdfViewer.do")
	    public String pdfViewer(
	    		@ModelAttribute("fileVO") ModuleUsrFileVO fileVO,
	    		@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response
	    		, ModelMap model
	    	) throws Exception {
	    	 
	    	String usrfileSeq = (String)commandMap.get("usrfileSeq");
	    	
	    	    fileVO = new ModuleUsrFileVO();
			    fileVO.setUsrfileSeq(usrfileSeq); 
			    fileVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			    ModuleUsrFileVO fvo = usrFileService.selectUsrFile(fileVO);
	    	model.addAttribute("pdfUrl", "/module/upload/usr/file/fileDown.do?usrfileSeq="+usrfileSeq);
	    	model.addAttribute("fileNm", fvo.getUsrfileNm());
			return "wzwg/module/upload/usr/file/pdfview";
	    }
	    
	    @RequestMapping(value = { "/module/upload/file/fileBBSDown.do", "/{siteKey}/module/upload/file/fileBBSDown.do"})    
	    public void fileBBSDown(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

	    	String atchFileId = (String)commandMap.get("atchFileId");
			String fileSn = (String)commandMap.get("fileSn");
			String sitecntntsSeq = (String)commandMap.get("sitecntntsSeq");
			String fileDownYn ="N";
			
			CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
			cntntsAuthVO.setAtchFileId(atchFileId);
			cntntsAuthVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			cntntsAuthVO.setSitecntntsSeq(sitecntntsSeq);
			HttpSession session = request.getSession();
			CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
			
			 boolean sadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		       boolean nadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");
		       boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
			if(loginVO == null) {
				cntntsAuthVO.setUsrgroupSeq("10000000003");
			}else {
				cntntsAuthVO.setUsrgroupSeq(loginVO.getUsrgroupSeq());	
			}
			fileDownYn = cntntsAuthService.selectCntntsFileAuthInfo(cntntsAuthVO);
			if(fileDownYn ==null ||fileDownYn.equals("")) {
				fileDownYn ="N";
			}
		//	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated(); 
			if (fileDownYn.equals("Y") || sadminAt || nadminAt || mngrAt) { 
				ModuleNttVO nttVO = new ModuleNttVO();
				nttVO.setAtchFileId(atchFileId);
				nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
				nttVO.setSitecntntsSeq(sitecntntsSeq);
				ModuleNttVO ntt = nttCmmnService.selectNttSecretAtByAtchFileId(nttVO);
				if(ntt.getSecretAt()!=null &&ntt.getSecretAt().equals("Y")) { 
					
					if(loginVO != null) {
						if((!loginVO.getUserId().equals(ntt.getNtcrId())) ) {
								
							if((!loginVO.getUserId().equals(ntt.getParntsNtcrId()))) {
								if(!sadminAt && !nadminAt && !mngrAt) {
									responsePrintNoAuthAccessFile(response);
									return;
								}
							}
						} 
					}else {
							
						responsePrintNoAuthAccessFile(response);
						return;
					}
				}
			    ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
			    fileVO.setAtchFileId(atchFileId);
			    fileVO.setFileSn(fileSn);
			    ModuleUploadFileVO fvo = fileService.selectFileInf(fileVO); 
			    File uFile = new File(fvo.getFileStreCours(), fvo.getStreFileNm());
			    int fSize = (int)uFile.length(); 
			    if (fSize > 0) {
					String mimetype = "application/x-msdownload";
			
					//response.setBufferSize(fSize);	// OutOfMemeory 발생
					response.setContentType(mimetype);
					//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
					setDisposition(fvo.getOrignlFileNm(), request, response);
					response.setContentLength(fSize);
			
					/*
					 * FileCopyUtils.copy(in, response.getOutputStream());
					 * in.close(); 
					 * response.getOutputStream().flush();
					 * response.getOutputStream().close();
					 */
					
					try (
						BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));
						BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
					){
						FileCopyUtils.copy(in, out);
					    out.flush();
					} catch (IOException e) {
					    LOG.error("파일 입출력 오류", e);
					} catch (Exception e) {
					    LOG.error("기타 예상치 못한 오류", e);
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
			}else { 
				responsePrintNoAuthAccessFile(response);
				return;
			}
	    }

	    private void responsePrintNoAuthAccessFile(HttpServletResponse response) throws Exception{
	    	response.setContentType("text/html");
			
			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<head><script>alert('no auth access file');</script></head>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }
}

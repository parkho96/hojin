package egovframework.wzwg.sysMngr.trans.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import egovframework.com.utl.fcc.service.ExcelParser;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.trans.service.SysMngrTransService;
import egovframework.wzwg.sysMngr.trans.service.SysMngrTransVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SysMngrTransController {
	
	@Resource(name="SysMngrTransService")
	SysMngrTransService sysMngrTransService;

	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	@RequestMapping(value= {"/**/siteMngr/trans/registSysMngrTrans.do","/{siteKey}/**/siteMngr/trans/registSysMngrTrans.do"})
	public String registKyoboTrans(        
			@ModelAttribute("paramVO") SysMngrTransVO paramVO 
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		 
    	
		return "wzwg/sysMngr/trans/sysMngrTrans";
	}	
	
	@RequestMapping(value= {"/**/siteMngr/trans/registSysMngrBbsTransAjax.do","/{siteKey}/**/siteMngr/trans/registSysMngrBbsTransAjax.do"} )
	public ModelAndView registKyoboBbsTransAjax(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("paramVO") SysMngrTransVO paramVO 
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

        final Map<String, MultipartFile> files = multiRequest.getFileMap();
		 Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		// paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	    Entry<String, MultipartFile> entry = itr.next();
       ExcelParser excelParser = new ExcelParser(entry.getValue());
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder;
		try {
			if(paramVO.getTransFileTy() == null || paramVO.getTransFileTy().equals("xml")) {
			documentBuilder = factory.newDocumentBuilder();
			InputStream fis = entry.getValue().getInputStream(); 
			  DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			  DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			  Document doc = dBuilder.parse(fis);
			  doc.getDocumentElement().normalize();
		
		// root 구하기
			  NodeList nList = doc.getElementsByTagName("Query");
		
			  for (int temp = 0; temp < nList.getLength(); temp++) {
				  
				     Node nNode = nList.item(temp);
				     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				 
				        Element eElement = (Element) nNode;
				 
				     	paramVO.setBoardId(getTagValue("board_id", eElement));
			        	paramVO.setBbsNm(getTagValue("bbs_nm", eElement));
			        	paramVO.setBoardType(getTagValue("board_type", eElement));
			        	paramVO.setUseAt(getTagValue("use_at", eElement));
			        	sysMngrTransService.registUnityBoard(paramVO);
				     }
				  }
			}else {
		        ArrayList<ArrayList<String>> resultList =excelParser.getExcel();
	        for(int i =0;i<resultList.size();i++) {
	        	ArrayList<String> excelList = resultList.get(i);
	        	String boardId = "";
	        	String bbsNm="";
	        	String boardType="";
	        	String useAt ="";
	        	
	        	boardId = excelList.get(0);
	        	bbsNm = excelList.get(1);
	        	boardType = excelList.get(2);
	        	useAt =excelList.get(3);
	        	
	        	paramVO.setBoardId(boardId);
	        	paramVO.setBbsNm(bbsNm);
	        	paramVO.setBoardType(boardType);
	        	paramVO.setUseAt(useAt);
	        	sysMngrTransService.registUnityBoard(paramVO);
	        	
	        }
			}
		}catch(NullPointerException e){
			log.error("NullPointerException " ,e);
  	   	}catch(NumberFormatException e){
  	   		log.error("NumberFormatException " ,e);
  	   	}catch(IllegalFormatException e){
  	   		log.error("IllegalFormatException " ,e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		log.error("ArrayIndexOutOfBoundsException " ,e);
  	   	}	  
	  return new ModelAndView("jsonView", model);
	}
	
	
	@RequestMapping(value= {"/**/siteMngr/trans/registSysMngrNttTransAjax.do" ,"/{siteKey}/**/siteMngr/trans/registSysMngrNttTransAjax.do" })
	public ModelAndView registKyoboNttTransAjax(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("paramVO") SysMngrTransVO paramVO 
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
	 
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
		 Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
				 
	    Entry<String, MultipartFile> entry = itr.next();
       ExcelParser excelParser = new ExcelParser(entry.getValue());
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder;
		try {
			if(paramVO.getTransFileTy() == null || paramVO.getTransFileTy().equals("xml")) {
			documentBuilder = factory.newDocumentBuilder();
			InputStream fis = entry.getValue().getInputStream(); 
			  DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			  DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			  Document doc = dBuilder.parse(fis);
			  doc.getDocumentElement().normalize();
		
		// root 구하기
			  NodeList nList = doc.getElementsByTagName("Query");
		
			  for (int temp = 0; temp < nList.getLength(); temp++) {
				  
				     Node nNode = nList.item(temp);
				     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				 
				        Element eElement = (Element) nNode;
				 
				        paramVO.setStartSeq("10000000");
						paramVO.setNttSeq( getTagValue("ntt_seq", eElement));
						paramVO.setBoardId( getTagValue("board_id", eElement));
						paramVO.setParntsNttSeq( getTagValue("parnts_ntt_seq", eElement));
						paramVO.setNtcrNm( getTagValue("ntcr_nm", eElement)); 
						paramVO.setNtcrId( getTagValue("ntcr_id", eElement));
						paramVO.setNttSj( getTagValue("ntt_sj", eElement));
						paramVO.setNttCn( getTagValue("ntt_cn", eElement));
						paramVO.setNoticeAt( getTagValue("notice_at", eElement));
						paramVO.setPassword( getTagValue("password", eElement));
						paramVO.setSecretAt( getTagValue("secret_at", eElement));
						paramVO.setInqireCnt( getTagValue("inqire_cnt", eElement));
						paramVO.setFrstRegistPnttm( getTagValue("frst_regist_pnttm", eElement));
						paramVO.setLastUpdtPnttm(getTagValue("last_updt_pnttm", eElement));
						paramVO.setUseAt(getTagValue("use_at", eElement));
						sysMngrTransService.registUnityMdntt(paramVO);    
				 
				     }
				  } 
			}else { 
	        ArrayList<ArrayList<String>> resultList =excelParser.getExcel();
	        for(int i =0;i<resultList.size();i++) {
	        	ArrayList<String> excelList = resultList.get(i);
	        	String startSeq = "";
	        	String nttSeq="";
	        	String boardId="";
	        	String bbsSeq="";
	        	String parntsNttSeq ="";
	        	String ntcrId ="";
	        	
	        	String nttSj = "";
	        	String nttCn="";
	        	String inqireCnt="";
	        	String useAt ="";
	        	
	        	String frstRegistPnttm = "";
	        	String lastUpdtPnttm="";
	        	String noticeAt="";
	        	String secretAt ="";
	        	String password ="";
	        	String ntcrNm="";
	        	
	            
				startSeq = "10000000";     
				nttSeq=excelList.get(0);    
				boardId=excelList.get(1);     
				parntsNttSeq =excelList.get(2);      
				ntcrNm=excelList.get(3);
				ntcrId=excelList.get(4);       
				nttSj =excelList.get(5);          
				nttCn=excelList.get(6);    
				noticeAt=excelList.get(7);  
				password =excelList.get(8);  
				secretAt =excelList.get(9);
				inqireCnt=excelList.get(10);   
				frstRegistPnttm =excelList.get(11);       
				lastUpdtPnttm=excelList.get(12);
				useAt =excelList.get(13);    
				
				paramVO.setStartSeq(startSeq);
				paramVO.setNttSeq(nttSeq);
				paramVO.setBoardId(boardId);
				paramVO.setParntsNttSeq(parntsNttSeq);
				paramVO.setNtcrId(ntcrId);
				paramVO.setNtcrNm(ntcrNm);
				paramVO.setNttSj(nttSj);
				paramVO.setNttCn(nttCn);
				paramVO.setNoticeAt(noticeAt);
				paramVO.setPassword(password);
				paramVO.setSecretAt(secretAt);
				paramVO.setInqireCnt(inqireCnt);
				paramVO.setFrstRegistPnttm(frstRegistPnttm.replaceAll("/","-"));
				paramVO.setLastUpdtPnttm(lastUpdtPnttm.replaceAll("/","-"));
				paramVO.setUseAt(useAt);
				
				sysMngrTransService.registUnityMdntt(paramVO);              
	        	}
		 }
		}catch(NullPointerException e){
			log.error("NullPointerException " ,e);
  	   	}catch(NumberFormatException e){
  	   		log.error("NumberFormatException " ,e);
  	   	}catch(IllegalFormatException e){
  	   		log.error("IllegalFormatException " ,e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		log.error("ArrayIndexOutOfBoundsException " ,e);
  	   	}	  
	  return new ModelAndView("jsonView", model);
	}
	
	
	@RequestMapping(value= {"/**/siteMngr/trans/registSysMngrAtchTransAjax.do" ,"/{siteKey}/**/siteMngr/trans/registSysMngrAtchTransAjax.do" })
	public ModelAndView registKyoboAtchTransAjax(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("paramVO") SysMngrTransVO paramVO 
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		 final Map<String, MultipartFile> files = multiRequest.getFileMap();
		 Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
				 
 	    Entry<String, MultipartFile> entry = itr.next();
        ExcelParser excelParser = new ExcelParser(entry.getValue());
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder documentBuilder;
		try {
			if(paramVO.getTransFileTy() == null || paramVO.getTransFileTy().equals("xml")) {
			documentBuilder = factory.newDocumentBuilder();
			InputStream fis = entry.getValue().getInputStream(); 
			  DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			  DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			  Document doc = dBuilder.parse(fis);
			  doc.getDocumentElement().normalize();
		
		// root 구하기
			  NodeList nList = doc.getElementsByTagName("Query");
		
			  for (int temp = 0; temp < nList.getLength(); temp++) {
				  
				     Node nNode = nList.item(temp);
				     if (nNode.getNodeType() == Node.ELEMENT_NODE) {
				 
				        Element eElement = (Element) nNode;
				  
				        String nttSeq ="";
			        	String fileName ="";
			        	String sysFileName ="";
			        	String filePath="";
			        	String frstRegistPnttm="";
			        	String lastUpdtPnttm="";
			        	String useAt="";
			        	String boardId ="";
			        	String fileMg="";
			        	
			        	nttSeq =getTagValue("ntt_seq", eElement);    
			        	  boardId =getTagValue("board_id", eElement);
			        	  fileName =getTagValue("file_name", eElement);
			        	  sysFileName =getTagValue("sys_file_name", eElement);    
			        	  filePath=getTagValue("file_path", eElement);    
			        	  fileMg=getTagValue("file_mg", eElement);    
			        	  frstRegistPnttm=getTagValue("frst_regist_pnttm", eElement);    
			        	  lastUpdtPnttm=getTagValue("last_updt_pnttm", eElement);
			        	  useAt=getTagValue("use_at", eElement);    
			        	  
			        	  paramVO.setNttSeq(nttSeq);
			        	  paramVO.setBoardId(boardId);
			        	  paramVO.setFileName(fileName);
			        	  paramVO.setFilePath(filePath);
			        	  paramVO.setFrstRegistPnttm(frstRegistPnttm.replaceAll("/","-"));
			        	  paramVO.setLastUpdtPnttm(lastUpdtPnttm.replaceAll("/","-"));
			        	  paramVO.setUseAt(useAt);
			        	  
			        	
			        	  String fileStreCours = request.getServletContext().getRealPath("")+"upload/"+paramVO.getSiteSeq()+"/trans/"+filePath;
			        	  String thumbStreCours = request.getServletContext().getRealPath("")+"upload/"+paramVO.getSiteSeq()+"/trans/"+filePath;
			        	  String extsn ="";
			        	  if(!fileName.equals("")) {
			        		  extsn = fileName.substring(fileName.lastIndexOf(".")+1);
			        	  }
			        	  paramVO.setFileStreCours(fileStreCours);
			        	  if("jpg,jpeg,gif,bmp,png".indexOf(extsn.toLowerCase()) >-1) {
			        	  paramVO.setThumbStreCours(thumbStreCours);
			        	  paramVO.setThumbFileNm(sysFileName);
			        	  }
			        	  paramVO.setFileDc("");
			        	  paramVO.setFileMg(fileMg);
			        	  paramVO.setStreFileNm(sysFileName);
			        	  paramVO.setOrignlFileNm(fileName);
			        	  paramVO.setFileExtsn(extsn);
			        	  
			        	  sysMngrTransService.registUnityAtchMdntt(paramVO);
				 
				     }
				  }
			}else {
		        ArrayList<ArrayList<String>> resultList =excelParser.getExcel();
		        for(int i =0;i<resultList.size();i++) {
		        	ArrayList<String> excelList = resultList.get(i);
		        	String nttSeq ="";
		        	String boardId="";
		        	String fileName ="";
		        	String sysFileName ="";
		        	String filePath="";
		        	String frstRegistPnttm="";
		        	String lastUpdtPnttm="";
		        	String useAt="";
		        	String fileMg="";
		        	
		        	  nttSeq =excelList.get(0);
		        	  boardId =excelList.get(1);  
		        	  fileName =excelList.get(2);
		        	  sysFileName =excelList.get(3);   
		        	  filePath=excelList.get(4);
		        	  fileMg=excelList.get(5);    
		        	  frstRegistPnttm=excelList.get(6);    
		        	  lastUpdtPnttm=excelList.get(7);    
		        	  useAt=excelList.get(8);    
		        	  
		        	  paramVO.setNttSeq(nttSeq);
		        	  paramVO.setBoardId(boardId);
		        	  paramVO.setFileName(fileName);
		        	  paramVO.setFilePath(filePath);
		        	  paramVO.setFrstRegistPnttm(frstRegistPnttm.replaceAll("/","-"));
		        	  paramVO.setLastUpdtPnttm(lastUpdtPnttm.replaceAll("/","-"));
		        	  paramVO.setUseAt(useAt);
		        	  
		        	
		        	  String fileStreCours = request.getServletContext().getRealPath("")+"upload/"+paramVO.getSiteSeq()+"/trans/"+filePath;
		        	  String thumbStreCours = request.getServletContext().getRealPath("")+"upload/"+paramVO.getSiteSeq()+"/trans/"+filePath;
		        	  String extsn ="";
		        	  if(!fileName.equals("")) {
		        		  extsn = fileName.substring(fileName.lastIndexOf(".")+1);
		        	  }
		        	  paramVO.setFileStreCours(fileStreCours);
		        	  if("jpg,jpeg,gif,bmp,png".indexOf(extsn.toLowerCase()) >-1) {
		        	  paramVO.setThumbStreCours(thumbStreCours);
		        	  paramVO.setThumbFileNm(sysFileName);
		        	  }
		        	  paramVO.setFileDc("");
		        	  paramVO.setFileMg(fileMg);
		        	  paramVO.setStreFileNm(sysFileName);
		        	  paramVO.setOrignlFileNm(fileName);
		        	  paramVO.setFileExtsn(extsn);
		        	  
		        	  sysMngrTransService.registUnityAtchMdntt(paramVO);
		        	
		        }
			}
		}catch(NullPointerException e){
			log.error("NullPointerException " ,e);
  	   	}catch(NumberFormatException e){
  	   		log.error("NumberFormatException " ,e);
  	   	}catch(IllegalFormatException e){
  	   		log.error("IllegalFormatException " ,e);
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   		log.error("ArrayIndexOutOfBoundsException " ,e);
  	   	} 
	  return new ModelAndView("jsonView", model);
	}
	
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
	
	@RequestMapping(value = {"/sysMngr/module/upload/transFile/fileTransDown.do","/{siteKey}/module/upload/transFile/fileTransDown.do"})    
    public void fileTransDown(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response) throws Exception {

    	String fileSeq = (String)commandMap.get("fileSeq"); 
	
	//	Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
	
	//	if (isAuthenticated) {
    	String fileName="";
    	
    	if(fileSeq.equals("1")) {
    		fileName="sample_bbsinfo.xlsx";
    	}else if(fileSeq.equals("2")) {
    		fileName="sample_bbsinfo.xml";
    	}else if(fileSeq.equals("3")) {
    		fileName="sample_mdntt.xlsx";
    	}else if(fileSeq.equals("4")) {
    		fileName="sample_mdntt.xml";
    	}else if(fileSeq.equals("5")) {
    		fileName="sample_mdatch.xlsx";
    	}else if(fileSeq.equals("6")) {
    		fileName="sample_mdatch.xml";
    	}
    	String contextPath = request.getSession().getServletContext().getRealPath(""); 
		    File uFile = new File(contextPath+"upload/transSampleFile/",fileName);
		    int fSize = (int)uFile.length();
	
		    if (fSize > 0) { 
				String mimetype = "application/x-msdownload";
		
				//response.setBufferSize(fSize);	// OutOfMemeory 발생
				response.setContentType(mimetype);
				//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
				setDisposition(fileName, request, response);
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
				printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fileName + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
		    }
		}
	
		
		 private static String getTagValue(String sTag, Element eElement) {
				NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
				
				       Node nValue = (Node) nlList.item(0);
				String value ="";
					if(nValue != null ) {
					value =nValue.getNodeValue();
					}
			    return value;
				 }
	 
}

package egovframework.wzwg.sysMngr.opnsu.file.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;


/**
 * @Class Name  : EgovFileMngUtil.java
 * @Description : 메시지 처리 관련 유틸리티
 * @Modification Information
 *
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.02.13       이삼섭                  최초 생성
 *   2011.08.09       서준식                  utl.fcc패키지와 Dependency제거를 위해 getTimeStamp()메서드 추가
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see
 *
 */
@Slf4j
@Component("OpnsuFileMngrUtil")
public class OpnsuFileMngrUtil {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "OpnsuFileMngrService")
    private OpnsuFileMngrService fileService;

    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public List<OpnsuFileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam,  String storePath,  String whiteFileExt, MultipartHttpServletRequest multiRequest, String moduleTy, String atchFileId, String siteId) throws Exception {
    int fileKey = fileKeyParam;

    Calendar calendar = Calendar.getInstance();
    
    String contextPath = multiRequest.getSession().getServletContext().getRealPath("/");
    if (contextPath != null && contextPath.length() > 0) {
        contextPath = contextPath.substring(0, contextPath.length() - 1);
    }
	
    //허용가능 파일 확장자
    String whiteFileExtStr = "";
    if ("".equals(whiteFileExt) || whiteFileExt == null) {
        whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");
    } else {
        whiteFileExtStr = EgovProperties.getProperty(whiteFileExt);
        if ("".equals(whiteFileExtStr) || whiteFileExtStr == null) {
            whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");
        }
    }    
    
	String storePathString = "";
	String atchFileIdString = "";
	
    Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    
    if(!isAuthenticated) {
        throw new IOException("Auth Failed ");
    }

	if ("".equals(storePath) || storePath == null) {
	    storePathString = contextPath + EgovProperties.getProperty("Globals.fileStorePath");
	} else {
	    storePathString = contextPath + EgovProperties.getProperty(storePath);
	}
	
    storePathString += siteId + "/" + "opnsu" + "/" + moduleTy + "/" + calendar.get(Calendar.YEAR)
            + "/" + ((calendar.get(Calendar.MONTH) + 1) < 10 ? "0"+(calendar.get(Calendar.MONTH) + 1):(calendar.get(Calendar.MONTH) + 1)) 
            + "/" + (calendar.get(Calendar.DATE) < 10 ? "0"+calendar.get(Calendar.DATE):calendar.get(Calendar.DATE)) + "/";	

	if ("".equals(atchFileId) || atchFileId == null) {
	    atchFileIdString = fileService.getNextAtchFileId();
	} else {
	    atchFileIdString = atchFileId;
	}

	File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

	if (!saveFolder.exists() || saveFolder.isFile()) {
		 if(!saveFolder.mkdirs()) {
		    	log.error("directory not make");
		    }
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<OpnsuFileVO> result  = new ArrayList<OpnsuFileVO>();
	OpnsuFileVO fvo;

	while (itr.hasNext()) {
	    Entry<String, MultipartFile> entry = itr.next();

	    file = entry.getValue();
	    String orginFileName = file.getOriginalFilename();

	    //--------------------------------------
	    // 원 파일명이 없는 경우 처리
	    // (첨부가 되지 않은 input file type)
	    //--------------------------------------
	    if ("".equals(orginFileName)) {
		continue;
	    }
	    ////------------------------------------

	    int index = -1;
	    String fileExt = "";
	    if (orginFileName != null) {
	        index = orginFileName.lastIndexOf(".");
	        if (index != -1) {
	            fileExt = orginFileName.substring(index + 1);
	        }
	    }
	    String newName = KeyStr + getTimeStamp() + fileKey;
	    long _size = file.getSize();

	    if (!"".equals(orginFileName)) {
		filePath = storePathString + File.separator + newName;
			file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
	    }
	    
	    
	    fvo = new OpnsuFileVO();
	    fvo.setFileExtsn(fileExt);
	    fvo.setFileStreCours(storePathString);
	    fvo.setFileMg(Long.toString(_size));
	    fvo.setOrignlFileNm(orginFileName);
	    fvo.setStreFileNm(newName);
	    fvo.setAtchFileId(atchFileIdString);
	    fvo.setFileSn(String.valueOf(fileKey));
	    
	    if("jpg".equals(fvo.getFileExtsn().toLowerCase())
	    		|| "jpeg".equals(fvo.getFileExtsn().toLowerCase())
				|| "gif".equals(fvo.getFileExtsn().toLowerCase()) 
				|| "png".equals(fvo.getFileExtsn().toLowerCase())){
			    	fvo.setThumbStreCours(storePathString+"thumbnail/");
				    fvo.setThumbFileNm("THUMB_" + getTimeStamp() + fileKey);
	    }

	    //writeFile(file, newName, storePathString);
	    result.add(fvo);

	    fileKey++;
	}

	return result;
    }

    /**
     * 첨부파일을 서버에 저장한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;

	try {
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            throw new IOException("Auth Failed ");
        }
        
	    stream = file.getInputStream();
	    File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));
	    // 보안 조치
	    if(!cFile.setExecutable(false, true)) {
	       	 throw new IOException("Directory exe Failed ");
	       }
	       if(!cFile.setReadable(true)) {
	       	 throw new IOException("Directory read Failed ");
	       }
	       if(!cFile.setWritable(false, true)) {
	       	 throw new IOException("Directory write Failed ");
	       }
		    
		    if (!cFile.isDirectory()) {
			boolean _flag = cFile.mkdirs();
			if (!_flag) {
			    throw new IOException("Directory creation Failed ");
			}
		    }

	    bos = new FileOutputStream(stordFilePath + File.separator + newName);

	    if (stream != null && bos != null) {
	        int bytesRead = 0;
	        byte[] buffer = new byte[BUFF_SIZE];

	        while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		        bos.write(buffer, 0, bytesRead);
	        }
	    }     
	}catch(NullPointerException e){
		 log.error("NullPointerException",e);
	}catch(NumberFormatException e){
	 log.error("NullPointerException",e);
	}catch(IllegalFormatException e){
	 log.error("NullPointerException",e);
	}catch(ArrayIndexOutOfBoundsException e){
	 log.error("NullPointerException",e);
	}catch(IOException e){
	 log.error("NullPointerException",e);
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch(NullPointerException e){
			 log.error("NullPointerException",e);
	  	}catch(NumberFormatException e){
	  	 log.error("NullPointerException",e);
	  	}catch(IllegalFormatException e){
	  	 log.error("NullPointerException",e);
	  	}catch(ArrayIndexOutOfBoundsException e){
	  	 log.error("NullPointerException",e);
	  	}catch(IOException e){
	  	 log.error("NullPointerException",e);
	  	} 
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch(NullPointerException e){
			 log.error("NullPointerException",e);
	  	}catch(NumberFormatException e){
	  	 log.error("NumberFormatException",e);
	  	}catch(IllegalFormatException e){
	  	 log.error("IllegalFormatException",e);
	  	}catch(ArrayIndexOutOfBoundsException e){
	  	 log.error("ArrayIndexOutOfBoundsException",e);
	  	}catch(IOException e){
	  	 log.error("IOException",e);
	  	} 
	    }
	}
    }

    /**
     * 서버의 파일을 다운로드한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		String downFileName = "";
		String orgFileName = "";
	
		if ((String)request.getAttribute("downFile") == null) {
		    downFileName = "";
		} else {
		    downFileName = (String)request.getAttribute("downFile");
		}
	
		if ((String)request.getAttribute("orgFileName") == null) {
		    orgFileName = "";
		} else {
		    orgFileName = (String)request.getAttribute("orginFile");
		}
	
		orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");
	
		File file = new File(EgovWebUtil.filePathBlackList(downFileName));
	
		if (!file.exists()) {
		    throw new FileNotFoundException(downFileName);
		}
	
		if (!file.isFile()) {
		    throw new FileNotFoundException(downFileName);
		}
	
		byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
	
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
	
		try (
				BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		){
		    int read = 0;
	
			while ((read = fin.read(b)) != -1) {
			    outs.write(b, 0, read);
			}
			outs.flush();
		} catch (RuntimeException e2) {
			log.error("RuntimeException",e2);
		} catch (FileNotFoundException e) {
			log.error("FileNotFoundException",e);
		} catch (IOException e) {
			log.error("IOException",e);
		}
    }

    /**
     * 첨부로 등록된 파일을 서버에 업로드한다.
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static HashMap<String, String> uploadFile(MultipartFile file) throws Exception {

	HashMap<String, String> map = new HashMap<String, String>();
	//Write File 이후 Move File????
	String newName = "";
	String stordFilePath = EgovProperties.getProperty("Globals.fileStorePath");
	String orginFileName = file.getOriginalFilename();

	int index = -1;
	String fileExt = "";
	if (orginFileName != null) {
	    index = orginFileName.lastIndexOf(".");
	    if (index != -1) {
	        fileExt = orginFileName.substring(index + 1);
	    }
	}
	long size = file.getSize();

	//newName 은 Naming Convention에 의해서 생성
	newName = getTimeStamp();	// 2012.11 KISA 보안조치
	writeFile(file, newName, stordFilePath);
	//storedFilePath는 지정
	map.put(Globals.ORIGIN_FILE_NM, orginFileName);
	map.put(Globals.UPLOAD_FILE_NM, newName);
	map.put(Globals.FILE_EXT, fileExt);
	map.put(Globals.FILE_PATH, stordFilePath);
	map.put(Globals.FILE_SIZE, String.valueOf(size));

	return map;
    }

    /**
     * 파일을 실제 물리적인 경로에 생성한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;

	try {
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            throw new IOException("Auth Failed ");
        }
        
	    stream = file.getInputStream();
	    File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));

        // 보안 조치
        cFile.setExecutable(false, true);
        cFile.setReadable(true);
        cFile.setWritable(false, true);
	    
	    if (!cFile.isDirectory())
		cFile.mkdirs();

	    bos = new FileOutputStream(EgovWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

	    if (stream != null && bos != null) {
	        int bytesRead = 0;
	        byte[] buffer = new byte[BUFF_SIZE];

	        while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		        bos.write(buffer, 0, bytesRead);
	        }
	    }
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch(NullPointerException e){
	    	log.debug("NullPointerException: " + "오류");
	   	}catch(NumberFormatException e){
	   		log.debug("NumberFormatException: " + "오류");
	   	}catch(IllegalFormatException e){
	   		log.debug("IllegalFormatException: " + "오류");
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.debug("ArrayIndexOutOfBoundsException: " + "오류");
	   	}catch(IOException e){
	   		log.debug("IOException: " + "오류");
	   	}
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch(NullPointerException e){
	    	log.debug("NullPointerException: " + "오류");
	   	}catch(NumberFormatException e){
	   		log.debug("NumberFormatException: " + "오류");
	   	}catch(IllegalFormatException e){
	   		log.debug("IllegalFormatException: " + "오류");
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.debug("ArrayIndexOutOfBoundsException: " + "오류");
	   	}catch(IOException e){
	   		log.debug("IOException: " + "오류");
	   	}
	    }
	}
    }

    /**
     * 서버 파일에 대하여 다운로드를 처리한다.
     *
     * @param response
     * @param streFileNm
     *            : 파일저장 경로가 포함된 형태
     * @param orignFileNm
     * @throws Exception
     */
    public void downFile(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
		String downFileName = streFileNm;
		String orgFileName = orignFileNm;
	
		File file = new File(downFileName);
	
		if (!file.exists()) {
		    throw new FileNotFoundException(downFileName);
		}
	
		if (!file.isFile()) {
		    throw new FileNotFoundException(downFileName);
		}
	
		//byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
		int fSize = (int)file.length();
		if (fSize > 0) {
		    try (
	    	    BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
			){
		    	String mimetype = "text/html"; //"application/x-msdownload"
	
		    	response.setBufferSize(fSize);
				response.setContentType(mimetype);
				response.setHeader("Content-Disposition", "attachment; filename=" + orgFileName);
				response.setContentLength(fSize);
				
				FileCopyUtils.copy(in, response.getOutputStream());
			    response.getOutputStream().flush();
		    } catch (RuntimeException e2) {
				log.error("RuntimeException",e2);
			} catch (FileNotFoundException e) {
				log.error("FileNotFoundException",e);
			} catch (IOException e) {
				log.error("IOException",e);
			}
		}

    }

    /**
     * 2011.08.09
     * 공통 컴포넌트 utl.fcc 패키지와 Dependency제거를 위해 내부 메서드로 추가 정의함
     * 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
     *
     * @param
     * @return Timestamp 값
     * @exception MyException
     * @see
     */
    private static String getTimeStamp() {

	String rtnStr = null;

	// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
	String pattern = "yyyyMMddhhmmssSSS";

	    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
	    Timestamp ts = new Timestamp(System.currentTimeMillis());

	    rtnStr = sdfCurrent.format(ts.getTime());

	return rtnStr;
    }
    
    /**
     * 파일을 삭제한다
     */   
    public static synchronized int deleteFile(String fileName) throws IOException, FileNotFoundException {

        int resultCode = 0;
        
        File delFile = new File(fileName);
        
        if(delFile.exists()) {
        	try {
        		if(delFile.delete()) {
        			resultCode = 1;
        		} else {
        			resultCode = 0;
        		}
				
			} catch (SecurityException e) {
				log.error("file delete SecurityException", e);
			}
        } else {
            resultCode = -1;
        }
        
        return resultCode;
    }
}

package egovframework.wzwg.module.upload.file.service;

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

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.filehandling.EgovFileUtil;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


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
@Component("ModuleUploadFileUtil")
public class ModuleUploadFileUtil {

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "ModuleUploadFileService")
    private ModuleUploadFileService fileService;

    private static final Logger LOG = Logger.getLogger(ModuleUploadFileUtil.class.getName());
    
    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public List<ModuleUploadFileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam,  String storePath,  String whiteFileExt, MultipartHttpServletRequest multiRequest, String moduleTy, String atchFileId, String siteId) throws Exception {
    int fileKey = fileKeyParam;

    Calendar calendar = Calendar.getInstance();
    
	String contextPath = multiRequest.getSession().getServletContext().getRealPath("/");
	if (contextPath != null && contextPath.length() > 0) {
		contextPath = contextPath.substring(0, contextPath.length() - 1);
	}
    
    //허용가능 파일 확장자
    String whiteFileExtStr = "";
    if (("").equals(StringUtils.defaultString(whiteFileExt)) || whiteFileExt == null) {
        whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");
    } else {
        whiteFileExtStr = EgovProperties.getProperty(whiteFileExt);
        if(("99").equals(StringUtils.defaultString(whiteFileExtStr))){
        	whiteFileExtStr = whiteFileExt;
        }else{
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
	
    storePathString += siteId + "/" + "module" + "/" + moduleTy + "/" + calendar.get(Calendar.YEAR)
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
	    	LOG.info(saveFolder+" : directory make fail ");
	    }
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<ModuleUploadFileVO> result  = new ArrayList<ModuleUploadFileVO>();
	ModuleUploadFileVO fvo;

	while (itr.hasNext()) {
	    Entry<String, MultipartFile> entry = itr.next();

	    file = entry.getValue();
	    String orginFileName = file.getOriginalFilename();
	    String name = file.getName();
	    //--------------------------------------
	    // 원 파일명이 없는 경우 처리
	    // (첨부가 되지 않은 input file type)
	    //--------------------------------------
	    if ("".equals(orginFileName)) {
		continue;
	    }
	    ////------------------------------------

	    int index = (orginFileName != null) ? orginFileName.lastIndexOf(".") : -1;
	    //String fileName = orginFileName.substring(0, index);
	    String fileExt = (index != -1) ? orginFileName.substring(index + 1) : "";
	    String newName = KeyStr + getTimeStamp() + fileKey;
	    long _size = file.getSize();

	    if (!"".equals(orginFileName)) {
		filePath = storePathString + File.separator + newName;
			file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
	    }
	     
	    if(whiteFileExtStr.indexOf(fileExt.toLowerCase().trim()) > -1){
		    fvo = new ModuleUploadFileVO();
		    fvo.setFileExtsn(fileExt);
		    fvo.setFileStreCours(storePathString);
		    fvo.setFileMg(Long.toString(_size));
		    fvo.setOrignlFileNm(orginFileName);
		    fvo.setStreFileNm(newName);
		    fvo.setAtchFileId(atchFileIdString);
		    fvo.setFileSn(String.valueOf(fileKey));
		    fvo.setName(name);
		    
		    fvo.setParamName(entry.getKey());

		    if("jpg".equals(fvo.getFileExtsn().toLowerCase())
		    		|| "jpeg".equals(fvo.getFileExtsn().toLowerCase())
		    		|| "gif".equals(fvo.getFileExtsn().toLowerCase()) 
		    		|| "png".equals(fvo.getFileExtsn().toLowerCase())){
		    	    	fvo.setThumbStreCours(storePathString+"thumbnail/");
		    		    fvo.setThumbFileNm("THUMB_" + getTimeStamp() + fileKey);
		    }
		    
		    if("ico".equals(fvo.getFileExtsn().toLowerCase())) {
		    	fvo.setThumbStreCours(storePathString);
    		    fvo.setThumbFileNm(newName);
		    }
		    
	   	    //writeFile(file, newName, storePathString);
	   	    result.add(fvo);
	    }else{
	    	EgovFileUtil.delete(new File(EgovWebUtil.filePathBlackList(filePath)));
	    }

	    fileKey++;
	}

	return result;
    }
    
    public List<ModuleUsrFileVO> parseUsrFileInf(Map<String, MultipartFile> files, String KeyStr, int fileKeyParam,  String storePath,  String whiteFileExt, MultipartHttpServletRequest multiRequest, String moduleTy, String siteId) throws Exception {
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
    	
        storePathString += siteId + "/" + "module" + "/" + moduleTy + "/" + calendar.get(Calendar.YEAR)
                + "/" + ((calendar.get(Calendar.MONTH) + 1) < 10 ? "0"+(calendar.get(Calendar.MONTH) + 1):(calendar.get(Calendar.MONTH) + 1)) 
                + "/" + (calendar.get(Calendar.DATE) < 10 ? "0"+calendar.get(Calendar.DATE):calendar.get(Calendar.DATE)) + "/";	

  
    	File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

    	if (!saveFolder.exists() || saveFolder.isFile()) {
    		  if(!saveFolder.mkdirs()) {
    		    	LOG.info(saveFolder+" : directory make fail ");
    		    }
    	}

    	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
    	MultipartFile file;
    	String filePath = "";
    	List<ModuleUsrFileVO> result  = new ArrayList<ModuleUsrFileVO>();
    	ModuleUsrFileVO fvo;

    	while (itr.hasNext()) {
    	    Entry<String, MultipartFile> entry = itr.next();

    	    file = entry.getValue();
    	    String orginFileName = file.getOriginalFilename();
    	    String name = file.getName();
    	    //--------------------------------------
    	    // 원 파일명이 없는 경우 처리
    	    // (첨부가 되지 않은 input file type)
    	    //--------------------------------------
    	    if ("".equals(orginFileName)) {
    		continue;
    	    }
    	    ////------------------------------------

    	    int index = (orginFileName != null) ? orginFileName.lastIndexOf(".") : -1;
    	    //String fileName = orginFileName.substring(0, index);
    	    String fileExt = (index != -1) ? orginFileName.substring(index + 1) : "";
    	    String newName = KeyStr + getTimeStamp() + fileKey;
    	    long _size = file.getSize();

    	    if (!"".equals(orginFileName)) {
    		filePath = storePathString + File.separator + newName;
    			file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
    	    }
    	    
    	    if(whiteFileExtStr.indexOf(fileExt.toLowerCase().trim()) > -1){
    	    fvo = new ModuleUsrFileVO();
    	    fvo.setFileExtsn(fileExt);
    	    fvo.setFileStreCours(storePathString);
    	    fvo.setFileMg(Long.toString(_size));
    	    fvo.setOrignlFileNm(orginFileName);
    	    fvo.setStreFileNm(newName); 
    	  //  fvo.setName(name);
    	    
    	     
    	    //writeFile(file, newName, storePathString);
    	    result.add(fvo);
    	    }else{
    	    	EgovFileUtil.delete(new File(EgovWebUtil.filePathBlackList(filePath)));
    	    }

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

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    if (stream != null) {
		    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
			bos.write(buffer, 0, bytesRead);
		    }
	    }     
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
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
	    if (stream != null) {
		try {
		    stream.close();
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
		} catch (IOException e) {
		    LOG.error("파일 입출력 오류", e);
		} catch (Exception e) {
		    LOG.error("기타 예상치 못한 오류", e);
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

	int index = (orginFileName != null) ? orginFileName.lastIndexOf(".") : -1;
	//String fileName = orginFileName.substring(0, _index);
	String fileExt = (index != -1) ? orginFileName.substring(index + 1) : "";
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

	    bos = new FileOutputStream(EgovWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    if (stream != null) {
		    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
			bos.write(buffer, 0, bytesRead);
		    }
	    }
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
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
	    if (stream != null) {
		try {
		    stream.close();
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
	//log.debug(this.getClass().getName()+" downFile downFileName "+downFileName);
	//log.debug(this.getClass().getName()+" downFile orgFileName "+orgFileName);

	if (!file.exists()) {
	    throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
	    throw new FileNotFoundException(downFileName);
	}

	//byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
	int fSize = (int)file.length();
	if (fSize > 0) {
	    String mimetype = "text/html"; //"application/x-msdownload"
    	response.setBufferSize(fSize);
		response.setContentType(mimetype);
		response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
		response.setContentLength(fSize);
	    try (
	    		BufferedInputStream in = new BufferedInputStream(new FileInputStream(file));
	    		BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		){
	    	
	    	FileCopyUtils.copy(in, outs);
	    	outs.flush();
		//response.setHeader("Content-Transfer-Encoding","binary");
		//response.setHeader("Pragma","no-cache");
		//response.setHeader("Expires","0");
		
	    }
	}

	/*
	String uploadPath = propertiesService.getString("fileDir");

	File uFile = new File(uploadPath, requestedFile);
	int fSize = (int) uFile.length();

	if (fSize > 0) {
	    BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

	    String mimetype = "text/html";

	    response.setBufferSize(fSize);
	    response.setContentType(mimetype);
	    response.setHeader("Content-Disposition", "attachment; filename=\""
					+ requestedFile + "\"");
	    response.setContentLength(fSize);

	    FileCopyUtils.copy(in, response.getOutputStream());
	    in.close();
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	} else {
	    response.setContentType("text/html");
	    PrintWriter printwriter = response.getWriter();
	    printwriter.println("<html>");
	    printwriter.println("<br><br><br><h2>Could not get file name:<br>" + requestedFile + "</h2>");
	    printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
	    printwriter.println("<br><br><br>&copy; webAccess");
	    printwriter.println("</html>");
	    printwriter.flush();
	    printwriter.close();
	}
	//*/


	/*
	response.setContentType("application/x-msdownload");
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(),"UTF-8" ));
	response.setHeader("Content-Transfer-Encoding","binary");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");

	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;

	while ((read = fin.read(b)) != -1) {
	    outs.write(b,0,read);
	}
	log.debug(this.getClass().getName()+" BufferedOutputStream Write Complete!!! ");

	outs.close();
    	fin.close();
	//*/
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
			} catch (RuntimeException e) {
				LOG.error("deleteFile RuntimeException" , e);
			}
        } else {
            resultCode = -1;
        }
        
        return resultCode;
    }
    
    public strictfp long getFolderSize(HttpServletRequest request, String fileCpctySe) throws Exception{
    	String contextPath = request.getSession().getServletContext().getRealPath("/"); 
    	if (contextPath != null && contextPath.length() > 0) {
    		contextPath = contextPath.substring(0, contextPath.length() - 1);
    	}
    	
    	String folderPath = contextPath + EgovProperties.getProperty("Globals.fileStorePath")+CmmSessionUtil.getSessionSiteSeq(request)+"/";
    	
    	File dir = new File(folderPath);
    	
    	long fSize = 0;
    	
		fSize += getFileSize(dir);
    	
    	if(fSize > 0){
    		
    		if(!"".equals(fileCpctySe)){
    			if("K".equals(fileCpctySe)){ fSize = fSize / 1024; }
    			if("M".equals(fileCpctySe)){ fSize = fSize / (1024 * 1024); }
    			if("G".equals(fileCpctySe)){ fSize = fSize / (1024 * 1024 * 1024); }
    			if("T".equals(fileCpctySe)){ fSize = fSize / (1024L * 1024 * 1024 * 1024); }
    		}
        	
        }
    	
    	return fSize;
    }
    
    private static long getFileSize(File dir) throws Exception{
    	long fSize = 0; 
    	
    	File[] fileList = dir.listFiles();
    	if (fileList == null){
    		 return 0;
    	}

    	if(fileList.length > 0) {
	    	if(dir.exists() && dir.isDirectory()) { 
		    	for (int i = 0; i < fileList.length; i++) { 
		    		if (fileList[i].isDirectory()){
		    			fSize = fSize + getFileSize(fileList[i]); 
		    		}else{ 
		    			fSize = fSize + fileList[i].length(); 
		    		} 
		    	} 
	    	}
    	}
        
        return fSize;
    }
    
    /** JSON 형식으로 넘어온 파일 정보를 추출 */
    @SuppressWarnings("unchecked")
	public List<ModuleUploadFileVO> parseFileInfJson(String jsonData, String atchFileId, int fileSn) throws Exception {
    	
    	List<ModuleUploadFileVO> resultList = new ArrayList<ModuleUploadFileVO>();
    	List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
	    
	    resultMap = JSONArray.fromObject(JSONSerializer.toJSON(jsonData));
	    
    	ModuleUploadFileVO fvo = new ModuleUploadFileVO();

    	String atchFileIdString = "";
    	
    	if ("".equals(atchFileId) || atchFileId == null) {
    	    atchFileIdString = fileService.getNextAtchFileId();
    	} else {
    	    atchFileIdString = atchFileId;
    	}
    	
    	for(Map<String, Object> map : resultMap){
    		fvo = new ModuleUploadFileVO();
    		
    		fvo.setAtchFileId(atchFileIdString);
    		fvo.setFileSn(String.valueOf(fileSn));
    		fvo.setFileStreCours(map.get("lastSavedDirectoryPath").toString());
    		fvo.setStreFileNm(map.get("lastSavedFileName").toString());
    		fvo.setOrignlFileNm(map.get("fileName").toString());
    		fvo.setFileExtsn(map.get("fileExtension").toString());
    		fvo.setFileMg(map.get("fileSize").toString());
    		fvo.setThumbStreCours(map.get("lastSavedDirectoryPath").toString()+"thumbnail/");
    		fvo.setThumbFileNm("THUMB_"+map.get("lastSavedFileName").toString());
    		
			resultList.add(fvo);
			
			fileSn++;
    	}
    	return resultList;
    }
    
    /** JSON 형식으로 넘어온 삭제된 파일 정보를 추출 */
    @SuppressWarnings("unchecked")
	public void parseDeleteFileInfJson(String jsonData) throws Exception {
    	
    	List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();

    	resultMap = JSONArray.fromObject(JSONSerializer.toJSON(jsonData));
	    
    	ModuleUploadFileVO fvo = new ModuleUploadFileVO();
    	String isDeleted = "";
    	
    	for(Map<String, Object> map : resultMap){
    		fvo = new ModuleUploadFileVO();
    		
    		fvo.setAtchFileId(map.get("fileId").toString());
    		fvo.setFileSn(map.get("fileSn").toString());
    		
    		isDeleted = map.get("isDeleted").toString();
    		
    		if("true".equals(isDeleted)){
    			fileService.deleteFileInf(fvo);
    		}
    		
    	}
    }
}

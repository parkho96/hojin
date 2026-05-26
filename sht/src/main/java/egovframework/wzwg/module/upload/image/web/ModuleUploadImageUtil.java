package egovframework.wzwg.module.upload.image.web;

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

import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.idgnr.EgovIdGnrService;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.module.upload.image.service.ModuleUploadImageVO;


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
@Component("ModuleUploadImageUtil")
public class ModuleUploadImageUtil {

    public static final int BUFF_SIZE = 2048;


    @Resource(name="egovUsrimgIdGnrService")
    private EgovIdGnrService idgenService;

    private static final Logger LOG = Logger.getLogger(ModuleUploadImageUtil.class.getName());

    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
    public List<ModuleUploadImageVO> parseFileInf(Map<String, MultipartFile> files, ModuleUploadImageVO vo, MultipartHttpServletRequest multiRequest) throws Exception {
	int fileKey = 0;
	
	String contextPath = multiRequest.getSession().getServletContext().getRealPath("/");
	if (contextPath != null && contextPath.length() > 0) {
		contextPath = contextPath.substring(0, contextPath.length() - 1);
	}
	
	String storePathString = contextPath + EgovProperties.getProperty("Globals.imageStorePath");
	String whiteFileExtStr = contextPath + EgovProperties.getProperty("Globals.WhiteImgFileExt");
	File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

	if (!saveFolder.exists() || saveFolder.isFile()) {
		boolean _flag = saveFolder.mkdirs();
		if (!_flag) {
		    throw new IOException("Directory creation Failed ");
		}  
	}

	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	MultipartFile file;
	String filePath = "";
	List<ModuleUploadImageVO> result  = new ArrayList<ModuleUploadImageVO>();
	ModuleUploadImageVO fvo;

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

	    int index = (orginFileName != null) ? orginFileName.lastIndexOf(".") : -1;
	    //String fileName = orginFileName.substring(0, index);
	    String fileExt = (index != -1) ? orginFileName.substring(index + 1) : "";
	    String newName = getTimeStamp() + fileKey;
	    long _size = file.getSize();

	    if (!"".equals(orginFileName)) {
		filePath = storePathString + File.separator + newName;
		file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
	    }
	    if(fileExt != null && whiteFileExtStr != null) {
		    if(whiteFileExtStr.indexOf(fileExt.toLowerCase().trim()) > -1) {
		    fvo = new ModuleUploadImageVO();
		    fvo.setImageExtsn(fileExt);
		    fvo.setImageStreCours(storePathString);
		    fvo.setImageMg(Long.toString(_size));
		    fvo.setOrignlImageNm(orginFileName);
		    fvo.setStreImageNm(newName);
		    fvo.setUsrimgId(vo.getUsrimgId());
		    fvo.setImgfolderId(vo.getImgfolderId());
		    fvo.setFrstRegisterId(vo.getFrstRegisterId());
		    fvo.setSiteSeq(vo.getSiteSeq());
		    
		    //writeFile(file, newName, storePathString);
		    result.add(fvo);
		    fileKey++;
		    }else{
	    		deleteFile(EgovWebUtil.filePathBlackList(filePath)+"."+fileExt);
				return null;
		    }
	    }
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
	    stream = file.getInputStream();
	    File cFile = new File(stordFilePath);

	    if (!cFile.isDirectory()) {
		boolean _flag = cFile.mkdir();
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
	}  catch(NullPointerException e){
		LOG.error("NullPointerException",e);
   	}catch(NumberFormatException e){
   		LOG.error("NumberFormatException",e);
   	}catch(IllegalFormatException e){
   		LOG.error("IllegalFormatException",e);
   	}catch(ArrayIndexOutOfBoundsException e){
   		LOG.error("ArrayIndexOutOfBoundsException",e);
   	}catch(IOException e){
   		LOG.error("IOException",e);
   	}finally {
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
		response.setHeader("Content-Disposition", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
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
	    stream = file.getInputStream();
	    File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));

	    if (!cFile.isDirectory()) {
			boolean _flag = cFile.mkdir();
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
   	}finally {
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
	
		if (!file.exists() || !file.isFile()) {
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
				response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
				response.setContentLength(fSize);
				
				FileCopyUtils.copy(in, response.getOutputStream());
			    response.getOutputStream().flush();
		    } catch (IOException e) {
			    throw e;
			} catch (Exception e) {
			    throw e;
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

	try {
	    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
	    Timestamp ts = new Timestamp(System.currentTimeMillis());

	    rtnStr = sdfCurrent.format(ts.getTime());
	} catch(NullPointerException e){
		LOG.error("NullPointerException",e);
   	}catch(NumberFormatException e){
   		LOG.error("NumberFormatException",e);
   	}catch(IllegalFormatException e){
   		LOG.error("IllegalFormatException",e);
   	}catch(ArrayIndexOutOfBoundsException e){
   		LOG.error("ArrayIndexOutOfBoundsException",e);
   	}

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
}

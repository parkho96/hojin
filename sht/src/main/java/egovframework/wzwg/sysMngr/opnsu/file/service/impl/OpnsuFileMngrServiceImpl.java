package egovframework.wzwg.sysMngr.opnsu.file.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileMngrService;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileVO;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import net.coobird.thumbnailator.Thumbnails;

/**
 * @Class Name : EgovFileMngServiceImpl.java
 * @Description : 파일정보의 관리를 위한 구현 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭    최초생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Slf4j
@Service("OpnsuFileMngrService")
@SuppressWarnings("rawtypes")
public class OpnsuFileMngrServiceImpl extends EgovAbstractServiceImpl implements OpnsuFileMngrService {

    @Resource(name = "OpnsuFileMngrDAO")
    private OpnsuFileMngrDAO fileMngDAO;

    /**
     * 여러 개의 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInfs(java.util.List)
     */
    public void deleteFileInfs(List fvoList) throws Exception {
    	fileMngDAO.deleteFileInfs(fvoList);
    }

    /**
     * 파일 ID를 추출
     * 
     * @param fvo
     * @throws Exception
     */
    public String getNextAtchFileId() throws Exception {
    	return fileMngDAO.getNextAtchFileId();
    }
    
    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInf(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public String insertFileInf(OpnsuFileVO fvo) throws Exception {
		String atchFileId = fvo.getAtchFileId();
		
		fileMngDAO.insertFileInf(fvo);
		
		makeImageThumbnail(fvo);
	
		return atchFileId;
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInfs(java.util.List)
     */
    public String insertFileInfs(List fvoList) throws Exception {
    	String atchFileId = "";
	
		if (fvoList.size() != 0) {
		    atchFileId = fileMngDAO.insertFileInfs(fvoList);
		    
		    OpnsuFileVO vo = new OpnsuFileVO();
		    
		    for(int i = 0; i < fvoList.size(); i++){
		    	vo = (OpnsuFileVO) fvoList.get(i);
		    	
			    if("jpg".equals(vo.getFileExtsn().toLowerCase()) 
			    		|| "jpeg".equals(vo.getFileExtsn().toLowerCase())
			    		|| "gif".equals(vo.getFileExtsn().toLowerCase()) 
			    		|| "png".equals(vo.getFileExtsn().toLowerCase())){
			    	makeImageThumbnail(vo);
			    }

		    }
		    
		}
		
		if(atchFileId == ""){
			atchFileId = null;
		}
		
		return atchFileId;
    }

    /**
     * 파일에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInfs(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public List<OpnsuFileVO> selectFileInfs(OpnsuFileVO fvo) throws Exception {
    	return fileMngDAO.selectFileInfs(fvo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#updateFileInfs(java.util.List)
     */
    public void updateFileInfs(List fvoList) throws Exception {
		//Delete & Insert
		fileMngDAO.updateFileInfs(fvoList);
		
		OpnsuFileVO vo = new OpnsuFileVO();
	    
	    for(int i = 0; i < fvoList.size(); i++){
	    	vo = (OpnsuFileVO) fvoList.get(i);
	    	
		    if("jpg".equals(vo.getFileExtsn().toLowerCase()) 
		    		|| "jpeg".equals(vo.getFileExtsn().toLowerCase())
		    		|| "gif".equals(vo.getFileExtsn().toLowerCase()) 
		    		|| "png".equals(vo.getFileExtsn().toLowerCase())){
		    	makeImageThumbnail(vo);
		    }
		    
	    }
    }

    /**
     * 하나의 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInf(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public int deleteFileInf(OpnsuFileVO fvo) throws Exception {
    	return fileMngDAO.deleteFileInf(fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInf(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public OpnsuFileVO selectFileInf(OpnsuFileVO fvo) throws Exception {
    	return fileMngDAO.selectFileInf(fvo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#getMaxFileSN(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public int getMaxFileSN(OpnsuFileVO fvo) throws Exception {
    	return fileMngDAO.getMaxFileSN(fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#deleteAllFileInf(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public void deleteAllFileInf(OpnsuFileVO fvo) throws Exception {
    	fileMngDAO.deleteAllFileInf(fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectFileListByFileNm(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public Map<String, Object> selectFileListByFileNm(OpnsuFileVO fvo) throws Exception {
		List<OpnsuFileVO>  result = fileMngDAO.selectFileListByFileNm(fvo);
		int cnt = fileMngDAO.selectFileListCntByFileNm(fvo);
	
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("resultList", result);
		map.put("resultCnt", Integer.toString(cnt));
	
		return map;
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public List<OpnsuFileVO> selectImageFileList(OpnsuFileVO vo) throws Exception {
    	return fileMngDAO.selectImageFileList(vo);
    }
    
    /**
     * 이미지 파일에 대한 전체 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public List<OpnsuFileVO> selectImageFileAllList(OpnsuFileVO vo) throws Exception {
        return fileMngDAO.selectImageFileAllList(vo);
    }
    
    /**
     * 폴더 목록을 조회한다.
     * 
     * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.OpnsuNttFileVO)
     */
    public List<OpnsuFileVO> selectDirList(OpnsuFileVO vo) throws Exception {
        return fileMngDAO.selectDirList(vo);
    }
    
    /** 첨부한 이미지에 대한 썸네일 생성 */
    public strictfp void makeImageThumbnail(OpnsuFileVO vo) throws Exception {
    	System.out.println("<<<<<<<<<<<<<makeImageThumbnail");
    	
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            throw new IOException("Auth Failed ");
        }
        
        OpnsuFileVO OpnsuFileVO = selectFileInf(vo);
        
        int thumbWidth = 1024;
        int thumbHeight = 768;
     
        // 탐지 포인트 방어: 경로 조작(Path Traversal) 문자열 필터링
        String srcPath = (OpnsuFileVO.getFileStreCours() + OpnsuFileVO.getStreFileNm()).replaceAll("\\.\\.", "");
        String destPath = (OpnsuFileVO.getThumbStreCours() + OpnsuFileVO.getThumbFileNm()).replaceAll("\\.\\.", "");
        
        // 원본 및 대상 경로 설정
        File srcFile = new File(srcPath);
        
        // 썸네일 파일명을 확장자 없이 생성
        File destFile = new File(destPath);
        
        if (!srcFile.exists()) {
            log.error("원본 이미지를 찾을 수 없습니다. 파일 경로를 확인하세요.");
            return;
        }

        // 썸네일 저장 디렉토리 생성
        File destDir = destFile.getParentFile();
        if (destDir != null && !destDir.exists()) {
            if(!destDir.mkdirs()) {
                log.info(destDir + " : directory make fail ");
            }
        }

        try (
            /**
             * Sparrow AWT 사용제한 대응: java.awt.Graphics2D 및 BufferedImage 대신 Thumbnailator 사용
             * 확장자 없이 저장하기 위해 FileOutputStream을 명시적으로 사용
             */
            OutputStream os = new FileOutputStream(destFile);
		){
            
            Thumbnails.of(srcFile)
                .size(thumbWidth, thumbHeight)
                .outputFormat(OpnsuFileVO.getFileExtsn()) // 이미지 포맷(내부 데이터 형식)은 유지
                .toOutputStream(os); // 스트림을 통해 저장하면 파일명에 확장자가 강제로 붙지 않음
                
        } catch (FileNotFoundException e) {
            log.error("Required file not found during thumbnail creation."); 
            throw new Exception("파일을 찾을 수 없어 썸네일 생성에 실패했습니다.");
        } catch (IOException e) {
            log.error("I/O error occurred during thumbnail processing.");
            throw new Exception("이미지 처리 중 오류가 발생했습니다.");
        } catch (Exception e) {
            log.error("Thumbnail generation failed: " + e.getMessage());
            throw e;
        }
    }
    
}

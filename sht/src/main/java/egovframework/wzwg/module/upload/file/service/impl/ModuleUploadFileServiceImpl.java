package egovframework.wzwg.module.upload.file.service.impl;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
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
@Service("ModuleUploadFileService")
@SuppressWarnings("rawtypes")
public class ModuleUploadFileServiceImpl extends EgovAbstractServiceImpl implements ModuleUploadFileService {

    @Resource(name = "ModuleUploadFileDAO")
    private ModuleUploadFileDAO fileDAO;

    public static final Logger LOGGER = Logger.getLogger(ModuleUploadFileServiceImpl.class.getName());

    /**
     * 여러 개의 파일을 삭제한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInfs(java.util.List)
     */
    public void deleteFileInfs(List fvoList) throws Exception {
        fileDAO.deleteFileInfs(fvoList);
    }

    /**
     * 파일 ID를 추출
     * * @param fvo
     * @throws Exception
     */
    public String getNextAtchFileId() throws Exception {
        return fileDAO.getNextAtchFileId();
    }
    
    /**
     * 하나의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInf(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public String insertFileInf(ModuleUploadFileVO fvo) throws Exception {
        String atchFileId = fvo.getAtchFileId();
        
        fileDAO.insertFileInf(fvo);
        
        makeImageThumbnail(fvo);
    
        return atchFileId;
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#insertFileInfs(java.util.List)
     */
    public String insertFileInfs(List fvoList) throws Exception {
        String atchFileId = "";
    
        if (fvoList.size() != 0) {
            atchFileId = fileDAO.insertFileInfs(fvoList);
            
            ModuleUploadFileVO vo = new ModuleUploadFileVO();
            
            for(int i = 0; i < fvoList.size(); i++){
                vo = (ModuleUploadFileVO) fvoList.get(i);
                
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
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInfs(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public List<ModuleUploadFileVO> selectFileInfs(ModuleUploadFileVO fvo) throws Exception {
        return fileDAO.selectFileInfs(fvo);
    }

    /**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 수정한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#updateFileInfs(java.util.List)
     */
    public void updateFileInfs(List fvoList) throws Exception {
        //Delete & Insert
        fileDAO.updateFileInfs(fvoList);
        
        ModuleUploadFileVO vo = new ModuleUploadFileVO();
    
        for(int i = 0; i < fvoList.size(); i++){
            vo = (ModuleUploadFileVO) fvoList.get(i);
            
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
     * * @see egovframework.com.cmm.service.EgovFileMngService#deleteFileInf(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public int deleteFileInf(ModuleUploadFileVO fvo) throws Exception {
        return fileDAO.deleteFileInf(fvo);
    }

    /**
     * 파일에 대한 상세정보를 조회한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectFileInf(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public ModuleUploadFileVO selectFileInf(ModuleUploadFileVO fvo) throws Exception {
        return fileDAO.selectFileInf(fvo);
    }

    /**
     * 파일 구분자에 대한 최대값을 구한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#getMaxFileSN(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public int getMaxFileSN(ModuleUploadFileVO fvo) throws Exception {
        return fileDAO.getMaxFileSN(fvo);
    }

    /**
     * 전체 파일을 삭제한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#deleteAllFileInf(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public void deleteAllFileInf(ModuleUploadFileVO fvo) throws Exception {
        fileDAO.deleteAllFileInf(fvo);
    }

    /**
     * 파일명 검색에 대한 목록을 조회한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectFileListByFileNm(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public Map<String, Object> selectFileListByFileNm(ModuleUploadFileVO fvo) throws Exception {
        List<ModuleUploadFileVO> result = fileDAO.selectFileListByFileNm(fvo);
        int cnt = fileDAO.selectFileListCntByFileNm(fvo);

        Map<String, Object> map = new HashMap<String, Object>();
        
        map.put("resultList", result);
        map.put("resultCnt", Integer.toString(cnt));

        return map;
    }

    /**
     * 이미지 파일에 대한 목록을 조회한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public List<ModuleUploadFileVO> selectImageFileList(ModuleUploadFileVO vo) throws Exception {
        return fileDAO.selectImageFileList(vo);
    }
    
    /**
     * 이미지 파일에 대한 전체 목록을 조회한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public List<ModuleUploadFileVO> selectImageFileAllList(ModuleUploadFileVO vo) throws Exception {
        return fileDAO.selectImageFileAllList(vo);
    }
    
    /**
     * 폴더 목록을 조회한다.
     * * @see egovframework.com.cmm.service.EgovFileMngService#selectImageFileList(egovframework.com.cmm.service.ModuleUploadFileVO)
     */
    public List<ModuleUploadFileVO> selectDirList(ModuleUploadFileVO vo) throws Exception {
        return fileDAO.selectDirList(vo);
    }
    
    
    /** 첨부한 이미지에 대한 썸네일 생성 */
    public strictfp void makeImageThumbnail(ModuleUploadFileVO vo) throws Exception {

        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
        
        if(!isAuthenticated) {
            throw new IOException("Auth Failed ");
        }
        
        ModuleUploadFileVO moduleUploadFileVO = selectFileInf(vo);
        
        int thumbWidth = 1024;
        int thumbHeight = 768;
     
        // 탐지 포인트 방어: 경로 조작(Path Traversal) 문자열 필터링
        String srcPath = (moduleUploadFileVO.getFileStreCours() + moduleUploadFileVO.getStreFileNm()).replaceAll("\\.\\.", "");
        String destPath = (moduleUploadFileVO.getThumbStreCours() + moduleUploadFileVO.getThumbFileNm()).replaceAll("\\.\\.", "");
        
        // 원본 및 대상 경로 설정
        File srcFile = new File(srcPath);
        
        // 썸네일 파일명을 확장자 없이 생성
        File destFile = new File(destPath);
        
        if (!srcFile.exists()) {
            LOGGER.error("원본 이미지를 찾을 수 없습니다. 파일 경로를 확인하세요.");
            return;
        }

        // 썸네일 저장 디렉토리 생성
        File destDir = destFile.getParentFile();
        if (destDir != null && !destDir.exists()) {
            if(!destDir.mkdirs()) {
                LOGGER.info(destDir + " : directory make fail ");
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
                .outputFormat(moduleUploadFileVO.getFileExtsn()) // 이미지 포맷(내부 데이터 형식)은 유지
                .toOutputStream(os); // 스트림을 통해 저장하면 파일명에 확장자가 강제로 붙지 않음
                
        } catch (FileNotFoundException e) {
            LOGGER.error("Required file not found during thumbnail creation."); 
            throw new Exception("파일을 찾을 수 없어 썸네일 생성에 실패했습니다.");
        } catch (IOException e) {
            LOGGER.error("I/O error occurred during thumbnail processing.");
            throw new Exception("이미지 처리 중 오류가 발생했습니다.");
        } catch (Exception e) {
            LOGGER.error("Thumbnail generation failed: " + e.getMessage());
            throw e;
        }
    }
    
    /**
     * 첨부파일의 설명을 수정한다
     * * @param vo
     * @return
     * @throws Exception
     */
    public int updateFileDc(ModuleUploadFileVO vo) throws Exception{
        return fileDAO.updateFileDc(vo);
    }
}
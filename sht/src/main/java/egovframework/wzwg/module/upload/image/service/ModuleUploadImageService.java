package egovframework.wzwg.module.upload.image.service;

import java.util.List;

/**
 * @Class Name : EgovFileMngService.java
 * @Description : 파일정보의 관리를 위한 서비스 인터페이스
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
public interface ModuleUploadImageService {

	/** 폴더가 생성된 사이트 목록 */
    public List<ModuleUploadImageVO> selectSearchSiteList(ModuleUploadImageVO vo) throws Exception;
    
	/** 업로드된 이미지 목록 조회 */
    public List<ModuleUploadImageVO> selectImageList(ModuleUploadImageVO vo) throws Exception;
    
    /** 이미지 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectFolderList(ModuleUploadImageVO vo) throws Exception;
    
    /** 이미지 하위 폴더 목록을 조회한다. */
    public List<ModuleUploadImageVO> selectSubFolderList(ModuleUploadImageVO vo) throws Exception;
    
    /** 폴더 생성 */
    public void registFolder(ModuleUploadImageVO vo) throws Exception;
    
    /** 폴더 수정 */
    public void modifyFolder(ModuleUploadImageVO vo) throws Exception;
    
    /** 폴더 삭제 */
    public void deleteFolder(ModuleUploadImageVO vo) throws Exception;
    
    /** usrimgId 추출 */
    public String getNextUsrimgId() throws Exception;
    
    /** 단일 이미지 업로드 */
    public String uploadImage(ModuleUploadImageVO vo) throws Exception;
    
    /** 다중 이미지 업로드 */
    public String uploadImage(List<ModuleUploadImageVO> list) throws Exception;
    
    /** 이미지 상세정보 */
    public ModuleUploadImageVO selectImageDetail(ModuleUploadImageVO vo) throws Exception;
    
    /** 이미지 삭제 */
    public int deleteImage(ModuleUploadImageVO vo) throws Exception;

    /** 폴더 체크 */
    public int selectFolderImageCheck(ModuleUploadImageVO vo) throws Exception;
}

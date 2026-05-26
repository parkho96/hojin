package egovframework.wzwg.module.upload.file.service;

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
@SuppressWarnings("rawtypes")
public interface ModuleUsrFileService {

	   @SuppressWarnings("unchecked")
	    public void insertUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception ;
	    
	    @SuppressWarnings("unchecked")
	    public void insertUsrFile(ModuleUsrFileVO paramVO) throws Exception ;
	    
	    @SuppressWarnings("unchecked")
	    public void deleteUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception;
	    
	    @SuppressWarnings("unchecked")
	    public void deleteUsrFile(ModuleUsrFileVO paramVO) throws Exception ;
	    
	    @SuppressWarnings("unchecked")
	    public List<ModuleUsrFileVO> selectUsrFilectgryList(ModuleUsrFileVO paramVO) throws Exception ;
	    
	    @SuppressWarnings("unchecked")
	    public List<ModuleUsrFileVO> selectUsrFileList(ModuleUsrFileVO paramVO) throws Exception;
	    
	    public ModuleUsrFileVO selectUsrFile(ModuleUsrFileVO paramVO) throws Exception ;
    
	    public int selectUsrFileCnt(ModuleUsrFileVO paramVO) throws Exception;
	    	
}

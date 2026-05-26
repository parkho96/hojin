package egovframework.wzwg.module.upload.fileMngr.service;

import java.util.List;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;


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
public interface ModuleUploadFileMngrService {

    public List<ModuleUploadFileVO> selectFileTyCodeList() throws Exception;
    
	public int modifyFileEstbsMngr(ModuleUploadFileVO vo) throws Exception;
	
	public List<ModuleUploadFileVO> selectEstbsFileTyCodeList(ModuleUploadFileVO vo) throws Exception;
	
	public int modifyFileEstbsInfo(ModuleUploadFileVO vo) throws Exception;
	
	public List<ModuleUploadFileVO> selectEstbsExtsnList(ModuleUploadFileVO vo) throws Exception;
	
	public int modifyFileBassEstbsInfo(ModuleUploadFileVO vo) throws Exception ;
	
}

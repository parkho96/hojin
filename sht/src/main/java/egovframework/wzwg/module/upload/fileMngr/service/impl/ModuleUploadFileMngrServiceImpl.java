package egovframework.wzwg.module.upload.fileMngr.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;

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
@Service("ModuleUploadFileMngrService")
public class ModuleUploadFileMngrServiceImpl extends EgovAbstractServiceImpl implements ModuleUploadFileMngrService {

    @Resource(name = "ModuleUploadFileMngrDAO")
    private ModuleUploadFileMngrDAO moduleUploadFileMngrDAO;

    public static final Logger LOGGER = Logger.getLogger(ModuleUploadFileMngrServiceImpl.class.getName());

    
    public List<ModuleUploadFileVO> selectFileTyCodeList() throws Exception {
    	return moduleUploadFileMngrDAO.selectFileTyCodeList();
    }
    
	public int modifyFileEstbsMngr(ModuleUploadFileVO vo) throws Exception {
		
		int resultSize = selectFileTyCodeList().size();
		int result = 0;
		
		if(resultSize > 0){
			
			String[] fileTyCodeArr 		= vo.getFileTyCodeArr().substring(0, vo.getFileTyCodeArr().length()-1).split(",");
			String[] fileCpctyArr 		= vo.getFileCpctyArr().substring(0, vo.getFileCpctyArr().length()-1).split(",");
			String[] fileCpctySeArr		= vo.getFileCpctySeArr().substring(0, vo.getFileCpctySeArr().length()-1).split(",");
			String[] permAtArr 			= vo.getPermAtArr().substring(0, vo.getPermAtArr().length()-1).split(",");
			String[] fileAllCpctyArr	= vo.getFileAllCpctyArr().substring(0, vo.getFileAllCpctyArr().length()-1).split(",");
					
			for(int i = 0; i < fileTyCodeArr.length; i++){
				vo.setFileTyCode(fileTyCodeArr[i]);
				vo.setFileCpcty(fileCpctyArr[i]);
				vo.setFileCpctySe(fileCpctySeArr[i]);
				vo.setPermAt(permAtArr[i]);
				vo.setFileAllCpcty(fileAllCpctyArr[i]);
				
				result = moduleUploadFileMngrDAO.modifyFileEstbsMngr(vo);
				result++;
			}
			
		}
		
		return result;
	}
	
	public List<ModuleUploadFileVO> selectEstbsFileTyCodeList(ModuleUploadFileVO vo) throws Exception {
		return moduleUploadFileMngrDAO.selectEstbsFileTyCodeList(vo);
	}
	
	public int modifyFileEstbsInfo(ModuleUploadFileVO vo) throws Exception {
		
		int resultSize = selectFileTyCodeList().size();
		int result = 0;
		 
		if(resultSize > 0){
			
			String[] fileTyCodeArr 	= vo.getFileTyCodeArr().substring(0, vo.getFileTyCodeArr().length()-1).split(",");
			String[] mdPermAtArr 	= vo.getMdPermAtArr().substring(0, vo.getMdPermAtArr().length()-1).split(",");
			
			for(int i = 0; i < fileTyCodeArr.length; i++){
				vo.setFileTyCode(fileTyCodeArr[i]);
				vo.setMdPermAt(mdPermAtArr[i]);
				 
				result = moduleUploadFileMngrDAO.modifyFileEstbsInfo(vo);
				result++;
			}
			
		}
		
		return result;
	}
	
	public int modifyFileBassEstbsInfo(ModuleUploadFileVO vo) throws Exception {
		int result =0;
	 
		result = moduleUploadFileMngrDAO.modifyFileEstbsInfo(vo); 
		return result;
	}
    
	public List<ModuleUploadFileVO> selectEstbsExtsnList(ModuleUploadFileVO vo) throws Exception {
		return moduleUploadFileMngrDAO.selectEstbsExtsnList(vo);
	}
    
}

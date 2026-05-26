package egovframework.wzwg.module.upload.file.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.log4j.Logger;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.upload.file.service.ModuleUsrFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUsrFileVO;

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
@Service("ModuleUsrFileService")
@SuppressWarnings("rawtypes")
public class ModuleUsrFileServiceImpl extends EgovAbstractServiceImpl implements ModuleUsrFileService {

    @Resource(name = "ModuleUsrFileDAO")
    private ModuleUsrFileDAO fileDAO;

    public static final Logger LOGGER = Logger.getLogger(ModuleUsrFileServiceImpl.class.getName());

    @SuppressWarnings("unchecked")
    public void insertUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception {
    	fileDAO.insertUsrFilectgry(paramVO);
    }
    
    @SuppressWarnings("unchecked")
    public void insertUsrFile(ModuleUsrFileVO paramVO) throws Exception {
    	fileDAO.insertUsrFile(paramVO);
    }
    
    @SuppressWarnings("unchecked")
    public void deleteUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception {
  
    	fileDAO.deleteUsrFilectgry(paramVO);
    }
    
    @SuppressWarnings("unchecked")
    public void deleteUsrFile(ModuleUsrFileVO paramVO) throws Exception {
  
    	fileDAO.deleteUsrFile(paramVO);
    }
    
    @SuppressWarnings("unchecked")
    public List<ModuleUsrFileVO> selectUsrFilectgryList(ModuleUsrFileVO paramVO) throws Exception {
  
	 return  fileDAO.selectUsrFilectgryList(paramVO);
    }
    
    @SuppressWarnings("unchecked")
    public List<ModuleUsrFileVO> selectUsrFileList(ModuleUsrFileVO paramVO) throws Exception {
  
   	 return  fileDAO.selectUsrFileList(paramVO);
    }
    
    public ModuleUsrFileVO selectUsrFile(ModuleUsrFileVO paramVO) throws Exception {
  	  
     	 return  fileDAO.selectUsrFile(paramVO);
      }
    
    public int selectUsrFileCnt(ModuleUsrFileVO paramVO) throws Exception {
    	  
    	 return  fileDAO.selectUsrFileCnt(paramVO);
     }
}

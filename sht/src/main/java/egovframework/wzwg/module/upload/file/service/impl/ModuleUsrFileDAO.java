package egovframework.wzwg.module.upload.file.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.upload.file.service.ModuleUsrFileVO;

/**
 * @Class Name : EgovFileMngDAO_java
 * @Description : 파일정보 관리를 위한 데이터 처리 클래스
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
@Repository("ModuleUsrFileDAO")
public class ModuleUsrFileDAO extends EgovAbstractMapper {

    //private static final Logger LOG = Logger.getLogger(this.getClass());

 
    public String getNextFilectgrySeq() throws Exception {
    	return (String) selectOne("ModuleUsrFileDAO_getNextFilectgrySeq", new String());
    }
    
    public String getNextUsrfileSeq() throws Exception {
    	return (String) selectOne("ModuleUsrFileDAO_getNextUsrfileSeq", new String());
    }
    
    
    public void insertUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception {
    	String filectgrySeq = getNextFilectgrySeq();
    	System.out.println("filectgrySeq : "+filectgrySeq);
    	paramVO.setFilectgrySeq(filectgrySeq);
	  insert("ModuleUsrFileDAO_insertUsrFilectgry", paramVO);
    }
    
    
    public void insertUsrFile(ModuleUsrFileVO paramVO) throws Exception {
    	String usrfileSeq = getNextUsrfileSeq();
    	paramVO.setUsrfileSeq(usrfileSeq);
	  insert("ModuleUsrFileDAO_insertUsrFile", paramVO);
    }
    
    
    public void deleteUsrFilectgry(ModuleUsrFileVO paramVO) throws Exception {
  
    	delete("ModuleUsrFileDAO_deleteUsrFilectgry", paramVO);
    }
    
    
    public void deleteUsrFile(ModuleUsrFileVO paramVO) throws Exception {
  
	  delete("ModuleUsrFileDAO_deleteUsrFile", paramVO);
    }
    
    
    public List<ModuleUsrFileVO> selectUsrFilectgryList(ModuleUsrFileVO paramVO) throws Exception {
  
	 return  selectList("ModuleUsrFileDAO_selectUsrFilectgryList", paramVO);
    }
    
    
    public List<ModuleUsrFileVO> selectUsrFileList(ModuleUsrFileVO paramVO) throws Exception {
  
   	 return  selectList("ModuleUsrFileDAO_selectUsrFileList", paramVO);
    }
    
    public ModuleUsrFileVO selectUsrFile(ModuleUsrFileVO paramVO) throws Exception {
    	  
      	 return  (ModuleUsrFileVO)selectOne("ModuleUsrFileDAO_selectUsrFile", paramVO);
       }
 
    public int selectUsrFileCnt(ModuleUsrFileVO paramVO) throws Exception {
  	  
     	 return  ((Integer)selectOne("ModuleUsrFileDAO_selectUsrFileCnt", paramVO)).intValue();
      }
}

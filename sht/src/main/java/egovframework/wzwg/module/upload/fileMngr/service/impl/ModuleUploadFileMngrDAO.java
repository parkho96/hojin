package egovframework.wzwg.module.upload.fileMngr.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;



@Repository("ModuleUploadFileMngrDAO")
public class ModuleUploadFileMngrDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
    public List<ModuleUploadFileVO> selectFileTyCodeList() throws Exception {
    	
    	String langcode = null;
    	ModuleUploadFileVO vo = new ModuleUploadFileVO();
    	
    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	vo.setLangCode(langcode);
    	
    	return selectList("ModuleUploadFileMngrDAO_selectFileTyCodeList_S", vo);
    }
    
	public int modifyFileEstbsMngr(ModuleUploadFileVO vo) throws Exception {
		return update("ModuleUploadFileMngrDAO_modifyFileEstbsMngr_U", vo);
	}

	public List<ModuleUploadFileVO> selectEstbsFileTyCodeList(ModuleUploadFileVO vo) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		vo.setLangCode(langcode);
		
    	return selectList("ModuleUploadFileMngrDAO_selectEstbsFileTyCodeList_S", vo);
    }
	
	public int modifyFileEstbsInfo(ModuleUploadFileVO vo) throws Exception {
		return update("ModuleUploadFileMngrDAO_modifyFileEstbsInfo_U", vo);
	}
	
	public List<ModuleUploadFileVO> selectEstbsExtsnList(ModuleUploadFileVO vo) throws Exception {
    	return selectList("ModuleUploadFileMngrDAO_selectEstbsExtsnList_S", vo);
    }
    
}

package egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.impl;

import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;

@Repository("SnsKeyMngrDAO")
public class SnsKeyMngrDAO extends EgovAbstractMapper{

	@Autowired
	HttpSession session;

	
    
    public List<SnsKeyMngrVO> selectSnsKeyMngrList(SnsKeyMngrVO paramVO) throws Exception {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("SnsKeyMngrDAO_selectSnsKeyMngrList", paramVO);
    }
    
    public  SnsKeyMngrVO  selectSnsKeyMngr(SnsKeyMngrVO paramVO) throws SQLException {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return (SnsKeyMngrVO)selectOne("SnsKeyMngrDAO_selectSnsKeyMngr", paramVO);
    }

    public Integer selectSnsKeyMngrChk(SnsKeyMngrVO paramVO) throws Exception {
        return (Integer)selectOne("SnsKeyMngrDAO_selectSnsKeyMngrChk", paramVO);
    }

    public int registSnsKeyMngr(SnsKeyMngrVO paramVO) throws Exception {
        return update("SnsKeyMngrDAO_registSnsKeyMngr", paramVO);
    }

    public int modifySnsKeyMngr(SnsKeyMngrVO paramVO) throws Exception {
        return update("SnsKeyMngrDAO_modifySnsKeyMngr", paramVO);
    }
    
    public Integer selectSnsKeyDeleteChk(SnsKeyMngrVO paramVO) throws Exception {
        return (Integer)selectOne("SnsKeyMngrDAO_selectSnsKeyDeleteChk", paramVO);
    }
    
    public int deleteSnsKeyMngr(SnsKeyMngrVO paramVO) throws Exception {
        return delete("SnsKeyMngrDAO_deleteSnsKeyMngr", paramVO);
    }
}

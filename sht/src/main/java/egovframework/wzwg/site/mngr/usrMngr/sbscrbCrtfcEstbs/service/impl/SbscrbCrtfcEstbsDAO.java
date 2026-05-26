package egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Repository("SbscrbCrtfcEstbsDAO")
public class SbscrbCrtfcEstbsDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/** 가입인증설정 목록*/
	
	public List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsList(SbscrbCrtfcEstbsVO paramVO) {
		
		return selectList("SbscrbCrtfcEstbsDAO_selectSbscrbCrtfcEstbsList", paramVO);
	}

	/** 가입인증설정 조회*/
	public int selectSbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO) {
	
		return (Integer)selectOne("SbscrbCrtfcEstbsDAO_selectSbscrbCrtfcEstbs", paramVO);
	}
    
    /**
     *  시스템인증설정 목록
     * @param cmmSbscrbVO
     * @return
     * @throws Exception
     */
    
    public List<UsrPrefcesVO> selectCrtfcEstbsList(String grpcode) {
    	
    	String langcode = null;
    	UsrPrefcesVO paramVO = new UsrPrefcesVO();
    	
    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}
    	String siteSeq ="";
    	if(session.getAttribute("SITE_SEQ") != null){
    		siteSeq = session.getAttribute("SITE_SEQ").toString();
    	}
    	paramVO.setSiteSeq(siteSeq);
    	paramVO.setUsrPrefeCode(grpcode);
    	paramVO.setLangCode(langcode);
    	
        return selectList("SbscrbCrtfcEstbsDAO_selectCrtfcEstbsList", paramVO);
    }

	/** 가입인증설정 등록*/
	public int registSbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO) {
	
		return update("SbscrbCrtfcEstbsDAO_registSbscrbCrtfcEstbs", paramVO);
	}

	/** 가입인증설정 수정*/
	public int modifySbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO) {
	
		return update("SbscrbCrtfcEstbsDAO_modifySbscrbCrtfcEstbs", paramVO);
	}
	
	public void deleteSbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO) {

        update("SbscrbCrtfcEstbsDAO_deleteSbscrbCrtfcEstbs", paramVO);
	}
	
	public int selectSbscrbCrtfcEstbsByUsrTyChk(SbscrbCrtfcEstbsVO paramVO) {
		
		return ((Integer)selectOne("SbscrbCrtfcEstbsDAO_selectSbscrbCrtfcEstbsByUsrTyChk", paramVO)).intValue();
	}
    
    
    public List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsByUsrTy(SbscrbCrtfcEstbsVO paramVO) {
        
        return selectList("SbscrbCrtfcEstbsDAO_selectSbscrbCrtfcEstbsByUsrTy", paramVO);
    }
}

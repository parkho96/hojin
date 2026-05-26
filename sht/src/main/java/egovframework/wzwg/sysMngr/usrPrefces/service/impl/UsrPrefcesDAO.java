package egovframework.wzwg.sysMngr.usrPrefces.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Repository("UsrPrefcesDAO")
public class UsrPrefcesDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
    /** 회원관리환경설정 조회 **/
    
    public List<UsrPrefcesVO> selectusrPrefcesIemList(UsrPrefcesVO paramVO) throws Exception {
        
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("UsrPrefcesDAO_selectusrPrefcesIemList", paramVO);
    }

    /** 회원관리환경설정 조회 **/
    public int selectUsrPrefcesIemCnt(UsrPrefcesVO paramVO) throws Exception {
        
        return (Integer)selectOne("UsrPrefcesDAO_selectUsrPrefcesIemCnt", paramVO);
    }

    /** 회원관리환경설정 등록 **/
    public int registUsrPrefces(UsrPrefcesVO paramVO) throws Exception {
        
        return update("UsrPrefcesDAO_registUsrPrefces", paramVO);
    }

    /** 회원관리환경설정 수정 **/
    public int modifyUsrPrefces(UsrPrefcesVO paramVO) throws Exception {
        
        return update("UsrPrefcesDAO_modifyUsrPrefces", paramVO);
    }

    /** 비밀번호 변경 주기(개월수) **/
    public String selectUpdtEstbsMonth(UsrPrefcesVO paramVO) throws Exception {
        
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return (String)selectOne("UsrPrefcesDAO_selectUpdtEstbsMonth", paramVO);
    }
    
    public String selectDupLoginChk(UsrPrefcesVO paramVO) throws Exception {
    	
        return (String)selectOne("UsrPrefcesDAO_selectDupLoginChk", paramVO);
    }
    
    public String selectSessionInterval(UsrPrefcesVO paramVO) throws Exception {
    	return (String)selectOne("UsrPrefcesDAO_selectSessionInterval", paramVO);
    }
}

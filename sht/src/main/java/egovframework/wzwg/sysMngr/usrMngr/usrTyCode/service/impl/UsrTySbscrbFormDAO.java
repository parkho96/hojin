package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;

@Repository("UsrTySbscrbFormDAO")
public class UsrTySbscrbFormDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
    /** 회원유형가입양식설정 조회 **/
    
    public List<UsrTySbscrbFormVO> selectUsrTySbscrbFormList(UsrTySbscrbFormVO paramVO) throws Exception {
        
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("UsrTySbscrbFormDAO_selectUsrTySbscrbFormList", paramVO);
    }

    /** 회원유형가입양식설정 조회 **/
    public int selectUsrTySbscrbFormCnt(UsrTySbscrbFormVO paramVO) throws Exception {
        
        return (Integer)selectOne("UsrTySbscrbFormDAO_selectUsrTySbscrbFormCnt", paramVO);
    }

    /** 회원유형가입양식설정 등록 **/
    public int registUsrTySbscrbForm(UsrTySbscrbFormVO paramVO) throws Exception {
        
        return update("UsrTySbscrbFormDAO_registUsrTySbscrbForm", paramVO);
    }

    /** 회원유형가입양식설정 수정 **/
    public int modifyUsrTySbscrbForm(UsrTySbscrbFormVO paramVO) throws Exception {
        
        return update("UsrTySbscrbFormDAO_modifyUsrTySbscrbForm", paramVO);
    }
	
}

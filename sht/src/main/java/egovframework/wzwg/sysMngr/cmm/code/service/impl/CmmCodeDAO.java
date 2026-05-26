package egovframework.wzwg.sysMngr.cmm.code.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmGrpCodeVO;

@Repository("CmmCodeDAO")
public class CmmCodeDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/** 코드그룹 조회 */
	
	public List<CmmGrpCodeVO> selectCmmGrpCodeList(String grpcode) throws Exception {
		
		return selectList("CmmCodeDAO_selectCmmGrpCodeList", grpcode);
	}
	
	/** 코드조회 */
	
	public List<CmmCodeVO> selectCmmCodeList(String searchCode) throws Exception {
		 String langcode ="";
    	 CmmCodeVO paramVO = new CmmCodeVO();
    	 if(session.getAttribute("useLangCode") != null){
    		  langcode = session.getAttribute("useLangCode").toString();
    	 }
    	 paramVO.setLangCode(langcode);
    	 paramVO.setSearchCode(searchCode);
		return selectList("CmmCodeDAO_selectCmmCodeList", paramVO);
	}
    
    /** 코드조회 */
    
    public List<CmmCodeVO> selectCmmCodeList(CmmCodeVO paramVO) throws Exception {
        
        return selectList("CmmCodeDAO_selectCmmCodeAndUppergrpcodeList", paramVO);
    }

    /** 코드정보조회 **/
    
    public List<CmmCodeVO> selectCodeInfoList(String grpcode) throws Exception {
    	 String langcode ="";
    	 CmmCodeVO paramVO = new CmmCodeVO();
    	 if(session.getAttribute("useLangCode") != null){
    		  langcode = session.getAttribute("useLangCode").toString();
    	 }
    	 paramVO.setLangCode(langcode);
    	 paramVO.setSearchCode(grpcode);
        return selectList("CmmCodeDAO_selectCodeInfoList", paramVO);
    }

    /** 코드정보조회 총건수 **/
    public int selectCodeInfoListCnt(String grpcode) throws Exception {
        return (Integer)selectOne("CmmCodeDAO_selectCodeInfoListCnt", grpcode);
    }

    /** 코드정보조회 **/
    public CmmCodeVO selectCodeInfo(CmmCodeVO paramVO) throws Exception {
    	 String langcode ="";
    	 if(session.getAttribute("useLangCode") != null){
    		  langcode = session.getAttribute("useLangCode").toString();
    	 }
    	 paramVO.setLangCode(langcode);
    		 
        return (CmmCodeVO)selectOne("CmmCodeDAO_selectCodeInfo", paramVO);
    }

    /** 코드SEQ **/
    public String selectSyscodeSeq() throws Exception {
        return (String)selectOne("CmmCodeDAO_selectSyscodeSeq", null);
    }
    
    /** 코드정보 등록 **/
    public int registCodeInfo(CmmCodeVO paramVO) throws Exception {
        return update("CmmCodeDAO_registCodeInfo", paramVO);
    }
    
    /** 코드정보 수정 **/
    public int modifyCodeInfo(CmmCodeVO paramVO) throws Exception {
        return update("CmmCodeDAO_modifyCodeInfo", paramVO);
    }
    
    /** 그룹&코드 매핑 등록 **/
    public int registSysCodeGrpcode(CmmCodeVO paramVO) throws Exception {
        return update("CmmCodeDAO_registSysCodeGrpcode", paramVO);
    }

    /** 코드정보 삭제(DELETE_AT -> 'N') */
	public int deleteCodeInfo(CmmCodeVO paramVO) {
		return update("CmmCodeDAO_deleteCodeInfo", paramVO);
	}
    
}

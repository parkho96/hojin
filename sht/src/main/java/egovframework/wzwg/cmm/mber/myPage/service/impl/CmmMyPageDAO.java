package egovframework.wzwg.cmm.mber.myPage.service.impl;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;

@Repository("CmmMyPageDAO")
public class CmmMyPageDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
    public CmmSbscrbVO selectMyPageUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		
		cmmSbscrbVO.setLangCode(langcode);
    	return (CmmSbscrbVO)selectOne("CmmMyPageDAO_selectMyPageUsrInfo_S", cmmSbscrbVO);
    }
    
    public int modifyMyPageUsrInfo(CmmSbscrbVO paramVO) {
        return update("CmmMyPageDAO_modifyMyPageUsrInfo_U",paramVO);
    }    
    
	public int modifyUsrSecsn(CmmSbscrbVO paramVO) {
		return update("CmmMyPageDAO_modifyUsrSecsn_U", paramVO);
	}    
	
	public int modifyUsrCrtfctSecsn(CmmSbscrbVO paramVO) {
		return update("CmmMyPageDAO_modifyUsrCrtfctSecsn_U", paramVO);
	}  
    
}

package egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.CntntsChargerVO;

@Repository("CntntsChargerDAO")
public class CntntsChargerDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
     * ㅁ 컨텐츠담당자정보 - 모듈 컨텐츠 담당자 정보 목록
	 * @param CntntsChargerVO
	 * @return
	 */
	
	public List<CntntsChargerVO> selectCntntsChargerList(CntntsChargerVO paramVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("CntntsChargerDAO_selectCntntsChargerList", paramVO);
	}
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 등록
     * @param CntntsAuthVO
     * @return
     */
    public int registCntntsCharger(CntntsChargerVO paramVO) {
        return update("CntntsChargerDAO_registCntntsCharger", paramVO);
    }
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 삭제
     * @param CntntsAuthVO
     * @return
     */
    public int deleteCntntsCharger(CntntsChargerVO paramVO) {
        return update("CntntsChargerDAO_deleteCntntsCharger", paramVO);
    }

}

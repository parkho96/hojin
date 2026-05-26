package egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;

/**
 * ㅁ 시스템 - 사용자관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Repository("SysMngrUsrInfoDAO")
public class SysMngrUsrInfoDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
    /**
	 * ㅁ 시스템 - 사용자 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
	public List<SysMngrUsrInfoVO> selectUsrInfoList(SysMngrUsrInfoVO paramVO) throws Exception {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
    	return selectList("SysMngrUsrInfoDAO_selectUsrInfoList", paramVO);
    }

    /**
     * ㅁ 시스템 - 사용자 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
    public List<SysMngrUsrInfoVO> selectUsrList(SysMngrUsrInfoVO paramVO) throws Exception {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
        return selectList("SysMngrUsrInfoDAO_selectUsrList", paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사용자 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectUsrInfoListCnt(SysMngrUsrInfoVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrUsrInfoDAO_selectUsrInfoListCnt", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 사용자 정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteSiteUsrInfo(SysMngrUsrInfoVO paramVO) {
		return update("SysMngrUsrInfoDAO_deleteSiteUsrInfo", paramVO);
	}

    /**
	 * ㅁ 시스템 - 사용자 정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteUsrInfo(SysMngrUsrInfoVO paramVO) {
		return update("SysMngrUsrInfoDAO_deleteUsrInfo", paramVO);
	}

    /**
	 * ㅁ 시스템 - 사용자 정보 상세조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrUsrInfoVO selectUsrInfoDetail(SysMngrUsrInfoVO paramVO) {
    	
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	
		return (SysMngrUsrInfoVO) selectOne("SysMngrUsrInfoDAO_selectUsrInfoDetail", paramVO);
	}

    /**
     * ㅁ 시스템 - 사용자 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrInfo(SysMngrUsrInfoVO paramVO) {
        return update("SysMngrUsrInfoDAO_modifyUsrInfo",paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 사용자 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteUsrInfo(SysMngrUsrInfoVO paramVO) {
        return update("SysMngrUsrInfoDAO_modifySiteUsrInfo",paramVO);
    }

    /**
     * ㅁ 시스템 - 사용자 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrSttus(SysMngrUsrInfoVO paramVO) throws Exception {
        return update("SysMngrUsrInfoDAO_modifyUsrSttus",paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사용자 그룹 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrInfoGroup(SysMngrUsrInfoVO paramVO) throws Exception {
        return update("SysMngrUsrInfoDAO_modifyUsrInfoGroup",paramVO);
    }

    /**
	 * ㅁ 시스템 - 사용자 인증 정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteUsrCrtfctInfo(SysMngrUsrInfoVO paramVO) {
		return delete("SysMngrUsrInfoDAO_deleteUsrCrtfctInfo", paramVO);
	}

}

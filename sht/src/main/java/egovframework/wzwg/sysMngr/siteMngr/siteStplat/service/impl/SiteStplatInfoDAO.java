package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Repository("SiteStplatInfoDAO")

public class SiteStplatInfoDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/********************************* 2019.02.28 start ****************************************/

	/**
     * @param paramVO
     * ㅁ 시스템 - 사이트 약관정보 시퀀스 조회
     * @return
     * @throws Exception
     */
	public String selectSiteStplatInfoNextSeq() {
		return (String) selectOne("SiteStplatInfoDAO_selectSiteStplatInfoNextSeq", null);
	}

	/**
	 * ㅁ 시스템 - 사이트 약관정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SiteStplatInfoVO> selectSiteStplatInfoList(SiteStplatInfoVO paramVO) throws Exception {
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	return selectList("SiteStplatInfoDAO_selectSiteStplatInfoList", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteStplatInfoListCnt(SiteStplatInfoVO paramVO) throws Exception {
    	return (Integer)selectOne("SiteStplatInfoDAO_selectSiteStplatInfoListCnt", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 약관정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SiteStplatInfoVO selectSiteStplatInfoDetail(SiteStplatInfoVO paramVO) throws Exception {
		String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	paramVO.setLangCode(langcode);
    	return (SiteStplatInfoVO)selectOne("SiteStplatInfoDAO_selectSiteStplatInfoDetail", paramVO);
    }
	
    /**
	 * ㅁ 시스템 - 사이트 약관정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception {
    	return update("SiteStplatInfoDAO_registSiteStplatInfo", paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사이트 약관정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception {
    	return update("SiteStplatInfoDAO_modifySiteStplatInfo", paramVO);
    }
    
    /**
	 * ㅁ 시스템 - 사이트 약관정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteSiteStplatInfo(SiteStplatInfoVO paramVO) {
		return update("SiteStplatInfoDAO_deleteSiteStplatInfo", paramVO);
	}
	
    /**
	 * ㅁ 약관 리스트 조회(사용자)
     * @param paramVO
     * @return
     * @throws Exception
     */	
	public List<SiteStplatInfoVO> selectStplatInfoUsrList(SiteStplatInfoVO searchVO) {
		return selectList("SiteStplatInfoDAO_selectStplatInfoUsrList",searchVO);
	}
	
	
    /**
	 * ㅁ 시스템 - 기본 설정 여부 수정
     * @param paramVO
     * @return
     * @throws Exception
     */	
	public int modifySysStplatInfoDefault(SiteStplatInfoVO paramVO) {
		return update("SiteStplatInfoDAO_modifySysStplatInfoDefault",paramVO);
	}

    /**
	 * ㅁ 시스템 - 전체사이트 적용시 사이트마다 약관 정보 존재여부 확인 
     * @param paramVO
     * @return
     * @throws Exception
     */	
	public String selectSysSiteStplatInfoChk(SiteStplatInfoVO paramVO) {
		return (String) selectOne("SiteStplatInfoDAO_selectSysSiteStplatInfoChk", paramVO);
	}

	
	/********************************* 2019.02.28 end ****************************************/
	
	
	
    public String registSiteStplatInfoInit(SiteStplatInfoVO paramVO) throws Exception {
    	String seq = (String)selectOne("SiteStplatInfoDAO_selectSiteStplatInfoNextSeq", paramVO);
    	paramVO.setStplatSeq(String.valueOf(seq));
    	insert("SiteStplatInfoDAO_registSiteStplatInfoNext", paramVO);
    	return seq;
    }

	public SiteStplatInfoVO selectSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception { 
    	return (SiteStplatInfoVO)selectOne("SiteStplatInfoDAO_selectSiteStplatInfoSign", paramVO);
    }
	
	public SiteStplatInfoVO selectSysSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception { 
    	return (SiteStplatInfoVO)selectOne("SiteStplatInfoDAO_selectSysSiteStplatInfoSign", paramVO);
    }

}

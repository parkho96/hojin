package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnVO;

/**
 * ㅁ 시스템 - 사이트 도메인관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteDomnDAO")
public class SysMngrSiteDomnDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;

    /**
	 * ㅁ 시스템 - 사이트 도메인 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	
	public List<SysMngrSiteDomnVO> selectSiteDomnList(SysMngrSiteDomnVO paramVO) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
    	return selectList("SysMngrSiteDomnDAO_selectSiteDomnList", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 목록 전체수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteDomnListCnt(SysMngrSiteDomnVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrSiteDomnDAO_selectSiteDomnListCnt", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrSiteDomnVO selectSiteDomnDetail(SysMngrSiteDomnVO paramVO) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
    	return (SysMngrSiteDomnVO)selectOne("SysMngrSiteDomnDAO_selectSiteDomnDetail", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception {
    	insert("SysMngrSiteDomnDAO_registSiteDomn", paramVO);
    }

    
    public String selectSiteDomnSeq() throws Exception{
    	return ((String) selectOne("SysMngrSiteDomnDAO_selectSiteDomnSeq")).toString();
    }
    /**
	 * ㅁ 시스템 - 사이트 도메인 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteDomn(SysMngrSiteDomnVO paramVO) throws Exception {

		System.out.println("\n\n\n\n\n\nparamVO3 : "+paramVO.getSiteUrl());
    	update("SysMngrSiteDomnDAO_modifySiteDomn", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception {
    	delete("SysMngrSiteDomnDAO_deleteSiteDomn", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 대표 도메인 수정 
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySiteReprsntDomn(SysMngrSiteDomnVO paramVO) {
		return update("SysMngrSiteDomnDAO_modifySiteReprsntDomn", paramVO);
	}

    /**
	 * ㅁ 시스템 - 사이트 대표 도메인 삭제 
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void deleteSiteReprsntDomn(SysMngrSiteDomnVO paramVO) {
		delete("SysMngrSiteDomnDAO_deleteSiteReprsntDomn", paramVO);
	}

	/**
	 * 
	 * @Method Name : selectSiteDomnDplctChk
	 * @Method 설명 : 시스템 - 사이트 도메인 중복체크
	 *
	 * @param paramVO
	 * @return
	 *
	 * @변경이력 :
	 */
	public int selectSiteDomnDplctChk(SysMngrSiteDomnVO paramVO) {
		return (Integer) selectOne("SysMngrSiteDomnDAO_selectSiteDomnDplctChk", paramVO);
	}
	
    /**
     * ㅁ 시스템 - 사이트도메인 엑셀 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer registSiteDomnExcel(Map<String, String> paramMap) throws Exception {
        return update("SysMngrSiteDomnDAO_registSiteDomnExcel", paramMap);
    }
    
	public void modifySiteDomnDir(SysMngrSiteDomnVO paramVO) throws Exception {
		update("SysMngrSiteDomnDAO_modifySiteDomnDir", paramVO);
	}

	
    /**
	 * 사이트 URL로 domnSeq 조회
	 * @param siteDomnVO
	 * @return
	 */
	public String selectSiteDomnSeqDetail(SysMngrSiteDomnVO siteDomnVO) {
		return (String) selectOne("SysMngrSiteDomnDAO_selectSiteDomnSeqDetail", siteDomnVO);
	}


}

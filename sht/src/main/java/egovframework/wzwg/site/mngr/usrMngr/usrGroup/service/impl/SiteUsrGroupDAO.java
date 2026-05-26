package egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;

@Repository("SiteUsrGroupDAO")
public class SiteUsrGroupDAO extends EgovAbstractMapper {
	
	/**
	 * 사이트 사용자 그룹 총 카운트 조회
	 * @param siteUsrGroupVO
	 * @return
	 */
	public int selectSiteUsrGroupTotCnt(SiteUsrGroupVO siteUsrGroupVO) {
		return (Integer)selectOne("SiteUsrGroupDAO_selectSiteUsrGroupTotCnt", siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 리스트 조회
	 * @param siteUsrGroupVO
	 * @return
	 */
	
	public List<SiteUsrGroupVO> selectSiteUsrGroupList(SiteUsrGroupVO siteUsrGroupVO) {
		return selectList("SiteUsrGroupDAO_selectSiteUsrGroupList", siteUsrGroupVO);
	}
	
	/**
     * 사이트 사용자 그룹 리스트 전체 조회
     * @param siteUsrGroupVO
     * @return
     */
    
    public List<SiteUsrGroupVO> selectSiteUsrGroupAllList(String siteSeq) {
        return selectList("SiteUsrGroupDAO_selectSiteUsrGroupAllList", siteSeq);
    }

	/**
	 * 사이트 사용자 그룹 시퀀스 조회
	 * @return
	 */
	public String selectSiteUsrGroupSeq() {
		return (String) selectOne("SiteUsrGroupDAO_selectSiteUsrGroupSeq", null);
	}

	/**
	 * 사이트 사용자 그룹 등록
	 * @param siteUsrGroupVO
	 * @return
	 */
	public int registSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
		return update("SiteUsrGroupDAO_registSiteUsrGroup", siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 상세조회
	 * @param siteUsrGroupVO
	 * @return
	 */
	public SiteUsrGroupVO selectSiteUsrGroupDetail(SiteUsrGroupVO siteUsrGroupVO) {
		return (SiteUsrGroupVO) selectOne("SiteUsrGroupDAO_selectSiteUsrGroupDetail", siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 수정
	 * @param siteUsrGroupVO
	 * @return
	 */
	public int modifySiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
		return update("SiteUsrGroupDAO_modifySiteUsrGroup", siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 삭제
	 * @param siteUsrGroupVO
	 * @return
	 */
	public int deleteSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
		return update("SiteUsrGroupDAO_deleteSiteUsrGroup", siteUsrGroupVO);
	}

    /**
     * 사이트 사용자 그룹 리스트 조회 - 코드
     * @param siteUsrGroupVO
     * @return
     */
    
    public List<SiteUsrGroupVO> selectSiteUsrGroupCode(String siteSeq) {
        return selectList("SiteUsrGroupDAO_selectSiteUsrGroupCode", siteSeq);
    }
}

package egovframework.wzwg.site.mngr.usrMngr.usrGroup.service;

import java.util.List;

public interface SiteUsrGroupService {
	
	/** 사이트 사용자 그룹 총 카운트 조회*/
	int selectSiteUsrGroupTotCnt(SiteUsrGroupVO siteUsrGroupVO);

	/** 사이트 사용자 그룹 리스트 조회 */
	List<SiteUsrGroupVO> selectSiteUsrGroupList(SiteUsrGroupVO siteUsrGroupVO);
	
	/** 사이트 사용자 그룹 리스트 전체 조회  */
    List<SiteUsrGroupVO> selectSiteUsrGroupAllList(String siteSeq);

	/** 사이트 사용자 그룹 등록 */
	int registSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO);

	/** 사이트 사용자 그룹 상세조회 */
	SiteUsrGroupVO selectSiteUsrGroupDetail(SiteUsrGroupVO siteUsrGroupVO);

	/** 사이트 사용자 그룹 수정 */
	int modifySiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO);

	/** 사이트 사용자 그룹 삭제 */
	int deleteSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO);

    /**
     * 사이트 사용자 그룹 리스트 조회 - 코드
     * @param siteUsrGroupVO
     * @return
     */
    List<SiteUsrGroupVO> selectSiteUsrGroupCode(String siteSeq);

}

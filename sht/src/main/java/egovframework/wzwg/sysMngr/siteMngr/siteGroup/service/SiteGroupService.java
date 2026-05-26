package egovframework.wzwg.sysMngr.siteMngr.siteGroup.service;

import java.util.List;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SiteGroupService {

    /**
	 * ㅁ 시스템 - 사이트 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteGroupVO> selectSiteGroupList(SiteGroupVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 그룹 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteGroupListCnt(SiteGroupVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 그룹 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SiteGroupVO selectSiteGroupDetail(SiteGroupVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteGroup(SiteGroupVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 그룹 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteGroup(SiteGroupVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 2차 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteGroupVO> selectSiteGroupMlsfcList(SiteGroupVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 그룹 셀렉트 박스
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteGroupVO> selectSiteGroupAjax(SiteGroupVO paramVO) throws Exception;
    
}

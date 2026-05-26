package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.util.List;



/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSiteDomnService {

    /**
	 * ㅁ 시스템 - 사이트 도메인 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteDomnVO> selectSiteDomnList(SysMngrSiteDomnVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 도메인 목록 전체수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteDomnListCnt(SysMngrSiteDomnVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 도메인 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteDomnVO selectSiteDomnDetail(SysMngrSiteDomnVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트  도메인 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트  도메인 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 대표 도메인 수정
     * @param paramVO
     * @return
     * @throws Exception 
     */
	public int modifySiteReprsntDomn(SysMngrSiteDomnVO paramVO);

	/**
	 * @Method Name : selectSiteDomnDplctChk
	 * @Method 설명 : 사이트 도메인 중복체크
	 *
	 * @param paramVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int selectSiteDomnDplctChk(SysMngrSiteDomnVO paramVO);

}

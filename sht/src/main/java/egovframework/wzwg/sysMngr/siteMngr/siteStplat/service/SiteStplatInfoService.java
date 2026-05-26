package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.util.List;

/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
public interface SiteStplatInfoService {

	/********************************* 2019.02.28 start ****************************************/
    /**
	 * ㅁ 시스템 - 사이트 약관정보 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteStplatInfoNextSeq() throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteStplatInfoVO> selectSiteStplatInfoList(SiteStplatInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteStplatInfoListCnt(SiteStplatInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SiteStplatInfoVO selectSiteStplatInfoDetail(SiteStplatInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteStplatInfo(SiteStplatInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 약관정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteSiteStplatInfo(SiteStplatInfoVO paramVO);
    
    /**
	 * ㅁ 시스템 - 약관 리스트 조회(사용자)
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteStplatInfoVO> selectStplatInfoUsrList(SiteStplatInfoVO searchVO);
    
    /**
	 * ㅁ 시스템 - 기본 설정 여부 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySysStplatInfoDefault(SiteStplatInfoVO paramVO) throws Exception;
    
    /**
	 * ㅁ 시스템 - 전체 사이트에 약관 적용
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registSysStplatInfoAllSiteApply(SiteStplatInfoVO paramVO) throws Exception;

	/********************************* 2019.02.28 end ****************************************/
    
    public SiteStplatInfoVO selectSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception;
    
    public SiteStplatInfoVO selectSysSiteStplatInfoSign(SiteStplatInfoVO paramVO) throws Exception;
    
    public String registSiteStplatInfoInit(SiteStplatInfoVO paramVO) throws Exception ;



    

}

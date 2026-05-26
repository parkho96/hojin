package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;



/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSiteAdiInfoService {

    /**
	 * ㅁ 시스템 - 사이트 부가정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteAdiInfoVO selectSiteAdiInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception;

    /**
	 * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteAdiInfo(SysMngrSiteAdiInfoVO paramVO) throws Exception;
    
    public SysMngrSiteAdiInfoVO selectSiteFtrInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 부가정보 - 메뉴설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception;
    
    public String selectSiteAdiInfoConnIp(String siteSeq) throws Exception;

}

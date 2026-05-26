package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.util.List;


/**
 * ㅁ 시스템 - 사이트필수약관설정
 * ㅁ DC   
 * - 가입/개인정보처리방침/사이트사용약관 등 필수 적으로 동의를 받아야되는 약관을 설정한다
 * @author HyoJuNiRaNe
 *
 */
public interface SiteEssntlStplatService {

    /**
     * ㅁ 사이트 - 사이트필수약관 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatInfoList(SiteEssntlStplatVO paramVO) throws Exception;

    
    public int applyEssntlStplat(SiteEssntlStplatVO paramVO)  throws Exception;
    /**
     * ㅁ 시스템 - 사이트약관목록 코드화 조회 
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatCode(SiteEssntlStplatVO paramVO) throws Exception;

    /**
     * ㅁ 시스템 - 사이트 필수약관 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registEssntlStplat(SiteEssntlStplatVO paramVO) throws Exception;
    
    public  SiteEssntlStplatVO  selectSiteEssntlStplatSign(SiteEssntlStplatVO paramVO) throws Exception ;

}

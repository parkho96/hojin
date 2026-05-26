package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.util.List;

public interface SiteStplatSimpService {

	/***************** 2018.02.28 start *******************/
	/** 세부약관 리스트 조회 */
    public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception;

    /** 세부약관 등록 */
    public Integer registSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;
 
    /** 세부약관 상세조회 */
    public SiteStplatInfoVO selectSiteStplatSimpDetail(SiteStplatInfoVO paramVO) throws Exception;

    /** 세부약관 수정 */
    public Integer modifySiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;

    /** 세부약관 삭제 */
    public Integer deleteSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;
    
    /**  전체사이트 적용시 사이트마다 세부약관 존재여부 확인 */
    public String selectSysSiteStplatSimpChk(SiteStplatInfoVO paramVO) throws Exception;
    
    
    /***************** 2018.02.28 end *******************/
    
    public Integer selectSiteStplatSimpListCnt(SiteStplatInfoVO paramVO) throws Exception;
    
    public SiteStplatInfoVO selectSysSiteStplatSimpDetail() throws Exception;
    
    public Integer deleteSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;

    public SiteStplatInfoVO selectStplatSimpBySeq(SiteStplatInfoVO paramVO) throws Exception;

    public SiteStplatInfoVO selectStplatSimpByJoin(SiteStplatInfoVO paramVO) throws Exception;
    
    public Integer defaultAllNonSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;
    
    public Integer defaultSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception;

}

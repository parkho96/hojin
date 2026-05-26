package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.util.List;


public interface SiteStplatLogService {
	
	/************************* 2019.03.05  start **********************************/
	
    public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception;
    
	/************************* 2019.03.05  end **********************************/

    public Integer selectSiteStplatLogListCnt(SiteStplatLogVO paramVO) throws Exception;
    
    public List<SiteStplatLogVO> selectSiteStplatLogList(SiteStplatLogVO paramVO) throws Exception;

    public List<SiteStplatLogVO> selectSiteStplatLog(SiteStplatLogVO paramVO) throws Exception;
    
    public SiteStplatLogVO selectSiteStplatSimpDetail(SiteStplatLogVO paramVO) throws Exception;

    public int deleteSiteStplatLog(SiteStplatLogVO paramVO) throws Exception;
    

}

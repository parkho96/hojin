package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogVO;

@Repository("SiteStplatLogDAO")

public class SiteStplatLogDAO extends EgovAbstractMapper {

    /************************* 2019.03.05  start **********************************/
	public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception {

        return selectList("SiteStplatLogDAO_selectSiteStplatSimpList", paramVO);
    }
    /************************* 2019.03.05  end **********************************/

	
    public Integer selectSiteEssntlStplatCheck(SiteEssntlStplatVO paramVO) throws Exception {
        return (Integer)selectOne("SiteStplatLogDAO_selectSiteEssntlStplatCheck", paramVO);
    }

    public String selectSiteStplatLogSeq(SiteEssntlStplatVO paramVO) throws Exception {
        return (String)selectOne("SiteStplatLogDAO_selectSiteStplatLogSeq", paramVO);
    }
    
    public void registStplatLog(SiteEssntlStplatVO paramVO) throws Exception {
        insert("SiteStplatLogDAO_registStplatLog", paramVO);
    }
    
    public void registStplatdetailLog(SiteEssntlStplatVO paramVO) throws Exception {
        insert("SiteStplatLogDAO_registStplatdetailLog", paramVO);
    }

    public Integer selectSiteStplatLogListCnt(SiteStplatLogVO paramVO) throws Exception {

        return (Integer)selectOne("SiteStplatLogDAO_selectSiteStplatLogListCnt", paramVO);
    }
    
    
    public List<SiteStplatLogVO> selectSiteStplatLogList(SiteStplatLogVO paramVO) throws Exception {

        return selectList("SiteStplatLogDAO_selectSiteStplatLogList", paramVO);
    }

    
    public List<SiteStplatLogVO> selectSiteStplatLog(SiteStplatLogVO paramVO) throws Exception {

        return selectList("SiteStplatLogDAO_selectSiteStplatLog", paramVO);
    }
    
    public SiteStplatLogVO selectSiteStplatSimpDetail(SiteStplatLogVO paramVO) throws Exception {
        return (SiteStplatLogVO)selectOne("SiteStplatLogDAO_selectSiteStplatSimpDetail", paramVO);
    }
    
    public int deleteSiteStplatLog(SiteStplatLogVO paramVO) throws Exception {
        return update("SiteStplatLogDAO_deleteSiteStplatLog", paramVO);
    }
    
}

package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogVO;


/**
 * ㅁ 시스템 - 사이트약관정보매핑관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보매핑을 관리
 * - 전체 시스템에서 사용할 약관정보매핑 관리
 * @author HyoJuNiRaNe
 *
 */
@Service("SiteStplatLogService")
public class SiteStplatLogServiceImpl extends EgovAbstractServiceImpl implements SiteStplatLogService {

    @Resource(name="SiteStplatLogDAO")
    private SiteStplatLogDAO siteStplatLogDAO;

    /************************* 2019.03.05  start **********************************/

    public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception {

        return siteStplatLogDAO.selectSiteStplatSimpList(paramVO);
    }
    
    /************************* 2019.03.05  end **********************************/
    
    
    public Integer selectSiteStplatLogListCnt(SiteStplatLogVO paramVO) throws Exception {

        return siteStplatLogDAO.selectSiteStplatLogListCnt(paramVO);
    }
    
    public List<SiteStplatLogVO> selectSiteStplatLogList(SiteStplatLogVO paramVO) throws Exception {
        
        return siteStplatLogDAO.selectSiteStplatLogList(paramVO);
    }

    public List<SiteStplatLogVO> selectSiteStplatLog(SiteStplatLogVO paramVO) throws Exception {

        return siteStplatLogDAO.selectSiteStplatLog(paramVO);
    }

    public SiteStplatLogVO selectSiteStplatSimpDetail(SiteStplatLogVO paramVO) throws Exception {

        return siteStplatLogDAO.selectSiteStplatSimpDetail(paramVO);
    }

    public int deleteSiteStplatLog(SiteStplatLogVO paramVO) throws Exception {

        int retVal = 0;

        String[] seqArr = paramVO.getStplatlogSeqArr();
        
        if (seqArr != null && seqArr.length > 0) {
            
            for (int i=0; i<seqArr.length; i++) {
                paramVO.setStplatlogSeq(seqArr[i]);
                retVal = siteStplatLogDAO.deleteSiteStplatLog(paramVO);
            }
        }
        
        return retVal;
    }
    
}

package egovframework.wzwg.site.mngr.inqryDtls.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsService;
import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsVO;

@Service("SiteInqryDtlsService")
public class SiteInqryDtlsServiceImpl extends EgovAbstractServiceImpl implements SiteInqryDtlsService {
    
	@Resource(name="SiteInqryDtlsDAO")
	private SiteInqryDtlsDAO siteInqryDtlsDAO;
	
	public int selectSiteInqryDtlsListCnt(SiteInqryDtlsVO siteInqryDtlsVO) {
		return siteInqryDtlsDAO.selectSiteInqryDtlsListCnt(siteInqryDtlsVO);
	}

	public List<SiteInqryDtlsVO> selectSiteInqryDtlsList(SiteInqryDtlsVO siteInqryDtlsVO) {
		return siteInqryDtlsDAO.selectSiteInqryDtlsList(siteInqryDtlsVO);
	}


	public SiteInqryDtlsVO selectSiteInqryDtlsDetail(SiteInqryDtlsVO siteInqryDtlsVO) {
		return siteInqryDtlsDAO.selectSiteInqryDtlsDetail(siteInqryDtlsVO);
	}

    public void registSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO) {
        siteInqryDtlsDAO.registSiteInqryDtls(siteInqryDtlsVO);
    }

	public int deleteSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO) {
		return siteInqryDtlsDAO.deleteSiteInqryDtls(siteInqryDtlsVO);
	}

}

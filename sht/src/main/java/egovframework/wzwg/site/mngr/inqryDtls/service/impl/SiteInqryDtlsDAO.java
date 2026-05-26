package egovframework.wzwg.site.mngr.inqryDtls.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsVO;

@Repository("SiteInqryDtlsDAO")
public class SiteInqryDtlsDAO extends EgovAbstractMapper {
	
	public int selectSiteInqryDtlsListCnt(SiteInqryDtlsVO siteInqryDtlsVO) {
		return (Integer)selectOne("SiteInqryDtlsDAO_selectSiteInqryDtlsListCnt", siteInqryDtlsVO);
	}

	
	public List<SiteInqryDtlsVO> selectSiteInqryDtlsList(SiteInqryDtlsVO siteInqryDtlsVO) {
		return selectList("SiteInqryDtlsDAO_selectSiteInqryDtlsList", siteInqryDtlsVO);
	}

	public SiteInqryDtlsVO selectSiteInqryDtlsDetail(SiteInqryDtlsVO siteInqryDtlsVO) {
		return (SiteInqryDtlsVO) selectOne("SiteInqryDtlsDAO_selectSiteInqryDtlsDetail", siteInqryDtlsVO);
	}

    public void registSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO) {
        insert("SiteInqryDtlsDAO_registSiteInqryDtls", siteInqryDtlsVO);
    }

	public int deleteSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO) {
		return update("SiteInqryDtlsDAO_deleteSiteInqryDtls", siteInqryDtlsVO);
	}
	
}

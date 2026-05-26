package egovframework.wzwg.site.mngr.inqryDtls.service;

import java.util.List;

public interface SiteInqryDtlsService {
	
	int selectSiteInqryDtlsListCnt(SiteInqryDtlsVO siteInqryDtlsVO);

	List<SiteInqryDtlsVO> selectSiteInqryDtlsList(SiteInqryDtlsVO siteInqryDtlsVO);

	SiteInqryDtlsVO selectSiteInqryDtlsDetail(SiteInqryDtlsVO siteInqryDtlsVO);

    void registSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO);

	int deleteSiteInqryDtls(SiteInqryDtlsVO siteInqryDtlsVO);

}

package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.screen.service.SiteTemplateLayoutVO;

@Repository("SiteTemplateLayoutDAO")
public class SiteTemplateLayoutDAO extends EgovAbstractMapper {

	/**
	 * 템플릿 세부 레이아웃 목록
	 * @return
	 */
	
	public List<SiteTemplateLayoutVO> selectSiteTemplateLayoutList(SiteTemplateLayoutVO paramVO) {
		return selectList("siteTemplateLayoutDAO_selectSiteTemplateLayoutList", paramVO);
	}
	 
	
	public void registSiteTemplateLayout(SiteTemplateLayoutVO paramVO) {
		  insert("siteTemplateLayoutDAO_registSiteTemplateLayout", paramVO);
	}
	
	public void deleteSiteTemplateLayout(SiteTemplateLayoutVO paramVO) {
		  insert("siteTemplateLayoutDAO_deleteSiteTemplateLayout", paramVO);
	}
}

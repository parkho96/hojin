package egovframework.wzwg.site.mngr.screen.service;

import java.util.List;

public interface SiteTemplateLayoutService {
	public List<SiteTemplateLayoutVO> selectSiteTemplateLayoutList(SiteTemplateLayoutVO paramVO) throws Exception ;
	public void registSiteTemplateLayout(SiteTemplateLayoutVO paramVO) throws Exception ;
	public void deleteSiteTemplateLayout(SiteTemplateLayoutVO paramVO) throws Exception ;
	
}

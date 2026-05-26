package egovframework.wzwg.site.mngr.screen.service;

import java.util.List;

public interface SiteLayoutService {
	public List<SiteLayoutVO> selectSiteLayoutList(SiteLayoutVO paramVO) throws Exception ;
	public SiteLayoutVO selectSiteLayout(SiteLayoutVO paramVO) throws Exception ;
	public void modifySiteLayout(SiteLayoutVO paramVO) throws Exception ;
	public void registSiteLayout(SiteLayoutVO paramVO) throws Exception ;
	public void deleteSiteLayout(SiteLayoutVO paramVO) throws Exception ;
	
	/* 메인위젯 */
	public List<SiteLayoutVO> selectLayoutContentsList(SiteLayoutVO paramVO) throws Exception ;
	
	/* 컨텐츠 위젯 */
	public List<SiteLayoutVO> selectContentsWidgetList(SiteLayoutVO paramVO) throws Exception ;
}

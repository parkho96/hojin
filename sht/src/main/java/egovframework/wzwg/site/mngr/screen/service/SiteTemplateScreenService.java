package egovframework.wzwg.site.mngr.screen.service;

import java.util.List;

public interface SiteTemplateScreenService {
	public List<SiteTemplateScreenVO> selectSiteTemplateScreenList(SiteTemplateScreenVO paramVO) throws Exception ;
	
	public SiteTemplateScreenVO selectSiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;
	
	public int selectSiteTemplateScreenChk(SiteTemplateScreenVO paramVO) throws Exception ;
	
	public List<SiteTemplateScreenVO> selectSiteTemplateLayoutScreenList(SiteTemplateScreenVO paramVO) throws Exception ;
	
	
	public void registSiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;

	public void modifySiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;
	
	public List<SiteTemplateScreenVO> selectTemplateScreenList(SiteTemplateScreenVO paramVO) throws Exception ;
	
	
	public void registTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;

	public void modifyTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;
	
	public void deleteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception ;
}

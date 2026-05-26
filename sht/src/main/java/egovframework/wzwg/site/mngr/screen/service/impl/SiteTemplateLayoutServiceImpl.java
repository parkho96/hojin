package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.screen.service.SiteTemplateLayoutService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateLayoutVO;

@Service("SiteTemplateLayoutService")
public class SiteTemplateLayoutServiceImpl extends EgovAbstractServiceImpl implements SiteTemplateLayoutService {
     
    @Resource(name="SiteTemplateLayoutDAO")
    private SiteTemplateLayoutDAO siteTemplateLayoutDAO;
 
 
	public List<SiteTemplateLayoutVO> selectSiteTemplateLayoutList(SiteTemplateLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		return siteTemplateLayoutDAO.selectSiteTemplateLayoutList(paramVO);
	}
	 
	public void registSiteTemplateLayout(SiteTemplateLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		  siteTemplateLayoutDAO.registSiteTemplateLayout(paramVO);
	}
	 
	
	public void deleteSiteTemplateLayout(SiteTemplateLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		  siteTemplateLayoutDAO.deleteSiteTemplateLayout(paramVO);
	}
	 
    
}

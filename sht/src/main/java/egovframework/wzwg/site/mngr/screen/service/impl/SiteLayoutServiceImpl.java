package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.screen.service.SiteLayoutService;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;

@Service("SiteLayoutService")
public class SiteLayoutServiceImpl extends EgovAbstractServiceImpl implements SiteLayoutService {
     
    @Resource(name="SiteLayoutDAO")
    private SiteLayoutDAO siteLayoutDAO;
 
 
	public List<SiteLayoutVO> selectSiteLayoutList(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		return siteLayoutDAO.selectSiteLayoutList(paramVO);
	}
	 
	public void registSiteLayout(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		  siteLayoutDAO.registSiteLayout(paramVO);
	}
	 
	
	public void deleteSiteLayout(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		  siteLayoutDAO.deleteSiteLayout(paramVO);
	}

	@Override
	public SiteLayoutVO selectSiteLayout(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		return siteLayoutDAO.selectSiteLayout(paramVO);
	}

	@Override
	public void modifySiteLayout(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		siteLayoutDAO.modifySiteLayout(paramVO);
	}

	@Override
	public List<SiteLayoutVO> selectLayoutContentsList(SiteLayoutVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		return siteLayoutDAO.selectLayoutContentsList(paramVO);
	}

	@Override
	public List<SiteLayoutVO> selectContentsWidgetList(SiteLayoutVO paramVO)
			throws Exception {
		// TODO Auto-generated method stub
		return siteLayoutDAO.selectContentsWidgetList(paramVO);
	}
	 
    
}

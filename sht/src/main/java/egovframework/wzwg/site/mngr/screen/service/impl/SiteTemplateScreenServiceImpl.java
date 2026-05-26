package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;

@Service("SiteTemplateScreenService")
public class SiteTemplateScreenServiceImpl extends EgovAbstractServiceImpl implements SiteTemplateScreenService {
     
    @Resource(name="SiteTemplateScreenDAO")
    private SiteTemplateScreenDAO siteTemplateScreenDAO;
 
 
	public List<SiteTemplateScreenVO> selectSiteTemplateScreenList(SiteTemplateScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		return siteTemplateScreenDAO.selectSiteTemplateScreenList(paramVO);
	}
	
	public SiteTemplateScreenVO selectSiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		return siteTemplateScreenDAO.selectSiteTemplateScreen(paramVO);
	}
	public int selectSiteTemplateScreenChk(SiteTemplateScreenVO paramVO) {
		return siteTemplateScreenDAO.selectSiteTemplateScreenChk(paramVO);
	}
	
	public void registSiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		siteTemplateScreenDAO.registSiteTemplateScreen(paramVO);
	}
 	
	public void modifySiteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		siteTemplateScreenDAO.modifySiteTemplateScreen(paramVO);
	}
	
	
	public List<SiteTemplateScreenVO> selectTemplateScreenList(SiteTemplateScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		 
		return siteTemplateScreenDAO.selectTemplateScreenList(paramVO);
	}
	
	public void registTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		siteTemplateScreenDAO.registTemplateScreen(paramVO);
	}

	public void modifyTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		siteTemplateScreenDAO.modifyTemplateScreen(paramVO);
	}
	
	public void deleteTemplateScreen(SiteTemplateScreenVO paramVO) throws Exception {
		siteTemplateScreenDAO.deleteTemplateScreen(paramVO);
	}

	@Override
	public List<SiteTemplateScreenVO> selectSiteTemplateLayoutScreenList(
			SiteTemplateScreenVO paramVO) throws Exception {
		// TODO Auto-generated method stub
		return siteTemplateScreenDAO.selectSiteTemplateLayoutScreenList(paramVO);
	}
	  
    
}

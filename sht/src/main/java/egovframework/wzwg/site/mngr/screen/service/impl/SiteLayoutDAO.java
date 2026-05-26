package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;

@Repository("SiteLayoutDAO")
public class SiteLayoutDAO extends EgovAbstractMapper {

	/**
	 * 템플릿 세부 레이아웃 목록
	 * @return
	 */
	
	public List<SiteLayoutVO> selectSiteLayoutList(SiteLayoutVO paramVO) {
		return selectList("siteLayoutDAO_selectSiteLayoutList", paramVO);
	}
	 
	public SiteLayoutVO selectSiteLayout(SiteLayoutVO paramVO) {
		return (SiteLayoutVO)selectOne("siteLayoutDAO_selectSiteLayout", paramVO);
	}
	
	public void registSiteLayout(SiteLayoutVO paramVO) {
		  insert("siteLayoutDAO_registSiteLayout", paramVO);
	}
	
	public void modifySiteLayout(SiteLayoutVO paramVO) {
		  update("siteLayoutDAO_modifySiteLayout", paramVO);
	}
	
	public void deleteSiteLayout(SiteLayoutVO paramVO) {
		update("siteLayoutDAO_deleteSiteLayout", paramVO);
	}
	
	
	public List<SiteLayoutVO> selectLayoutContentsList(SiteLayoutVO paramVO) {
		return selectList("siteLayoutDAO_selectLayoutContentsList", paramVO);
	}
	
	
	public List<SiteLayoutVO> selectContentsWidgetList(SiteLayoutVO paramVO) {
		return selectList("siteLayoutDAO_selectContentsWidgetList", paramVO);
	}
}

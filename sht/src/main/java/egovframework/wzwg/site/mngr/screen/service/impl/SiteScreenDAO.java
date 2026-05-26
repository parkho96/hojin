package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenVO;

@Repository("SiteScreenDAO")
public class SiteScreenDAO extends EgovAbstractMapper {

	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteMenuVO> selectSiteMenuList(SiteMenuVO paramVO) {
		return selectList("siteMenuDAO_selectSiteMenuList", paramVO);
	}
 
	public void registTemplateBackupInfo(SiteScreenVO paramVO)
			throws Exception{
		insert("SiteScreenDAO_registTemplateBackupInfo",paramVO);
	}
	
	public List<SiteScreenVO> selectTemplateBackupInfoList(SiteScreenVO paramVO) {
		return selectList("SiteScreenDAO_selectTemplateBackupInfoList", paramVO);
	}
	
	public SiteScreenVO selectTemplateBackupInfo(SiteScreenVO paramVO) {
		return (SiteScreenVO)selectOne("SiteScreenDAO_selectTemplateBackupInfo", paramVO);
	}
 
	public List<SiteMenuVO> selectModuleMenuList(SiteMenuVO siteMenuVO) {
		return selectList("siteMenuDAO_selectModuleMenuList", siteMenuVO);
	}
	
	public List<SiteScreenVO> selectTabMenuModuleList(SiteScreenVO siteScreenVO){
		return selectList("SiteScreenDAO_selectTabMenuModuleList", siteScreenVO);
	}
	
}

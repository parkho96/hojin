package egovframework.wzwg.site.mngr.screen.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;

@Repository("SiteTemplateScreenDAO")
public class SiteTemplateScreenDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteTemplateScreenVO> selectSiteTemplateScreenList(SiteTemplateScreenVO paramVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("siteTemplateScreenDAO_selectSiteTemplateScreenList", paramVO);
	}
	
	public SiteTemplateScreenVO selectSiteTemplateScreen(SiteTemplateScreenVO paramVO) {
		return (SiteTemplateScreenVO)selectOne("siteTemplateScreenDAO_selectSiteTemplateScreen", paramVO);
	}
	
	public int selectSiteTemplateScreenChk(SiteTemplateScreenVO paramVO) {
		return ((Integer)selectOne("siteTemplateScreenDAO_selectSiteTemplateScreenChk", paramVO)).intValue();
	}
	
	
	
	public void registSiteTemplateScreen(SiteTemplateScreenVO paramVO){
		insert("siteTemplateScreenDAO_registSiteTemplateScreen", paramVO);
	}
	
	public void modifySiteTemplateScreen(SiteTemplateScreenVO paramVO){
		update("siteTemplateScreenDAO_modifySiteTemplateScreen", paramVO);
	}
	
	
	
	public List<SiteTemplateScreenVO> selectTemplateScreenList(SiteTemplateScreenVO paramVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("siteTemplateScreenDAO_selectTemplateScreenList", paramVO);
	}
	
	public void registTemplateScreen(SiteTemplateScreenVO paramVO){
		insert("siteTemplateScreenDAO_registTemplateScreen", paramVO);
	}
	
	public void modifyTemplateScreen(SiteTemplateScreenVO paramVO){
		update("siteTemplateScreenDAO_modifyTemplateScreen", paramVO);
	}
	
	public void deleteTemplateScreen(SiteTemplateScreenVO paramVO){
		update("siteTemplateScreenDAO_deleteTemplateScreen", paramVO);
	}
	
	public List<SiteTemplateScreenVO> selectSiteTemplateLayoutScreenList(SiteTemplateScreenVO paramVO) {

		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("siteTemplateScreenDAO_selectSiteTemplateLayoutScreenList", paramVO);
	}
}

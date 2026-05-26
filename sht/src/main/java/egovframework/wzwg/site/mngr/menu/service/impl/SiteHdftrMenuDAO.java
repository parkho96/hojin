package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository("SiteHdftrMenuDAO")
public class SiteHdftrMenuDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteHdftrMenuVO> selectSiteHdftrMenuList(SiteHdftrMenuVO paramVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("siteHdftrMenuDAO_selectSiteHdftrMenuList", paramVO);
	}
	 
	
	public SiteHdftrMenuVO selectSiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		return (SiteHdftrMenuVO)selectOne("siteHdftrMenuDAO_selectSiteHdftrMenu", paramVO);
	}

	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public int registSiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		int result =0;
		try{
		 insert("siteHdftrMenuDAO_registSiteHdftrMenu", paramVO);
		 result = 1;
		}catch(NullPointerException e){
			result = 0;
			log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		result = 0;
	   	 	log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		result = 0;
	   	 	log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		result = 0;
	   	 	log.error("ArrayIndexOutOfBoundsException",e);
	   	}
		return result;
	}
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public int modifySiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		return update("siteHdftrMenuDAO_modifySiteHdftrMenu", paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public void deleteSiteHdftrMenuMngr(SiteHdftrMenuVO paramVO) {
		update("siteHdftrMenuDAO_deleteSiteHdftrMenuMngr", paramVO);
	}
	
	/**
	 * 사이트 메뉴 정렬
	 * @return
	 */
	public SiteHdftrMenuVO selectSiteHdftrMenuOrdrUp(SiteHdftrMenuVO paramVO) {
		return (SiteHdftrMenuVO) selectOne("siteHdftrMenuDAO_selectSiteHdftrMenuOrdrUp", paramVO);
	}
	
	/**
	 * 사이트 메뉴 정렬
	 * @return
	 */
	public SiteHdftrMenuVO selectSiteHdftrMenuOrdrDown(SiteHdftrMenuVO paramVO) {
		return (SiteHdftrMenuVO) selectOne("siteHdftrMenuDAO_selectSiteHdftrMenuOrdrDown", paramVO);
	}
	
	/**
	 * 사이트 메뉴 정렬 수정
	 * @return
	 */
	public int modifySiteHdftrMenuOrdr(SiteHdftrMenuVO paramVO) {
		return update("siteHdftrMenuDAO_modifySiteHdftrMenuOrdr", paramVO);
	}
 
	/**
	 * 사이트 메뉴 정렬 수정
	 * @return
	 */
	public int modifySiteHdftrMenuOrdrNew(SiteHdftrMenuVO paramVO) {
		return update("siteHdftrMenuDAO_modifySiteHdftrMenuOrdrNew", paramVO);
	}
  

	/**
	 * 번역 여부 중복체크
	 * @param paramVO
	 * @return
	 */
	public int selectSiteHdftrMenuTrnslatChk(SiteHdftrMenuVO paramVO) {
		return (int) selectOne("siteHdftrMenuDAO_selectSiteHdftrMenuTrnslatChk", paramVO);
	}
  
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteHdftrMenuVO> selectSiteftrImgList(SiteHdftrMenuVO paramVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("siteHdftrMenuDAO_selectSiteftrImgList", paramVO);
	}
	
}

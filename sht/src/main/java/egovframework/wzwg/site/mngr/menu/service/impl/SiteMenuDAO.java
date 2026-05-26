package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;

@Repository("SiteMenuDAO")
public class SiteMenuDAO extends EgovAbstractMapper {

	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteMenuVO> selectSiteMenuList(SiteMenuVO paramVO) {
		return selectList("siteMenuDAO_selectSiteMenuList", paramVO);
	}
	
	public List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO paramVO) {
		return selectList("siteMenuDAO_selectSiteMenuCntntList", paramVO);
	}
    
    public String seletSiteMenuSeq() {
        return (String)selectOne("siteMenuDAO_seletSiteMenuSeq");
    }
	
	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public void registSiteMenu(SiteMenuVO paramVO) {
		insert("siteMenuDAO_registSiteMenu", paramVO);
	}
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public void modifySiteMenu(SiteMenuVO paramVO) {
		update("siteMenuDAO_modifySiteMenu", paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public int deleteSiteMenuMngr(SiteMenuVO paramVO) {
		return update("siteMenuDAO_deleteSiteMenuMngr", paramVO);
	}

	/**
	 * 사이트 메뉴 정렬 수정
	 * @return
	 */
	public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO) {
		update("siteMenuDAO_modifySiteMenuMngrOrdr", paramVO);
	}

	public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO) {
		update("siteMenuDAO_modifySiteMenuPlusOrdr", paramVO);
	}
	
    /**
     * 사이트 메뉴 경로 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteMenuPathList(SiteMenuVO paramVO) {
        return selectList("siteMenuDAO_selectSiteMenuPathList", paramVO);
    }

    /**
     * 최상위 메뉴SEQ
     * @return
     */
    public String selectTopMenuSeq(SiteMenuVO paramVO) {
        return (String)selectOne("siteMenuDAO_selectTopMenuSeq", paramVO);
    }

    /**
     * 사이트 서브 메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteSubMenuList(SiteMenuVO paramVO) {
        return selectList("siteMenuDAO_selectSiteSubMenuList", paramVO);
    }
    
    public String selectTopLogo(SiteMenuVO paramVO) {
        return (String)selectOne("siteMenuDAO_selectTopLogo", paramVO);
    }
    
    public String selectFooterLogo(SiteMenuVO paramVO) {
        return (String)selectOne("siteMenuDAO_selectFooterLogo", paramVO);
    }


    /**
     * 1차 메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteFirstMenuList(SiteMenuVO paramVO) {
        return selectList("siteMenuDAO_selectSiteFirstMenuList", paramVO);
    }
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO) {
        return (SiteMenuVO)selectOne("siteMenuDAO_selectSiteMenu", paramVO);
    }
    
    
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO) {
        return (Integer)selectOne("siteMenuDAO_selectMaxMenuOrdr", paramVO);
    }
    
    public int selectSubMenuCnt(SiteMenuVO paramVO) {
        return ((Integer)selectOne("siteMenuDAO_selectSubMenuCnt", paramVO)).intValue();
    }
    
    /**
     * 사이트 메뉴 전체 삭제
     * @return
     */
    public void deleteSiteMenuAll(SiteMenuVO paramVO) {
        update("siteMenuDAO_deleteSiteMenuAll", paramVO);
    }
    
    /**
     * 현재메뉴 포함 하위메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteMenuLow(SiteMenuVO paramVO) {
        return selectList("siteMenuDAO_selectSiteMenuLow", paramVO);
    }
    
}

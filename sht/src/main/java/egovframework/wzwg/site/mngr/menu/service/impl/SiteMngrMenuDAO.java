package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;

@Repository("siteMngrMenuDAO")
public class SiteMngrMenuDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteMngrMenuVO> selectSiteMenuList(SiteMngrMenuVO paramVO) {
		return selectList("siteMngrMenuDAO_selectSiteMenuList", paramVO);
	}
	
	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public List<SiteMngrMenuVO> selectSiteMenuLeftList(SiteMngrMenuVO paramVO) {
		String langcode ="";
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		paramVO.setLangCode(langcode);
			 
		return selectList("siteMngrMenuDAO_selectSiteMenuLeftList", paramVO);
	}
	
	public List<SiteMngrMenuVO> selectSiteMenuCntntList(SiteMngrMenuVO paramVO) {
		return selectList("siteMngrMenuDAO_selectSiteMenuCntntList", paramVO);
	}
    
    public String seletSiteMenuSeq() {
        return (String)selectOne("siteMngrMenuDAO_seletSiteMenuSeq");
    }
	
	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public void registSiteMenu(SiteMngrMenuVO paramVO) {
		insert("siteMngrMenuDAO_registSiteMenu", paramVO);
	}
	
	public void registSiteMenuAuth(SiteMngrMenuVO paramVO) {
		insert("siteMngrMenuDAO_registSiteMenuAuth", paramVO);
	}

	public void deleteSiteMenuAuth(SiteMngrMenuVO paramVO) {
		insert("siteMngrMenuDAO_deleteSiteMenuAuth", paramVO);
	}
	
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public void modifySiteMenu(SiteMngrMenuVO paramVO) {
		update("siteMngrMenuDAO_modifySiteMenu", paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public int deleteSiteMenuMngr(SiteMngrMenuVO paramVO) {
		return update("siteMngrMenuDAO_deleteSiteMenuMngr", paramVO);
	}

	/**
	 * 사이트 메뉴 정렬 수정
	 * @return
	 */
	public void modifySiteMenuMngrOrdr(SiteMngrMenuVO paramVO) {
		update("siteMngrMenuDAO_modifySiteMenuMngrOrdr", paramVO);
	}

	public void modifySiteMenuPlusOrdr(SiteMngrMenuVO paramVO) {
		update("siteMngrMenuDAO_modifySiteMenuPlusOrdr", paramVO);
	}
	
    /**
     * 사이트 메뉴 경로 목록
     * @return
     */
    
    public List<SiteMngrMenuVO> selectSiteMenuPathList(SiteMngrMenuVO paramVO) {
        return selectList("siteMngrMenuDAO_selectSiteMenuPathList", paramVO);
    }

    /**
     * 최상위 메뉴SEQ
     * @return
     */
    public String selectTopMenuSeq(SiteMngrMenuVO paramVO) {
        return (String)selectOne("siteMngrMenuDAO_selectTopMenuSeq", paramVO);
    }

    /**
     * 사이트 서브 메뉴 목록
     * @return
     */
    
    public List<SiteMngrMenuVO> selectSiteSubMenuList(SiteMngrMenuVO paramVO) {
        return selectList("siteMngrMenuDAO_selectSiteSubMenuList", paramVO);
    }
    
    public String selectTopLogo(SiteMngrMenuVO paramVO) {
        return (String)selectOne("siteMngrMenuDAO_selectTopLogo", paramVO);
    }
    
    public String selectFooterLogo(SiteMngrMenuVO paramVO) {
        return (String)selectOne("siteMngrMenuDAO_selectFooterLogo", paramVO);
    }


    /**
     * 1차 메뉴 목록
     * @return
     */
    
    public List<SiteMngrMenuVO> selectSiteFirstMenuList(SiteMngrMenuVO paramVO) {
        return selectList("siteMngrMenuDAO_selectSiteFirstMenuList", paramVO);
    }
    
    public SiteMngrMenuVO selectSiteMenu(SiteMngrMenuVO paramVO) {
        return (SiteMngrMenuVO)selectOne("siteMngrMenuDAO_selectSiteMenu", paramVO);
    }
    
    
    public Integer selectMaxMenuOrdr(SiteMngrMenuVO paramVO) {
        return (Integer)selectOne("siteMngrMenuDAO_selectMaxMenuOrdr", paramVO);
    }
    
    public int selectSubMenuCnt(SiteMngrMenuVO paramVO) {
        return ((Integer)selectOne("siteMngrMenuDAO_selectSubMenuCnt", paramVO)).intValue();
    }
    
    /**
     * 사이트 메뉴 전체 삭제
     * @return
     */
    public void deleteSiteMenuAll(SiteMngrMenuVO paramVO) {
        update("siteMngrMenuDAO_deleteSiteMenuAll", paramVO);
    }
    
    /**
     * 현재메뉴 포함 하위메뉴 목록
     * @return
     */
    
    public List<SiteMngrMenuVO> selectSiteMenuLow(SiteMngrMenuVO paramVO) {
        return selectList("siteMngrMenuDAO_selectSiteMenuLow", paramVO);
    }
    
	public List<SiteMngrMenuVO> selectMngrMenuAuthList(SiteMngrMenuVO paramVO) {
		return selectList("siteMngrMenuDAO_selectMngrMenuAuthList", paramVO);
	}
	
	public SiteMngrMenuVO selectSiteMngrMenuNm(SiteMngrMenuVO paramVO) {
		String langcode ="";
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		paramVO.setLangCode(langcode);

		return (SiteMngrMenuVO)selectOne("siteMngrMenuDAO_selectSiteMngrMenuNm", paramVO);
	}
	
	public SiteMngrMenuVO selectSiteMngrMenuCntntsNm(SiteMngrMenuVO paramVO) {
		String langcode ="";
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		paramVO.setLangCode(langcode);

		return (SiteMngrMenuVO)selectOne("siteMngrMenuDAO_selectSiteMngrMenuCntntsNm", paramVO);
	}
	
	public SiteMngrMenuVO selectSiteMngrMenuUrlByAuthSeq(SiteMngrMenuVO paramVO) { 
		
		return (SiteMngrMenuVO)selectOne("siteMngrMenuDAO_selectSiteMngrMenuUrlByAuthSeq", paramVO);
	}
	
	public SiteMngrMenuVO selectSiteMngrUsrSeqByAuthSeq(SiteMngrMenuVO paramVO) { 
		
		return (SiteMngrMenuVO)selectOne("siteMngrMenuDAO_selectSiteMngrUsrSeqByAuthSeq", paramVO);
	}
	
	
    
}

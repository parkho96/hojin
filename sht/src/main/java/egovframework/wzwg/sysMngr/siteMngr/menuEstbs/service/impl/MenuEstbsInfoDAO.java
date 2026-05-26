package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;

/**
 * ㅁ 시스템 - 사이트 부가정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("MenuEstbsInfoDAO")
public class MenuEstbsInfoDAO extends EgovAbstractMapper {

    /**
     * 1차 메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteFirstMenuList(SiteMenuVO paramVO) {
        return selectList("menuEstbsInfoDAO_selectSiteFirstMenuList", paramVO);
    }
    
    public String seletSiteMenuSeq() {
        return (String)selectOne("menuEstbsInfoDAO_seletSiteMenuSeq");
    }
    
    /**
     * 사이트 메뉴 등록
     * @return
     */
    public void registSiteMenu(SiteMenuVO paramVO) {
        insert("menuEstbsInfoDAO_registSiteMenu", paramVO);
    }

    public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO) {
        update("menuEstbsInfoDAO_modifySiteMenuPlusOrdr", paramVO);
    }
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO) {
        return (SiteMenuVO)selectOne("menuEstbsInfoDAO_selectSiteMenu", paramVO);
    }
    
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO) {
        return (Integer)selectOne("menuEstbsInfoDAO_selectMaxMenuOrdr", paramVO);
    }
    
    public List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO paramVO) {
        return selectList("menuEstbsInfoDAO_selectSiteMenuCntntList", paramVO);
    }
    
    public int selectSubMenuCnt(SiteMenuVO paramVO) {
        return ((Integer)selectOne("menuEstbsInfoDAO_selectSubMenuCnt", paramVO)).intValue();
    }
    
    /**
     * 사이트 메뉴 수정
     * @return
     */
    public void modifySiteMenu(SiteMenuVO paramVO) {
        update("menuEstbsInfoDAO_modifySiteMenu", paramVO);
    }

    /**
     * 사이트 메뉴 삭제
     * @return
     */
    public int deleteSiteMenuMngr(SiteMenuVO paramVO) {
        return update("menuEstbsInfoDAO_deleteSiteMenuMngr", paramVO);
    }
    /**
     * 사이트 메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteMenuList(SiteMenuVO paramVO) {
        return selectList("menuEstbsInfoDAO_selectSiteMenuList", paramVO);
    }

    /**
     * 사이트 메뉴 정렬 수정
     * @return
     */
    public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO) {
        update("menuEstbsInfoDAO_modifySiteMenuMngrOrdr", paramVO);
    }
    
    
    
    
    /**
     * 사이트 메뉴 설정 정보 목록 조회
     * @return
     */
    
    public List<SiteMenuVO> selectSiteMenuEstbsInfoList(SiteMenuVO paramVO) {
        return selectList("menuEstbsInfoDAO_selectSiteMenuEstbsInfoList", paramVO);
    }
    
    /**
     * 현재메뉴 포함 하위메뉴 목록
     * @return
     */
    
    public List<SiteMenuVO> selectSiteMenuLow(SiteMenuVO paramVO) {
        return selectList("menuEstbsInfoDAO_selectSiteMenuLow", paramVO);
    }
}

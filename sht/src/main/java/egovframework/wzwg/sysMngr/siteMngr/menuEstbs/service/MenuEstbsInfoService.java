package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service;

import java.util.List;
import java.util.Map;

import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;

/**
 * ㅁ 시스템 - 메뉴설정관리
 * ㅁ DC   
 * - 시스템관리자가 메뉴설정를 관리
 * - 생선된 메뉴설정는 메뉴설정 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface MenuEstbsInfoService {

    public Map<String, Object> registSiteMenuMngrInfo(SiteMenuVO siteMenuVO) throws Exception;   
    
    public void registSiteMenu(SiteMenuVO siteMenuVO); 
    
    public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO);
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO);
    
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO);
    
    public List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO siteMenuVO) throws Exception;
    
    public int selectSubMenuCnt(SiteMenuVO paramVO);
    
    public void modifySiteMenu(SiteMenuVO siteMenuVO);
    
    /**
     * 사이트 메뉴 삭제
     */
    public void deleteSiteMenu(SiteMenuVO siteMenuVO);

    /**
     * 사이트 메뉴 정보 조회
     * @throws Exception 
     */
    public Map<String, Object> selectSiteMenuMngrList(SiteMenuVO siteMenuVO) throws Exception;

    public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO);
    
    // 하위메뉴포함 삭제
    public int deleteSiteMenuLow(SiteMenuVO siteMenuVO) throws Exception;
}

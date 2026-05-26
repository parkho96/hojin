package egovframework.wzwg.site.mngr.menu.service;

import java.util.List;
import java.util.Map;

import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;

public interface SiteMenuService {

	/** 사이트 메뉴 정보 조회 */
	Map<String, Object> selectSiteMenuMngrList(SiteMenuVO siteMenuVO) throws Exception;

	/** 사이트 메뉴 등록 */
	void registSiteMenu(SiteMenuVO siteMenuVO);
	
    void modifySiteMenu(SiteMenuVO siteMenuVO);

    /**
     * 사이트 메뉴 경로 목록
     * @return
     */
    List<SiteMenuVO> selectSiteMenuPathList(SiteMenuVO paramVO);
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    List<SiteMenuVO> selectSiteMenuList(SiteMenuVO siteMenuVO) throws Exception;
    
    List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO siteMenuVO) throws Exception;
    
    /**
     * 사이트 서브 메뉴 목록 조회
     * @throws Exception 
     */
    List<SiteMenuVO> selectSiteSubMenuList(SiteMenuVO siteMenuVO) throws Exception;
    
    /**
     * 초기 메뉴 저장
     * @throws Exception 
     */
    public void registSiteMenuInit(SiteMenuVO siteMenuVO) throws Exception;

//	/** 사이트 메뉴 정렬 수정 */
//	void modifySiteMenuMngrOrdr(HttpServletRequest request);
    
    String selectSiteTopLogo(SiteMenuVO siteMenuVO) throws Exception;
    
    public String selectSiteFooterLogo(SiteMenuVO siteMenuVO) throws Exception;
    
    public Map<String, Object> registSiteMenuMngrInfo(SiteMenuVO siteMenuVO) throws Exception;
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO) ;
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO);
    
    public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO);
    
    public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO);
    
    public void deleteSiteMenu(SiteMenuVO siteMenuVO);
    
    public int selectSubMenuCnt(SiteMenuVO paramVO);
    
    // 하위메뉴포함 삭제
    public int deleteSiteMenuLow(SiteMenuVO siteMenuVO) throws Exception;
    
    public String seletSiteMenuSeq() ;
    
    
    public int registSiteMenuByUsrGroup(CntntsAuthVO paramVO);
 

}

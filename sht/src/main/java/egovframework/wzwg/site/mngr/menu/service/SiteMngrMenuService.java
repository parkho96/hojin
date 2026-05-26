package egovframework.wzwg.site.mngr.menu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface SiteMngrMenuService {

	/** 사이트 메뉴 정보 조회 */
	Map<String, Object> selectSiteMenuMngrList(SiteMngrMenuVO siteMenuVO) throws Exception;

	/** 사이트 메뉴 등록 */
	void registSiteMenu(SiteMngrMenuVO siteMenuVO);
	
    void modifySiteMenu(SiteMngrMenuVO siteMenuVO);

    /**
     * 사이트 메뉴 경로 목록
     * @return
     */
	HashMap<String, String> selectSiteMenuPathList(SiteMngrMenuVO paramVO);
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    List<SiteMngrMenuVO> selectSiteMenuList(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    List<SiteMngrMenuVO> selectSiteMenuCntntList(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    /**
     * 사이트 서브 메뉴 목록 조회
     * @throws Exception 
     */
    List<SiteMngrMenuVO> selectSiteSubMenuList(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    /**
     * 초기 메뉴 저장
     * @throws Exception 
     */
    public void registSiteMenuInit(SiteMngrMenuVO siteMenuVO) throws Exception;

//	/** 사이트 메뉴 정렬 수정 */
//	void modifySiteMenuMngrOrdr(HttpServletRequest request);
    
    String selectSiteTopLogo(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    public String selectSiteFooterLogo(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    public Map<String, Object> registSiteMenuMngrInfo(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    public SiteMngrMenuVO selectSiteMenu(SiteMngrMenuVO paramVO) ;
    public Integer selectMaxMenuOrdr(SiteMngrMenuVO paramVO);
    
    public void modifySiteMenuPlusOrdr(SiteMngrMenuVO paramVO);
    
    public void modifySiteMenuMngrOrdr(SiteMngrMenuVO paramVO);
    
    public void deleteSiteMenu(SiteMngrMenuVO siteMenuVO);
    
    public int selectSubMenuCnt(SiteMngrMenuVO paramVO);
    
    // 하위메뉴포함 삭제
    public int deleteSiteMenuLow(SiteMngrMenuVO siteMenuVO) throws Exception;
    
    public String seletSiteMenuSeq() ; 
    
	public void registSiteMenuAuth(SiteMngrMenuVO paramVO) ;
	
	public Map<String, Object> selectSiteMenuMngrLeftList(SiteMngrMenuVO siteMngrMenuVO) throws Exception ;
	 
	public List<SiteMngrMenuVO> selectMngrMenuAuthList(SiteMngrMenuVO paramVO) ;
 
	public SiteMngrMenuVO selectSiteMngrMenuNm(SiteMngrMenuVO siteMenuVO) throws Exception;
	
	public List<SiteMngrMenuVO> selectSiteMenuLeftList(SiteMngrMenuVO siteMenuVO) throws Exception;
	
	public SiteMngrMenuVO selectSiteMngrMenuUrlByAuthSeq(SiteMngrMenuVO paramVO) ;
	
	public SiteMngrMenuVO selectSiteMngrUsrSeqByAuthSeq(SiteMngrMenuVO paramVO);

}

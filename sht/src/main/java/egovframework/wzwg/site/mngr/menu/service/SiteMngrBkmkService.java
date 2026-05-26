package egovframework.wzwg.site.mngr.menu.service;

import java.util.List;

public interface SiteMngrBkmkService {
	@SuppressWarnings("unchecked")
	public List<SiteMngrMenuVO> selectSiteMngrMenuList(SiteMngrBkmkVO paramVO) ;
	
	
	@SuppressWarnings("unchecked")
	public List<SiteMngrMenuVO> selectSiteMngrBkmkList(SiteMngrBkmkVO paramVO) ;
	  
    
    public String seletSiteMngrBkmkSeq();
	
	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public void registSiteMngrBkmk(SiteMngrBkmkVO paramVO) ;
	 
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public void modifySiteMngrBkmk(SiteMngrBkmkVO paramVO);

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public int deleteSiteMngrBkmk(SiteMngrBkmkVO paramVO) ;

}

package egovframework.wzwg.site.mngr.screen.service;

import java.util.List;
import java.util.Map;

import egovframework.wzwg.module.scrin.service.ScrinMenuVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;

public interface SiteScreenService {

	
	/** 사이트 메뉴 정보 조회 */
	Map<String, Object> selectSiteMenuMngrList(SiteScreenVO siteScreenVO) throws Exception;
 
	
	List<Object> selectModuleList(String moduleCode,String siteSeq) throws Exception;
	
	public List<ScrinMenuVO> selectModuleListType(String grpcode,String siteSeq) throws Exception;
	
	public List<ScrinMenuVO> selectModuleMenuList(String sysmoduleSeq,String siteSeq) throws Exception;
//	/** 사이트 메뉴 정렬 수정 */
//	void modifySiteMenuMngrOrdr(HttpServletRequest request);
	
	public ScrinMenuVO selectFirstNttMenuSeq(ScrinMenuVO paramVO);
	
	void registTemplateBackupInfo(SiteScreenVO siteScreenVO) throws Exception;
	
	List<SiteScreenVO> selectTemplateBackupInfoList(SiteScreenVO paramVO) throws Exception;
	
	SiteScreenVO selectTemplateBackupInfo(SiteScreenVO paramVO) throws Exception;

	public List<SiteMenuVO> selectModuleMenuList(SiteScreenVO siteScreenVO); 
	
	/**
	 * 탭메뉴 연결 게시판 목록
	 * @param siteScreenVO
	 * @return
	 */
	public List<SiteScreenVO> selectTabMenuModuleList(SiteScreenVO siteScreenVO);
}

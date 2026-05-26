package egovframework.wzwg.site.mngr.menu.service;

import java.util.List;

public interface SiteHdftrMenuService {
	  /**
		 * 사이트 메뉴 목록
		 * @return
		 */
		@SuppressWarnings("unchecked")
		 List<SiteHdftrMenuVO> selectSiteHdftrMenuList(SiteHdftrMenuVO paramVO) ;
		 
		SiteHdftrMenuVO selectSiteHdftrMenu(SiteHdftrMenuVO paramVO) ;
		/**
		 * 사이트 메뉴 등록
		 * @return
		 */
		 int registSiteHdftrMenu(SiteHdftrMenuVO paramVO) ;
		
		/**
		 * 사이트 메뉴 수정
		 * @return
		 */
		int modifySiteHdftrMenu(SiteHdftrMenuVO paramVO) ;
		
		int modifySiteHdftrMenuOrdr(SiteHdftrMenuVO paramVO) ;


		/**
		 * 사이트 메뉴 삭제
		 * @return
		 */
		public void deleteSiteHdftrMenuMngr(SiteHdftrMenuVO paramVO);
		

		/**
		 * 번역 여부 중복체크
		 */
		public int selectSiteHdftrMenuTrnslatChk(SiteHdftrMenuVO paramVO) ;

}

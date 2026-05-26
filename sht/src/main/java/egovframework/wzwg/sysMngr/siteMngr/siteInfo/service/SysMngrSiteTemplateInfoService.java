package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.util.List;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSiteTemplateInfoService {

	/**
	 * ㅁ 템플릿 목록
     * @param vo
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectTemplateList(SysMngrSiteTemplateInfoVO vo) throws Exception;
	
	/**
	 * ㅁ 사이트별 템플릿 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectSiteTemplateInfoList(SysMngrSiteTemplateInfoVO vo) throws Exception;

	/**
	 * ㅁ 사이트별 템플릿 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteTemplateInfo(SysMngrSiteTemplateInfoVO vo) throws Exception ;
    
    /**
	 * ㅁ 사이트별 템플릿 전체 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registAllSiteTemplateInfo(SysMngrSiteTemplateInfoVO vo) throws Exception; 
  
}

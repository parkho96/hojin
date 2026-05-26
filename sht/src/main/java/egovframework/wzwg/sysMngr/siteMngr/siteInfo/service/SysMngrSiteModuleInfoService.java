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
public interface SysMngrSiteModuleInfoService {

	public List<SysMngrSiteModuleInfoVO> selectSiteModuleInfoList(SysMngrSiteModuleInfoVO paramVO) throws Exception;

    public void registSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception ;
  
    public void deleteSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception ;
    
    public void registAllSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception; 
}

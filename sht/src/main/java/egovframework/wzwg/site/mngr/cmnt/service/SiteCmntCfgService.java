package egovframework.wzwg.site.mngr.cmnt.service;

import java.util.List;

public interface SiteCmntCfgService {
		public void registSiteCmntCfg(SiteCmntCfgVO paramVO) ;
		
		public void modifySiteCmntCfg(SiteCmntCfgVO paramVO) ;
		
		public SiteCmntCfgVO selectSiteCmntCfg(SiteCmntCfgVO paramVO) ;
		
		public void registSiteCmntCfgroup(SiteCmntCfgVO paramVO) ;
		
		public void deleteSiteCmntCfgroup(SiteCmntCfgVO paramVO) ;
		
		public List<SiteCmntCfgVO> selectSiteCmntCfgroupList(SiteCmntCfgVO paramVO) ;
}

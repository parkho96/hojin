package egovframework.wzwg.site.mngr.cmnt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgVO;

@Repository("SiteCmntCfgDAO")
public class SiteCmntCfgDAO extends EgovAbstractMapper {
 
	
	public void registSiteCmntCfg(SiteCmntCfgVO paramVO) {
		  insert("siteCmntCfgDAO_registSiteCmntCfg", paramVO);
	}
	
	
	public void modifySiteCmntCfg(SiteCmntCfgVO paramVO) {
		  update("siteCmntCfgDAO_modifySiteCmntCfg", paramVO);
	}
	
	
	public SiteCmntCfgVO selectSiteCmntCfg(SiteCmntCfgVO paramVO) {
		 return (SiteCmntCfgVO)selectOne("siteCmntCfgDAO_selectSiteCmntCfg", paramVO);
	}
  
	
	public void registSiteCmntCfgroup(SiteCmntCfgVO paramVO) {
		  insert("siteCmntCfgDAO_registSiteCmntCfgroup", paramVO);
	}
	
	public void deleteSiteCmntCfgroup(SiteCmntCfgVO paramVO) {
		  delete("siteCmntCfgDAO_deleteSiteCmntCfgroup", paramVO);
	}
	
	public List<SiteCmntCfgVO> selectSiteCmntCfgroupList(SiteCmntCfgVO paramVO) {
		 return selectList("siteCmntCfgDAO_selectSiteCmntCfgroupList", paramVO);
	}
  
}

package egovframework.wzwg.site.mngr.cmnt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Service("SiteCmntCfgService")
public class SiteCmntCfgServiceImpl extends EgovAbstractServiceImpl implements SiteCmntCfgService {
     

	/** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="SiteCmntCfgDAO")
    private SiteCmntCfgDAO siteCmntCfgDAO;
    
    @SuppressWarnings("unchecked")
	public void registSiteCmntCfg(SiteCmntCfgVO paramVO) {
    	siteCmntCfgDAO.registSiteCmntCfg(paramVO);
	}
	
	@SuppressWarnings("unchecked")
	public void modifySiteCmntCfg(SiteCmntCfgVO paramVO) {
		siteCmntCfgDAO.modifySiteCmntCfg(paramVO);
	}
	
	@SuppressWarnings("unchecked")
	public SiteCmntCfgVO selectSiteCmntCfg(SiteCmntCfgVO paramVO) {
		 return siteCmntCfgDAO.selectSiteCmntCfg(paramVO);
	}

	
	public void registSiteCmntCfgroup(SiteCmntCfgVO paramVO) {
		siteCmntCfgDAO.registSiteCmntCfgroup(paramVO);
	}
	
	public void deleteSiteCmntCfgroup(SiteCmntCfgVO paramVO) {
		siteCmntCfgDAO.deleteSiteCmntCfgroup(paramVO);
	}
	
	public List<SiteCmntCfgVO> selectSiteCmntCfgroupList(SiteCmntCfgVO paramVO) {
		 return siteCmntCfgDAO.selectSiteCmntCfgroupList(paramVO);
	}
    
}

package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoVO;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteModuleInfoService")
public class SysMngrSiteModuleInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteModuleInfoService {

   

    @Resource(name="SysMngrSiteModuleInfoDAO")
    private SysMngrSiteModuleInfoDAO siteModuleInfoDAO; 
    
	  @SuppressWarnings("unchecked")
		public List<SysMngrSiteModuleInfoVO> selectSiteModuleInfoList(SysMngrSiteModuleInfoVO paramVO) throws Exception {
	    	return siteModuleInfoDAO.selectSiteModuleInfoList(paramVO);
	    }
	 
		
 
	    public void registSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception {
	    	if(paramVO.getSysmoduleSeqArr().length >0) {
	    	deleteSiteModuleInfo(paramVO);
	    		for(int i = 0;i<paramVO.getSysmoduleSeqArr().length;i++) {
	    			paramVO.setSysmoduleSeq(paramVO.getSysmoduleSeqArr()[i]);
	    			siteModuleInfoDAO.registSiteModuleInfo(paramVO);
	    		}
	    	}
	    }
	    
	    public void registAllSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception {
	    	
	    	List<SysMngrSiteModuleInfoVO> list = selectSiteModuleInfoList(paramVO);
	    	
	    	if(list.size() >0) { 
	    		for(int i = 0;i<list.size();i++) {
	    			SysMngrSiteModuleInfoVO siteModuleInfoVO =list.get(i);
	    			paramVO.setSysmoduleSeq(siteModuleInfoVO.getSysmoduleSeq());
	    			siteModuleInfoDAO.registSiteModuleInfo(paramVO);
	    		}
	    	}
	    }

	  
	    public void deleteSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception {
	    	siteModuleInfoDAO.deleteSiteModuleInfo(paramVO);
	    }

}

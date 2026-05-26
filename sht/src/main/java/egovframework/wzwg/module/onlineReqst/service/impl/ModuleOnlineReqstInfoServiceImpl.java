package egovframework.wzwg.module.onlineReqst.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstInfoService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("ModuleOnlineReqstInfoService")
public class ModuleOnlineReqstInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineReqstInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
	@Resource(name="ModuleOnlineReqstInfoDAO")
	ModuleOnlineReqstInfoDAO moduleOnlineReqstInfoDAO;
	
	/**
	 * 온라인신청 목록
	 */
	public List<CntntsInfoVO> selectOnlineReqstInfoList(ModuleOnlineReqstInfoVO moduleOnlineReqstInfoVO) throws Exception{
		return moduleOnlineReqstInfoDAO.selectOnlineReqstInfoList(moduleOnlineReqstInfoVO);
	}		 
	
}

package egovframework.wzwg.module.onlineReqst.service;

import java.util.List;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface ModuleOnlineReqstInfoService {
	
	/**
	 * 온라인신청 목록
	 */
	public List<CntntsInfoVO> selectOnlineReqstInfoList(ModuleOnlineReqstInfoVO moduleOnlineReqstInfoVO) throws Exception;
		
}

package egovframework.wzwg.module.onlineReqst.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Repository("ModuleOnlineReqstInfoDAO")
public class ModuleOnlineReqstInfoDAO extends EgovAbstractMapper{
	
	/**
	 * 온라인신청 목록
	 */
	
	public List<CntntsInfoVO> selectOnlineReqstInfoList(ModuleOnlineReqstInfoVO moduleOnlineReqstInfoVO) throws Exception{
		return selectList("ModuleOnlineReqstInfoDAO_selectOnlineReqstInfoList_S", moduleOnlineReqstInfoVO);
	}	

}

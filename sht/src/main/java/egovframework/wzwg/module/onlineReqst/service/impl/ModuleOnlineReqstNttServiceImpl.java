package egovframework.wzwg.module.onlineReqst.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttVO;


@Service(value="ModuleOnlineReqstNttService")
public class ModuleOnlineReqstNttServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineReqstNttService {
	
	@Resource(name="ModuleOnlineReqstNttDAO")
	public ModuleOnlineReqstNttDAO moduleOnlineReqstNttDAO;
	
	/*
	 * 온라인신청 정보 목록
	 */
	public List<ModuleOnlineReqstNttVO> selectOnlineReqstNttList(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return moduleOnlineReqstNttDAO.selectOnlineReqstNttList(moduleOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 정보 목록 총 갯수
	 */
	public int selectOnlineReqstNttListTotCnt(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return moduleOnlineReqstNttDAO.selectOnlineReqstNttListCnt(moduleOnlineReqstNttVO);
	}
	
	/*
	 * 온라인신청 정보 목록
	 */
	public List<ModuleOnlineReqstNttVO> selectOnlineReqstNttScrinCntnts(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception{
		return moduleOnlineReqstNttDAO.selectOnlineReqstNttList(moduleOnlineReqstNttVO);
	}	  
    
    /*
     * 온라인신청 정보 목록
     */
    public List<ModuleOnlineReqstNttVO> selectOnlineReqstScrinCntnts(ModuleOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception {
        return selectOnlineReqstNttScrinCntnts(mngrOnlineReqstNttVO);
    }
	
	/*
	 * 온라인신청 상세
	 */
	public ModuleOnlineReqstNttVO selectOnlineReqstNttDetail(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception {
		return moduleOnlineReqstNttDAO.selectOnlineReqstNttDetail(moduleOnlineReqstNttVO);
	}

}

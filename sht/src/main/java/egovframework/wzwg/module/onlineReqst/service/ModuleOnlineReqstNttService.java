package egovframework.wzwg.module.onlineReqst.service;

import java.util.List;

public interface ModuleOnlineReqstNttService {
    
	/*
	 * 온라인신청 정보 목록
	 */
	public List<ModuleOnlineReqstNttVO> selectOnlineReqstNttList(ModuleOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception;
	
	/*
	 * 온라인신청 정보 목록 총 갯수
	 */
	public int selectOnlineReqstNttListTotCnt(ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception;
    
    /*
     * 온라인신청 정보 목록
     */
    public List<ModuleOnlineReqstNttVO> selectOnlineReqstNttScrinCntnts(ModuleOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception;  
    
    /*
     * 온라인신청 정보 목록
     */
    public List<ModuleOnlineReqstNttVO> selectOnlineReqstScrinCntnts(ModuleOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception;  

	/*
	 * 온라인신청 상세
	 */
	public ModuleOnlineReqstNttVO selectOnlineReqstNttDetail(ModuleOnlineReqstNttVO mngrOnlineReqstNttVO) throws Exception;

}

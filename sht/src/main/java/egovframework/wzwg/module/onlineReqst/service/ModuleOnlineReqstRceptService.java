package egovframework.wzwg.module.onlineReqst.service;

import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;


public interface ModuleOnlineReqstRceptService {
	
	/*
	 * 사용자그룹정보
	 */
	public SiteUsrGroupVO selectSiteUsrGroupInfo(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptDAO) throws Exception;
    
	/*
	 * 온라인신청접수 여부
	 */
	public String selectOnlineReqstRceptAt(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptDAO) throws Exception;
	
	/*
	 * 온라인신청접수 상세정보
	 */
	public ModuleOnlineReqstRceptVO selectOnlineReqstRceptDetail(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptDAO) throws Exception;

	/*
	 * 온라인신청접수 등록
	 */
	public int registOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptDAO) throws Exception;
	
	/*
	 * 온라인신청접수 수정
	 */
	public int modifyOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptDAO, ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception;
	
}

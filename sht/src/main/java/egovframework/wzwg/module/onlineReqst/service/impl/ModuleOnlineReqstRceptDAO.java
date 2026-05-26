package egovframework.wzwg.module.onlineReqst.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstRceptVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;

@Repository(value="ModuleOnlineReqstRceptDAO")
public class ModuleOnlineReqstRceptDAO extends EgovAbstractMapper {
	
	/*
	 * 사용자그룹정보
	 */
	public SiteUsrGroupVO selectSiteUsrGroupInfo(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		return (SiteUsrGroupVO) selectOne("ModuleOnlineReqstRceptDAO_selectSiteUsrGroupInfo_S", moduleOnlineReqstRceptVO);
	}    

	/*
	 * 온라인신청접수 여부
	 */
	public String selectOnlineReqstRceptAt(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception{
		return (String) selectOne("ModuleOnlineReqstRceptDAO_selectOnlineReqstRceptAt_S", moduleOnlineReqstRceptVO);
	}
	
	/*
	 * 온라인신청접수 상세정보
	 */
	public ModuleOnlineReqstRceptVO selectOnlineReqstRceptDetail(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception{
		return (ModuleOnlineReqstRceptVO) selectOne("ModuleOnlineReqstRceptDAO_selectOnlineReqstRceptDetail_S", moduleOnlineReqstRceptVO);
	}

	/*
	 * 온라인신청접수 등록
	 */
	public int registOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = update("ModuleOnlineReqstRceptDAO_registOnlineReqstRcept_I", moduleOnlineReqstRceptVO);	
		return result;		
	}	
	
	/*
	 * 온라인신청접수 수정
	 */
	public int modifyOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = update("ModuleOnlineReqstRceptDAO_modifyOnlineReqstRcept_U", moduleOnlineReqstRceptVO);	
		return result;		
	}	
	
	/*
	 * 온라인신청접수 대기자 수
	 */
	
	public int selectOnlineReqstWaitCnt(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception{
		return (Integer) selectOne("ModuleOnlineReqstRceptDAO_selectOnlineReqstWaitCnt_S", moduleOnlineReqstRceptVO);
	}	

	/*
	 * 온라인신청접수 대기자 완료 승인
	 */
	public int selectOnlineReqstWaitConfm(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = update("ModuleOnlineReqstRceptDAO_selectOnlineReqstWaitConfm_U", moduleOnlineReqstRceptVO);	
		return result;		
	}	
	
}

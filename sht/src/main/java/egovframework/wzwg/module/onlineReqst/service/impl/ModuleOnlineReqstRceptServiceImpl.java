package egovframework.wzwg.module.onlineReqst.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstNttVO;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstRceptService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstRceptVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;

@Service(value="ModuleOnlineReqstRceptService")
public class ModuleOnlineReqstRceptServiceImpl extends EgovAbstractServiceImpl implements ModuleOnlineReqstRceptService {
	
	@Resource(name="ModuleOnlineReqstRceptDAO")
	public ModuleOnlineReqstRceptDAO moduleOnlineReqstRceptDAO;
	
	/*
	 * 사용자그룹정보
	 */
	public SiteUsrGroupVO selectSiteUsrGroupInfo(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		return moduleOnlineReqstRceptDAO.selectSiteUsrGroupInfo(moduleOnlineReqstRceptVO);
	}  	

	/*
	 * 온라인신청접수 여부
	 */
	public String selectOnlineReqstRceptAt(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		return moduleOnlineReqstRceptDAO.selectOnlineReqstRceptAt(moduleOnlineReqstRceptVO);
	}
	
	/*
	 * 온라인신청접수 상세정보
	 */
	public ModuleOnlineReqstRceptVO selectOnlineReqstRceptDetail(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		return moduleOnlineReqstRceptDAO.selectOnlineReqstRceptDetail(moduleOnlineReqstRceptVO);
	}

	/*
	 * 온라인신청접수 등록
	 */
	public int registOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO) throws Exception {
		int result = 0;
		result = moduleOnlineReqstRceptDAO.registOnlineReqstRcept(moduleOnlineReqstRceptVO);	
		return result;		
	}
	
	/*
	 * 온라인신청접수 수정
	 */
	public int modifyOnlineReqstRcept(ModuleOnlineReqstRceptVO moduleOnlineReqstRceptVO, ModuleOnlineReqstNttVO moduleOnlineReqstNttVO) throws Exception {
		int result = 0;
		result = moduleOnlineReqstRceptDAO.modifyOnlineReqstRcept(moduleOnlineReqstRceptVO);	
		
		if(moduleOnlineReqstNttVO.getConfmMthdCode().equals("SC00000109")) { // 자동승인(선착순)일 경우
			
			if(moduleOnlineReqstRceptVO.getBeforeConfmSttusCode().equals("SC00000118")) { // 이전 산태가 완료이고
		
				if(result > 0) {
					if(moduleOnlineReqstRceptVO.getConfmSttusCode().equals("SC00000117")) { // 취소가 발생하면
						int waitCnt = 0;
						waitCnt = moduleOnlineReqstRceptDAO.selectOnlineReqstWaitCnt(moduleOnlineReqstRceptVO); // 대기 수 확인 후
		
						if(waitCnt > 0) {
							result = moduleOnlineReqstRceptDAO.selectOnlineReqstWaitConfm(moduleOnlineReqstRceptVO); // 대기를 완료처리
						}			
					}
				}
			
			}
		
		}
		
		return result;		
	}	
}

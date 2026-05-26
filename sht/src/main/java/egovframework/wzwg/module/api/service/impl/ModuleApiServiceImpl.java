package egovframework.wzwg.module.api.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.api.service.ModuleApiService;
import egovframework.wzwg.module.api.service.ModuleApiVO;

@Service("ModuleApiService")
public class ModuleApiServiceImpl extends EgovAbstractServiceImpl implements ModuleApiService {
	
	@Resource(name="ModuleApiDAO")
	ModuleApiDAO moduleApiDAO;

	/**
	 * API관리 -> API 총 카운트 조회
	 */
	public Integer selectModuleApiTotCnt(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.selectModuleApiTotCnt(moduleApiVO);
	}

	/**
	 * API관리 -> API 리스트 조회
	 */
	public List<ModuleApiVO> selectModuleApiList(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.selectModuleApiList(moduleApiVO);
	}

	/**
	 * API관리 -> API 상세조회
	 */
	public ModuleApiVO selectModuleApiDetail(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.selectModuleApiDetail(moduleApiVO);
	}

	/**
	 * API관리 -> API 등록
	 */
	public int registModuleApi(ModuleApiVO moduleApiVO) {
		String apiSeq = moduleApiDAO.selectModuleApiSeq();
		moduleApiVO.setApiSeq(apiSeq);
		return moduleApiDAO.registModuleApi(moduleApiVO);
	}

	/**
	 * API관리 -> API 수정
	 */
	public int modifyModuleApi(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.modifyModuleApi(moduleApiVO);
	}

	/**
	 * API관리 -> API 삭제
	 */
	public int deleteModuleApi(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.deleteModuleApi(moduleApiVO);
	}

	/**
	 * 네이버지도 -> 사용자(임시)
	 */
	public ModuleApiVO selectMapDetail(ModuleApiVO moduleApiVO) {
		return moduleApiDAO.selectMapDetail(moduleApiVO);
	}
	
	
}

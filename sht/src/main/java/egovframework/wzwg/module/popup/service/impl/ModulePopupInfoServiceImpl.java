package egovframework.wzwg.module.popup.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.popup.service.ModulePopupInfoService;
import egovframework.wzwg.module.popup.service.ModulePopupInfoVO;
import egovframework.wzwg.module.popup.service.ModulePopupTmplatVO;

@Service("ModulePopupInfoService")
public class ModulePopupInfoServiceImpl extends EgovAbstractServiceImpl implements ModulePopupInfoService {
	
	@Resource(name="ModulePopupInfoDAO")
	ModulePopupInfoDAO modulePopupInfoDAO;

	/**
	 * 팝업 총 카운트 조회
	 */
	public Integer selectPopupTotCnt(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.selectPopupTotCnt(modulePopupVO);
	}

	/**
	 * 팝업 리스트 조회
	 */
	public List<ModulePopupInfoVO> selectModulePopupList(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.selectModulePopupList(modulePopupVO);
	}

	/**
	 * 팝업 상세조회
	 */
	public ModulePopupInfoVO selectModulePopupDetail(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.selectModulePopupDetail(modulePopupVO);
	}

	/**
	 * 팝업 등록
	 */
	public int registModulePopup(ModulePopupInfoVO modulePopupVO) {
		String popupSeq = modulePopupInfoDAO.selectModulePopupSeq(modulePopupVO);
		modulePopupVO.setPopupSeq(popupSeq);
		
		return modulePopupInfoDAO.registModulePopup(modulePopupVO);
	}

	/**
	 * 팝업 수정
	 */
	public int modifyModulePopup(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.modifyModulePopup(modulePopupVO);
	}

	/**
	 * 팝업 삭제
	 */
	public int deleteModulePopup(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.deleteModulePopup(modulePopupVO);
	}

	/**
	 * 팝업 템플릿 상세조회
	 */
	public ModulePopupTmplatVO selectPopupTmplatDetail(String tmplatSeq) {
		return modulePopupInfoDAO.selectPopupTmplatDetail(tmplatSeq);
	}

	/**
	 * 팝업 리스트 조회
	 */
	public List<ModulePopupTmplatVO> selectPopupTmplatList() {
		return modulePopupInfoDAO.selectPopupTmplatList();
	}
	
	
	/**
	 * 팝업 메인 리스트 조회
	 */
	public List<ModulePopupInfoVO> selectModuleMainPopupList(ModulePopupInfoVO modulePopupVO) {
		return modulePopupInfoDAO.selectModuleMainPopupList(modulePopupVO);
	}
}

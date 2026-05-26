package egovframework.wzwg.module.popup.service;

import java.util.List;

public interface ModulePopupInfoService {

	/** 팝업 총 카운트 조회 */
	Integer selectPopupTotCnt(ModulePopupInfoVO modulePopupVO);
	
	/** 팝업 리스트 조회 */
	List<ModulePopupInfoVO> selectModulePopupList(ModulePopupInfoVO modulePopupVO);

	/** 팝업 상세조회 */
	ModulePopupInfoVO selectModulePopupDetail(ModulePopupInfoVO modulePopupVO);

	/** 팝업 등록 */
	int registModulePopup(ModulePopupInfoVO modulePopupVO);

	/** 팝업 수정 */
	int modifyModulePopup(ModulePopupInfoVO modulePopupVO);

	/** 팝업 삭제 */
	int deleteModulePopup(ModulePopupInfoVO modulePopupVO);

	/** 팝업 템플릿 상세조회 */
	ModulePopupTmplatVO selectPopupTmplatDetail(String tmplatSeq);

	/** 팝업 템플릿 리스트 조회 */
	List<ModulePopupTmplatVO> selectPopupTmplatList();
	
	/** 팝업 메인 리스트 조회 */
	List<ModulePopupInfoVO> selectModuleMainPopupList(ModulePopupInfoVO modulePopupVO);

}

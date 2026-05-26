package egovframework.wzwg.module.popup.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.popup.service.ModulePopupInfoVO;
import egovframework.wzwg.module.popup.service.ModulePopupTmplatVO;


@Repository("ModulePopupInfoDAO")
public class ModulePopupInfoDAO extends EgovAbstractMapper{
	
	@Autowired
	HttpSession session;
	
	/**
	 * 
	 * @Method Name : selectModulePopupSeq
	 * @Method 설명 : 팝업 시퀀스 조회 
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 :
	 */
	public String selectModulePopupSeq(ModulePopupInfoVO modulePopupVO) {
		return (String) selectOne("ModulePopupInfoDAO_selectModulePopupSeq", modulePopupVO);
	}

	/**
	 * 
	 * @Method Name : selectPopupTotCnt
	 * @Method 설명 : 팝업 총 카운트 조회
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 :
	 */
	public Integer selectPopupTotCnt(ModulePopupInfoVO modulePopupVO) {
		return (Integer) selectOne("ModulePopupInfoDAO_selectPopupTotCnt", modulePopupVO);
	}

	/**
	 * @Method Name : selectModulePopupList
	 * @Method 설명 : 팝업 리스트 조회
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public List<ModulePopupInfoVO> selectModulePopupList(ModulePopupInfoVO modulePopupVO) {
		
		String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		
		modulePopupVO.setLangCode(langcode);
		
		return selectList("ModulePopupInfoDAO_selectModulePopupList", modulePopupVO);
	}

	/**
	 * @Method Name : selectModulePopupDetail
	 * @Method 설명 : 팝업 상세조회
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public ModulePopupInfoVO selectModulePopupDetail(ModulePopupInfoVO modulePopupVO) {
		return (ModulePopupInfoVO)selectOne("ModulePopupInfoDAO_selectModulePopupDetail", modulePopupVO);
	}

	/**
	 * @Method Name : registModulePopup
	 * @Method 설명 : 팝업 등록
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int registModulePopup(ModulePopupInfoVO modulePopupVO) {
		return update("ModulePopupInfoDAO_registModulePopup", modulePopupVO);
	}

	/**
	 * @Method Name : modifyModulePopup
	 * @Method 설명 : 팝업 수정
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int modifyModulePopup(ModulePopupInfoVO modulePopupVO) {
		return update("ModulePopupInfoDAO_modifyModulePopup", modulePopupVO);
	}

	/**
	 * @Method Name : deleteModulePopup
	 * @Method 설명 : 팝업 삭제 
	 *
	 * @param modulePopupVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int deleteModulePopup(ModulePopupInfoVO modulePopupVO) {
		return update("ModulePopupInfoDAO_deleteModulePopup", modulePopupVO);
	}

	/**
	 * @Method Name : selectPopupTmplatDetail
	 * @Method 설명 : 팝업 템플릿 상세조회
	 *
	 * @param tmplatSeq
	 * @return
	 *
	 * @변경이력 : 
	 */
	public ModulePopupTmplatVO selectPopupTmplatDetail(String tmplatSeq) {
		return (ModulePopupTmplatVO) selectOne("ModulePopupInfoDAO_selectPopupTmplatDetail", tmplatSeq);
	}

	/**
	 * @Method Name : selectPopupTmplatList
	 * @Method 설명 : 팝업 템플릿 리스트 조회
	 *
	 * @return
	 *
	 * @변경이력 : 
	 */
	public List<ModulePopupTmplatVO> selectPopupTmplatList() {
		return selectList("ModulePopupInfoDAO_selectPopupTmplatList", null);
	}

	public List<ModulePopupInfoVO> selectModuleMainPopupList(ModulePopupInfoVO modulePopupVO) {
		return selectList("ModulePopupInfoDAO_selectModuleMainPopupList", modulePopupVO);
	}
}

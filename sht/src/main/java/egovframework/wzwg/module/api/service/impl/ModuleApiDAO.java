package egovframework.wzwg.module.api.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.api.service.ModuleApiVO;


@Repository("ModuleApiDAO")
public class ModuleApiDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
	 * API관리 -> API SEQ 조회
	 * @return
	 */
	public String selectModuleApiSeq() {
		return (String) selectOne("ModuleApiDAO_selectModuleApiSeq", null);
	}

	/**
	 * @param moduleApiVO
	 * @return
	 */
	public Integer selectModuleApiTotCnt(ModuleApiVO moduleApiVO) {
		return (Integer) selectOne("ModuleApiDAO_selectModuleApiTotCnt", moduleApiVO);
	}

	/**
	 * API관리 -> API 리스트 조회
	 * @param moduleApiVO
	 * @return
	 */
	public List<ModuleApiVO> selectModuleApiList(ModuleApiVO moduleApiVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		moduleApiVO.setLangCode(langcode);
		
		return selectList("ModuleApiDAO_selectModuleApiList", moduleApiVO);
	}

	/**
	 * API관리 -> API 상세조회
	 * @param moduleApiVO
	 * @return
	 */
	public ModuleApiVO selectModuleApiDetail(ModuleApiVO moduleApiVO) {
		return (ModuleApiVO) selectOne("ModuleApiDAO_selectModuleApiDetail", moduleApiVO);
	}

	/**
	 * API관리 -> API 등록
	 * @param moduleApiVO
	 * @return
	 */
	public int registModuleApi(ModuleApiVO moduleApiVO) {
		return update("ModuleApiDAO_registModuleApi", moduleApiVO);
	}

	/**
	 * API관리 -> API 수정
	 * @param moduleApiVO
	 * @return
	 */
	public int modifyModuleApi(ModuleApiVO moduleApiVO) {
		return update("ModuleApiDAO_modifyModuleApi", moduleApiVO);
	}

	/**
	 * API관리 -> API 삭제
	 * @param moduleApiVO
	 * @return
	 */
	public int deleteModuleApi(ModuleApiVO moduleApiVO) {
		return update("ModuleApiDAO_deleteModuleApi", moduleApiVO);
	}

	/**
	 * 네이버지도 -> 사용자(임시)
	 * @param moduleApiVO
	 * @return
	 */
	public ModuleApiVO selectMapDetail(ModuleApiVO moduleApiVO) {
		return (ModuleApiVO) selectOne("ModuleApiDAO_selectMapDetail", moduleApiVO);
	}

}

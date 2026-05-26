package egovframework.wzwg.module.bbs.bbsForm.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.bbs.bbsForm.service.ModuleBbsFormVO;


@Repository("ModuleBbsFormDAO")
public class ModuleBbsFormDAO extends EgovAbstractMapper{
	
	@Autowired
	HttpSession session;
	
	/**
	 * 게시판 양식 관리 리스트 조회
	 * @param moduleBbsFormVO
	 * @return
	 */
	public List<ModuleBbsFormVO> selectModuleBbsFormList(ModuleBbsFormVO moduleBbsFormVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		moduleBbsFormVO.setLangCode(langcode);
		
		return selectList("ModuleBbsFormDAO_selectModuleBbsFormList", moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 상세조회
	 * @param moduleBbsFormVO
	 * @return
	 */
	public ModuleBbsFormVO selectModuleBbsFormDetail(ModuleBbsFormVO moduleBbsFormVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		moduleBbsFormVO.setLangCode(langcode);
		
		return (ModuleBbsFormVO) selectOne("ModuleBbsFormDAO_selectModuleBbsFormDetail", moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 시퀀스 조회
	 * @return
	 */
	public String selectModuleBbsFormSeq() {
		return (String) selectOne("ModuleBbsFormDAO_selectModuleBbsFormSeq", null);
	}

	/**
	 * 게시판 양식 관리 등록
	 * @param moduleBbsFormVO
	 * @return
	 */
	public int registModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_registModuleBbsFormAjax",moduleBbsFormVO);
	}

	/**
	 * MDNTTBBSFORM 테이블에 매핑 정보 입력
	 * @param moduleBbsFormVO
	 * @return
	 */
	public int registNttBbsForm(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_registNttBbsForm", moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 수정
	 * @param moduleBbsFormVO
	 * @return
	 */
	public int modifyModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_modifyModuleBbsFormAjax",moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 삭제
	 * @param moduleBbsFormVO
	 * @return
	 */
	public int deleteModuleBbsFormAjax(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_deleteModuleBbsFormAjax", moduleBbsFormVO);
	}

	/**
	 * 게시판 양식 관리 총 카운트 조회
	 * @param moduleBbsFormVO
	 * @return
	 */
	
	public int selectModuleBbsFormTotCnt(ModuleBbsFormVO moduleBbsFormVO) {
		return (Integer)selectOne("ModuleBbsFormDAO_selectModuleBbsFormTotCnt", moduleBbsFormVO);
	}

	/**
	 * 게시판 리스트 조회(팝업)
	 * @param moduleBbsFormVO
	 * @return
	 */
	public List<ModuleBbsFormVO> selectBbsApplcListPopup(ModuleBbsFormVO moduleBbsFormVO) {
		return selectList("ModuleBbsFormDAO_selectBbsApplcListPopup", moduleBbsFormVO);
	}

	/**
	 * 게시판 매핑 리스트 조회
	 * @param moduleBbsFormVO
	 * @return
	 */
	public ModuleBbsFormVO selectNttBbsMappingDetail(ModuleBbsFormVO moduleBbsFormVO) {
		return (ModuleBbsFormVO) selectOne("ModuleBbsFormDAO_selectNttBbsMappingDetail", moduleBbsFormVO);
	}

	/**
	 * 게시판 매핑 정보 수정
	 * @param moduleBbsFormVO
	 * @return
	 */
	public int modifyNttBbsForm(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_modifyNttBbsForm", moduleBbsFormVO);
	}

	/**
	 * 게시판 매핑 정보 삭제
	 * @param moduleBbsFormVO
	 */
	public int deleteNttBbsForm(ModuleBbsFormVO moduleBbsFormVO) {
		return update("ModuleBbsFormDAO_deleteNttBbsForm", moduleBbsFormVO);
	}

}

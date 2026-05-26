package egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;

@Repository("CntntsTmplatDAO")
public class CntntsTmplatDAO extends EgovAbstractMapper{
	
	@Autowired
	HttpSession session;

	
	/**
	 * 컨텐츠 템플릿 리스트 조회
	 * @param cntntsTmplatVO
	 * @return
	 */
	
	public List<CntntsTmplatVO> selectCntntsTmplatList(CntntsTmplatVO cntntsTmplatVO) {
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		cntntsTmplatVO.setLangCode(langcode);
		
		return selectList("CntntsTmplatDAO_selectCntntsTmplatList", cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 시퀀스 조회
	 * @return
	 */
	public String selectCntnteTmplatSeq() {
		return (String) selectOne("CntntsTmplatDAO_selectCntnteTmplatSeq", null);
	}

	/**
	 * 컨텐츠 템플릿 등록
	 * @param cntntsTmplatVO
	 * @return
	 */
	public int registCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		return update("CntntsTmplatDAO_registCntntsTmplatAjax", cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 상세조회
	 * @param cntntsTmplatVO
	 * @return
	 */
	public CntntsTmplatVO selectCntntsTmplatDetail(CntntsTmplatVO cntntsTmplatVO) {
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		cntntsTmplatVO.setLangCode(langcode);
		
		return (CntntsTmplatVO) selectOne("CntntsTmplatDAO_selectCntntsTmplatDetail", cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 수정
	 * @param cntntsTmplatVO
	 * @return
	 */
	public int modifyCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		return update("CntntsTmplatDAO_modifyCntntsTmplatAjax", cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 삭제
	 * @param cntntsTmplatVO
	 * @return
	 */
	public int deleteCntntsTmplatAjax(CntntsTmplatVO cntntsTmplatVO) {
		return update("CntntsTmplatDAO_deleteCntntsTmplatAjax", cntntsTmplatVO);
	}

	/**
	 * 컨텐츠 템플릿 총 카운트 조회
	 * @param cntntsTmplatVO
	 * @return
	 */
	public int selectCntntsTmplatTotCnt(CntntsTmplatVO cntntsTmplatVO) {
		return (Integer)selectOne("CntntsTmplatDAO_selectCntntsTmplatTotCnt", cntntsTmplatVO);
	}

}

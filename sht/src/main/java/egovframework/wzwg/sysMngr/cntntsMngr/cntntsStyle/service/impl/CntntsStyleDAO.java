package egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.CntntsStyleVO;

@Repository("CntntsStyleDAO")
public class CntntsStyleDAO extends EgovAbstractMapper{

	/**
	 * 컨텐츠 CSS 리스트 조회
	 * @param cntntsStyleVO
	 * @return
	 */
	
	public List<CntntsStyleVO> selectCntntsStyleList(CntntsStyleVO cntntsStyleVO) {
		return selectList("CntntsStyleDAO_selectCntntsStyleList", cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 시퀀스 조회
	 * @return
	 */
	public String selectCntnteStyleSeq() {
		return (String) selectOne("CntntsStyleDAO_selectCntnteStyleSeq", null);
	}

	/**
	 * 컨텐츠 CSS 등록
	 * @param cntntsStyleVO
	 * @return
	 */
	public int registCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		return update("CntntsStyleDAO_registCntntsStyleAjax", cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 상세조회
	 * @param cntntsStyleVO
	 * @return
	 */
	public CntntsStyleVO selectCntntsStyleDetail(CntntsStyleVO cntntsStyleVO) {
		return (CntntsStyleVO) selectOne("CntntsStyleDAO_selectCntntsStyleDetail", cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 수정
	 * @param cntntsStyleVO
	 * @return
	 */
	public int modifyCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		return update("CntntsStyleDAO_modifyCntntsStyleAjax", cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 삭제
	 * @param cntntsStyleVO
	 * @return
	 */
	public int deleteCntntsStyleAjax(CntntsStyleVO cntntsStyleVO) {
		return update("CntntsStyleDAO_deleteCntntsStyleAjax", cntntsStyleVO);
	}

	/**
	 * 컨텐츠 CSS 총 카운트 조회
	 * @param cntntsStyleVO
	 * @return
	 */
	
	public int selectCntntsStyleTotCnt(CntntsStyleVO cntntsStyleVO) {
		return (Integer)selectOne("CntntsStyleDAO_selectCntntsStyleTotCnt", cntntsStyleVO);
	}

	/**
	 * CSS 적용가능한 모듈 리스트 조회
	 * @param cntntsStyleVO
	 * @return
	 */
	
	public List<CntntsStyleVO> selectCssProvdModuleList(CntntsStyleVO cntntsStyleVO) {
		return selectList("CntntsStyleDAO_selectCssProvdModuleList", cntntsStyleVO);
	}	
}

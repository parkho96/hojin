package egovframework.wzwg.sysMngr.usrMngr.usrTy.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;

@Repository("SysMngrUsrTyDAO")

public class SysMngrUsrTyDAO extends EgovAbstractMapper{
	
	@Autowired
	HttpSession session;
	
	public List<SysMngrUsrTyVO> selectUsrTyList(SysMngrUsrTyVO sysMngrUsrTyVO){
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		sysMngrUsrTyVO.setLangCode(langcode);
		
		return selectList("sysMngrUsrTyDAO_selectUsrTyList", sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 리스트 카운트조회
	 * @param sysMngrUsrTyVO
	 * @return
	 */
	
	public int selectSysMngrUsrTyTotCnt(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return (Integer)selectOne("sysMngrUsrTyDAO_selectSysMngrUsrTyTotCnt", sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 등록 시퀀스조회
	 * @return
	 */
	public String selectUsrTySeq() {
		return (String) selectOne("sysMngrUsrTyDAO_selectUsrTySeq", null);
	}

	/**
	 * 사용자 유형 등록
	 * @param sysMngrUsrTyVO
	 * @return
	 */
	public int registUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return update("sysMngrUsrTyDAO_registUsrTy", sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 상세조회
	 * @param sysMngrUsrTyVO
	 * @return
	 */
	public SysMngrUsrTyVO selectUsrTyDetail(SysMngrUsrTyVO sysMngrUsrTyVO) {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		sysMngrUsrTyVO.setLangCode(langcode);
		
		return (SysMngrUsrTyVO) selectOne("sysMngrUsrTyDAO_selectUsrTyDetail", sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 수정
	 * @param sysMngrUsrTyVO
	 * @return
	 */
	public int modifyUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return update("sysMngrUsrTyDAO_modifyUsrTy", sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 삭제
	 * @param sysMngrUsrTyVO
	 * @return
	 */
	public int deleteUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return update("sysMngrUsrTyDAO_deleteUsrTy", sysMngrUsrTyVO);
	}

	public List<SysMngrUsrTyVO> selectUsrTyCodeList() {
		return selectList("sysMngrUsrTyDAO_selectUsrTyCodeList", null);
	}

    /**
     * 사용자 유형 Ajax 셀렉트박스
     * @param sysMngrUsrTyVO
     * @return
     */
    public List<SysMngrUsrTyVO> selectSiteUsrTySbscrb(SysMngrUsrTyVO sysMngrUsrTyVO) {
        return selectList("sysMngrUsrTyDAO_selectSiteUsrTySbscrb", sysMngrUsrTyVO);
    }

	/**
	 * @Method Name : selectUsrTyCodeApplcCnt
	 * @Method 설명 : 사용자 유형 테이블에 등록된 갯수 카운트(USR_TY_CODE)
	 *
	 * @param paramVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int selectUsrTyCodeApplcCnt(String code) {
		return (Integer)selectOne("sysMngrUsrTyDAO_selectUsrTyCodeApplcCnt", code);
	}

}


package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cmnt.service.CmntMenuVO;


@Repository("CmntMenuDAO")
public class CmntMenuDAO extends EgovAbstractMapper{

	/**
	 * 커뮤니티 메뉴 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuVO> selectCmntMenuList(CmntMenuVO paramVO) {
		return selectList("CmntMenuDAO_selectCmntMenuList",paramVO);
	}

	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public CmntMenuVO selectCmntMenuDetail(CmntMenuVO paramVO) {
		return (CmntMenuVO) selectOne("CmntMenuDAO_selectCmntMenuDetail", paramVO);
	}
	
	/**
	 * 커뮤니티 메뉴 시퀀스 조회
	 * @return
	 */
	public String selectCmntMenuSeq() {
		return (String) selectOne("CmntMenuDAO_selectCmntMenuSeq", null);
	}

	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void registCmntMenu(CmntMenuVO paramVO) {
		  insert("CmntMenuDAO_registCmntMenu", paramVO);
	}

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenu(CmntMenuVO paramVO) {
		return update("CmntMenuDAO_deleteCmntMenu", paramVO);
	}

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenu(CmntMenuVO paramVO) {
		return update("CmntMenuDAO_modifyCmntMenu", paramVO);
	}
	
	public int selectCmntMenuTotCnt(CmntMenuVO paramVO) {
		return ((Integer) selectOne("CmntMenuDAO_selectCmntMenuTotCnt", paramVO)).intValue();
	}
 
	public int modifyCmntMenuOrd(CmntMenuVO paramVO) {
		return update("CmntMenuDAO_modifyCmntMenuOrd", paramVO);
	}

}

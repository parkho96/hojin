package egovframework.wzwg.module.cmnt.service;

import java.util.List;

public interface CmntMenuService {
	/**
	 * 커뮤니티 메뉴 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuVO> selectCmntMenuList(CmntMenuVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public CmntMenuVO selectCmntMenuDetail(CmntMenuVO paramVO) ;
	
	/**
	 * 커뮤니티 메뉴 시퀀스 조회
	 * @return
	 */
	public String selectCmntMenuSeq() ;

	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void registCmntMenu(CmntMenuVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenu(CmntMenuVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenu(CmntMenuVO paramVO) ;
	
	public int selectCmntMenuTotCnt(CmntMenuVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 순서 변경
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenuOrd(CmntMenuVO paramVO) ;
}

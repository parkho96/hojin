package egovframework.wzwg.module.cmnt.service;

import java.util.List;

public interface CmntMenuAuthService {
	/**
	 * 커뮤니티 메뉴 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthList(CmntMenuAuthVO paramVO) ;
	
	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthDetail(CmntMenuAuthVO paramVO);
	
	 
	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void registCmntMenuAuth(CmntMenuAuthVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenuAuth(CmntMenuAuthVO paramVO) ;

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenuAuth(CmntMenuAuthVO paramVO) ;
	
	public List<CmntMenuAuthVO> selectCmntMenuAuthForBbsSeqDetail(CmntMenuAuthVO paramVO);

}

package egovframework.wzwg.module.cmnt.service;

import java.util.List;

public interface CmntUserService {
	/**
	 * 커뮤니티 회원 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntUserVO> selectCmntUserList(CmntUserVO paramVO) ;
 
	 
	/**
	 * 커뮤니티 회원 가입
	 * @param paramVO
	 * @return
	 */
	public void registCmntUser(CmntUserVO paramVO) ;

	/**
	 * 커뮤니티 회원 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntUser(CmntUserVO paramVO) ;

	/**
	 * 커뮤니티 회원 승인
	 * @param paramVO
	 * @return
	 */
	public int apprvlCmntUser(CmntUserVO paramVO) ;
	
	public int selectCmntUserTotCnt(CmntUserVO paramVO);

	
	public int registCmntConn(CmntUserVO paramVO);
	
	public  CmntUserVO selectCmntUser(CmntUserVO paramVO) ;
	
	public int selectCmntUserChk(CmntUserVO paramVO);
}

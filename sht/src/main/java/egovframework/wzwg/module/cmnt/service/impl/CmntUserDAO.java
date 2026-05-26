package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cmnt.service.CmntUserVO;


@Repository("CmntUserDAO")
public class CmntUserDAO extends EgovAbstractMapper{

	/**
	 * 커뮤니티 회원 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntUserVO> selectCmntUserList(CmntUserVO paramVO) {
		return selectList("CmntUserDAO_selectCmntUserList",paramVO);
	}
 
	 
	/**
	 * 커뮤니티 회원 가입
	 * @param paramVO
	 * @return
	 */
	public void registCmntUser(CmntUserVO paramVO) {
		 insert("CmntUserDAO_registCmntUser", paramVO);
	}
 
	/**
	 * 커뮤니티 회원 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntUser(CmntUserVO paramVO) {
		return delete("CmntUserDAO_deleteCmntUser", paramVO);
	}

	/**
	 * 커뮤니티 회원 승인
	 * @param paramVO
	 * @return
	 */
	public int apprvlCmntUser(CmntUserVO paramVO) {
		return update("CmntUserDAO_apprvlCmntUser", paramVO);
	}
	
	public int selectCmntUserTotCnt(CmntUserVO paramVO) {
		return ((Integer)selectOne("CmntUserDAO_selectCmntUserTotCnt", paramVO)).intValue();
	}
	
	public int registCmntConn(CmntUserVO paramVO) {
		return update("CmntUserDAO_registCmntConn", paramVO);
	}
	
 
	public  CmntUserVO selectCmntUser(CmntUserVO paramVO) {
		return (CmntUserVO) selectOne("CmntUserDAO_selectCmntUser",paramVO);
	}
	
	public int selectCmntUserChk(CmntUserVO paramVO) {
		return ((Integer)selectOne("CmntUserDAO_selectCmntUserChk", paramVO)).intValue();
	}
}

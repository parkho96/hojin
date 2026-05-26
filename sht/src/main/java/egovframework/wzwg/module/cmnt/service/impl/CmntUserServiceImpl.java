package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.cmnt.service.CmntUserService;
import egovframework.wzwg.module.cmnt.service.CmntUserVO;

@Service("CmntUserService")
public class CmntUserServiceImpl extends EgovAbstractServiceImpl implements CmntUserService {
	@Resource(name="CmntUserDAO")
	CmntUserDAO cmntUserDAO;
	/**
	 * 커뮤니티 회원 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntUserVO> selectCmntUserList(CmntUserVO paramVO) {
		return cmntUserDAO.selectCmntUserList(paramVO);
	}
 
	 
	/**
	 * 커뮤니티 회원 가입
	 * @param paramVO
	 * @return
	 */
	public void registCmntUser(CmntUserVO paramVO) {
		cmntUserDAO.registCmntUser(paramVO);
	}

	/**
	 * 커뮤니티 회원 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntUser(CmntUserVO paramVO) {
		return cmntUserDAO.deleteCmntUser(paramVO);
	}

	/**
	 * 커뮤니티 회원 승인
	 * @param paramVO
	 * @return
	 */
	public int apprvlCmntUser(CmntUserVO paramVO) {
		return cmntUserDAO.apprvlCmntUser(paramVO);
	}
	
	public int selectCmntUserTotCnt(CmntUserVO paramVO) {
		return cmntUserDAO.selectCmntUserTotCnt(paramVO);
	}
 
	public int registCmntConn(CmntUserVO paramVO) {
		return cmntUserDAO.registCmntConn(paramVO);
	}
	
	public  CmntUserVO selectCmntUser(CmntUserVO paramVO) {
		return  cmntUserDAO.selectCmntUser(paramVO);
	}
	
	public int selectCmntUserChk(CmntUserVO paramVO) {
		return cmntUserDAO.selectCmntUserChk(paramVO);
	}
}

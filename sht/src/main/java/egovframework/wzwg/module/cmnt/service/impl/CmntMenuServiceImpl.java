package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.cmnt.service.CmntMenuService;
import egovframework.wzwg.module.cmnt.service.CmntMenuVO;

@Service("CmntMenuService")
public class CmntMenuServiceImpl extends EgovAbstractServiceImpl implements CmntMenuService {
	@Resource(name="CmntMenuDAO")
	CmntMenuDAO cmntMenuDAO;
	/**
	 * 커뮤니티 메뉴 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuVO> selectCmntMenuList(CmntMenuVO paramVO) {
		return cmntMenuDAO.selectCmntMenuList(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public CmntMenuVO selectCmntMenuDetail(CmntMenuVO paramVO) {
		return cmntMenuDAO.selectCmntMenuDetail(paramVO) ;
	}
	
	/**
	 * 커뮤니티 메뉴 시퀀스 조회
	 * @return
	 */
	public String selectCmntMenuSeq() {
		return cmntMenuDAO.selectCmntMenuSeq();
	}

	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void  registCmntMenu(CmntMenuVO paramVO) {
		cmntMenuDAO.registCmntMenu(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenu(CmntMenuVO paramVO) {
		return cmntMenuDAO.deleteCmntMenu(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenu(CmntMenuVO paramVO) {
		return cmntMenuDAO.modifyCmntMenu(paramVO);
	}
	
	public int selectCmntMenuTotCnt(CmntMenuVO paramVO) {
		return cmntMenuDAO.selectCmntMenuTotCnt(paramVO) ;
	}
	
	public int modifyCmntMenuOrd(CmntMenuVO paramVO) {
		return cmntMenuDAO.modifyCmntMenuOrd(paramVO);
	}
}

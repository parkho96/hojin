package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;

@Service("CmntMenuAuthService")
public class CmntMenuAuthServiceImpl extends EgovAbstractServiceImpl implements CmntMenuAuthService {
	@Resource(name="CmntMenuAuthDAO")
	CmntMenuAuthDAO cmntMenuAuthDAO;
	/**
	 * 커뮤니티 메뉴 권한 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthList(CmntMenuAuthVO paramVO) {
		return cmntMenuAuthDAO.selectCmntMenuAuthList(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthDetail(CmntMenuAuthVO paramVO) {
		return cmntMenuAuthDAO.selectCmntMenuAuthDetail(paramVO);
	}
	
	 
	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void registCmntMenuAuth(CmntMenuAuthVO paramVO) {
		cmntMenuAuthDAO.registCmntMenuAuth(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenuAuth(CmntMenuAuthVO paramVO) {
		return cmntMenuAuthDAO.deleteCmntMenuAuth(paramVO);
	}

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenuAuth(CmntMenuAuthVO paramVO) {
		return cmntMenuAuthDAO.modifyCmntMenuAuth(paramVO);
	}
	
	/**
     * @param paramVO
     * @return
     */
    public List<CmntMenuAuthVO> selectCmntMenuAuthForBbsSeqDetail(CmntMenuAuthVO paramVO) {
        return cmntMenuAuthDAO.selectCmntMenuAuthForBbsSeqDetail(paramVO);
    }
}

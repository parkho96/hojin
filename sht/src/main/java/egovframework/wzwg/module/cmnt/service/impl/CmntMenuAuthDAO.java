package egovframework.wzwg.module.cmnt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;


@Repository("CmntMenuAuthDAO")
public class CmntMenuAuthDAO extends EgovAbstractMapper{

	/**
	 * 커뮤니티 메뉴 데이터 리스트
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthList(CmntMenuAuthVO paramVO) {
		return selectList("CmntMenuAuthDAO_selectCmntMenuAuthList",paramVO);
	}

	/**
	 * 커뮤니티 메뉴 상세조회
	 * @param paramVO
	 * @return
	 */
	public List<CmntMenuAuthVO> selectCmntMenuAuthDetail(CmntMenuAuthVO paramVO) {
		return selectList("CmntMenuAuthDAO_selectCmntMenuAuthDetail", paramVO);
	}
	
	 
	/**
	 * 커뮤니티 메뉴 등록
	 * @param paramVO
	 * @return
	 */
	public void registCmntMenuAuth(CmntMenuAuthVO paramVO) {
		 insert("CmntMenuAuthDAO_registCmntMenuAuth", paramVO);
	}

	/**
	 * 커뮤니티 메뉴 삭제
	 * @param paramVO
	 * @return
	 */
	public int deleteCmntMenuAuth(CmntMenuAuthVO paramVO) {
		return delete("CmntMenuAuthDAO_deleteCmntMenuAuth", paramVO);
	}

	/**
	 * 커뮤니티 메뉴 수정
	 * @param paramVO
	 * @return
	 */
	public int modifyCmntMenuAuth(CmntMenuAuthVO paramVO) {
		return update("CmntMenuAuthDAO_modifyCmntMenuAuth", paramVO);
	}
	
	/**
     * @param paramVO
     * @return
     */
    public List<CmntMenuAuthVO> selectCmntMenuAuthForBbsSeqDetail(CmntMenuAuthVO paramVO) {
        return selectList("CmntMenuAuthDAO_selectCmntMenuAuthForBbsSeqDetail", paramVO);
    }
 

}

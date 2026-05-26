package egovframework.wzwg.module.ntt.simp.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpVO;


@Repository("ModuleNttSimpDataManageDAO")

public class ModuleNttSimpDataManageDAO extends EgovAbstractMapper {

	/**
	 * ㅁ 간단게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpList(ModuleNttSimpVO nttSimpVO) throws Exception {
		return selectList("ModuleNttSimpDataManageDAO_selectNttSimpList_S", nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttSimpNtcrId(ModuleNttSimpVO nttSimpVO) throws Exception {
		return (String) selectOne("ModuleNttSimpDataManageDAO_selectNttSimpNtcrId_S", nttSimpVO);
	}	

	/**
	 * ㅁ 간단게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return update("ModuleNttSimpDataManageDAO_registNttSimpInfo_I", nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return update("ModuleNttSimpDataManageDAO_modifyNttSimpInfo_I", nttSimpVO);
	}
	
	/**
	 * ㅁ 간단게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception {
		return delete("ModuleNttSimpDataManageDAO_deleteNttSimpInfo_I", nttSimpVO);
	}
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpRecycleList(ModuleNttSimpVO nttSimpVO) throws Exception {
		return selectList("ModuleNttSimpDataManageDAO_selectNttSimpRecycleList_S", nttSimpVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpRecycleListTotCnt(ModuleNttSimpVO nttSimpVO) throws Exception {
		return (Integer) selectOne("ModuleNttSimpDataManageDAO_selectNttSimpRecycleListTotCnt_S", nttSimpVO);
	}	

	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttSimpRecycle(ModuleNttSimpVO nttSimpVO) throws Exception {
		return update("ModuleNttSimpDataManageDAO_modifyNttSimpRecycle_U", nttSimpVO);
	}
	
	/**
	 * 휴지통 - 간단게시판 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNttAnswer(ModuleNttSimpVO nttSimpVO) throws Exception {	
		return update("ModuleNttSimpDataManageDAO_deleteSiteSimpNttAnswer", nttSimpVO);
	}	
	    
	/**
	 * 휴지통 - 간단게시판 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNtt(ModuleNttSimpVO nttSimpVO) throws Exception {	
		return update("ModuleNttSimpDataManageDAO_deleteSiteSimpNtt", nttSimpVO);
	}	
}

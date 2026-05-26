package egovframework.wzwg.module.ntt.simp.answer.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.simp.answer.service.ModuleNttSimpAnswerVO;


@Repository("ModuleNttSimpAnswerDAO")

public class ModuleNttSimpAnswerDAO extends EgovAbstractMapper {


	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpAnswerVO> selectNttSimpAnswerList(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return selectList("ModuleNttSimpAnswerDAO_selectNttSimpAnswerList_S", nttSimpAnswerVO);
	}

	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpAnswerListTotCnt(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return (Integer) selectOne("ModuleNttSimpAnswerDAO_selectNttSimpAnswerListTotCnt_S", nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSimpAnswerVO selectNttSimpAnswerDetail(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return (ModuleNttSimpAnswerVO) selectOne("ModuleNttSimpAnswerDAO_selectNttSimpAnswerDetail_S", nttSimpAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return update("ModuleNttSimpAnswerDAO_registNttSimpAnswer_I", nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return update("ModuleNttSimpAnswerDAO_modifyNttSimpAnswer_U", nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return delete("ModuleNttSimpAnswerDAO_deleteNttSimpAnswer_D", nttSimpAnswerVO);
	}
	
}

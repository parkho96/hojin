package egovframework.wzwg.module.ntt.module.answer.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;


@Repository("ModuleNttAnswerDAO")

public class ModuleNttAnswerDAO extends EgovAbstractMapper {


	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return selectList("ModuleNttAnswerDAO_selectNttAnswerList_S", nttAnswerVO);
	}

	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return (Integer) selectOne("ModuleNttAnswerDAO_selectNttAnswerListTotCnt_S", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return (ModuleNttAnswerVO) selectOne("ModuleNttAnswerDAO_selectNttAnswerDetail_S", nttAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return update("ModuleNttAnswerDAO_registNttAnswer_I", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return update("ModuleNttAnswerDAO_modifyNttAnswer_U", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return delete("ModuleNttAnswerDAO_deleteNttAnswer_D", nttAnswerVO);
	}
	
}

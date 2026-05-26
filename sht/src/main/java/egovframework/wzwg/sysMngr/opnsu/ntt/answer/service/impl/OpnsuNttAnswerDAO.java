package egovframework.wzwg.sysMngr.opnsu.ntt.answer.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.ntt.answer.service.OpnsuNttAnswerVO;



@Repository("OpnsuNttAnswerDAO")

public class OpnsuNttAnswerDAO extends EgovAbstractMapper {


	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttAnswerVO> selectNttAnswerList(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return selectList("OpnsuNttAnswerDAO_selectNttAnswerList_S", nttAnswerVO);
	}

	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return (Integer) selectOne("OpnsuNttAnswerDAO_selectNttAnswerListTotCnt_S", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttAnswerVO selectNttAnswerDetail(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return (OpnsuNttAnswerVO) selectOne("OpnsuNttAnswerDAO_selectNttAnswerDetail_S", nttAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return update("OpnsuNttAnswerDAO_registNttAnswer_I", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return update("OpnsuNttAnswerDAO_modifyNttAnswer_U", nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return delete("OpnsuNttAnswerDAO_deleteNttAnswer_D", nttAnswerVO);
	}
	
}

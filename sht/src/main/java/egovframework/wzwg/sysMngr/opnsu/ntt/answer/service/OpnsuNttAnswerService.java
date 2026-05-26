package egovframework.wzwg.sysMngr.opnsu.ntt.answer.service;

import java.util.List;

public interface OpnsuNttAnswerService {

	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttAnswerVO> selectNttAnswerList(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttAnswerVO selectNttAnswerDetail(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception;
	
	
}

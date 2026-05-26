package egovframework.wzwg.module.ntt.simp.answer.service;

import java.util.List;

public interface ModuleNttSimpAnswerService {

	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpAnswerVO> selectNttSimpAnswerList(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpAnswerListTotCnt(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSimpAnswerVO selectNttSimpAnswerDetail(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception;
	
	
}

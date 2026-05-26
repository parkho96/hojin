package egovframework.wzwg.module.ntt.module.answer.service;

import java.util.List;

public interface ModuleNttAnswerService {

	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception;
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	
}

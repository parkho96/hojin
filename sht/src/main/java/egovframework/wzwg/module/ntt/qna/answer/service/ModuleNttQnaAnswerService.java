package egovframework.wzwg.module.ntt.qna.answer.service;

import java.util.List;

import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;

public interface ModuleNttQnaAnswerService {

	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttQnaAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttQnaAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttQnaAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception;
    
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception;
	
	
}

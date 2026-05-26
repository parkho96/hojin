package egovframework.wzwg.module.ntt.qna.service;

import java.util.List;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;

public interface ModuleNttQnaReplyService {

	
	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttReplyList(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(ModuleNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectNttReplyChoice(ModuleNttVO nttVO) throws Exception;
	
}

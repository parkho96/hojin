package egovframework.wzwg.sysMngr.opnsu.ntt.service;

import java.util.List;

public interface OpnsuNttQnaReplyService {

	
	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttReplyList(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttReplyChoice(OpnsuNttVO nttVO) throws Exception;
	
}

package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;


@Repository("OpnsuNttQnaReplyDAO")

public class OpnsuNttQnaReplyDAO extends EgovAbstractMapper {


	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(OpnsuNttVO nttVO) throws Exception {
		return (String) selectOne("OpnsuNttQnaReplyDAO_selectNttReplyChoiceAt_S", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttReplyList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttQnaReplyDAO_selectNttReplyList_S", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return (Integer) selectOne("OpnsuNttQnaReplyDAO_selectNttReplyListTotCnt_S", nttVO);
	}

	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(OpnsuNttVO nttVO) throws Exception {
		return update("OpnsuNttQnaReplyDAO_modifyNttReply_U", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(OpnsuNttVO nttVO) throws Exception {
		return update("OpnsuNttQnaReplyDAO_registNttReplyChoice_I", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttReplyChoice(OpnsuNttVO nttVO) throws Exception {
		return (OpnsuNttVO) selectOne("OpnsuNttQnaReplyDAO_selectNttReplyChoice_S", nttVO);
	}
	
	
}

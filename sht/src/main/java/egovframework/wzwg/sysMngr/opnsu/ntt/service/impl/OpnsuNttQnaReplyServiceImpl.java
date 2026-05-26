package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaReplyService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Service("OpnsuNttQnaReplyService")
public class OpnsuNttQnaReplyServiceImpl extends EgovAbstractServiceImpl implements OpnsuNttQnaReplyService {
	
	@Resource(name="OpnsuNttQnaReplyDAO")
    protected OpnsuNttQnaReplyDAO nttQnaReplyDAO;
	
	
	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyChoiceAt(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttReplyList(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyList(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyListTotCnt(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.modifyNttReply(nttVO);
	}
    
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.registNttReplyChoice(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttReplyChoice(OpnsuNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyChoice(nttVO);
	}
	
}

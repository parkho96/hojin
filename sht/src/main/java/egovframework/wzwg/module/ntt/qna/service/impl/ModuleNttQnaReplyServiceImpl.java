package egovframework.wzwg.module.ntt.qna.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.qna.service.ModuleNttQnaReplyService;



@Service("ModuleNttQnaReplyService")
public class ModuleNttQnaReplyServiceImpl extends EgovAbstractServiceImpl implements ModuleNttQnaReplyService {
	
	@Resource(name="ModuleNttQnaReplyDAO")
    protected ModuleNttQnaReplyDAO nttQnaReplyDAO;
	
	
	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyChoiceAt(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttReplyList(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyList(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyListTotCnt(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.modifyNttReply(nttVO);
	}
    
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.registNttReplyChoice(nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectNttReplyChoice(ModuleNttVO nttVO) throws Exception {
		return nttQnaReplyDAO.selectNttReplyChoice(nttVO);
	}
	
}

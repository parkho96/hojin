package egovframework.wzwg.module.ntt.qna.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;


@Repository("ModuleNttQnaReplyDAO")

public class ModuleNttQnaReplyDAO extends EgovAbstractMapper {


	/**
	 * ㅁ 질의응답게시물 답변채택 여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttReplyChoiceAt(ModuleNttVO nttVO) throws Exception {
		return (String) selectOne("ModuleNttQnaReplyDAO_selectNttReplyChoiceAt_S", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttReplyList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttQnaReplyDAO_selectNttReplyList_S", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttReplyListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttQnaReplyDAO_selectNttReplyListTotCnt_S", nttVO);
	}

	/**
	 * ㅁ 질의응답게시물 답변 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttReply(ModuleNttVO nttVO) throws Exception {
		return update("ModuleNttQnaReplyDAO_modifyNttReply_U", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttReplyChoice(ModuleNttVO nttVO) throws Exception {
		return update("ModuleNttQnaReplyDAO_registNttReplyChoice_I", nttVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변채택 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttVO selectNttReplyChoice(ModuleNttVO nttVO) throws Exception {
		return (ModuleNttVO) selectOne("ModuleNttQnaReplyDAO_selectNttReplyChoice_S", nttVO);
	}
	
	
}

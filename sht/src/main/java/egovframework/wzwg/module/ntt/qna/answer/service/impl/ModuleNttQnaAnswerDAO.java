package egovframework.wzwg.module.ntt.qna.answer.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;


@Repository("ModuleNttQnaAnswerDAO")

public class ModuleNttQnaAnswerDAO extends EgovAbstractMapper {

	
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttQnaAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return selectList("ModuleNttQnaAnswerDAO_selectNttQnaAnswerList_S", nttAnswerVO);
	}

	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttQnaAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return (Integer) selectOne("ModuleNttQnaAnswerDAO_selectNttQnaAnswerListTotCnt_S", nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttQnaAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return (ModuleNttAnswerVO) selectOne("ModuleNttQnaAnswerDAO_selectNttQnaAnswerDetail_S", nttAnswerVO);
	}
    
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return update("ModuleNttQnaAnswerDAO_registNttQnaAnswer_I", nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return update("ModuleNttQnaAnswerDAO_modifyNttQnaAnswer_U", nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return delete("ModuleNttQnaAnswerDAO_deleteNttQnaAnswer_D", nttAnswerVO);
	}
	
}

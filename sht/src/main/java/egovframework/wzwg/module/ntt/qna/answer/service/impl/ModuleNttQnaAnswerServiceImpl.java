package egovframework.wzwg.module.ntt.qna.answer.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.qna.answer.service.ModuleNttQnaAnswerService;



@Service("ModuleNttQnaAnswerService")
public class ModuleNttQnaAnswerServiceImpl extends EgovAbstractServiceImpl implements ModuleNttQnaAnswerService {

	
	@Resource(name="ModuleNttQnaAnswerDAO")
    protected ModuleNttQnaAnswerDAO nttQnaAnswerDAO;
	
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttQnaAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.selectNttQnaAnswerList(nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttQnaAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.selectNttQnaAnswerListTotCnt(nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttQnaAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.selectNttQnaAnswerDetail(nttAnswerVO);
	}
    
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.registNttQnaAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.modifyNttQnaAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttQnaAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttQnaAnswerDAO.deleteNttQnaAnswer(nttAnswerVO);
	}
	
}

package egovframework.wzwg.module.ntt.simp.answer.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.simp.answer.service.ModuleNttSimpAnswerService;
import egovframework.wzwg.module.ntt.simp.answer.service.ModuleNttSimpAnswerVO;



@Service("ModuleNttSimpAnswerService")
public class ModuleNttSimpAnswerServiceImpl extends EgovAbstractServiceImpl implements ModuleNttSimpAnswerService {

	
	@Resource(name="ModuleNttSimpAnswerDAO")
    protected ModuleNttSimpAnswerDAO nttSimpAnswerDAO;
	
	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpAnswerVO> selectNttSimpAnswerList(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.selectNttSimpAnswerList(nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpAnswerListTotCnt(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.selectNttSimpAnswerListTotCnt(nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSimpAnswerVO selectNttSimpAnswerDetail(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.selectNttSimpAnswerDetail(nttSimpAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.registNttSimpAnswer(nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.modifyNttSimpAnswer(nttSimpAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpAnswer(ModuleNttSimpAnswerVO nttSimpAnswerVO) throws Exception {
		return nttSimpAnswerDAO.deleteNttSimpAnswer(nttSimpAnswerVO);
	}
	
	
}

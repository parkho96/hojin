package egovframework.wzwg.module.ntt.module.answer.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerService;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;



@Service("ModuleNttAnswerService")
public class ModuleNttAnswerServiceImpl extends EgovAbstractServiceImpl implements ModuleNttAnswerService {

	
	@Resource(name="ModuleNttAnswerDAO")
    protected ModuleNttAnswerDAO nttAnswerDAO;
	
	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttAnswerVO> selectNttAnswerList(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerList(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerListTotCnt(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttAnswerVO selectNttAnswerDetail(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerDetail(nttAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.registNttAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.modifyNttAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(ModuleNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.deleteNttAnswer(nttAnswerVO);
	}
	
	
}

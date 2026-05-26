package egovframework.wzwg.sysMngr.opnsu.ntt.answer.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.opnsu.ntt.answer.service.OpnsuNttAnswerService;
import egovframework.wzwg.sysMngr.opnsu.ntt.answer.service.OpnsuNttAnswerVO;




@Service("OpnsuNttAnswerService")
public class OpnsuNttAnswerServiceImpl extends EgovAbstractServiceImpl implements OpnsuNttAnswerService {

	
	@Resource(name="OpnsuNttAnswerDAO")
    protected OpnsuNttAnswerDAO nttAnswerDAO;
	
	
	/**
	 * ㅁ 게시물 댓글 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttAnswerVO> selectNttAnswerList(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerList(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttAnswerListTotCnt(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerListTotCnt(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttAnswerVO selectNttAnswerDetail(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.selectNttAnswerDetail(nttAnswerVO);
	}
    
	/**
	 * ㅁ 게시물 댓글 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.registNttAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.modifyNttAnswer(nttAnswerVO);
	}
	
	/**
	 * ㅁ 게시물 댓글 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttAnswer(OpnsuNttAnswerVO nttAnswerVO) throws Exception {
		return nttAnswerDAO.deleteNttAnswer(nttAnswerVO);
	}
	
	
}

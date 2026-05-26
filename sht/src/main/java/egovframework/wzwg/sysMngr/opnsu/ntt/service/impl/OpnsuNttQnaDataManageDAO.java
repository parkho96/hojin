package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Repository("OpnsuNttQnaDataManageDAO")

public class OpnsuNttQnaDataManageDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 상단걸기 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttNoticeList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttQnaDataManageDAO_selectNttNoticeList_S", nttVO);
	}
	
	/**
	 * ㅁ 상단걸기 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(OpnsuNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("OpnsuNttQnaDataManageDAO_modifyNttNoticeAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("OpnsuNttQnaDataManageDAO_modifyNttNotice_U", nttVO);
	}
	
	/**
	 * ㅁ 자주묻는질문 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttFaq(OpnsuNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("OpnsuNttQnaDataManageDAO_modifyNttFaqAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("OpnsuNttQnaDataManageDAO_modifyNttFaq_U", nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttQnaDataManageDAO_selectNttList_S", nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return (Integer) selectOne("OpnsuNttQnaDataManageDAO_selectNttListTotCnt_S", nttVO);
	}

	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttScrinCntnts(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttQnaDataManageDAO_selectNttScrinCntnts_S", nttVO);
	}
	
}

package egovframework.wzwg.module.ntt.qna.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;


@Repository("ModuleNttQnaDataManageDAO")

public class ModuleNttQnaDataManageDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 상단걸기 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttNoticeList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttQnaDataManageDAO_selectNttNoticeList_S", nttVO);
	}
	
	/**
	 * ㅁ 상단걸기 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(ModuleNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("ModuleNttQnaDataManageDAO_modifyNttNoticeAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("ModuleNttQnaDataManageDAO_modifyNttNotice_U", nttVO);
	}
	
	/**
	 * ㅁ 자주묻는질문 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttFaq(ModuleNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("ModuleNttQnaDataManageDAO_modifyNttFaqAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("ModuleNttQnaDataManageDAO_modifyNttFaq_U", nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttQnaDataManageDAO_selectNttList_S", nttVO);
	}
	
	/**
	 * ㅁ 게시판 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttQnaDataManageDAO_selectNttListTotCnt_S", nttVO);
	}

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttQnaDataManageDAO_selectNttRecycleList_S", nttVO);
	}
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttQnaDataManageDAO_selectNttRecycleListTotCnt_S", nttVO);
	}
	
}

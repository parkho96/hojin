package egovframework.wzwg.sysMngr.opnsu.ntt.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Repository("OpnsuNttUnityDataManageDAO")

public class OpnsuNttUnityDataManageDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 공지 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttNoticeList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttUnityDataManageDAO_selectNttNoticeList_S", nttVO);
	}
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(OpnsuNttVO nttVO) throws Exception {
		
		// 공지게시물 부가정보 수정
		update("OpnsuNttUnityDataManageDAO_modifyNttNoticeAdi_U", nttVO);
		
		// 공지게시물 기본정보 수정
		return update("OpnsuNttUnityDataManageDAO_modifyNttNotice_U", nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttList(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttUnityDataManageDAO_selectNttList_S", nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttScrinCntnts(OpnsuNttVO nttVO) throws Exception {
		return selectList("OpnsuNttUnityDataManageDAO_selectNttScrinCntnts_S", nttVO);
	}

	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(OpnsuNttVO nttVO) throws Exception {
		return (Integer) selectOne("OpnsuNttUnityDataManageDAO_selectNttListTotCnt_S", nttVO);
	}

	
}

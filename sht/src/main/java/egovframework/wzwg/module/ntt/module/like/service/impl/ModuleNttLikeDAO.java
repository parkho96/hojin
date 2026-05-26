package egovframework.wzwg.module.ntt.module.like.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.module.like.service.ModuleNttLikeVO;


@Repository("ModuleNttLikeDAO")

public class ModuleNttLikeDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시물 좋아요 등록여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeAt(ModuleNttLikeVO nttLikeVO) throws Exception {
		return (Integer) selectOne("ModuleNttLikeDAO_selectNttLikeAt_S", nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttLike(ModuleNttLikeVO nttLikeVO) throws Exception {
		return update("ModuleNttLikeDAO_registNttLike_I", nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 취소
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttLike(ModuleNttLikeVO nttLikeVO) throws Exception {
		return delete("ModuleNttLikeDAO_deleteNttLike_D", nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLikeVO> selectNttLikeList(ModuleNttLikeVO nttLikeVO) throws Exception {
		return selectList("ModuleNttLikeDAO_selectNttLikeList_S", nttLikeVO);
	}

	/**
	 * ㅁ 게시물 좋아요 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeListTotCnt(ModuleNttLikeVO nttLikeVO) throws Exception {
		return (Integer) selectOne("ModuleNttLikeDAO_selectNttLikeListTotCnt_S", nttLikeVO);
	}
   	
}

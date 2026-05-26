package egovframework.wzwg.module.ntt.module.like.service;

import java.util.List;


public interface ModuleNttLikeService {


	/**
	 * ㅁ 게시물 좋아요 등록여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeAt(ModuleNttLikeVO nttLikeVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttLike(ModuleNttLikeVO nttLikeVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요 취소
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttLike(ModuleNttLikeVO nttLikeVO) throws Exception;
	
	/**
	 * ㅁ 게시물 좋아요 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLikeVO> selectNttLikeList(ModuleNttLikeVO nttLikeVO) throws Exception;

	/**
	 * ㅁ 게시물 좋아요 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeListTotCnt(ModuleNttLikeVO nttLikeVO) throws Exception;
	
}

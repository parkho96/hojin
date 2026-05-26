package egovframework.wzwg.module.ntt.module.like.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.module.like.service.ModuleNttLikeService;
import egovframework.wzwg.module.ntt.module.like.service.ModuleNttLikeVO;



@Service("ModuleNttLikeService")
public class ModuleNttLikeServiceImpl extends EgovAbstractServiceImpl implements ModuleNttLikeService {

	
	@Resource(name="ModuleNttLikeDAO")
    protected ModuleNttLikeDAO nttLikeDAO;
	
	
	
	/**
	 * ㅁ 게시물 좋아요 등록여부
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeAt(ModuleNttLikeVO nttLikeVO) throws Exception {
		return nttLikeDAO.selectNttLikeAt(nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttLike(ModuleNttLikeVO nttLikeVO) throws Exception {
		return nttLikeDAO.registNttLike(nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 취소
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttLike(ModuleNttLikeVO nttLikeVO) throws Exception {
		return nttLikeDAO.deleteNttLike(nttLikeVO);
	}
	
	/**
	 * ㅁ 게시물 좋아요 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLikeVO> selectNttLikeList(ModuleNttLikeVO nttLikeVO) throws Exception {
		return nttLikeDAO.selectNttLikeList(nttLikeVO);
	}

	/**
	 * ㅁ 게시물 좋아요 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLikeListTotCnt(ModuleNttLikeVO nttLikeVO) throws Exception {
		return nttLikeDAO.selectNttLikeListTotCnt(nttLikeVO);
	}
	
	
}

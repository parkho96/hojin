package egovframework.wzwg.module.ntt.image.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;

@Repository("ModuleNttImageDataManageDAO")

public class ModuleNttImageDataManageDAO extends EgovAbstractMapper{
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttImageDataManageDAO_selectNttList_S", nttVO);
	}
	
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttScrinCntnts(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttImageDataManageDAO_selectNttScrinCntnts", nttVO);
	}
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttImageDataManageDAO_selectNttListTotCnt_S", nttVO);
	}

	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttVO> selectNttRecycleList(ModuleNttVO nttVO) throws Exception {
		return selectList("ModuleNttImageDataManageDAO_selectNttRecycleList_S", nttVO);
	}	
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttRecycleListTotCnt(ModuleNttVO nttVO) throws Exception {
		return (Integer) selectOne("ModuleNttImageDataManageDAO_selectNttRecycleListTotCnt_S", nttVO);
	}	
}

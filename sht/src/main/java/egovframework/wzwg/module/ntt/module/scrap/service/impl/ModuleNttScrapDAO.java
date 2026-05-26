package egovframework.wzwg.module.ntt.module.scrap.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;


@Repository("ModuleNttScrapDAO")

public class ModuleNttScrapDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 게시물  스크랩 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttScrapVO> selectNttScrapgroupList(ModuleNttScrapVO vo) throws Exception {
		return selectList("ModuleNttScrapDAO_selectNttScrapgroupList_S", vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹명 중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapgroupDplctChk(ModuleNttScrapVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttScrapDAO_selectNttScrapgroupDplctChk_S", vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapgroupSeq() throws Exception {
		return (String) selectOne("ModuleNttScrapDAO_selectNextNttScrapgroupSeq_S", new String());
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrapgroup(ModuleNttScrapVO vo) throws Exception {
		return update("ModuleNttScrapDAO_registNttScrapgroup_I", vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 그룹 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttScrapgroup(ModuleNttScrapVO vo) {
		return update("ModuleNttScrapDAO_deleteNttScrapgroup_I",vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩  중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapDplctChk(ModuleNttScrapVO vo) throws Exception {
		return (Integer) selectOne("ModuleNttScrapDAO_selectNttScrapDplctChk_S", vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapSeq() throws Exception {
		return (String) selectOne("ModuleNttScrapDAO_selectNextNttScrapSeq_S", new String());
	}
	
	/**
	 * ㅁ 게시물  스크랩
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrap(ModuleNttScrapVO vo) throws Exception {
		return update("ModuleNttScrapDAO_registNttScrap_I", vo);
	}
	
	/**
	 * ㅁ 게시물  스크랩 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttScrap(ModuleNttScrapVO vo) throws Exception {
		return delete("ModuleNttScrapDAO_deleteNttScrap_I",vo);
	}

	/**
	 * ㅁ 게시물 스크랩 삭제 SEQ
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttScrapSeq(ModuleNttVO vo) {
		return (String)selectOne("ModuleNttScrapDAO_selectNttScrapSeq",vo);
	}

	
}

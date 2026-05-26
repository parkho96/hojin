package egovframework.wzwg.module.ntt.module.scrap.service;

import java.util.List;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;

public interface ModuleNttScrapService {

	
	/**
	 * ㅁ 게시물  스크랩 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttScrapVO> selectNttScrapgroupList(ModuleNttScrapVO vo) throws Exception;

	/**
	 * ㅁ 게시물  스크랩 그룹명 중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapgroupDplctChk(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물  스크랩 그룹 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapgroupSeq() throws Exception;
	
	/**
	 * ㅁ 게시물  스크랩 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrapgroup(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 스크랩 그룹 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteNttScrapgroup(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물  스크랩  중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttScrapDplctChk(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 스크랩SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttScrapSeq() throws Exception;
	
	/**
	 * ㅁ 게시물 스크랩
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttScrap(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 스크랩 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttScrap(ModuleNttScrapVO vo) throws Exception;

	/**
	 * ㅁ 게시물 스크랩 선택 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteCheckNttScrap(ModuleNttScrapVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 스크랩 Seq 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttScrapSeq(ModuleNttVO vo) throws Exception;
	
	
}

package egovframework.wzwg.module.ntt.module.tag.service;

import java.util.List;


public interface ModuleNttTagService {


	/**
	 * ㅁ 태그SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttTagSeq() throws Exception;
	
	/**
	 * ㅁ 태그등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttTag(ModuleNttTagVO tagVO) throws Exception;
	
	/**
	 * ㅁ 태그수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttTag(ModuleNttTagVO tagVO) throws Exception;
	
	/**
	 * ㅁ 게시물 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttTagList(ModuleNttTagVO tagVO) throws Exception;

	/**
	 * ㅁ 게시물 나의 태그 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttTagVO> selectNttUsrTagList(ModuleNttTagVO tagVO) throws Exception;
	
}

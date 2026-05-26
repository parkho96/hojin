package egovframework.wzwg.module.ntt.simp.service;

import java.util.List;

public interface ModuleNttSimpDataManageService {


	/**
	 * ㅁ 간단게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpList(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 간단게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttSimpNtcrId(ModuleNttSimpVO nttSimpVO) throws Exception;

	/**
	 * ㅁ 간단게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 간단게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 간단게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 간단게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteCheckNttSimpInfo(ModuleNttSimpVO nttSimpVO) throws Exception;	
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttSimpVO> selectNttSimpScrinCntnts(ModuleNttSimpVO nttVO) throws Exception;	
    
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSimpVO> selectNttSimpRecycleList(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttSimpRecycleListTotCnt(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttSimpRecycle(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttSimpRecycle(ModuleNttSimpVO nttSimpVO) throws Exception;
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNtt(ModuleNttSimpVO nttSimpVO) throws Exception;	
	
}

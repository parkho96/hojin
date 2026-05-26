package egovframework.wzwg.module.ntt.link.service;

import java.util.List;

public interface ModuleNttLinkDataManageService {

	
	/**
	 * ㅁ 링크게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextLinknttSeq(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkList(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkListTotCnt(ModuleNttLinkVO vo) throws Exception;

	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttLinkVO selectNttLinkDetail(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttLinkInfo(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkInfo(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttLinkInfo(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttLinkInfo(ModuleNttLinkVO vo) throws Exception;
	
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttLinkVO> selectNttLinkScrinCntnts(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttLinkVO> selectNttLinkRecycleList(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttLinkRecycleListTotCnt(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttLinkRecycle(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 복원)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttLinkRecycle(ModuleNttLinkVO vo) throws Exception;
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttLink(ModuleNttLinkVO vo) throws Exception;
	
}

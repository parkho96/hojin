package egovframework.wzwg.module.ntt.mvp.service;

import java.util.List;

public interface ModuleNttMvpDataManageService {

	
	/**
	 * ㅁ 동영상게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextMvpnttSeq(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpList(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpListTotCnt(ModuleNttMvpVO vo) throws Exception;

	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttMvpInqireCnt(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttMvpVO selectNttMvpDetail(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttMvpInfo(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpInfo(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttMvpInfo(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttMvpInfo(ModuleNttMvpVO vo) throws Exception;
	
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<ModuleNttMvpVO> selectNttMvpScrinCntnts(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttMvpVO> selectNttMvpRecycleList(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttMvpRecycleListTotCnt(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ 휴지통 복원
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttMvpRecycle(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * ㅁ  휴지통 복원 (체크박스 선택 목록 복원)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyCheckNttMvpRecycle(ModuleNttMvpVO vo) throws Exception;
	
	/**
	 * 휴지통 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public Integer deleteSiteNttMvp(ModuleNttMvpVO vo) throws Exception;
	
}

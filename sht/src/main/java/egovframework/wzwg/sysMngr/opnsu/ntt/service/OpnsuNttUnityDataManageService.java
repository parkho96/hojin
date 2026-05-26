package egovframework.wzwg.sysMngr.opnsu.ntt.service;

import java.util.List;



public interface OpnsuNttUnityDataManageService {


	/**
	 * ㅁ 공지게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttNoticeList(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 공지 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttNotice(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttList(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 목록 총 갯수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectNttListTotCnt(OpnsuNttVO nttVO) throws Exception;
    
    /**
     * ㅁ 게시물 목록 - 화면
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<OpnsuNttVO> selectNttScrinCntnts(OpnsuNttVO nttVO) throws Exception;

}

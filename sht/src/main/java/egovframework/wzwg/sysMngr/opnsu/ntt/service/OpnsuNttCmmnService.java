package egovframework.wzwg.sysMngr.opnsu.ntt.service;

import java.util.List;


public interface OpnsuNttCmmnService {


	/**
	 * ㅁ 조회수 증가
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void modifyNttInqireCnt(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuNttVO selectNttDetail(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 작성자
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttNtcrId(OpnsuNttVO nttVO) throws Exception;	
	
	/**
	 * ㅁ 글양식 내용 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNttFormCn(String bbsSeq) throws Exception;
	
	/**
	 * ㅁ 게시물SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSeq(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttInfo(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer modifyNttInfo(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteNttInfo(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 삭제 (체크박스 선택 목록 삭제)
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer deleteCheckNttInfo(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyCheckNttSubospec(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 이동 - 게시판 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuNttVO> selectNttMvmnBbsList(OpnsuNttVO nttVO) throws Exception;
	
	/**
	 * ㅁ 게시물 이동
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer mvmnNtt(OpnsuNttVO nttVO) throws Exception;
	
}

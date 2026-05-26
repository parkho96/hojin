package egovframework.wzwg.sysMngr.opnsu.bbs.service;

import java.util.List;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface OpnsuBbsCmmnService {

	
	/**
	 * ㅁ 컨텐츠관리 - 게시판 모듈 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<CntntsInfoVO> selectBbsList(String siteSeq) throws Exception;
	
	/**
	 * ㅁ 글양식 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuBbsVO> selectBbsFormList(String siteSeq) throws Exception;
	
	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<OpnsuBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception;
	
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(OpnsuBbsVO bbsVO) throws Exception;
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(OpnsuBbsVO bbsVO) throws Exception;
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(OpnsuBbsVO bbsVO) throws Exception;

}

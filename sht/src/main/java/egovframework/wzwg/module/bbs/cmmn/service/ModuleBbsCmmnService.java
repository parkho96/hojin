package egovframework.wzwg.module.bbs.cmmn.service;

import java.util.List;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

public interface ModuleBbsCmmnService {

	
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
	public List<ModuleBbsVO> selectBbsFormList(String siteSeq) throws Exception;
	
	/**
	 * ㅁ 말머리 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleBbsVO> selectBbsSubospecList(String bbsSeq) throws Exception;
	
	/**
	 * ㅁ 말머리 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception;
	
	/**
	 * ㅁ 말머리 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception;
	
	/**
	 * ㅁ 말머리 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteBbsSubospec(ModuleBbsVO moduleBbsVO) throws Exception;

	/**
	 * CSS 리스트 조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public List<ModuleBbsCssVO> selectBbsCssList(ModuleBbsVO moduleBbsVO) throws Exception;	
	
	public List<ModuleBbsCssVO> selectSysmoduleBbsCssList(ModuleBbsVO moduleBbsVO)  throws Exception;
	
	/**
	 * CSS 상세조회
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssDetail(ModuleBbsCssVO moduleBbsCssVO) throws Exception;	
	
	/**
	 * ㅁ 게시판 CSS정보 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsCssSeq(ModuleBbsVO moduleBbsVO) throws Exception;	
	
	/**
	 * 게시판 CSS_SEQ 가져오기 
     * @param paramVO
     * @return
     * @throws Exception
	 */
	public ModuleBbsCssVO selectBbsCssSeq(ModuleBbsVO moduleBbsVO);
}

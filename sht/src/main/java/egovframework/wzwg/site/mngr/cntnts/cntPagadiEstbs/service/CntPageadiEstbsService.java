package egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service;

import java.util.List;

public interface CntPageadiEstbsService {

	/**
	 * 컨텐츠 페이지 추가설정 SEQ 조회
	 * @return
	 */
	public String selectCntPageadiEstbsSeq() throws Exception;

	/**
	 * 컨텐츠 페이지 추가설정 정보 입력
	 * @param paramVO
	 * @return
	 */
	public int registCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 컨텐츠 페이지 추가설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectCntPageadiEstbs(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 담당관 SEQ 조회
	 * @return
	 * @throws Exception
	 */
	public String selectOclhgSeq() throws Exception;
	
	/**
	 * 담당관 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registOclhg(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 담당관 정보 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyOclhg(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 담당관 목록 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<CntPageadiEstbsVO> selectOclhgList(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 담당관 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteOclhg(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 담당관 순서변경
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int oclhgOrdrChange(CntPageadiEstbsVO paramVO, String ordrSe) throws Exception;
	
	
	/**
	 * 저작권 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 저작권 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectPagecpyrht(CntPageadiEstbsVO paramVO) throws Exception;
	
	

	/**
	 * 평가하기 설정 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 평가하기 설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectEvlEstbs(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 평가하기 점수 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registEvlScore(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 평가하기 요약정보
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectEvlScoreSummary(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 평가점수 목록 상세보기
	 * @param paramVO
	 * @return
	 */
	public List<CntPageadiEstbsVO> selectEvlScoreList(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 평가하기 컨텐츠명
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectCntntsNm(CntPageadiEstbsVO paramVO) throws Exception;
	
	
	/**
	 * 스킨 설정 정보 입력
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception;
	
	/**
	 * 스킨 설정 정보 조회
	 * @param paramVO
	 * @return
	 */
	public CntPageadiEstbsVO selectSkinEstbs(CntPageadiEstbsVO paramVO) throws Exception;
}

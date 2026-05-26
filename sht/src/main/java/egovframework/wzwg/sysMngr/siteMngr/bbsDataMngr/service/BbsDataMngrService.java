package egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service;


public interface BbsDataMngrService {
	 
	/**
	 * 사이트 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSiteOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception;	
	
	/**
	 * 시스템 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception;	
	
	/**
	 * 사이트 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNtt(BbsDataMngrVO paramVO) throws Exception;
	
	/**
	 * 시스템 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNtt(BbsDataMngrVO paramVO) throws Exception;
	
}


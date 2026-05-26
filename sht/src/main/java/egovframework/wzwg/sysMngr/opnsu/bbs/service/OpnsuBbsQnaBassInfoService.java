package egovframework.wzwg.sysMngr.opnsu.bbs.service;


public interface OpnsuBbsQnaBassInfoService {


	/**
	 * ㅁ 게시판 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public OpnsuBbsVO selectBbsBassInfoDetail(OpnsuBbsVO OpnsuBbsVO) throws Exception;
	
	/**
	 * ㅁ 글양식 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyBbsBassInfo(OpnsuBbsVO OpnsuBbsVO) throws Exception;
    
    /**
     * ㅁ 게시판 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registBbsBassInfo(OpnsuBbsVO OpnsuBbsVO) throws Exception;

}

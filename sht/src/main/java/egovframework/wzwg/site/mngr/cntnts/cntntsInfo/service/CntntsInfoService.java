package egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service;

import java.util.List;

public interface CntntsInfoService {

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록
	 * @param siteMenuVO
	 * @return
	 */
	public List<CntntsInfoVO> selectCntntsInfoList(CntntsInfoVO paramVO);

    /**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectCntntsInfoListCnt(CntntsInfoVO paramVO);

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보
     * @param CntntsInfoVO
     * @return
     */
    public CntntsInfoVO selectCntntsInfo(CntntsInfoVO paramVO);

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 전체 목록
	 * @param ApiVO
	 * @return
	 */
	public List<CntntsInfoVO> selectCntntsInfoAllList(String siteSeq);

	

	/**
	 * ㅁ 컨텐츠정보 - 모듈 메뉴 컨텐츠 정보 전체 목록
	 * @param String
	 * @return
	 */
	public List<CntntsInfoVO> selectMenuCntntsInfoAllList(String siteSeq);
    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public int registCntntsInfo(CntntsInfoVO paramVO);

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public String registCntntsInfoRetSeq(CntntsInfoVO paramVO);

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록 후 기본권한 셋팅
     * @param String
     * @return
     */
    public int registCntntsInfoDefaultAuth(CntntsInfoVO paramVO) throws Exception ;
    
    public String registCntntsInfoDefaultAuthInit(CntntsInfoVO paramVO) throws Exception;

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 삭제
     * @param String
     * @return
     */
    public int deleteCntntsInfo(CntntsInfoVO paramVO);

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 삭제
     * @param String
     * @return
     */
    public int deleteCntntsInfoArr(CntntsInfoVO paramVO);

    /**
     * ㅁ 컨텐츠정보 - 컨텐츠 API 제공 목록
     * @param String
     * @return
     */
    public List<CntntsInfoVO> selectCntntsApiProvdList(CntntsInfoVO paramVO);
    
    /**
	 * ㅁ 컨텐츠정보 - 컨텐츠 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSitecntntsSeq();
    
    /**
     * ㅁ 컨텐츠정보 - 모듈 초기 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public void registCntntsInfoInit(CntntsInfoVO paramVO);
    
    public void modifyCntntsInfoInit(CntntsInfoVO paramVO);

    public CntntsInfoVO selectCntntsBassInfo(CntntsInfoVO paramVO);
    
    
    /* 이하 컨텐츠 대시보드용 */
    public List<CntntsInfoVO> selectCntntsDashboardCnt(CntntsInfoVO paramVO);
    
	public List<CntntsInfoVO> selectBbsInfoList(CntntsInfoVO paramVO) ;
	
	
	/**
	 * atchFileId 로 게시판에서 사용중인지 체크
	 * @param atchFileId
	 * @return
	 */
	public CntntsInfoVO selectBbsAtchFileIdCheck(String atchFileId);
}

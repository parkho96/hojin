package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

public interface SysMngrSiteOpertNtcService {
	
	/** 사이트 작업알림 존재여부 확인 */
	String selectSiteOpertNtcSeqChk(SysMngrSiteInfoVO paramVO);
	
	/** 사이트 작업알림 상세조회 */
	SysMngrSiteInfoVO selectSiteOpertNtcDetail(SysMngrSiteInfoVO paramVO);
	
	/** 사이트 작업알림 등록 */
	void registSiteOpertNtc(SysMngrSiteInfoVO paramVO);
	
	/** 사이트 작업알림 수정 */
	void modifySiteOpertNtc(SysMngrSiteInfoVO paramVO);

	/** 사이트 작업알림 삭제 */
	void deleteSiteOpertNtc(SysMngrSiteInfoVO paramVO);

    /** 사이트 작업알림 - 접속제어 인터셉터에서 사용  */
	SysMngrSiteInfoVO selectConectCtrlSiteOpertntc(String siteSeq);

    /** 사이트 작업알림 - 접속제어 인터셉터에서 사용  */
    Integer selectConectCtrlSiteOpertntcChk(String siteSeq);
}

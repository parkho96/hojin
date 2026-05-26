package egovframework.wzwg.sysMngr.siteMngr.siteOpert.service;

import java.util.List;

public interface SysMngrSysOpertNtcService {

	/** 작업알림 총 카운트 조회 */
	Integer selectSysOpertNtcTotCnt(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 리스트 조회 */
	List<SysMngrSysOpertNtcVO> selectSysOpertNtcList(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 상세조회 */
	SysMngrSysOpertNtcVO selectSysOpertNtcDetail(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 등록 */
	int registSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 수정 */
	int modifySysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 삭제 */
	int deleteSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO);

	/** 작업알림 체크박스 삭제 */
	int deleteSysOpertNtcArr(SysMngrSysOpertNtcVO sysOpertNtcVO);

    /** 사이트 작업알림 - 접속제어 인터셉터에서 사용  */
    public SysMngrSysOpertNtcVO selectConectCtrlSysOpertntc(SysMngrSysOpertNtcVO sysOpertNtcVO);

    /** 사이트 작업알림 - 접속제어 인터셉터에서 사용  */
    public Integer selectConectCtrlSysOpertntcChk(SysMngrSysOpertNtcVO sysOpertNtcVO);

}

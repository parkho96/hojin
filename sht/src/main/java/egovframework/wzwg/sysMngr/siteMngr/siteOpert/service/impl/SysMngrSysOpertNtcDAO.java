package egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcVO;


@Repository("SysOpertNtcDAO")
public class SysMngrSysOpertNtcDAO extends EgovAbstractMapper{

	/**
	 * @Method Name : selectSysOpertNtcSeq
	 * @Method 설명 : 작업알림 시퀀스 조회
	 *
	 * @return
	 *
	 * @변경이력 : 
	 */
	public String selectSysOpertNtcSeq() {
		return (String) selectOne("SysOpertNtcDAO_selectSysOpertNtcSeq", null);
	}

	/**
	 * @Method Name : selectSysOpertNtcTotCnt
	 * @Method 설명 : 총 카운트 조회
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public Integer selectSysOpertNtcTotCnt(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return (Integer) selectOne("SysOpertNtcDAO_selectSysOpertNtcTotCnt", sysOpertNtcVO);
	}

	/**
	 * @Method Name : selectSysOpertNtcList
	 * @Method 설명 : 작업알림 리스트 조회
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public List<SysMngrSysOpertNtcVO> selectSysOpertNtcList(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return selectList("SysOpertNtcDAO_selectSysOpertNtcList", sysOpertNtcVO);
	}

	/**
	 * @Method Name : selectSysOpertNtcDetail
	 * @Method 설명 : 작업알림 상세조회
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public SysMngrSysOpertNtcVO selectSysOpertNtcDetail(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return (SysMngrSysOpertNtcVO) selectOne("SysOpertNtcDAO_selectSysOpertNtcDetail", sysOpertNtcVO);
	}

	/**
	 * @Method Name : registSysOpertNtc
	 * @Method 설명 : 작업알림 등록
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int registSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return update("SysOpertNtcDAO_registSysOpertNtc", sysOpertNtcVO);
	}

	/**
	 * @Method Name : modifySysOpertNtc
	 * @Method 설명 : 작업알림 수정
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int modifySysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return update("SysOpertNtcDAO_modifySysOpertNtc", sysOpertNtcVO);
	}

	/**
	 * @Method Name : deleteSysOpertNtc
	 * @Method 설명 : 작업알림 삭제
	 *
	 * @param sysOpertNtcVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public int deleteSysOpertNtc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
		return update("SysOpertNtcDAO_deleteSysOpertNtc", sysOpertNtcVO);
	}

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param paramVO
     * @return
     *
     * @변경이력 : 
     */
    public SysMngrSysOpertNtcVO selectConectCtrlSysOpertntc(SysMngrSysOpertNtcVO sysOpertNtcVO) {
        return (SysMngrSysOpertNtcVO)selectOne("SysOpertNtcDAO_selectConectCtrlSysOpertntc", sysOpertNtcVO);
    }

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param paramVO
     * @return
     *
     * @변경이력 : 
     */
    public Integer selectConectCtrlSysOpertntcChk(SysMngrSysOpertNtcVO sysOpertNtcVO) {
        return (Integer)selectOne("SysOpertNtcDAO_selectConectCtrlSysOpertntcChk", sysOpertNtcVO);
    }
}

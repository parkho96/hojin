package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;

@Repository("SysMngrSiteOpertNtcDAO")
public class SysMngrSiteOpertNtcDAO extends EgovAbstractMapper {

	/**
	 * @Method Name : selectSiteOpertNtcSeqChk
	 * @Method 설명 : 사이트 작업알림 존재여부 확인
	 *
	 * @param paramVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public String selectSiteOpertNtcSeqChk(SysMngrSiteInfoVO paramVO){
		return (String) selectOne("SysMngrSiteOpertNtcDAO_selectSiteOpertNtcSeqChk", paramVO);
	}
	
	/**
	 * @Method Name : registSiteOpertNtc
	 * @Method 설명 : 사이트 작업알림 등록
	 *
	 * @param paramVO
	 *
	 * @변경이력 : 
	 */
	public void registSiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		update("SysMngrSiteOpertNtcDAO_registSiteOpertNtc", paramVO);
	}

	/**
	 * @Method Name : modifySiteOpertNtc
	 * @Method 설명 : 사이트 작업알림 수정
	 *
	 * @param paramVO
	 *
	 * @변경이력 : 
	 */
	public void modifySiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		update("SysMngrSiteOpertNtcDAO_modifySiteOpertNtc", paramVO);
	}

	/**
	 * @Method Name : selectSiteOpertNtcDetail
	 * @Method 설명 : 사이트 작업알림 상세조회
	 *
	 * @param paramVO
	 * @return
	 *
	 * @변경이력 : 
	 */
	public SysMngrSiteInfoVO selectSiteOpertNtcDetail(SysMngrSiteInfoVO paramVO) {
		return (SysMngrSiteInfoVO) selectOne("SysMngrSiteOpertNtcDAO_selectSiteOpertNtcDetail", paramVO);
	}

	/**
	 * @Method Name : deleteSiteOpertNtc
	 * @Method 설명 : 사이트 작업알림 삭제
	 *
	 * @param paramVO
	 *
	 * @변경이력 : 
	 */
	public void deleteSiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		update("SysMngrSiteOpertNtcDAO_deleteSiteOpertNtc", paramVO);
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
    public SysMngrSiteInfoVO selectConectCtrlSiteOpertntc(String siteSeq) {
        return (SysMngrSiteInfoVO)selectOne("SysMngrSiteOpertNtcDAO_selectConectCtrlSiteOpertntc", siteSeq);
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
    public Integer selectConectCtrlSiteOpertntcChk(String siteSeq) {
        return (Integer)selectOne("SysMngrSiteOpertNtcDAO_selectConectCtrlSiteOpertntcChk", siteSeq);
    }
}

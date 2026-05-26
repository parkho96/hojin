package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteOpertNtcService;

@Service("SysMngrSiteOpertNtcService")
public class SysMngrSiteOpertNtcServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteOpertNtcService {
	
	@Resource(name="SysMngrSiteOpertNtcDAO")
	SysMngrSiteOpertNtcDAO sysMngrSiteOpertNtcDAO;
	
	/**
	 * 사이트 작업알림 존재여부 확인
	 */
	public String selectSiteOpertNtcSeqChk(SysMngrSiteInfoVO paramVO) {
		return sysMngrSiteOpertNtcDAO.selectSiteOpertNtcSeqChk(paramVO);
	}

	/**
	 * 사이트 작업알림 상세조회
	 */
	public SysMngrSiteInfoVO selectSiteOpertNtcDetail(SysMngrSiteInfoVO paramVO) {
		return sysMngrSiteOpertNtcDAO.selectSiteOpertNtcDetail(paramVO);
	}

	/**
	 * 사이트 작업알림 등록
	 */
	public void registSiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		sysMngrSiteOpertNtcDAO.registSiteOpertNtc(paramVO);
	}

	/**
	 * 사이트 작업알림 수정
	 */
	public void modifySiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		sysMngrSiteOpertNtcDAO.modifySiteOpertNtc(paramVO);
	}

	/**
	 * 사이트 작업알림 삭제
	 */
	public void deleteSiteOpertNtc(SysMngrSiteInfoVO paramVO) {
		sysMngrSiteOpertNtcDAO.deleteSiteOpertNtc(paramVO);
	}

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param siteSeq
     * @return
     *
     * @변경이력 : 
     */
    public SysMngrSiteInfoVO selectConectCtrlSiteOpertntc(String siteSeq) {
        return sysMngrSiteOpertNtcDAO.selectConectCtrlSiteOpertntc(siteSeq);
    }

    /**
     * @Method Name : selectSiteOpertNtcDetail
     * @Method 설명 : 사이트 작업알림 - 접속제어 인터셉터에서 사용
     *
     * @param siteSeq
     * @return
     *
     * @변경이력 : 
     */
    public Integer selectConectCtrlSiteOpertntcChk(String siteSeq) {
        return sysMngrSiteOpertNtcDAO.selectConectCtrlSiteOpertntcChk(siteSeq);
    }
}

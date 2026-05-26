package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteAdiInfoService")
public class SysMngrSiteAdiInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteAdiInfoService {

    @Resource(name="SysMngrSiteAdiInfoDAO")
    private SysMngrSiteAdiInfoDAO siteAdiInfoDAO;

    /**
	 * ㅁ 시스템 - 사이트 부가정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteAdiInfoVO selectSiteAdiInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return siteAdiInfoDAO.selectSiteAdiInfoDetail(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteAdiInfo(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	
    	int resultCnt = siteAdiInfoDAO.selectSiteAdiInfoCnt(paramVO);
    	
    	if (resultCnt > 0) {
    		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        	siteAdiInfoDAO.modifySiteAdiInfo(paramVO);	
    	} else {
    		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        	siteAdiInfoDAO.registSiteAdiInfo(paramVO);
    	}
    }
    
    /**
	 * ㅁ 시스템 - 사이트 부가하단정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteAdiInfoVO selectSiteFtrInfoDetail(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return siteAdiInfoDAO.selectSiteFtrInfoDetail(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 부가정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception {
        
        int resultCnt = siteAdiInfoDAO.selectSiteAdiInfoCnt(paramVO);
        
        if (resultCnt > 0) {
            paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
            siteAdiInfoDAO.modifySiteMenuEstbsAt(paramVO);
        } else {
            paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
            siteAdiInfoDAO.registSiteAdiInfo(paramVO);
            siteAdiInfoDAO.modifySiteMenuEstbsAt(paramVO);
        }
    }

    /**
     * ㅁ 시스템 - 사이트 부가정보 - 메뉴설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteMenuEstbsAt(SysMngrSiteAdiInfoVO paramVO) throws Exception {
        return siteAdiInfoDAO.selectSiteMenuEstbsAt(paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사이트 부가정보 - 관리자 접속 IP
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSiteAdiInfoConnIp(String siteSeq) throws Exception {
        return siteAdiInfoDAO.selectSiteAdiInfoConnIp(siteSeq);
    }


}

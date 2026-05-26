package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteFileProvdService;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteFileProvdService")
public class SysMngrSiteFileProvdServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteFileProvdService {

    @Resource(name="SysMngrSiteFileProvdDAO")
    private SysMngrSiteFileProvdDAO siteFileProvdDAO;

    /**
     * ㅁ 시스템 - 사이트 첨부파일 허용용량 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteFileProvd(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return siteFileProvdDAO.modifySiteFileProvd(paramVO);
    }

}

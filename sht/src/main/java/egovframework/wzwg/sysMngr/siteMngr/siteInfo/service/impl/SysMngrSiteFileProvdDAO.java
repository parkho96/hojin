package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;

/**
 * ㅁ 시스템 - 사이트 부가정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteFileProvdDAO")
public class SysMngrSiteFileProvdDAO extends EgovAbstractMapper {


    /**
     * ㅁ 시스템 - 사이트 첨부파일 허용용량 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteFileProvd(SysMngrSiteAdiInfoVO paramVO) throws Exception {
    	return update("SysMngrSiteFileProvdDAO_modifySiteFileProvd_U", paramVO);
    }

    
}

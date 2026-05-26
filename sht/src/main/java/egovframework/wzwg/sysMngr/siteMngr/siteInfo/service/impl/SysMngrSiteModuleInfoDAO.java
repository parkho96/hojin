package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoVO;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteModuleInfoDAO")
public class SysMngrSiteModuleInfoDAO extends EgovAbstractMapper {

    /**
	 * ㅁ 시스템 - 사이트 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    
	public List<SysMngrSiteModuleInfoVO> selectSiteModuleInfoList(SysMngrSiteModuleInfoVO paramVO) throws Exception {
    	return selectList("SysMngrSiteModuleInfoDAO_selectSiteModuleInfoList", paramVO);
    }
 
	

    /**
	 * ㅁ 시스템 - 사이트 정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception {
    	insert("SysMngrSiteModuleInfoDAO_registSiteModuleInfo", paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteModuleInfo(SysMngrSiteModuleInfoVO paramVO) throws Exception {
    	delete("SysMngrSiteModuleInfoDAO_deleteSiteModuleInfo", paramVO);
    }
 
 
}

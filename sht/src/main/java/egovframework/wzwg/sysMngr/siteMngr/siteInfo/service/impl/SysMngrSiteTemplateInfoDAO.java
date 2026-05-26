package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteTemplateInfoVO;

/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Repository("SysMngrSiteTemplateInfoDAO")

public class SysMngrSiteTemplateInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 템플릿 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectTemplateList(SysMngrSiteTemplateInfoVO paramVO) throws Exception {
    	return selectList("SysMngrSiteTemplateInfoDAO_selectTemplateList_S", paramVO);
    }
	
    /**
	 * ㅁ 사이트별 템플릿 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteTemplateInfoVO> selectSiteTemplateInfoList(SysMngrSiteTemplateInfoVO paramVO) throws Exception {
    	return selectList("SysMngrSiteTemplateInfoDAO_selectSiteTemplateInfoList_S", paramVO);
    }

    /**
	 * ㅁ 사이트별 템플릿 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteTemplateInfo(SysMngrSiteTemplateInfoVO paramVO) throws Exception {
    	insert("SysMngrSiteTemplateInfoDAO_registSiteTemplateInfo_I", paramVO);
    }

    /**
	 * ㅁ 사이트별 템플릿 체크 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteTemplateChkInfo(SysMngrSiteTemplateInfoVO paramVO) throws Exception {
    	delete("SysMngrSiteTemplateInfoDAO_deleteSiteTemplateChkInfo_D", paramVO);
    }
    
    /**
	 * ㅁ 사이트별 템플릿 전체 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteTemplateInfo(SysMngrSiteTemplateInfoVO paramVO) throws Exception {
    	delete("SysMngrSiteTemplateInfoDAO_deleteSiteTemplateInfo_D", paramVO);
    }
 
}

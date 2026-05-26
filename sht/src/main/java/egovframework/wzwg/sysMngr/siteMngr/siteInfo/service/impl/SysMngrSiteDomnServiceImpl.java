package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnVO;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteDomnService")
public class SysMngrSiteDomnServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteDomnService {

    @Resource(name="SysMngrSiteDomnDAO")
    private SysMngrSiteDomnDAO siteDomnDAO;

    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
    
    /**
	 * ㅁ 시스템 - 사이트 도메인 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSiteDomnVO> selectSiteDomnList(SysMngrSiteDomnVO paramVO) throws Exception {
    	return siteDomnDAO.selectSiteDomnList(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 목록 전체수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSiteDomnListCnt(SysMngrSiteDomnVO paramVO) throws Exception {
    	return siteDomnDAO.selectSiteDomnListCnt(paramVO);
	}

    /**
	 * ㅁ 시스템 - 사이트 도메인 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteDomnVO selectSiteDomnDetail(SysMngrSiteDomnVO paramVO) throws Exception {
    	return siteDomnDAO.selectSiteDomnDetail(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 도메인 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception {
		if(paramVO.getSiteUrl().indexOf("/")>-1) {
			String domn =paramVO.getSiteUrl().substring(0, paramVO.getSiteUrl().indexOf("/"));
			String siteKey =paramVO.getSiteUrl().substring(paramVO.getSiteUrl().indexOf("/"));
			paramVO.setSiteUrl(domn.toLowerCase()+siteKey);
		}else {
    	paramVO.setSiteUrl(paramVO.getSiteUrl().toLowerCase());
		}
		
    	SysMngrSiteDomnVO resultVO = siteDomnDAO.selectSiteDomnDetail(paramVO);
    	
    	if (resultVO != null) {
    		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        	siteDomnDAO.modifySiteDomn(paramVO);	
    	} else {
    		String domnSeq = siteDomnDAO.selectSiteDomnSeq();
    		SiteTemplateScreenVO siteTemplateScreenVO = new SiteTemplateScreenVO();
    		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
    		paramVO.setDomnSeq(domnSeq);
    		//siteTemplateScreenVO.setSiteSeq(paramVO.getSiteSeq());
    		//siteTemplateScreenVO.setDomnSeq(String.valueOf(domnSeq));
    		//siteTemplateScreenVO.setUserId(CmmSessionUtil.getSessionUserId());
    		String templateSeq = EgovProperties.getProperty("defaultTempltSeq");
    		siteTemplateScreenVO.setTemplateSeq(templateSeq);
    		siteDomnDAO.registSiteDomn(paramVO);
    	//	siteTemplateScreenService.registSiteTemplateScreen(siteTemplateScreenVO);
    	}
    }

    /**
	 * ㅁ 시스템 - 사이트  도메인 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void deleteSiteDomn(SysMngrSiteDomnVO paramVO) throws Exception {


		String[] seqArr = paramVO.getDomnSeqArr();
		
		if (seqArr != null && seqArr.length > 0) {
			
			for (int i=0; i<seqArr.length; i++) {
				paramVO.setDomnSeq(seqArr[i]);
				siteDomnDAO.deleteSiteDomn(paramVO);
			}
		}
    }


    /**
	 * ㅁ 시스템 - 사이트 대표 도메인 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySiteReprsntDomn(SysMngrSiteDomnVO paramVO) {
		
		/** 해당 사이트 대표 도메인 'N'로 변경 */
		siteDomnDAO.deleteSiteReprsntDomn(paramVO);
		
		return siteDomnDAO.modifySiteReprsntDomn(paramVO);
	}

    /**
	 * ㅁ 시스템 - 사이트 도메인 중복체크
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectSiteDomnDplctChk(SysMngrSiteDomnVO paramVO) {
		return siteDomnDAO.selectSiteDomnDplctChk(paramVO);
	}

}

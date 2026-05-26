package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuVO;

@Service("SiteHdftrMenuService")
public class SiteHdftrMenuServiceImpl extends EgovAbstractServiceImpl implements SiteHdftrMenuService {
    
    @Resource(name="SiteHdftrMenuDAO")
    private SiteHdftrMenuDAO siteHdftrMenuDAO;
 
    
    /**
	 * 사이트 메뉴 목록
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<SiteHdftrMenuVO> selectSiteHdftrMenuList(SiteHdftrMenuVO paramVO) {
		return siteHdftrMenuDAO.selectSiteHdftrMenuList(paramVO);
	}
	 
	
	public  SiteHdftrMenuVO selectSiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		return siteHdftrMenuDAO.selectSiteHdftrMenu(paramVO);
	}

	/**
	 * 사이트 메뉴 등록
	 * @return
	 */
	public int registSiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		return siteHdftrMenuDAO.registSiteHdftrMenu(paramVO);
	}
	
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public int modifySiteHdftrMenu(SiteHdftrMenuVO paramVO) {
		return siteHdftrMenuDAO.modifySiteHdftrMenu(paramVO);
	}

	/**
	 * 사이트 메뉴 삭제
	 * @return
	 */
	public void deleteSiteHdftrMenuMngr(SiteHdftrMenuVO paramVO) {
		siteHdftrMenuDAO.deleteSiteHdftrMenuMngr(paramVO);
	}
 
	/**
	 * 사이트 메뉴 수정
	 * @return
	 */
	public int modifySiteHdftrMenuOrdr(SiteHdftrMenuVO paramVO) {
		 
		SiteHdftrMenuVO thisVO = new SiteHdftrMenuVO();
		SiteHdftrMenuVO targetVO = new SiteHdftrMenuVO();
        if(paramVO.getOrdrGubun().equals("U"))
            targetVO = siteHdftrMenuDAO.selectSiteHdftrMenuOrdrUp(paramVO);
        else
        if(paramVO.getOrdrGubun().equals("D"))
            targetVO = siteHdftrMenuDAO.selectSiteHdftrMenuOrdrDown(paramVO);
        if(targetVO == null)
        {
            return -1;
        } else {
        	
            thisVO.setHdftrmenuSeq(paramVO.getHdftrmenuSeq());
            thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            thisVO.setHdftrmenuOrdr(targetVO.getHdftrmenuOrdr());
            thisVO.setSiteSeq(paramVO.getSiteSeq());
            
            targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            targetVO.setHdftrmenuOrdr(paramVO.getHdftrmenuOrdr());
            targetVO.setSiteSeq(paramVO.getSiteSeq());
            
            int result = 0;
            result += siteHdftrMenuDAO.modifySiteHdftrMenuOrdr(thisVO);
            result += siteHdftrMenuDAO.modifySiteHdftrMenuOrdr(targetVO);
            
            return result;
            
        }
	}
	
	/**
	 * 번역 여부 중복체크
	 */
	public int selectSiteHdftrMenuTrnslatChk(SiteHdftrMenuVO paramVO) {
		if(("N").equals(StringUtils.defaultString(paramVO.getNChk())) && ("Y").equals(StringUtils.defaultString(paramVO.getYChk()))) {
			paramVO.setChkCondition("ALL");
		} 
		return siteHdftrMenuDAO.selectSiteHdftrMenuTrnslatChk(paramVO);
	}

}

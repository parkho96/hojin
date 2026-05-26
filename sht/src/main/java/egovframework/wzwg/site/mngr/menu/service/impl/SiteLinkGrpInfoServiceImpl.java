package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;

@Service("LinkGrpInfoService")
public class SiteLinkGrpInfoServiceImpl extends EgovAbstractServiceImpl implements SiteLinkGrpInfoService {
	
	@Resource(name="LinkGrpInfoDAO")
	SiteLinkGrpInfoDAO linkGrpInfoDAO;

    public Integer selectLinkGrpInfoListCnt(SiteLinkGrpInfoVO paramVO) {
        return linkGrpInfoDAO.selectLinkGrpInfoListCnt(paramVO);
    }

    public List<SiteLinkGrpInfoVO> selectLinkGrpInfoList(SiteLinkGrpInfoVO paramVO) {
        return linkGrpInfoDAO.selectLinkGrpInfoList(paramVO);
    }

    public int registLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
        String linkGrpSeq = linkGrpInfoDAO.selectLinkGrpInfoSeq(paramVO);
        
        paramVO.setLinkGrpSeq(linkGrpSeq);
        
        return linkGrpInfoDAO.registLinkGrpInfo(paramVO);
    }

    public SiteLinkGrpInfoVO selectLinkGrpInfoDetail(SiteLinkGrpInfoVO paramVO) {
        return linkGrpInfoDAO.selectLinkGrpInfoDetail(paramVO);
    }

    public int modifyLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
        return linkGrpInfoDAO.modifyLinkGrpInfo(paramVO);
    }

    public int deleteLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
        return linkGrpInfoDAO.deleteLinkGrpInfo(paramVO);
    }

    public List<SiteLinkGrpInfoVO> selectLinkGrpInfoAll(String siteSeq) {
        return linkGrpInfoDAO.selectLinkGrpInfoAll(siteSeq);
    }
}

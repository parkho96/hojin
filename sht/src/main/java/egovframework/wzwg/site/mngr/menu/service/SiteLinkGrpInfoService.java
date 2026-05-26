package egovframework.wzwg.site.mngr.menu.service;

import java.util.List;

public interface SiteLinkGrpInfoService {

    public Integer selectLinkGrpInfoListCnt(SiteLinkGrpInfoVO paramVO);

    public List<SiteLinkGrpInfoVO> selectLinkGrpInfoList(SiteLinkGrpInfoVO paramVO);

    public int registLinkGrpInfo(SiteLinkGrpInfoVO paramVO);

    public SiteLinkGrpInfoVO selectLinkGrpInfoDetail(SiteLinkGrpInfoVO paramVO);

    public int modifyLinkGrpInfo(SiteLinkGrpInfoVO paramVO);

    public int deleteLinkGrpInfo(SiteLinkGrpInfoVO paramVO);

    public List<SiteLinkGrpInfoVO> selectLinkGrpInfoAll(String siteSeq);
}

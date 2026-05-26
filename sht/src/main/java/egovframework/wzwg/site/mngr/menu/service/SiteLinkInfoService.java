package egovframework.wzwg.site.mngr.menu.service;

import java.util.List;

public interface SiteLinkInfoService {

    public Integer selectLinkInfoListCnt(SiteLinkGrpInfoVO paramVO);

    public List<SiteLinkGrpInfoVO> selectLinkInfoList(SiteLinkGrpInfoVO paramVO);

    public int registLinkInfo(SiteLinkGrpInfoVO paramVO);

    public SiteLinkGrpInfoVO selectLinkInfoDetail(SiteLinkGrpInfoVO paramVO);

    public int modifyLinkInfo(SiteLinkGrpInfoVO paramVO);

    public int deleteLinkInfo(SiteLinkGrpInfoVO paramVO);

    public List<SiteLinkGrpInfoVO> selectLinkGrpMapListAjax(SiteLinkGrpInfoVO paramVO);

    public int registLinkGrp(SiteLinkGrpInfoVO paramVO);

    public int deleteLinkGrp(SiteLinkGrpInfoVO paramVO);
    
    public List<SiteLinkGrpInfoVO> selectLinkUrlList(SiteLinkGrpInfoVO paramVO);

    public int modifySiteLinkGrpOrdr(SiteLinkGrpInfoVO sitelinkgrpinfovo) throws Exception;
}

package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;


@Repository("LinkGrpInfoDAO")
public class SiteLinkGrpInfoDAO extends EgovAbstractMapper{

	public Integer selectLinkGrpInfoListCnt(SiteLinkGrpInfoVO paramVO) {
		return (Integer)selectOne("LinkGrpInfoDAO_selectLinkGrpInfoListCnt", paramVO);
	}

	public List<SiteLinkGrpInfoVO> selectLinkGrpInfoList(SiteLinkGrpInfoVO paramVO) {
		return selectList("LinkGrpInfoDAO_selectLinkGrpInfoList", paramVO);
	}

    public String selectLinkGrpInfoSeq(SiteLinkGrpInfoVO paramVO) {
        return (String)selectOne("LinkGrpInfoDAO_selectLinkGrpInfoSeq", paramVO);
    }

    public int registLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
        return update("LinkGrpInfoDAO_registLinkGrpInfo", paramVO);
    }

	public SiteLinkGrpInfoVO selectLinkGrpInfoDetail(SiteLinkGrpInfoVO paramVO) {
		return (SiteLinkGrpInfoVO)selectOne("LinkGrpInfoDAO_selectLinkGrpInfoDetail", paramVO);
	}

	public int modifyLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
		return update("LinkGrpInfoDAO_modifyLinkGrpInfo", paramVO);
	}

	public int deleteLinkGrpInfo(SiteLinkGrpInfoVO paramVO) {
		return update("LinkGrpInfoDAO_deleteLinkGrpInfo", paramVO);
	}

    public List<SiteLinkGrpInfoVO> selectLinkGrpInfoAll(String siteSeq) {
        return selectList("LinkGrpInfoDAO_selectLinkGrpInfoAll", siteSeq);
    }
}

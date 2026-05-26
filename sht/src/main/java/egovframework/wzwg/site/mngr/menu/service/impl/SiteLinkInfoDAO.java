package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;


@Repository("LinkInfoDAO")
public class SiteLinkInfoDAO extends EgovAbstractMapper{

    public Integer selectLinkInfoListCnt(SiteLinkGrpInfoVO paramVO) {
        return (Integer)selectOne("LinkInfoDAO_selectLinkInfoListCnt", paramVO);
    }
    
	public List<SiteLinkGrpInfoVO> selectLinkInfoList(SiteLinkGrpInfoVO paramVO) {
		return selectList("LinkInfoDAO_selectLinkInfoList", paramVO);
	}

    public String selectLinkInfoSeq(SiteLinkGrpInfoVO paramVO) {
        return (String)selectOne("LinkInfoDAO_selectLinkInfoSeq", paramVO);
    }

    public int registLinkInfo(SiteLinkGrpInfoVO paramVO) {
        return update("LinkInfoDAO_registLinkInfo", paramVO);
    }

	public SiteLinkGrpInfoVO selectLinkInfoDetail(SiteLinkGrpInfoVO paramVO) {
		return (SiteLinkGrpInfoVO)selectOne("LinkInfoDAO_selectLinkInfoDetail", paramVO);
	}

	public int modifyLinkInfo(SiteLinkGrpInfoVO paramVO) {
		return update("LinkInfoDAO_modifyLinkInfo", paramVO);
	}

	public int deleteLinkInfo(SiteLinkGrpInfoVO paramVO) {
		return update("LinkInfoDAO_deleteLinkInfo", paramVO);
	}

    public List<SiteLinkGrpInfoVO> selectLinkGrpMapListAjax(SiteLinkGrpInfoVO paramVO) {
        return selectList("LinkInfoDAO_selectLinkGrpMapListAjax", paramVO);
    }

    public Integer selectLinkGrpCnt(SiteLinkGrpInfoVO paramVO) {
        return (Integer)selectOne("LinkInfoDAO_selectLinkGrpCnt", paramVO);
    }

    public String selectLinkGrpOrdr(SiteLinkGrpInfoVO paramVO) {
        return (String)selectOne("LinkInfoDAO_selectLinkGrpOrdr", paramVO);
    }
    
    public Integer registLinkGrp(SiteLinkGrpInfoVO paramVO) {
        return update("LinkInfoDAO_registLinkGrp", paramVO);
    }
    
    public Integer deleteLinkGrp(SiteLinkGrpInfoVO paramVO) {
        return delete("LinkInfoDAO_deleteLinkGrp", paramVO);
    }

    public List<SiteLinkGrpInfoVO> selectLinkUrlList(SiteLinkGrpInfoVO paramVO) {
        return selectList("LinkInfoDAO_selectLinkUrlList", paramVO);
    }

    public SiteLinkGrpInfoVO selectSiteLinkGrpOrdrUp(SiteLinkGrpInfoVO paramVO) throws Exception {
        return (SiteLinkGrpInfoVO)selectOne("linkInfoDAO_selectSiteLinkGrpOrdrUp", paramVO);
    }

    public SiteLinkGrpInfoVO selectSiteLinkGrpOrdrDown(SiteLinkGrpInfoVO paramVO) throws Exception {
        return (SiteLinkGrpInfoVO)selectOne("linkInfoDAO_selectSiteLinkGrpOrdrDown", paramVO);
    }

    public int modifySiteLinkGrpOrdr(SiteLinkGrpInfoVO paramVO) throws Exception {
        return update("linkInfoDAO_modifySiteLinkGrpOrdr", paramVO);
    }
}

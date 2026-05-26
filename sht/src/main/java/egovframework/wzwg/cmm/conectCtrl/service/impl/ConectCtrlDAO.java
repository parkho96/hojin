package egovframework.wzwg.cmm.conectCtrl.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.conectCtrl.service.ConectCtrlVO;

@Repository("ConectCtrlDAO")
public class ConectCtrlDAO extends EgovAbstractMapper {

    public List<ConectCtrlVO> selectSiteUrlBySiteSeq(String siteUrl) throws Exception {
        return selectList("ConectCtrlDAO_selectSiteUrlBySiteSeq", siteUrl);
    }
    
    public List<ConectCtrlVO> selectSiteKeyBySiteSeq(String siteKey) throws Exception {
        return selectList("ConectCtrlDAO_selectSiteKeyBySiteSeq", siteKey);
    }

    public List<ConectCtrlVO> selectSiteSeqBySysSiteSeq(String siteUrl) throws Exception {
        return selectList("ConectCtrlDAO_selectSiteSeqBySysSiteSeq", null);
    }
}

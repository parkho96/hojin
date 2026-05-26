package egovframework.wzwg.module.kocw.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.kocw.service.KocwService;
import egovframework.wzwg.module.kocw.service.KocwVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("KocwService")
public class KocwServiceImpl extends EgovAbstractServiceImpl implements KocwService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
	public void modifyKocwAjax(KocwVO paramVO) {
	    
        CntntsInfoVO ciVO = new CntntsInfoVO();
        
        ciVO.setCntntsNm(paramVO.getSitecntntsNm());
        ciVO.setCntntsDc(paramVO.getSitecntntsNm());
//        ciVO.setLastUpdusrId(paramVO.getUserId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(ciVO);
	}

    public KocwVO selectKocwScrinCntnts(KocwVO paramVO) {
        return new KocwVO();
    }

}

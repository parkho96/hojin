package egovframework.wzwg.cmm.mber.myPage.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

@Repository("CmmMyStplatAgreDAO")
public class CmmMyStplatAgreDAO extends EgovAbstractMapper {

    /*************************** 2019.03.06 start *******************************/
    
    public List<SiteStplatInfoVO> selectMyStplatAgreList(SiteStplatInfoVO paramVO) throws Exception {
        
        return selectList("CmmMyStplatAgreDAO_selectMyStplatAgreList", paramVO);
    }
    /*************************** 2019.03.06 end *******************************/
	
}

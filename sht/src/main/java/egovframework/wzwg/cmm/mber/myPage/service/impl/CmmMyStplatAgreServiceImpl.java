package egovframework.wzwg.cmm.mber.myPage.service.impl;

import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.mber.myPage.service.CmmMyStplatAgreService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;


@Service("CmmMyStplatAgreService")
public class CmmMyStplatAgreServiceImpl extends EgovAbstractServiceImpl implements CmmMyStplatAgreService {

    @Resource(name="CmmMyStplatAgreDAO")
    private CmmMyStplatAgreDAO cmmMyStplatAgreDAO;

    @Resource(name="CmmSbscrbService")
    private CmmSbscrbService cmmSbscrbService;
	
    /*************************** 2019.03.06 start *******************************/
    public List<SiteStplatInfoVO> selectMyStplatAgreList(SiteStplatInfoVO paramVO) throws Exception {
    	
    	return cmmMyStplatAgreDAO.selectMyStplatAgreList(paramVO);
    }

    public int modifyMyStplatAgre(CmmSbscrbVO paramVO) throws Exception {
        int result = 1;
        try {
            cmmSbscrbService.registSiteSbscrbstplat(paramVO);
        }catch(NumberFormatException e){
      		 result = 0;
      	}catch(IllegalFormatException e){
      		 result = 0;
      	}catch(ArrayIndexOutOfBoundsException e){
      		 result = 0;
      	} catch(SQLException e){
     		 result = 0;
     	} 
        return result;
    }
    

}

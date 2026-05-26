package egovframework.wzwg.cmm.mber.myPage.service.impl;

import java.util.IllegalFormatException;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyPageService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;


@Service("CmmMyPageService")
public class CmmMyPageServiceImpl extends EgovAbstractServiceImpl implements CmmMyPageService {

	@Resource(name="CmmMyPageDAO")
    private CmmMyPageDAO cmmMyPageDAO;

    public CmmSbscrbVO selectMyPageUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	
    	return cmmMyPageDAO.selectMyPageUsrInfo(cmmSbscrbVO);
    }
    
	public int modifyMyPageUsrInfo(CmmSbscrbVO paramVO) throws Exception {
		
		if(!("").equals(paramVO.getPassword())){
			String password = EgovFileScrty.encryptPassword(paramVO.getPassword());
			paramVO.setPassword(password);
			
			String passwordCnfirm = EgovFileScrty.encryptPassword(paramVO.getPasswordCnfirm());
			paramVO.setPasswordCnfirm(passwordCnfirm);
			
		}
		
		return cmmMyPageDAO.modifyMyPageUsrInfo(paramVO);
	}    

	public int modifyUsrSecsn(CmmSbscrbVO paramVO) {
		
		int retVal = 0;
        
        try {
        	retVal = cmmMyPageDAO.modifyUsrSecsn(paramVO);
        	
			if(retVal > 0) {
				cmmMyPageDAO.modifyUsrCrtfctSecsn(paramVO);
				
				retVal++;
	        } else {
	            retVal = 0;
	        }
        } catch(NullPointerException e){
      	 retVal = 0;
	   	}catch(NumberFormatException e){
	   	 retVal = 0;
	   	}catch(IllegalFormatException e){
	   	 retVal = 0;
	   	}catch(ArrayIndexOutOfBoundsException e){
	   	 retVal = 0;
	   	} 
	   	return retVal;	
	}
	
}

package egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;

@Service("SnsKeyMngrService")
public class SnsKeyMngrServiceImpl extends EgovAbstractServiceImpl implements SnsKeyMngrService {
	
	@Resource(name="SnsKeyMngrDAO")
	SnsKeyMngrDAO SnsKeyMngrDAO;

    public List<SnsKeyMngrVO> selectSnsKeyMngrList(SnsKeyMngrVO paramVO) throws Exception {
        return SnsKeyMngrDAO.selectSnsKeyMngrList(paramVO);
    }
    
    public SnsKeyMngrVO selectSnsKeyMngr(SnsKeyMngrVO paramVO) throws SQLException {
        return SnsKeyMngrDAO.selectSnsKeyMngr(paramVO);
    }

    public int registSnsKeyMngr(SnsKeyMngrVO paramVO) throws Exception {
        
        String[] snsTyCodeArr = paramVO.getSnsTyCodeArr();
        
        int result = 0;
        
        int chkCnt = 0;
        
        try {
        	chkCnt = SnsKeyMngrDAO.selectSnsKeyDeleteChk(paramVO);
        	
        	if (chkCnt > 0) 
                result = SnsKeyMngrDAO.deleteSnsKeyMngr(paramVO);
        	
        	chkCnt = 0;
        	
            if (snsTyCodeArr != null) {
                
                for (int i=0; i<snsTyCodeArr.length; i++) {
                    paramVO.setSnsTyCode(snsTyCodeArr[i]);
                    paramVO.setClientId(paramVO.getClientIdArr()[i]);
                    paramVO.setClientSecret(paramVO.getClientSecretArr()[i]);
    
                    chkCnt = SnsKeyMngrDAO.selectSnsKeyMngrChk(paramVO);
                    
                    if (chkCnt > 0) {
                        result = SnsKeyMngrDAO.modifySnsKeyMngr(paramVO);
                    } else {
                        result = SnsKeyMngrDAO.registSnsKeyMngr(paramVO);
                    }
                }
            }
        } catch(NullPointerException e){
        	result = 0;
	   	}catch(NumberFormatException e){
	   		result = 0;
	   	}catch(IllegalFormatException e){
	   		result = 0;
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		result = 0;
	   	}catch(IOException e){
	   		result = 0;
	   	}catch(SQLException e){
	   		result = 0;
	   	} 
        
        return result;
    }

}

package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;

@Service("CntntsAuthService")
public class CntntsAuthServiceImpl extends EgovAbstractServiceImpl implements CntntsAuthService {
	
	@Resource(name="CntntsAuthDAO")
    private CntntsAuthDAO cntntsAuthDAO;
	
	public CntntsAuthVO selectCntntsAuthForNtt(CntntsAuthVO paramVO) {
		return cntntsAuthDAO.selectCntntsAuthForNtt(paramVO);
	}		

    public List<CntntsAuthVO> selectCntntsAuthList(CntntsAuthVO paramVO) {
        return cntntsAuthDAO.selectCntntsAuthList(paramVO);
    }
    
    public List<CntntsAuthVO> selectCntntsAuthAllList(CntntsAuthVO paramVO) {
        return cntntsAuthDAO.selectCntntsAuthAllList(paramVO);
    } 

    public int registCntntsAuth(CntntsAuthVO paramVO) {
    	
    	int resultInt = 1;
        
    	try {
    		
    		String[] usrGroupArr = paramVO.getUsrgroupSeqArr();
        
    		String[] authorSeArr = paramVO.getAuthorSeArr();
    		
    		if(usrGroupArr == null || authorSeArr == null) {
    			resultInt = 0;
    			return resultInt;
    		}
    		

            if (usrGroupArr.length != authorSeArr.length) {
            	resultInt = 0;
                return resultInt;
            } else {
            	if(paramVO.getUsrgroupSeqArr() == null || paramVO.getAuthorSeArr() == null) {
            		resultInt = 0;
                    return resultInt;
        		}
                for (int i=0; i<paramVO.getAuthorSeArr().length; i++) {
                    paramVO.setAuthorSe(paramVO.getAuthorSeArr()[i]);
                    paramVO.setUsrgroupSeq(paramVO.getUsrgroupSeqArr()[i]);
                    
                    int dupChk = cntntsAuthDAO.selectCntntsAuthChk(paramVO);
                    if(dupChk >0) {
                    	cntntsAuthDAO.updateCntntsAuth(paramVO);	
                    }else {
                    cntntsAuthDAO.registCntntsAuthInfo(paramVO);
                    }
                }
            }
        } catch(NullPointerException e){
        	resultInt = 0;
	   	}catch(NumberFormatException e){
	   		resultInt = 0;
	   	}catch(IllegalFormatException e){
	   		resultInt = 0;
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		resultInt = 0;
	   	} 
        
        return resultInt;
    }
    
	public CntntsAuthVO selectWriteAuthAt(CntntsAuthVO paramVO) {
		return cntntsAuthDAO.selectWriteAuthAt(paramVO);
	}	
	
	public String selectCntntsFileAuthInfo(CntntsAuthVO paramVO) {
		return cntntsAuthDAO.selectCntntsFileAuthInfo(paramVO);
	}
    
    public String selectCntntsSeqAuthInfo(CntntsAuthVO paramVO) {
    	return cntntsAuthDAO.selectCntntsSeqAuthInfo(paramVO);
    }
}
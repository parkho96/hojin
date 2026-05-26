package egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.CntntsChargerService;
import egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.CntntsChargerVO;

@Service("CntntsChargerService")
public class CntntsChargerServiceImpl extends EgovAbstractServiceImpl implements CntntsChargerService {
	
	@Resource(name="CntntsChargerDAO")
    private CntntsChargerDAO cntntsChargerDAO;

    /**
     * ㅁ 컨텐츠담당자정보 - 모듈 컨텐츠 담당자 정보 목록
     * @param CntntsChargerVO
     * @return
     */
    public List<CntntsChargerVO> selectCntntsChargerList(CntntsChargerVO paramVO) {
        return cntntsChargerDAO.selectCntntsChargerList(paramVO);
    }
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 등록
     * @param CntntsAuthVO
     * @return
     */
    public int registCntntsCharger(CntntsChargerVO paramVO) {
        
        String[] usrSeqArr = paramVO.getUsrSeqArr();
        
        int resultInt = 1;
        
        try {
            if (usrSeqArr != null) {
                
                for (int i=0; i<usrSeqArr.length; i++) {
                    paramVO.setUsrSeq(usrSeqArr[i]);
                    
                    cntntsChargerDAO.registCntntsCharger(paramVO);
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
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 삭제
     * @param CntntsAuthVO
     * @return
     */
    public int deleteCntntsCharger(CntntsChargerVO paramVO) {
        return cntntsChargerDAO.deleteCntntsCharger(paramVO);
    }
    
}
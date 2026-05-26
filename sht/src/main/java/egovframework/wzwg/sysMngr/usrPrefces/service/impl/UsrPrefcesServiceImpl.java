package egovframework.wzwg.sysMngr.usrPrefces.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Service("UsrPrefcesService")
public class UsrPrefcesServiceImpl extends EgovAbstractServiceImpl implements UsrPrefcesService {
	
	@Resource(name="UsrPrefcesDAO")
    private UsrPrefcesDAO usrTySbscrbFormDAO;

    /** 회원관리환경설정 조회 **/
	public List<UsrPrefcesVO> selectusrPrefcesIemList(UsrPrefcesVO paramVO) throws Exception {
		
		return usrTySbscrbFormDAO.selectusrPrefcesIemList(paramVO);
	}

    /** 회원관리환경설정 등록/수정 **/
    public int modifyUsrPrefces(UsrPrefcesVO paramVO) throws Exception {
        
        int retVal = 0;
        
        String[] mberSbsfrmCodeArr = paramVO.getUsrMngrestbsCodeArr();
        String[] qesitmEstbsSeArr = paramVO.getQesitmEstbsSeArr();
        String[] pdEstbsCodeArr = paramVO.getPdEstbsCodeArr();
        
        if (mberSbsfrmCodeArr != null 
                && qesitmEstbsSeArr != null 
//                && pdEstbsCodeArr != null
                ) {
            
            if (mberSbsfrmCodeArr.length > 0 
                    && mberSbsfrmCodeArr.length == qesitmEstbsSeArr.length 
//                    && mberSbsfrmCodeArr.length == pdEstbsCodeArr.length
                    ) {
                
                for (int i=0; i<mberSbsfrmCodeArr.length; i++) {

                    paramVO.setUsrMngrestbsCode(mberSbsfrmCodeArr[i]);
                    paramVO.setQesitmEstbsSe(qesitmEstbsSeArr[i]);
                    
                    if (pdEstbsCodeArr != null) {
                        paramVO.setPdEstbsCode(pdEstbsCodeArr[i]);
                    }
                    
                    int chkCnt = usrTySbscrbFormDAO.selectUsrPrefcesIemCnt(paramVO);
                    
                    if (chkCnt > 0) {
                        retVal = usrTySbscrbFormDAO.modifyUsrPrefces(paramVO);
                    } else {
                        retVal = usrTySbscrbFormDAO.registUsrPrefces(paramVO);
                    }
                }
            }
        }
        
        return retVal;
    }

    /** 비밀번호 변경 주기(개월수) **/
    public int selectUpdtEstbsMonth(UsrPrefcesVO paramVO) throws Exception {
        String result = usrTySbscrbFormDAO.selectUpdtEstbsMonth(paramVO);
        
        if (!"".equals(StringUtils.defaultString(result))) {
            return Integer.parseInt(result);
        } else {
            return 9999;
        }
    }
    
  public String selectDupLoginChk(UsrPrefcesVO paramVO) throws Exception {
    	String result ="";
    	result = usrTySbscrbFormDAO.selectDupLoginChk(paramVO);
    	if(result == null || result.equals("")){
    		result ="Y";
    	}
        return result;
    }
	
	public String selectSessionInterval(UsrPrefcesVO paramVO) throws Exception {
		if(paramVO == null || paramVO.getUsrPrefeCode() == null){
			return null;
		}
		return usrTySbscrbFormDAO.selectSessionInterval(paramVO);
	}
}

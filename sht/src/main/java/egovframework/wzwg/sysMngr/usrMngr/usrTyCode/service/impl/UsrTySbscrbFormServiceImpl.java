package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;

@Service("UsrTySbscrbFormService")
public class UsrTySbscrbFormServiceImpl extends EgovAbstractServiceImpl implements UsrTySbscrbFormService {
	
	@Resource(name="UsrTySbscrbFormDAO")
    private UsrTySbscrbFormDAO usrTySbscrbFormDAO;

    /** 회원유형가입양식설정 조회 **/
	public List<UsrTySbscrbFormVO> selectUsrTySbscrbFormList(UsrTySbscrbFormVO paramVO) throws Exception {
		
		return usrTySbscrbFormDAO.selectUsrTySbscrbFormList(paramVO);
	}

    /** 회원유형가입양식설정 등록/수정 **/
    public int modifyUsrTySbscrbForm(UsrTySbscrbFormVO paramVO) throws Exception {
        
        int retVal = 0;
        
        String[] mberSbsfrmCodeArr = paramVO.getMberSbsfrmCodeArr();
        String[] qesitmEstbsSeArr = paramVO.getQesitmEstbsSeArr();
        
        if (mberSbsfrmCodeArr != null && qesitmEstbsSeArr != null) {
            
            if (mberSbsfrmCodeArr.length > 0 && mberSbsfrmCodeArr.length == qesitmEstbsSeArr.length) {
                
                for (int i=0; i<mberSbsfrmCodeArr.length; i++) {

                    paramVO.setMberSbsfrmCode(mberSbsfrmCodeArr[i]);
                    paramVO.setQesitmEstbsSe(qesitmEstbsSeArr[i]);
                    
                    int chkCnt = usrTySbscrbFormDAO.selectUsrTySbscrbFormCnt(paramVO);
                    
                    if (chkCnt > 0) {
                        retVal = usrTySbscrbFormDAO.modifyUsrTySbscrbForm(paramVO);
                    } else {
                        retVal = usrTySbscrbFormDAO.registUsrTySbscrbForm(paramVO);
                    }
                }
            }
        }
        
        return retVal;
    }
	
}

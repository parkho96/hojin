package egovframework.com.cmm.interceptor.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.interceptor.service.AuthenticService;

@Service("AuthenticService")
public class AuthenticServiceImpl extends EgovAbstractServiceImpl implements AuthenticService {

    @Resource(name = "AuthenticDAO")
    private AuthenticDAO authenticDAO;

    /**
     * 메뉴권한체크
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectMenuAuthenticChk(EgovMap paramMap) throws Exception {
	return authenticDAO.selectMenuAuthenticChk(paramMap);
    }
    
    public int selectMenuCntntAuthenticChk(EgovMap paramMap) throws Exception {
	return authenticDAO.selectMenuCntntAuthenticChk(paramMap);
    }
    
    public int selectMenuCmntAuthenticChk(EgovMap paramMap) throws Exception {
	return authenticDAO.selectMenuCmntAuthenticChk(paramMap);
    }
}

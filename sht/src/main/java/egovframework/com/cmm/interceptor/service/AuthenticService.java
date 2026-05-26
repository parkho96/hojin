package egovframework.com.cmm.interceptor.service;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface AuthenticService {


    /**
     * 메뉴권한체크
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    int selectMenuAuthenticChk(EgovMap paramMap) throws Exception;
    int selectMenuCntntAuthenticChk(EgovMap paramMap) throws Exception;
    int selectMenuCmntAuthenticChk(EgovMap paramMap) throws Exception;
}

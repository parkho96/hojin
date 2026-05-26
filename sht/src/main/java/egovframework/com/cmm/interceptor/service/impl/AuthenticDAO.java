package egovframework.com.cmm.interceptor.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.stereotype.Repository;

@Repository("AuthenticDAO")
public class AuthenticDAO extends EgovAbstractMapper {

    /**
     * 메뉴권한체크
     * 
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectMenuAuthenticChk(EgovMap paramMap) throws Exception {
	return ((Integer)selectOne("AuthenticDAO_selectMenuAuthenticChk", paramMap)).intValue();
    }
    
    public int selectMenuCntntAuthenticChk(EgovMap paramMap) throws Exception {
	return ((Integer)selectOne("AuthenticDAO_selectMenuCntntAuthenticChk", paramMap)).intValue();
    }
        
    public int selectMenuCmntAuthenticChk(EgovMap paramMap) throws Exception {
	return ((Integer)selectOne("AuthenticDAO_selectMenuCmntAuthenticChk", paramMap)).intValue();
    }
   
}

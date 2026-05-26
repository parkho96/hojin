package egovframework.wzwg.cmm.mber.cmm.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;

@Repository("CmmRecrtfcDAO")
public class CmmRecrtfcDAO extends EgovAbstractMapper {

    public int modifyUsrSttusCode(CmmLoginVO loginVO) throws Exception {
        return update("CmmRecrtfcDAO_modifyUsrSttusCode", loginVO);
    }

    public int modifySiteUsrSttusCode(CmmLoginVO loginVO) throws Exception {
        return update("CmmRecrtfcDAO_modifySiteUsrSttusCode", loginVO);
    }

    public String selectUserIdByCrtfctSeCd(String userId) throws Exception {
        return (String)selectOne("CmmRecrtfcDAO_selectUserIdByCrtfctSeCd", userId);
    }

    public int selectUsrCrtfctCnt(CmmLoginVO loginVO) throws Exception {
        return (Integer)selectOne("CmmRecrtfcDAO_selectUsrCrtfctCnt", loginVO);
    }
}

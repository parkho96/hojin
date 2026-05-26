package egovframework.wzwg.cmm.authCtrl.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlVO;

@Repository("AuthCtrlDAO")
public class AuthCtrlDAO extends EgovAbstractMapper {

    public AuthCtrlVO selectModuleTable(AuthCtrlVO paramVO) {
        return (AuthCtrlVO)selectOne("AuthCtrlDAO_selectModuleTable", paramVO);
    }
    
    public AuthCtrlVO selectCntntsInfo(AuthCtrlVO paramVO) {
        return (AuthCtrlVO)selectOne("AuthCtrlDAO_selectCntntsInfo", paramVO);
    }
    
    public List<AuthCtrlVO> selectCntntsUsrAuthInfoCnt(AuthCtrlVO paramVO) {
        return selectList("AuthCtrlDAO_selectCntntsUsrAuthInfoCnt", paramVO);
    }
    
    public Integer selectCntntsChrgCnt(AuthCtrlVO paramVO) {
        return (Integer)selectOne("AuthCtrlDAO_selectCntntsChrgCnt", paramVO);
    }
    
    public String selectMenuSeqBySiteCntntsSeq(AuthCtrlVO paramVO) {
        return (String)selectOne("AuthCtrlDAO_selectMenuSeqBySiteCntntsSeq", paramVO);
    }
    
    public String selectMenuSeqByAuthorUseAt(AuthCtrlVO paramVO) {
        return (String)selectOne("AuthCtrlDAO_selectMenuSeqByAuthorUseAt", paramVO);
    }
    
}

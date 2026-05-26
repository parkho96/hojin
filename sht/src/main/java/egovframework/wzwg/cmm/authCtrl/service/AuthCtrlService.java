package egovframework.wzwg.cmm.authCtrl.service;

import java.util.List;


public interface AuthCtrlService {

    public AuthCtrlVO selectModuleTable(AuthCtrlVO paramVO);
    public AuthCtrlVO selectCntntsInfo(AuthCtrlVO paramVO);
    public List<AuthCtrlVO> selectCntntsUsrAuthInfoCnt(AuthCtrlVO paramVO);
    public Integer selectCntntsChrgCnt(AuthCtrlVO paramVO);
    public String selectMenuSeqBySiteCntntsSeq(AuthCtrlVO paramVO);
    public String selectMenuSeqByAuthorUseAt(AuthCtrlVO paramVO) ;
}

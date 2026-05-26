package egovframework.wzwg.cmm.authCtrl.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlService;
import egovframework.wzwg.cmm.authCtrl.service.AuthCtrlVO;

@Service("AuthCtrlService")
public class AuthCtrlServiceImpl implements AuthCtrlService {

    @Resource(name="AuthCtrlDAO")
    private AuthCtrlDAO authCtrlDAO;

    public AuthCtrlVO selectModuleTable(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectModuleTable(paramVO);
    }
    
    public AuthCtrlVO selectCntntsInfo(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectCntntsInfo(paramVO);
    }

    public List<AuthCtrlVO> selectCntntsUsrAuthInfoCnt(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectCntntsUsrAuthInfoCnt(paramVO);
    }
    
    public Integer selectCntntsChrgCnt(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectCntntsChrgCnt(paramVO);
    }
    
    public String selectMenuSeqBySiteCntntsSeq(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectMenuSeqBySiteCntntsSeq(paramVO);
    }
    
    public String selectMenuSeqByAuthorUseAt(AuthCtrlVO paramVO) {
        return authCtrlDAO.selectMenuSeqByAuthorUseAt(paramVO);
    }
    
}

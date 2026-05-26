package egovframework.wzwg.cmm.mber.login.service;

import java.util.List;


public interface CmmLoginService {
    
    public CmmLoginVO selectSiteUsrInfo(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO actionSnsLogin(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO actionLogin(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO actionMergeTransLogin(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO actionSysMngrLogin(CmmLoginVO loginVO) throws Exception;
    public String selectUsrSnsCnfirm(CmmLoginVO loginVO) throws Exception;
    public List<CmmLoginVO> selectSearchUserId(CmmLoginVO loginVO) throws Exception; 
    public String modifyTmprPassword(CmmLoginVO paramVO) throws Exception;
    public String selectSearchUsrInfoCheck(CmmLoginVO paramVO) throws Exception;    
    public CmmLoginVO actionUsrinfoChk(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO selectSiteUsrinfo(CmmLoginVO loginVO) throws Exception;
    public int modifyPwUpdtDe(CmmLoginVO loginVO) throws Exception;
    public int selectSiteUsrCrtfcCnt(CmmLoginVO loginVO) throws Exception;
    public int modifyPwUpdt(CmmLoginVO loginVO) throws Exception;
    public CmmLoginVO getSiteUsrInfoCrtfc(CmmLoginVO loginVO) throws Exception;
    public void modifyUsrPassFailLoginCnt(CmmLoginVO paramVO) throws Exception;
    public void modifyUsrPassFailLoginInit(CmmLoginVO paramVO) throws Exception;
    public String selectPassFailYn(CmmLoginVO loginVO) throws Exception ;
}

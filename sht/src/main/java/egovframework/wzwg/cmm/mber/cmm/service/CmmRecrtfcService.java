package egovframework.wzwg.cmm.mber.cmm.service;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;


public interface CmmRecrtfcService {

    
    public ModelMap getCrtfcEstbsAndNiceModule(HttpServletRequest request, ModelMap model, SbscrbCrtfcEstbsVO secVO);
    public ModelMap getCrtfcEstbsAndNiceModuleLogin(HttpServletRequest request, ModelMap model, SbscrbCrtfcEstbsVO secVO);
    public CmmLoginVO selectSiteUsrInfo(CmmLoginVO loginVO) throws Exception;
    public int updateRecrtfc(CmmLoginVO loginVO) throws Exception;
    public String selectUserIdByCrtfctSeCd(String userId) throws Exception;
    public int selectUsrCrtfctCnt(CmmLoginVO loginVO) throws Exception;
}

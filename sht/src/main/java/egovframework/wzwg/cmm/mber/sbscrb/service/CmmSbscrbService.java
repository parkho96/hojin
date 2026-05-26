package egovframework.wzwg.cmm.mber.sbscrb.service;

import java.util.List;

import org.springframework.ui.ModelMap;

import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;


public interface CmmSbscrbService {

    public Integer selectSbscrbCrtfc(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    public Integer selectSbscrbUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    public List<SiteStplatInfoVO> selectSiteStplatList(SiteStplatInfoVO sysMngrSiteStplatInfoVO) throws Exception;
    public String selectSbscrbUserIdDplctCeck(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    public String selectUserSeq(CmmSbscrbVO cmmSbscrbVO) throws Exception ;
    public int registUsrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception;
	public int registMngrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO, MngrAuthVO mngrAuthVO) throws Exception;
    public List<CmmSbscrbVO> selectSysSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO);  
    public List<CmmSbscrbVO> selectSiteSbscrbUsrTyList(CmmSbscrbVO cmmSbscrbVO);  
    public CmmSbscrbVO selectSiteSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO);
    public CmmSiteInfoVO selectSiteInfo(CmmSiteInfoVO cmmSiteInfoVO) throws Exception;
    public String selectSiteUsrTyCheck(CmmSbscrbVO paramVO);   
    public ModelMap getSiteSbscrbFormCodeSetting(ModelMap model) throws Exception;
    public ModelMap getSiteSbscrbForm(ModelMap model, CmmSbscrbVO paramVO) throws Exception; 
    public CmmLoginVO selectSiteUsrCrtfc(CmmSbscrbVO paramVO) throws Exception;
    public int registUnityUsrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    public void registSiteSbscrbstplat(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    public CmmLoginVO selectSiteUsrCrtfcBySiteSeq(CmmSbscrbVO paramVO) throws Exception;
}

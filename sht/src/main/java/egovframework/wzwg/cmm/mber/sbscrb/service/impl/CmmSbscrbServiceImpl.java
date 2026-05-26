package egovframework.wzwg.cmm.mber.sbscrb.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSiteInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.code.service.impl.CmmCodeDAO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;


@Service("CmmSbscrbService")
@SuppressWarnings("unchecked")
public class CmmSbscrbServiceImpl extends EgovAbstractServiceImpl implements CmmSbscrbService {
    
    /**
     * @uml.property  name="cmmCodeDAO"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name = "CmmCodeDAO")
    private CmmCodeDAO cmmCodeDAO;

	/**
     * @uml.property  name="cmmSbscrbDAO"
     * @uml.associationEnd  readOnly="true"
     */
	@Resource(name="CmmSbscrbDAO")
    private CmmSbscrbDAO cmmSbscrbDAO;
    
    /**
     * @uml.property  name="usrTySbscrbFormService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="UsrTySbscrbFormService")
    private UsrTySbscrbFormService usrTySbscrbFormService;
    
    /**
     * @uml.property  name="sbscrbQesitmService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="SysMngrSbscrbQesitmService")
    private SysMngrSbscrbQesitmService sbscrbQesitmService;
    
    /**
     * @uml.property  name="sbscrbInfoService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="SysMngrSbscrbInfoService")
    private SysMngrSbscrbInfoService sbscrbInfoService;

    /**
     * @uml.property  name="mngrAuthService"
     * @uml.associationEnd  readOnly="true"
     */
    @Resource(name="MngrAuthService")
    private MngrAuthService mngrAuthService;
    
	@Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
    
    public Integer selectSbscrbCrtfc(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	String enpassword = EgovFileScrty.encryptPassword(cmmSbscrbVO.getPassword());
    	cmmSbscrbVO.setPassword(enpassword);
    	
    	return cmmSbscrbDAO.selectSbscrbCrtfc(cmmSbscrbVO);
    }
    
    public Integer selectSbscrbUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return cmmSbscrbDAO.selectSbscrbUsrInfo(cmmSbscrbVO);
    }
    
    public List<SiteStplatInfoVO> selectSiteStplatList(SiteStplatInfoVO sysMngrSiteStplatInfoVO) throws Exception {
    	return cmmSbscrbDAO.selectSiteStplatList(sysMngrSiteStplatInfoVO);
    }
    
    public String selectSbscrbUserIdDplctCeck(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return cmmSbscrbDAO.selectSbscrbUserIdDplctCeck(cmmSbscrbVO);
    }
    
	public int registUsrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {

		int result = 0;
		System.out.println("cmmSbscrbVO.getUnitySbscrbYn() : "+cmmSbscrbVO.getUnitySbscrbYn());
		if(!"Y".equals(cmmSbscrbVO.getUnitySbscrbYn())){
			String enpassword = EgovFileScrty.encryptPassword(cmmSbscrbVO.getPassword());
	    	cmmSbscrbVO.setPassword(enpassword);
	
	    	cmmSbscrbVO.setUsrSeq(cmmSbscrbDAO.selectNextUsrSeq());
		}else{
			cmmSbscrbVO.setUsrSeq(cmmSbscrbDAO.selectSbscrbUserIdDplctCeck(cmmSbscrbVO));
		}
		
		result = cmmSbscrbDAO.registUsrSbscrbInfo(cmmSbscrbVO);
		
		registSiteSbscrbstplat(cmmSbscrbVO);
		
    	return result;
    }
	  public String selectUserSeq(CmmSbscrbVO cmmSbscrbVO) throws Exception {
	    	return cmmSbscrbDAO.selectUserSeq(cmmSbscrbVO);
	    }
	  
    public int registUnityUsrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {

        int result = 0;
        
        result = cmmSbscrbDAO.registUsrSbscrbInfo(cmmSbscrbVO);
        
        registSiteSbscrbstplat(cmmSbscrbVO);
        
        return result;
    }
	
	public void registSiteSbscrbstplat(CmmSbscrbVO cmmSbscrbVO) throws Exception {
        
        List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
        
        if(!"".equals(StringUtils.defaultString(cmmSbscrbVO.getStplatArr()))) {
            
            if(cmmSbscrbVO.getStplatArr() != null){
                cmmSbscrbVO.setStplatArr(cmmSbscrbVO.getStplatArr().replaceAll("&amp;", "&"));
                cmmSbscrbVO.setStplatArr(cmmSbscrbVO.getStplatArr().replaceAll("&quot;", "'"));
                cmmSbscrbVO.setStplatArr(cmmSbscrbVO.getStplatArr().replaceAll("&apos;", "'"));
            }
            
            resultMap = JSONArray.fromObject(JSONSerializer.toJSON(cmmSbscrbVO.getStplatArr()));

            for(Map<String, Object> map : resultMap){
                
                cmmSbscrbVO.setStplatSeq(map.get("stplatSeq").toString());
                cmmSbscrbVO.setStplatdetailSeq(StringUtils.defaultString((String)map.get("stplatdetailSeq")).toString());
                cmmSbscrbVO.setStplatsimpSeq(StringUtils.defaultString((String)map.get("stplatsimpSeq")).toString());
                cmmSbscrbVO.setAgreAt(map.get("agreAt").toString());

                if (!"".equals(StringUtils.defaultString(cmmSbscrbVO.getStplatdetailSeq()))) {

                    cmmSbscrbDAO.registSiteSbscrbstplat(cmmSbscrbVO);
                }
                
                if (!"".equals(StringUtils.defaultString(cmmSbscrbVO.getStplatsimpSeq()))) {

                    cmmSbscrbDAO.registSiteSbscrbstplatSimp(cmmSbscrbVO);
                }
                
            }
        }
	    
	}
	
	public int registMngrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO, MngrAuthVO mngrAuthVO) throws Exception {
		int result = 0;
		
		if(!"Y".equals(cmmSbscrbVO.getUnitySbscrbYn())){
			String enpassword = EgovFileScrty.encryptPassword(cmmSbscrbVO.getPassword());
	    	cmmSbscrbVO.setPassword(enpassword);
	
	    	cmmSbscrbVO.setUsrSeq(cmmSbscrbDAO.selectNextUsrSeq());
		}else{
			cmmSbscrbVO.setUsrSeq(cmmSbscrbDAO.selectSbscrbUserIdDplctCeck(cmmSbscrbVO));
		}
		
		cmmSbscrbVO.setCrtfctSeCode(Globals.USR_STTUS_CRTFC_CODE);
		
		result = cmmSbscrbDAO.registUsrSbscrbInfo(cmmSbscrbVO);
		
        mngrAuthVO.setSiteSeq(cmmSbscrbVO.getSiteSeq());
		mngrAuthVO.setUsrSeq(cmmSbscrbVO.getUsrSeq());
		
		
		
		mngrAuthService.registMngrConAuth(mngrAuthVO);
		if(!mngrAuthVO.getSiteSeq().equals("10000000001")) {
		SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
		siteMngrMenuVO.setSiteSeq(mngrAuthVO.getSiteSeq());
		siteMngrMenuVO.setUsrSeq(mngrAuthVO.getUsrSeq());
		siteMngrMenuVO.setMngrMenuSeqArry(mngrAuthVO.getMngrMenuSeqArry());
		siteMngrMenuVO.setUserId(cmmSbscrbVO.getUserId());
		siteMngrMenuService.registSiteMenuAuth(siteMngrMenuVO);
		}
		
		return result;
	}
    
    public List<CmmSbscrbVO> selectSysSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO) {
        return cmmSbscrbDAO.selectSysSbscrbUsrTy(cmmSbscrbVO);
    }
  
    public List<CmmSbscrbVO> selectSiteSbscrbUsrTyList(CmmSbscrbVO cmmSbscrbVO) {
        return cmmSbscrbDAO.selectSiteSbscrbUsrTyList(cmmSbscrbVO);
    }   
  
    public CmmSbscrbVO selectSiteSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO) {
        return cmmSbscrbDAO.selectSiteSbscrbUsrTy(cmmSbscrbVO);
    }   

    public CmmSiteInfoVO selectSiteInfo(CmmSiteInfoVO cmmSiteInfoVO) throws Exception {
        return cmmSbscrbDAO.selectSiteInfo(cmmSiteInfoVO);
    }
    
    public String selectSiteUsrTyCheck(CmmSbscrbVO paramVO) {
        return cmmSbscrbDAO.selectSiteUsrTyCheck(paramVO);
    }
    
    public ModelMap getSiteSbscrbFormCodeSetting(ModelMap model) throws Exception {
        
        List<CmmCodeVO> usrTyCdList = cmmCodeDAO.selectCmmCodeList("USR_TY_CODE");
        model.addAttribute("usrTyCdList", usrTyCdList);
        
        List<CmmCodeVO> usrSttusList = cmmCodeDAO.selectCmmCodeList("USR_STTUS_CODE");
        model.addAttribute("usrSttusList", usrSttusList);
        
        List<CmmCodeVO> hTelnoList = cmmCodeDAO.selectCmmCodeList("HTELCD");
        model.addAttribute("hTelnoList", hTelnoList);

        List<CmmCodeVO> mTelnoList = cmmCodeDAO.selectCmmCodeList("MTELCD");
        model.addAttribute("mTelnoList", mTelnoList);
        
        return model;
    }
    
    public ModelMap getSiteSbscrbForm(ModelMap model, CmmSbscrbVO paramVO) throws Exception {
        
        String frmGubun = StringUtils.defaultString(paramVO.getFrmGubun());

        SysMngrSbscrbVO resultVO = new SysMngrSbscrbVO();

        int result = sbscrbInfoService.selectSbscrbinfoSeq(paramVO);
        
        List<SysMngrSbscrbVO> qesitmList = null;
        List<SysMngrSbscrbVO> iemList   = null;
        if(result > 0){
            
            resultVO = sbscrbInfoService.selectSbscrbInfoDetail(paramVO);
            
            if (resultVO != null) {  
                getSiteSbscrbFormCodeSetting(model);
                
                UsrTySbscrbFormVO sbsFormVO = new UsrTySbscrbFormVO();
                
                sbsFormVO.setGrpcode("MBER_SBSCRB_FORM");
                sbsFormVO.setCode(resultVO.getUsrTyCode());
                
                List<UsrTySbscrbFormVO> sbsFormList = usrTySbscrbFormService.selectUsrTySbscrbFormList(sbsFormVO);
                model.addAttribute("sbsFormList", sbsFormList);   
            }

            if ("M".equals(frmGubun)) {
                qesitmList  = sbscrbQesitmService.selectSbscrbQesitmUsrRspns(paramVO);
            } else {
                qesitmList  = sbscrbQesitmService.selectSbscrbQesitmList(paramVO);
            }
            
            if (qesitmList != null && !qesitmList.isEmpty()) {
            	if(qesitmList.get(0) != null && qesitmList.get(0).getSbscrbinfoSeq() != null && resultVO != null) {
	                resultVO.setSbscrbinfoSeq(qesitmList.get(0).getSbscrbinfoSeq());
	                iemList = sbscrbQesitmService.selectSbscrbIemList(resultVO);
            	}
            }
        }else{
            resultVO.setSiteSeq(resultVO.getSiteSeq());
        }
        System.out.println("\n\n\n");
        
        model.addAttribute("qesitmList", qesitmList);
        model.addAttribute("iemList", iemList);
        model.addAttribute("resultVO", resultVO);
        
        return model;
    }
    
    public CmmLoginVO selectSiteUsrCrtfc(CmmSbscrbVO paramVO) throws Exception {
        return cmmSbscrbDAO.selectSiteUsrCrtfc(paramVO);
    }
    
    public CmmLoginVO selectSiteUsrCrtfcBySiteSeq(CmmSbscrbVO paramVO) throws Exception {
        return cmmSbscrbDAO.selectSiteUsrCrtfcBySiteSeq(paramVO);
    }
}

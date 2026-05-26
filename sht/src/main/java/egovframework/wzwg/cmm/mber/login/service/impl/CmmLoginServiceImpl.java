package egovframework.wzwg.cmm.mber.login.service.impl;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.List;
import java.util.Random;

import jakarta.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;


@Service("CmmLoginService")
public class CmmLoginServiceImpl extends EgovAbstractServiceImpl implements CmmLoginService {

    @Resource(name="egovMessageSource")
    private EgovMessageSource egovMessageSource;
    
    @Resource(name="CmmLoginDAO")
    private CmmLoginDAO loginDAO;
    
    protected static final Log LOG = LogFactory.getLog(CmmLoginServiceImpl.class);
    
    public CmmLoginVO selectSiteUsrInfo(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);
        
        return loginDAO.actionLogin(loginVO);
    }
    
    public CmmLoginVO getSiteUsrInfoCrtfc(CmmLoginVO loginVO) throws Exception {
        
        if (loginVO != null) {
            
            String errMsg = setErrMsg(loginVO.getUsrSttusCode(), Integer.parseInt(loginVO.getLastUpdtDe()));
            
            if ("".equals(errMsg)) {
                errMsg = setErrMsg(loginVO.getSiteUsrSttusCode(), Integer.parseInt(loginVO.getLastUpdtDe()));
            }
            
            loginVO.setErrMsg(errMsg);
        }
        
        return loginVO;
    }
    
    public CmmLoginVO actionSnsLogin(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);
        
        CmmLoginVO getVO = loginDAO.actionSnsLogin(loginVO);
        
        return getSiteUsrInfoCrtfc(getVO);
    }
    
    public CmmLoginVO actionLogin(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);
        
        CmmLoginVO getVO = loginDAO.actionLogin(loginVO);
        
        return getSiteUsrInfoCrtfc(getVO);
    }
    
    public CmmLoginVO actionMergeTransLogin(CmmLoginVO loginVO) throws Exception {
      CmmLoginVO getVO = loginDAO.actionMergeTransLogin(loginVO);
        
        return getVO;
    }

    public CmmLoginVO actionSysMngrLogin(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);
        
        CmmLoginVO getVO = loginDAO.actionSysMngrLogin(loginVO);
        
        if (getVO != null) {

            String usrSttusCode = StringUtils.defaultString(getVO.getUsrSttusCode());
            String siteUsrSttusCode = StringUtils.defaultString(getVO.getSiteUsrSttusCode());
            
            if (!usrSttusCode.equals(Globals.USR_STTUS_CRTFC_CODE) 
                || !siteUsrSttusCode.equals(Globals.USR_STTUS_CRTFC_CODE)) {
                
                getVO = new CmmLoginVO();
                getVO.setErrMsg(egovMessageSource.getMessage("fail.common.login.crtfc"));
            }
        }
        
        return getVO;
    }
    
    public String selectUsrSnsCnfirm(CmmLoginVO loginVO) throws Exception {
        return loginDAO.selectUsrSnsCnfirm(loginVO);
    }
    
    public List<CmmLoginVO> selectSearchUserId(CmmLoginVO loginVO) throws Exception {

        return loginDAO.selectSearchUserId(loginVO);
    }  
    
    public String modifyTmprPassword(CmmLoginVO paramVO) throws Exception {
    	int result = 0;
    	String tmprPassword = "";
    	
    	String usrSeq = loginDAO.selectSearchUsrInfoCheck(paramVO);
    	
    	if(usrSeq != null) {

    		tmprPassword = getRandomVal("str");

    		String enpassword = EgovFileScrty.encryptPassword(tmprPassword);

    		paramVO.setPassword(enpassword);
    		paramVO.setUsrSeq(usrSeq);
    		result = loginDAO.modifyTmprPassword(paramVO);
    		
    		if(result == 0) {
    			tmprPassword = "";
    		}
    	}

        return tmprPassword;
    }     
    
    public String selectSearchUsrInfoCheck(CmmLoginVO paramVO) throws Exception {
        return loginDAO.selectSearchUsrInfoCheck(paramVO);
    }    
    
    public CmmLoginVO actionUsrinfoChk(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);

        CmmLoginVO getVO = loginDAO.actionUsrinfoChk(loginVO);
        
        if (getVO != null) {
            getVO.setErrMsg(setDefaultErrMsg(getVO.getUsrSttusCode()));
        } else {
            getVO = new CmmLoginVO();
            getVO.setErrMsg("fail.common.login");
        }
        
        return getVO;
    }

    public CmmLoginVO selectSiteUsrinfo(CmmLoginVO loginVO) throws Exception {

        CmmLoginVO getVO = loginDAO.selectSiteUsrinfo(loginVO);
        
        if (getVO != null) {
            getVO.setErrMsg(setDefaultErrMsg(getVO.getUsrSttusCode()));
        } else {
            getVO = new CmmLoginVO();
            getVO.setErrMsg("fail.common.login");
        }
        
        return getVO;
    }
    
    private String setDefaultErrMsg(String usrSttusCode) {
        
        String retMsg = "";
        
        usrSttusCode = StringUtils.defaultString(usrSttusCode);
        
        if (!usrSttusCode.equals(Globals.USR_STTUS_CRTFC_CODE)) {
            
            retMsg = egovMessageSource.getMessage("fail.common.login.crtfc");
        }
        
        return retMsg;
    }
    
    private String setErrMsg(String usrSttusCode, int lastUpdtDe) {
        
        String retMsg = "";
        
        usrSttusCode = StringUtils.defaultString(usrSttusCode);
        
        if (usrSttusCode.equals(Globals.USR_STTUS_QUIT_CODE)) {
            
            int usrRentrnDay = Integer.parseInt(Globals.USR_REENTRN_DAY);
            
            if (lastUpdtDe <= usrRentrnDay) {
                retMsg = Globals.USR_RE_CRTFC;
            }
        }
        
        return ("".equals(retMsg))? setDefaultErrMsg(usrSttusCode):retMsg;
    }
    
	protected String getRandomVal(String type) {  
	    String val = "";      
	    try {
	    if(type.equals("chr")) {
		    int ranChar;
			
		    // 정수 오버플로우 방지를 위한 안전한 연산
		    int baseValue = 65;
		    int randomRange = SecureRandom.getInstance("SHA1PRNG").nextInt(25); // 0~24
		    
		    // 오버플로우 체크
		    if (randomRange < 0 || baseValue > Integer.MAX_VALUE - randomRange) {
		        ranChar = 65; // 기본값으로 'A' 사용
		    } else {
		        ranChar = baseValue + randomRange;
		    }
			
		    char ch = (char)ranChar;        
		    val += ch;      
	    }else if(type.equals("num")) {
		    Random r = new Random();
		    
		    // 정수 오버플로우 방지를 위한 안전한 연산
		    int baseValue = 100000;
		    int randomValue = (int)(SecureRandom.getInstance("SHA1PRNG").nextFloat() * 899900);
		    int numbers;
		    
		    // 오버플로우 체크
		    if (randomValue < 0 || baseValue > Integer.MAX_VALUE - randomValue) {
		        numbers = 100000; // 기본값 사용
		    } else {
		        numbers = baseValue + randomValue;
		    }
		    
		    if (numbers < Integer.MAX_VALUE)
		    {
		    val += String.valueOf(numbers);
		    }
		    
	    }else if(type.equals("str")) {
		    for(int i = 0; i<10;){
		        // 정수 오버플로우 방지를 위한 안전한 연산
		        int baseValue = 48;
		        int randomRange = (SecureRandom.getInstance("SHA1PRNG")).nextInt(25); // 0~24 (기존과 동일)
		        int ranAny;
		        
		        // 오버플로우 체크
		        if (randomRange < 0 || baseValue > Integer.MAX_VALUE - randomRange) {
		            ranAny = 48; // 기본값 사용
		        } else {
		            ranAny = baseValue + randomRange;
		        }
	
		        if(!(57 < ranAny && ranAny<= 65)){
			        char c = (char)ranAny;      
			        val += c;
			        i++;
		        }	
		    }
	    }
	    } catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
	    	LOG.error("NoSuchAlgorithmException",e);
		}
	    return val;
	}    
	
    public int selectSiteUsrCrtfcCnt(CmmLoginVO loginVO) throws Exception {

        return loginDAO.selectSiteUsrCrtfcCnt(loginVO);
    }
	
    public int modifyPwUpdtDe(CmmLoginVO loginVO) throws Exception {

        return loginDAO.modifyPwUpdtDe(loginVO);
    }

    public int modifyPwUpdt(CmmLoginVO loginVO) throws Exception {

        String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
        loginVO.setPassword(enpassword);

        int returnVal = loginDAO.modifyPwUpdt(loginVO);
        
        return returnVal;
    }
    
    public void modifyUsrPassFailLoginCnt(CmmLoginVO paramVO) throws Exception {
  	  loginDAO.modifyUsrPassFailLoginCnt(paramVO);
  }     
  
  public void modifyUsrPassFailLoginInit(CmmLoginVO paramVO) throws Exception {
  		  loginDAO.modifyUsrPassFailLoginInit(paramVO);
  }     
  
  public String selectPassFailYn(CmmLoginVO loginVO) throws Exception {
      return loginDAO.selectPassFailYn(loginVO);
  } 
    
}

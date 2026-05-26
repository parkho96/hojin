package egovframework.wzwg.cmm.crtfc;

import java.util.HashMap;
import java.util.UUID;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CmmNiceCrtfcUtil {

    public CmmNiceCrtfcUtil() {
        super();
    }
    
    @Resource(name="egovMessageSource")
    private static EgovMessageSource egovMessageSource;

    public static HashMap<String, String> getNiceCrtfcKey(HttpServletRequest request) {
    	String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
        
        String sSiteCode = Globals.CRTFC_SITE_CODE;
        String sSitePassword = Globals.CRTFC_SITE_PW;
        
        String sRequestNumber = Globals.CRTFC_REQ_NUM; 

        sRequestNumber = niceCheck.getRequestNO(sSiteCode);
        CmmSessionUtil.setSessionValue(request, "REQ_SEQ" , sRequestNumber);
        
        String sAuthType = "";
        
        String popgubun     = "N";
        String customize    = "";
        
        String sGender = ""; 
        
        String domain = request.getRequestURL().toString().replace(request.getRequestURI(),"");
        String sReturnUrl = domain+wzwgContext+"/cmm/mber/sbscrb/selectSbscrbCrtfcResult.do";
        String sErrorUrl = domain+wzwgContext+"/cmm/mber/sbscrb/selectSbscrbCrtfcFail.do";

        String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
                            "8:SITECODE" + sSiteCode.getBytes().length + ":" + sSiteCode +
                            "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                            "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                            "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                            "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
                            "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize + 
                            "6:GENDER" + sGender.getBytes().length + ":" + sGender;
        
        String sMessage = "";
        String sEncData = "";
        
        int iReturn = niceCheck.fnEncode(sSiteCode, sSitePassword, sPlainData);
        if( iReturn == 0 ) {
            sEncData = niceCheck.getCipherData();
        } else if( iReturn == -1) {
            sMessage = "암호화 시스템 에러입니다.";
        } else if( iReturn == -2) {
            sMessage = "암호화 처리오류입니다.";
        } else if( iReturn == -3) {
            sMessage = "암호화 데이터 오류입니다.";
        } else if( iReturn == -9) {
            sMessage = "입력 데이터 오류입니다.";
        } else {
            sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
        }
        
        HashMap<String, String> retMap = new HashMap<String, String>();

        retMap.put("sEncData", sEncData);
        retMap.put("sMessage", sMessage);
        
        return retMap;
    }

    public static HashMap<String, String> getNiceCrtfcDupInfo(HttpServletRequest request) {
        NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();
    
        String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");

        String sSiteCode = Globals.CRTFC_SITE_CODE;
        String sSitePassword = Globals.CRTFC_SITE_PW;
        
        String sRequestNumber = "";
        String sResponseNumber = "";
        String sAuthType = "";
        String sDupInfo = "";
        String sMessage = "";
        String sPlainData = "";
        
        int iReturn = niceCheck.fnDecode(sSiteCode, sSitePassword, sEncodeData);
    
        if( iReturn == 0 ) {
            sPlainData = niceCheck.getPlainData();
            
            HashMap mapresult = niceCheck.fnParse(sPlainData);
            
            sRequestNumber  = (String)mapresult.get("REQ_SEQ");
            sDupInfo        = (String)mapresult.get("DI");
            
            String session_sRequestNumber = CmmSessionUtil.getSessionValue(request, "REQ_SEQ");
            if(!sRequestNumber.equals(session_sRequestNumber)) {
                sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
                sResponseNumber = "";
                sAuthType = "";
                sDupInfo = "";
            }
        } else if( iReturn == -1) {
            sMessage = "복호화 시스템 에러입니다.";
        } else if( iReturn == -4) {
            sMessage = "복호화 처리오류입니다.";
        } else if( iReturn == -5) {
            sMessage = "복호화 해쉬 오류입니다.";
        } else if( iReturn == -6) {
            sMessage = "복호화 데이터 오류입니다.";
        } else if( iReturn == -9) {
            sMessage = "입력 데이터 오류입니다.";
        } else if( iReturn == -12) {
            sMessage = "사이트 패스워드 오류입니다.";
        } else {
            sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
        }
        
        HashMap<String, String> retMap = new HashMap<String, String>();

        retMap.put("sDupInfo", sDupInfo);
        retMap.put("sMessage", sMessage);
        
        return retMap;
    }

    public static HashMap<String, String> getNiceCrtfcError() {
        
        HashMap<String, String> retMap = new HashMap<String, String>();
        
        retMap.put("sMessage", egovMessageSource.getMessage("fail.common.msg"));
        
        return retMap;
    }

    public static HashMap<String, String> getNiceCrtfcDupInfoTest() {

        HashMap<String, String> retMap = new HashMap<String, String>();
        
        retMap.put("sDupInfo", "test"+UUID.randomUUID().toString());
        
        return retMap;
    }
    
    private static String requestReplace (String paramValue, String gubun) {

        String result = "";
        
        if (paramValue != null) {
            
            paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

            paramValue = paramValue.replaceAll("\\*", "");
            paramValue = paramValue.replaceAll("\\?", "");
            paramValue = paramValue.replaceAll("\\[", "");
            paramValue = paramValue.replaceAll("\\{", "");
            paramValue = paramValue.replaceAll("\\(", "");
            paramValue = paramValue.replaceAll("\\)", "");
            paramValue = paramValue.replaceAll("\\^", "");
            paramValue = paramValue.replaceAll("\\$", "");
            paramValue = paramValue.replaceAll("'", "");
            paramValue = paramValue.replaceAll("@", "");
            paramValue = paramValue.replaceAll("%", "");
            paramValue = paramValue.replaceAll(";", "");
            paramValue = paramValue.replaceAll(":", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll("#", "");
            paramValue = paramValue.replaceAll("--", "");
            paramValue = paramValue.replaceAll("-", "");
            paramValue = paramValue.replaceAll(",", "");
            
            if(gubun != "encodeData"){
                paramValue = paramValue.replaceAll("\\+", "");
                paramValue = paramValue.replaceAll("/", "");
                paramValue = paramValue.replaceAll("=", "");
            }
            
            result = paramValue;
            
        }
        return result;
  }
}

package egovframework.wzwg.sysMngr.usrPrefces.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsrPrefcesVO {

    /** 회원유형코드 **/
    private String usrPrefeCode;
    
    /** 회원가입양식코드 **/
    private String usrMngrestbsCode;
    
    /** 회원가입양식코드명 **/
    private String usrMngrestbsCodeNm;

    /** 회원가입양식코드호출펀션 **/
    private String usrMngrestbsCodeFunc;
    
    /** 항목설정코드 **/
    private String qesitmEstbsSe;
    
    /** 그룹코드 **/
    private String grpcode;
    
    /** 회원ID **/
    private String userId;
    
    /** 기간설정코드 **/
    private String pdEstbsCode;

    /** 회원가입양식코드 저장을 위한 배열 **/
    private String[] usrMngrestbsCodeArr;

    /** 문항설정구분 저장을 위한 배열 **/
    private String[] qesitmEstbsSeArr;
    
    /** 기간설정코드 저장을 위한 배열 **/
    private String[] pdEstbsCodeArr;
    
    /** 공통코드 **/
    private String code;
    
    private String langCode;
    
    private String siteSeq;
    
    private String clientId;
    
    public String[] getUsrMngrestbsCodeArr() {
    	if(usrMngrestbsCodeArr != null) {
            return Arrays.copyOf(usrMngrestbsCodeArr,usrMngrestbsCodeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setUsrMngrestbsCodeArr(String[] usrMngrestbsCodeArr) {
		if (usrMngrestbsCodeArr != null) {
			this.usrMngrestbsCodeArr = Arrays.copyOf(usrMngrestbsCodeArr, usrMngrestbsCodeArr.length);
		} else {
			this.usrMngrestbsCodeArr = null;
		}
    }

    public String[] getQesitmEstbsSeArr() {
    	if(qesitmEstbsSeArr != null) {
            return Arrays.copyOf(qesitmEstbsSeArr,qesitmEstbsSeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setQesitmEstbsSeArr(String[] qesitmEstbsSeArr) {
		if (qesitmEstbsSeArr != null) {
			this.qesitmEstbsSeArr = Arrays.copyOf(qesitmEstbsSeArr, qesitmEstbsSeArr.length);
		} else {
			this.qesitmEstbsSeArr = null;
		}
    }

    public String[] getPdEstbsCodeArr() {
    	if(pdEstbsCodeArr != null) {
            return Arrays.copyOf(pdEstbsCodeArr,pdEstbsCodeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setPdEstbsCodeArr(String[] pdEstbsCodeArr) {
		if (pdEstbsCodeArr != null) {
			this.pdEstbsCodeArr = Arrays.copyOf(pdEstbsCodeArr, pdEstbsCodeArr.length);
		} else {
			this.pdEstbsCodeArr = null;
		}
    }
	
}

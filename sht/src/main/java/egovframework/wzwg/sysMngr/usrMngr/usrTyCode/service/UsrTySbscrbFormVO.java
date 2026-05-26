package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class UsrTySbscrbFormVO {

    /** 회원유형코드 **/
    private String usrTyCode;
    
    /** 회원가입양식코드 **/
    private String mberSbsfrmCode;
    
    /** 회원가입양식코드명 **/
    private String mberSbsfrmCodeNm;
    
    /** 항목설정코드 **/
    private String qesitmEstbsSe;
    
    /** 그룹코드 **/
    private String grpcode;
    
    /** 회원ID **/
    private String userId;

    /** 회원가입양식코드 저장을 위한 배열 **/
    private String[] mberSbsfrmCodeArr;

    /** 문항설정구분 저장을 위한 배열 **/
    private String[] qesitmEstbsSeArr;
    
    /** 공통코드 **/
    private String code;
    
    private String usrTySeq;
    
    private String langCode;
    
    public String[] getMberSbsfrmCodeArr() {
    	if(mberSbsfrmCodeArr != null) {
            return Arrays.copyOf(mberSbsfrmCodeArr,mberSbsfrmCodeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setMberSbsfrmCodeArr(String[] mberSbsfrmCodeArr) {
		if (mberSbsfrmCodeArr != null) {
			this.mberSbsfrmCodeArr = Arrays.copyOf(mberSbsfrmCodeArr, mberSbsfrmCodeArr.length);
		} else {
			this.mberSbsfrmCodeArr = null;
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

}

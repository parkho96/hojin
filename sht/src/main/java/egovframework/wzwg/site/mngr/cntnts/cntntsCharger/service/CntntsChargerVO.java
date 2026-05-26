package egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class CntntsChargerVO implements Serializable  {

	private static final long serialVersionUID = 1L;

    /** 사이트SEQ **/
	private String siteSeq;
	
	/** 사이트컨텐츠SEQ **/
    private String sitecntntsSeq;

    /** 컨텐츠SEQ **/
    private String cntntschrgSeq;

    /** 사용자SEQ **/
    private String usrSeq;

    /** 사용자ID **/
    private String usrId;

    /** 사용자명 **/
    private String usrNm;
    
    /** 컨텐츠담당자타입코드 **/
    private String cntntschrgTyCode;

    /** 컨텐츠담당자타입코드명 **/
    private String cntntschrgTyNm;

    /** 컨텐츠담당자설명 **/
    private String cntntsChrgDc;

    /** 최초등록자 **/
    private String frstRegisterId;
    
    /** 최초등록일시 **/
    private String frstRegistPnttm;

    /** 최종등록자 **/
    private String lastUpdusrId;
    
    /** 최종등록일시 **/
    private String lastUpdtPnttm;

    /** 조회조건 **/
    private String searchCondition;

    /** 검색어 **/
    private String searchKeyword;

    /** 사용자SEQ - 선택저장 **/
    private String[] usrSeqArr;
    
    private String langCode;
    
    public String[] getUsrSeqArr() {
    	if(usrSeqArr != null) {
            return Arrays.copyOf(usrSeqArr,usrSeqArr.length);
    	}else {
    		return null;
    	}
    }

    public void setUsrSeqArr(String[] usrSeqArr) {
		if (usrSeqArr != null) {
			this.usrSeqArr = Arrays.copyOf(usrSeqArr, usrSeqArr.length);
		} else {
			this.usrSeqArr = null;
		}
    }

}

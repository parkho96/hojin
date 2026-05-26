package egovframework.wzwg.sysMngr.usrMngr.usrStplat.service;

import java.io.Serializable;
import java.util.Arrays;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrUsrStplatVO extends SysMngrSiteInfoVO implements Serializable {

	/* 사이트SEQ */
	private String siteSeq;
		
	/* 가입정보SEQ */
	private String sbscrbinfoSeq;

	/* 가입안내내용 */
	private String sbscrbGuidCn;
	
	/* 가입질문 설정여부 */
	private String sbscrbQestnEstbsAt;
	
	/* 가입신청 제한여부 */
	private String sbscrbReqstLmttAt;
	
	/* 가입제한 시작일 */
	private String sbscrbLmttBgnde;
	
	/* 가입제한 종료일 */
	private String sbscrbLmttEndde;
	
	/* 가입조건성별 */
	private String sbscrbCndSexdstn;
	
	/* 가입조건연령 */
	private String sbscrbCndAgeLmttAt;
	
	/* 가입조건연령 시작년도 */
	private String sbscrbAgeBeginYear;
	
	/* 가입조건연령 종료년도 */
	private String sbscrbAgeEndYear;
	
	/* 실명인증여부 */
	private String lsftCrtfcAt;
	
	/* 휴대전화인증여부 */
	private String moblphonCrtfcAt;
	
	/* 인증서인증여부 */
	private String crtfctCrtfcAt;
	
	/* 가입문항SEQ */
	private String sbscrbqesitmSeq;
	
	/* 문항구분 */
	private String qesitmSe;
	
	/* 문항제목 */
	private String qesitmSj;
	
	/* 항목 SEQ */
	private String sbscrbiemSeq;
	
	/* 항목제목 */
	private String iemSj;
	
	/* 순서 */
	private String ordr; 
	
	/*사용여부*/
	private String useAt;

	/*최초등록자ID*/
	private String frstRegisterId;

	/*최초등록시점*/
	private String frstRegistPnttm;

	/*최종수정자ID*/
	private String lastUpdusrId;

	/*최종수정시점*/
	private String lastUpdtPnttm;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 10;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** firstIndex */
    private int firstIndex = 1;

    /** lastIndex */
    private int lastIndex = 1;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /* 검색구분 */
    private String searchCondition;
    
    /* 검색keyword */
    private String searchKeyword;
    
    private String qesitmArr = "";
    
    private String iemArr = "";
    
    
    private String usrstplatSeq;
    private String usrstphistSeq;
    private String stplatTyCode;
    private String stplatTyCodeNm;
    private String stplatSj;
    private String stplatCn;
    private String stplatEstbsSe;
    private String stplatEstbsPnttm;
    private String userId;
    private String[] usrstphistSeqArr;
    
    public String[] getUsrstphistSeqArr() {
    	if(usrstphistSeqArr != null) {
        	return Arrays.copyOf(usrstphistSeqArr,usrstphistSeqArr.length);
    	}else {
    		return null;
    	}
    }

    public void setUsrstphistSeqArr(String[] usrstphistSeqArr) {
		if (usrstphistSeqArr != null) {
			this.usrstphistSeqArr = Arrays.copyOf(usrstphistSeqArr, usrstphistSeqArr.length);
		} else {
			this.usrstphistSeqArr = null;
		}
    }
    
}

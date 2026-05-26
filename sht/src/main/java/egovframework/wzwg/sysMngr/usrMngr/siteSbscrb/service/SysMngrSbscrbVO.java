package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service;

import java.io.Serializable;

import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSbscrbVO extends SysMngrSiteInfoVO implements Serializable {
		
	/* 가입정보SEQ */
	private String sbscrbinfoSeq;

	/* 회원SEQ */
	private String usrSeq;
	
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
	
	/* 사용여부 */
	private String useAt;
    
    /* 검색구분 */
    private String searchCondition;
    
    /* 검색keyword */
    private String searchKeyword;
    
    private String qesitmArr;
    
    private String iemArr;
    
    private String rspnsArr;

	/* 가입응답SEQ */
	private String sbscrbrspns;
	
	/* 주관식응답 */
	private String sbjctRspns;
    
	/* 사용자 응답 */
	private String rspnsVal;
	
	/** 회원유형코드 **/
	private String usrTyCode;
	
	/** 회원유형 **/
	private String usrtySeq;

    /** 가입대상여부 **/
	private String sbscrbTrgetAt;

    /** 기본그룹SEQ **/
	private String bassGroupSeq;
	
}

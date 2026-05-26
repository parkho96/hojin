package egovframework.wzwg.module.schdul.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleSchdulBassInfoVO {
	
	/* 사이트 seq */
	private String siteSeq;
	
	/* 일정 seq */
	private String schdulSeq;
	
	/* 일정명 */
	private String schdulNm;
	
	/* 일정설명 */
	private String schdulDc;
	
	/* 식단사용여부 */
	private String dietaryUseAt;
	
	/* 회의록 사용여부 */
	private String minutesUseAt;
	
	/* 첨부파일 사용여부 */
	private String fileUseAt;
	
	/* 사용여부 */
	private String useAt;
	
	/* 최초등록자ID */
	private String frstRegisterId;

	/* 최초등록시점 */
	private String frstRegistPnttm;

	/* 최종수정자ID */
	private String lastUpdusrId;

	/* 최종수정시점 */
	private String lastUpdtPnttm;
	
	/* 일정 기능 */
	private String schdulSkll;
	
	/* 일정 CSS SEQ */
	private String cssSeq;
	
	/** 컨텐츠 시퀀스 */
	private String sitecntntsSeq;
    
	/** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
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
    
    /* 정렬 구분(A:오름차순, D:내림차순) */
    private String ordrSe;
    
    /* 정렬 조건 */
    private String searchCnd;
    
    private String ctgrySeqArr;
	
	private String ctgryColorCodeArr;
	
	private String ctgryNmArr;
	
	private String atchFileId;
	
	private String initScrin;
	
	private String hldyAt;
	
	private String sysmoduleSeq;
	
	private String cntntsSeq;
	
	private String cntntsNm;
	
	private String conncntntsSeq;
	
	private String ctgrySeq;
	
	private String ctgryNm;
	
	private String ctgryColorCode;
	
	private String langCode;
	
	private String schdulDetaSeq;
	
	private String day2;
	
	private String menuSeq;
	
	private String searchYYYYMM;
	
	private String bgnde; 
	
	private String beginTime;
	
	private String endde;
	
	private String endTime;
	

	private String delSchdulSeq;
	private String delSitecntntsSeq;
	private String delCntntsSeq;
	private String delCtgrySeq;
	
	private String sun;
	private String mon;
	private String tue;
	private String wed;
	private String thu;
	private String fri;
	private String sat;


}

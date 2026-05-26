package egovframework.wzwg.module.ntt.schdul.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttSchdulDataManageVO {
	
	/*사이트SEQ*/
	private String siteSeq;
	/*세부일정SEQ*/
	private String schdetaSeq;
	/*일정SEQ*/
	private String schdulSeq;
	/*아이콘SEQ*/
	private String iconSeq;
	/*세부일정명*/
	private String schdulNm;
	/*세부일정설명*/
	private String cn;
	/*시작일*/
	private String bgnde;
	/*시작시간*/
	private String beginTime;
	/*종료일*/
	private String endde;
	/*종료시간*/
	private String endTime;
	/*첨부파일ID*/
	private String atchFileId;
	/*공개여부*/
	private String othbcAt;
	/*사용여부*/
	private String useAt;
	/*범주시퀀스*/
	private String ctgrySeq;
	/*범주코드*/
	private String ctgryColorCode;
	/*최초등록자ID*/
	private String frstRegisterId;
	/*최초등록시점*/
	private String frstRegistPnttm;
	/*최종수정자ID*/
	private String lastUpdusrId;
	/*최종수정시점*/
	private String lastUpdtPnttm;
	
	/*식단구분코드*/
	private String mlsvSe;
	/*식단*/
	private String menu;
	/*칼로리*/
	private String calri;
	/*장소*/
	private String place;

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
    
    /** 검색 연도 */
    private String searchYear = "";
    
    /** 검색 월 */
    private String searchMonth = "";
    
    /** 검색 일 */
    private String searchDay = "";
    
    /** 검색 날짜 */
    private String searchDate = "";
    
    /** 검색 날짜 */
    private String searchWeek = "";
    
    /** 회의록 사용여부 */
    private String minutesUseAt;
    
    /** 아이콘 경로 */
    private String iconPath;

    private String bgndeWeek;
    private String bgndeWeekCnt;
    private String bgndeDay;

    private String enddeWeek;
    private String enddeWeekCnt;
    private String enddeDay;
    
    private String schdulCntntsSe;
    private String connCntntsSeq;
    
    private String langCode;
    
	private String ctgryNm;
    
	private String frstDay;
	private String lastDay;
	private String lastWeek;
	
	private String sitecntntsSeq;
	
	//달력날짜
	private String date = "";
	
	//colspan 갯수
	private int colspanCount = 0;
	
	//row
	private int row = 0;
	
	//position
	private int position = 0;

}

package egovframework.wzwg.sysMngr.opnsu.bbs.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpnsuBbsVO {


	/* 사이트SEQ */
	private String siteSeq;
	
	/* 게시판SEQ */
	private String bbsSeq;

	/* 게시판명 */
	private String bbsNm;
	
	/* 게시판설명 */
	private String bbsDc;
	
	/* 목록화면코드 */
	private String listScrinCode;

	/* 상세화면코드 */
	private String viewScrinCode;

	/* 좋아요사용여부 */
	private String likeUseAt;

	/* 추천게시물기준점수 */
	private String recnttStdrScore;
	
	/* 추천게시물건수 */
	private String recnttCnt;
	
	/* 양식SEQ */
	private String formSeq;
	
	/* 양식분류코드 */
	private String formClCode;
	
	/* 양식제목 */
	private String formSj;
	
	/* 양식내용 */
	private String formCn;
	
	/* 말머리SEQ */
	private String subospecSeq;
	
	/* 말머리제목 */
	private String subospecSj;
	
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
    
	/* 메뉴SEQ */
	private String menuSeq;
	
	/* 사이트컨텐츠SEQ */
	private String sitecntntsSeq;	
	
	/* 관리자페이지여부 */
	private String mngrAt;
	
	/* 첨부파일 가능 여부 */
    private String atchFilePosblAt;
    
    /* 첨부파일 가능 개수 */
    private String atchFilePosblCo;
	
}

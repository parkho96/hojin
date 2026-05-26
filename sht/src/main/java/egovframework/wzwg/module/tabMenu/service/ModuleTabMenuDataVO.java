package egovframework.wzwg.module.tabMenu.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleTabMenuDataVO {
	/* 사이트SEQ */
	private String siteSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 게시판SEQ */
	private String tabSeq;

	/* 게시판명 */
	private String tabNm;
	
	/* 모듈명 */
	private String moduleNm;
	
	/* 게시물SEQ */
	private String tabdataSeq;
	
	/* 부모게시물SEQ */
	private String parntsNttSeq;

	/* 말머리SEQ */
	private String subospecSeq;
	
	/* 말머리제목 */
	private String subospecSj;

	/* 게시물제목 */
	private String tabdataSj;

	/* 게시물내용 */
	private String tabCn;
	
	/* 조회수 */
	private String inqireCnt;

	/* 게시자ID */
	private String ntcrId;

	/* 게시자명 */
	private String ntcrNm;

	/* 게시물 상태코드 */
	private String tabSttusCode;
	
	private String menuSeq;
	
	/* 관리자페이지여부 */
	private String mngrAt;	
	
	/* 커뮤니티 사용여부*/
	private String cmntUseAt;
	
	
    /* 분류게시판타입 */
    private String tabClSe;
    
    /* 분류게시판순서 */
    private String tabClOrdr;
    
    private String useAt;
    
    /* 링크URL */
    private String menuLinkUrl;
    
    /* 링크타겟 */
    private String menuLinkTarget;
    
    /* 모듈 SEQ */
    private String sysmoduleSeq;
    
    /* 모듈 타입 */
    private String moduleTyCode;
    
    /* 컨텐트SEQ */
	private String sitecntntsSeq;
    
    
    
    
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
    
    /** 검색여부 */
    private String searchAt = "";
    
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
    
    private String ntcrSeq;

}

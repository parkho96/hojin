package egovframework.wzwg.module.calc.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleCalcVO {
	/** 금융계산기 시퀀스 */
	private String calcinfoSeq;
 
	
	/** 사용여부 */
	private String useAt		= "";
	
	/** 유저ID */
	private String userId		= "";
	
	/** 사이트 시퀀스 */
	private String siteSeq		= "";
	
	/** 모듈명 */
	private String moduleNm		= "";
	
	/** 패키지경로 */
	private String pckagePath 	= "";
	
	/** 페이지경로 */
	private String mngrPageUrl	= ""; 
	
	 
	/** 컨텐츠 최초등록 시간 */
	private String frstRegistPnttm = "";
	
	private String calcSeq;
	
	/** 금융계산기 페이지명 */
	private String calcNm;
	
	/** 금융계산기 컨텐츠 */
	private String calcCn;
	
	private String calcType;
	
	private String calcCss;
	
	private String sitecntntsSeq;
	
	private String cntntsSeq;
	
	/** 템플릿 시퀀스 */
	private String tmplatSeq	= "";
	
	/** 템플릿 분류코드 */
	private String tmplatClSeq	= "";
	
	/* 전자정부프레임워크 페이징 */
	
    /* 현재페이지 */
    private int pageIndex = 1;

    /* 페이지갯수 */
    private int pageUnit = 10;

    /* 페이지사이즈 */
    private int pageSize = 10;

    /* firstIndex */
    private int firstIndex = 1;

    /* lastIndex */
    private int lastIndex = 1;

    /* recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /* 검색구분 */
    private String searchCondition;
    
    /* 검색keyword */
    private String searchKeyword;

}
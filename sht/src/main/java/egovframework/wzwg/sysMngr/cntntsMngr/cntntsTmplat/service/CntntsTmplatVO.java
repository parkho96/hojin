package egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CntntsTmplatVO {
	
	/** 템플릿 시퀀스 */
	private String tmplatSeq = "";

	/** 템플릿 분류 코드 */
	private String tmplatClSeq = "";
	
	/** 템플릿 분류 코드 명 */
	private String tmplatClSeqNm = "";

	/** 템플릿 제목 */
	private String tmplatSj = "";

	/** 템플릿 내용 */
	private String tmplatCn = "";

	/** 사용여부 */
	private String useAt = "";

	/** 사용자 ID */
	private String userId = "";
	
	/** 코드시퀀스 */
	private String codeSeq = "";
	
	/** 썸네일 SEQ */
	private String atchFileId = "";
	

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
    
    /** 언어코드 */
    private String langCode;
    
}

package egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CntntsStyleVO {
	
	/** CSS시퀀스 */
	private String cssSeq = "";

	/** 모듈코드 */
	private String sysmoduleSeq = "";

	/** CSS명 */
	private String cssNm = "";

	/** CSS파일명 */
	private String cssFileNm = "";

	/** CSS경로 */
	private String cssPath = "";

	/** 미리보기경로 */
	private String prevewPath = "";

	/** 사용여부 */
	private String useAt = "";

	/** 최초등록자ID  */
	private String frstRegisterId = "";

	/** 최초등록시점 */
	private String frstRegistPnttm = "";

	/** 최종수정자ID */
	private String lastUpdusrId = "";

	/** 최송수정시점 */
	private String lastUpdtPnttm = "";
	
	/** 사용자 ID */
	private String userId = "";	
	
	/** 모듈명 */
	private String moduleNm = "";
	
	/** 모듈 CSS 사용가능여부 */
	private String cssProvdAt = "";
	

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
    
    private String moduleNmEng;

}

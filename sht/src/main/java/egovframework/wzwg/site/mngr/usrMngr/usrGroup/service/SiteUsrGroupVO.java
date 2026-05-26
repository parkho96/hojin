package egovframework.wzwg.site.mngr.usrMngr.usrGroup.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteUsrGroupVO {
	/** 회원그룹 시퀀스 */
	private String usrGroupSeq 	= "";
	
	/** 사이트 시퀀스 */
	private String siteSeq		= "";
	
	/** 회원유형 시퀀스 */
	private String usrTySeq		= "";
	
	/** 회원유형 명 */
	private String usrTyNm	= "";
	
	/** 회원그룹명 */
	private String usrGroupNm	= "";
	
	/** 회원그룹설명 */
	private String usrDc		= "";
	
	/** 사용여부 */
	private String useAt		= "";
	
	/** 사용자ID */
	private String userId		= "";
	
	/** usrty 코드 제목 */
	private String tyNm			= "";
	
	/* =전자정부프레임워크 페이징= */
	
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

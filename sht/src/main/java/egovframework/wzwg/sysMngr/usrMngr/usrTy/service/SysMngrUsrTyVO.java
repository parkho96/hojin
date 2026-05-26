package egovframework.wzwg.sysMngr.usrMngr.usrTy.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrUsrTyVO implements Serializable {
    
    private String siteSeq;
    
	/** 회원 유형 시퀀스 */
	private String usrTySeq		= "";
	
	/** 유형명 */
	private String tyNm			= "";
	
	/** 회원분류코드 */
	private String usrTyCode	= "";
	
	/** 회원분류코드명 */
	private String usrTyCodeNm	= "";
	
	/** 유형설명 */
	private String tyDc			= "";

	/** 사용여부 */
	private String useAt		= "";

	/** 등록자, 수정자 ID */
	private String userId		= "";
	
	/** 최초등록일자 **/
	private String frstRegistPnttm = "";
    
    /** 가입대상여부 **/
    private String sbscrbTrgetAt;
    
    /** 기본그룹SEQ **/
    private String bassGroupSeq;

    /** 기본그룹명 **/
    private String bassGroupNm;
	
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

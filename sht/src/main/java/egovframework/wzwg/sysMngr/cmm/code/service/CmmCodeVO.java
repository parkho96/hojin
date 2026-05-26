package egovframework.wzwg.sysMngr.cmm.code.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class CmmCodeVO extends CmmGrpCodeVO {

	/** 코드 */
	private String code			= 	"";
	
	/** 코드명 */
	private String codeNm		= 	"";
	
	/** 코드약명 */
	private String codeAbrvNm	=	"";
	
	/** 코드설명 */
	private String codeDc		=	"";
	
	private String langCode     =	"";

    /** 사용여부 */
    private String useAt;

    /** 회원ID*/
    private String userId;	

    /** 최초등록일시*/
    private String frstRegistPnttm;

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
    
    private String searchCode ="";
    
}

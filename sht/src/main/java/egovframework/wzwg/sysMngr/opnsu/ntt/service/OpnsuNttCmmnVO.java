package egovframework.wzwg.sysMngr.opnsu.ntt.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpnsuNttCmmnVO  {

	
	/* 목록 LEVEL */
	private String lv;
	
	/* 검색 게시판 SEQ */
	private String searchBbsSeq;
	
	/* 검색 말머리 SEQ */
	private String searchSubospecSeq;
	
	/* 선택된 게시물 seq */
	private String checkNttSeq;
	
	/* */
	private String[] dynamicArr;
	
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
    
    /* 정렬 구분(A:오름차순, D:내림차순) */
    private String ordrSe;
    
    /* 정렬 조건 */
    private String searchCnd;
    
	public String[] getDynamicArr() {
		if(dynamicArr != null) {
			return Arrays.copyOf(dynamicArr,dynamicArr.length);
		}else {
			return null;
		}
	}

	public void setDynamicArr(String[] dynamicArr) {
		if (dynamicArr != null) {
			this.dynamicArr = Arrays.copyOf(dynamicArr, dynamicArr.length);
		} else {
			this.dynamicArr = null;
		}
	}
	
}

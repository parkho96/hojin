package egovframework.wzwg.module.ntt.cmmn.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttCmmnVO  {

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
    
    /* 정렬 구분(A:오름차순, D:내림차순) */
    private String ordrSe;
    
    /* 정렬 조건 */
    private String searchCnd;
    
	/** 삭제 구분 */
	private String delSe;
	
	/** 시작일 */
	private String bgnde;
	
	/** 시작시간 */
	private String beginTime;
	
	/** 종료일 */
	private String endde;
	
	/** 종료시간 */
	private String endTime;
	
    /* SNS 공유하기 사용여부 */
    private String snsCnrsAt;
    
    /* 게시판 모듈 타입 */
    private String moduleMethodNcnm;
    
    /* 원문 삭제여부 */
    private String nttDeletAt;
    
    /* 이전글 정보 */
    private String prevNttInfo;
    
    /* 다음글 정보 */
    private String nextNttInfo;
    
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

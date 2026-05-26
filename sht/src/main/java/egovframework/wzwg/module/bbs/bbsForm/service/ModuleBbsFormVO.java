package egovframework.wzwg.module.bbs.bbsForm.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleBbsFormVO {
	/** 게시판 양식 시퀀스 */
	private String formSeq		= "";
	
	/** 사이트 SEQ */
	private String siteSeq		= "";
	
	/** 양식분류코드 */
	private String formClCode	= "";
	
	/** 양식분류코드명 */
	private String formClCodeNm	= "";
	
	/** 양식 제목 */
	private String formSj		= "";
	
	/** 양식 내용 */
	private String formCn		= "";
	
	/** 사용여부 */
	private String useAt		= "";
	
	/** 유저 ID */
	private String userId		= "";
	
	/** 유저 이름 */
	private String userNm		= "";
	
	/** 게시판 시퀀스 */
	private String bbsSeq		= "";
	
	/** 게시판 제목 */
	private String bbsNm		= "";

	/** 게시판 수정시 이미 적용되어있던 시퀀스(비교대상으로 사용) */
	private String beforeBbsSeq 	= "";

	/** 게시판 시퀀스 리스트 */
	private String bbsSeqList	= "";

	/** 게시판 양식 코드 (list, regist, modify로 분류)*/
	private String formSttusCode = "";

	/** 게시판 모듈 타입 코드 */
	private String bbsModuleTyCode = "";
	
	/** 게시판양식 사용하는 게시판 시퀀스 */
	private String[] bbsFormUseBbsSeq = {};
	
	/** 매핑 적용 여부(있으면1, 없으면0) */
	private String mappingApplcAt = "";

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
    
    private String langCode;
    
	public String[] getBbsFormUseBbsSeq() {
		if(bbsFormUseBbsSeq != null) {
			return Arrays.copyOf(bbsFormUseBbsSeq,bbsFormUseBbsSeq.length);
		}else {
			return null;
		}
	}

	public void setBbsFormUseBbsSeq(String[] bbsFormUseBbsSeq) {
		if (bbsFormUseBbsSeq != null) {
			this.bbsFormUseBbsSeq = Arrays.copyOf(bbsFormUseBbsSeq, bbsFormUseBbsSeq.length);
		} else {
			this.bbsFormUseBbsSeq = null;
		}
	}
	
}

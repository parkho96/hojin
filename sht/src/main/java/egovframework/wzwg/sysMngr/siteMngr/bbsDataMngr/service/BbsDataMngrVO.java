package egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BbsDataMngrVO   {

	/* 사이트 시퀀스 */
	private String siteSeq;
	  
	/* 게시판 시퀀스 */
	private String bbsSeq;
	  
	/* 시작일 */
	private String bgnde;
	
	/* 시작시간 */
	private String beginTime;
	
	/* 종료일 */
	private String endde;
	
	/* 종료시간 */
	private String endTime;
	
	/** 작업분류구분 */
	private String opertClSe;
	
	/** 사이트 대분류 그룹 */
	private String siteLclasGroup;
	
	/** 사이트 대분류 그룹명 */
	private String siteLclasGroupNm;
	
	/** 사이트 중분류 그룹 */
	private String siteMlsfcGroup;
	
	/** 사이트 중분류 그룹명 */
	private String siteMlsfcGroupNm;

}

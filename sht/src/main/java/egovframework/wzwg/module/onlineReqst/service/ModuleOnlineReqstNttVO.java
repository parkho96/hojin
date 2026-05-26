package egovframework.wzwg.module.onlineReqst.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineReqstNttVO extends ModuleOnlineReqstCommonVO {
	
	/* 온라인신청Seq*/
	private String reqstnttSeq;
	
	/* 온라인신청 Seq */
	private String reqstSeq;		
	
	/* 사이트Seq */
	private String siteSeq;	
	
	/* 신청명 */
	private String reqstnttSj;
	
	/* 내용 */
	private String reqstnttCn;
	
	/* 시작일 */
	private String bgnde;
	
	/* 시작시간 */
	private String beginTime;
	
	/* 종료일 */
	private String endde;
	
	/* 종료시간 */
	private String endTime;
	
	/* 정원 */
	private String psncpa;
	
	/* 승인방식코드 */
	private String confmMthdCode;
	
	/* 진행상태 */
	private String progrsSttusCode;
	
	/* 신청대상자 사이트회원그룹 */
	private String trgterUsrgroup;	
	
	/* 첨부파일ID */
	private	String atchFileId;
	
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
	
	/* 작성자이름 */
	private String registerNm;
	
	/* 체크된 신청ID 문자열 */
	private String reqstnttSeqChkStr;	

	/* 신청인원 */
	private String reqstNmpr;

	/* 검색조건 진행상태  */
	private String selectProgrsSttusCode;
	
	/* 사용자그룹SEQ */
	private String usrgroupSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 신청대상자 사이트회원그룹 여부 */
	private String trgterUsrgroupAt;
	
	/* 승인상태코드 */
	private String confmSttusCode;
	
	/** 사용자 유형 SEQ */
	private String usrtySeq;
	
	/** 사용자 유형 그룹  */
	private String trgterUsrty;

	/** 사용자 유형 구분 */
	private String trgterUsrtyAt;
	
	/** 사용자 유형 명 */
	private String tyNm;

}

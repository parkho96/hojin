package egovframework.wzwg.module.orgnzt.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrgnztInfoVO {
	private String siteSeq;
	
	private String orgnztSeq; // orgInfoSeq
	private String orgnztLv; // depthOrd
	private String parntsOrgnztSeq; // parentSeq
	private String orgnztTySe; // orgTySe
	private String cssClssNm; // clsNm
	private String orgnztNmKr; // orgNmKr
	private String orgnztNmEn; // orgNmEn
	private String orgnztDcKr; // orgDcKr
	private String orgnztDcEn; // orgDcEn
	private String orgnztOrdr; // orderby
	private String useAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	
	private String orgnztmberSeq; // orgMemSeq
	private String orgnztmberNm; // memNm
	private String telno; // memTelNo
	private String faxnum; // memFax
	private String orgnztmberClsf; // 직위 memPosition
	private String emailAdres; // memEmail
	private String chrgJob; // 담당업무 memJob
	private String orgnztmberOrdr; // memOrderby

	/** 검색 */
	private String orgnztMemSearchSel;
	private String orgnztMemSearchVal;
	private String orgnztAcctoSearchSel;
	
	/* 조직도 설정값(mdorgnztestbs) */
	private String orgnztEstbsSeq;
	private String cssSeq;
	
}

package egovframework.wzwg.site.mngr.cntnts.cntPagadiEstbs.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CntPageadiEstbsVO {
	private String pagadiestbsSeq; 		// 페이지추가설정 SEQ
	private String siteSeq;				// 사이트 SEQ
	private String sysmoduleSeq;		// 모듈 SEQ
	private String cntntsSeq;			// 컨텐츠 SEQ
	private String cntntsNm;			// 컨텐츠명
	private String nttSeq;				// 게시판 SEQ
	private String frstRegisterId;		// 등록자 ID
	private String frstRegistPnttm;		// 등록일
	private String lastUpdusrId;		// 수정자 ID
	private String lastUpdtPnttm;		// 수정일
	private String pagecpyrhtSeq;		// 페이지 저작권 SEQ
	private String cpyrhtSe;			// 저작권 구분( 공공누리 타입 1,2,3,4)
	private String cpyrhtImgPath;		// 저작권 이미지 경로
	private String useAt;				// 사용여부
	private String cssClssNm;			// CSS class 이름
	private String pagevlSeq;			// 페이지 평가 SEQ
	private String pagevlestbsSeq;		// 페이지 평가설정 SEQ
	private String evlScore;			// 평가점수
	private String evlOpinion;			// 평가의견
	private String opinionUseAt;		// 평가의견 사용 여부
	private String pagoclhgSeq;			// 페이지 담당관 SEQ
	private String departNm;			// 부서이름
	private String oclhgNm;				// 담당관 이름
	private String oclhgCttpl;			// 담당관 연락처
	private String sortOrdr;			// 정렬순서
	
	private String bbsSeq;				// 게시판 변환용
	private String sitecntntsSeq;		//
	
	private String apicntntsSeq;		// 학교정보API게시판변환용
	
	private String skinTy;				//스킨타입
	
	private String evlCount;			// 평가갯수
	private String evlSum;				// 평가합
	private String evlAverage;			// 평균점수
	
	private String nttSeqAt;			// 게시판 SEQ 사용여부
	
	
	/* 전자정부프레임워크 페이징 */
	/** 현재페이지 */
    private int pageIndex = 1;
    /** 페이지갯수 */
    private int pageUnit = 10;
    /** 페이지사이즈 */
    private int pageSize = 10;
    /** firstIndex */
    private int firstIndex = 1;
    /** lastIndex */
    private int lastIndex = 10;
    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
}

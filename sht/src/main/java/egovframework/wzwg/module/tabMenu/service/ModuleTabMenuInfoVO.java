package egovframework.wzwg.module.tabMenu.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleTabMenuInfoVO {
	/* 사이트SEQ */
	private String siteSeq;
	
	/* 탭메뉴 SEQ */
	private String tabSeq;
	
	/* 커뮤니티 사용여부*/
	private String cmntUseAt;

	/* 탭메뉴 명 */
	private String tabNm;
	
	/* 탭메뉴 설명 */
	private String tabDc;
	
	/* 탭메뉴 머리말 */
	private String bbsPrface;
	
	/* 목록화면코드 */
	private String listScrinCode;
	
	/* 목록화면 게시물 번호코드 */
	private String listNumCode; 
	
	/* 목록화면 게시물 갯수 설정여부 */
	private String listCountAt;
	
	/* 목록화면 게시물 갯수 설정 단위 */
	private String listCountUnit;

	/* 상세화면코드 */
	private String viewScrinCode;

	/* 좋아요사용여부 */
	private String likeUseAt;

	/* 추천게시물기준점수 */
	private String recnttStdrScore;
	
	/* 추천게시물건수 */
	private String recnttCnt;
	
	/* 양식SEQ */
	private String formSeq;
	
	/* 양식분류코드 */
	private String formClCode;
	
	/* 양식제목 */
	private String formSj;
	
	/* 양식내용 */
	private String formCn;
	
	/* 말머리SEQ */
	private String subospecSeq;
	
	/* 말머리제목 */
	private String subospecSj;
	
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
    
	/* 메뉴SEQ */
	private String menuSeq;
	
	/* 사이트컨텐츠SEQ */
	private String sitecntntsSeq;	
	
	/* 관리자페이지여부 */
	private String mngrAt;
	
	/* CSS SEQ */
	private String cssSeq;
	
	private String cssNm;
	
	/**
	 * 커스텀 게시판 추가필드
	 * @return
	 */
	/* 커스텀 기능 시퀀스 */
	private String funcSeq;
	/* 이용약관 */
	private String agreementCn;
	/* 비로그인사용 */
	private String nolognAt;
	/* 사용자 화면 타입 */
	private String usrScrinTy;
	
	/** 커스텀게시판의 리스트 노출값 구분 */
    private String expsrAt;
    
    /* 필드 복사 원본 사이트정보 */
    private String oriSiteSeq;
    
    /** 시스템사이트SEQ **/
    private String sysSiteSeq = "";
    
    /** 시스템컨텐츠SEQ **/
    private String sysCntntsSeq = "";
    
    private String sysmoduleSeq="";
    
    /* SNS 공유하기 사용여부 */
    private String snsCnrsAt;

    private String pageMode;
    
    /* 카테고리 뷰 타입 */
    private String cateTy;
    
    /* 첨부파일 가능 여부 */
    private String atchFilePosblAt;
    
    /* 첨부파일 가능 개수 */
    private String atchFilePosblCo;
    
    /* 첨부파일(이미지) 가능 개수 */
    private String atchImgFilePosblCo;
    
    /* 스크랩 기능 사용여부 */
    private String scrapAt;
    
    
    private String reciveEmail;
    
    private String skinImgFileId;
    private String skinImgReplcText;
    
}

package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSiteAdiInfoVO implements Serializable {

	/*사이트SEQ*/
	private String siteSeq;

	/*사이트분류코드*/
	private String siteClCode;

	/*로고 이미지 경로*/
	private String logoTImagePath;

	/*사이트 푸터 이미지 경로*/
	private String logoFImagePath;

	/*최초등록자ID*/
	private String frstRegisterId;

	/*저작권 내용*/
	private String cpyrhtCn;

	/*최초등록시점*/
	private String frstRegistPnttm;

	/*최종수정자ID*/
	private String lastUpdusrId;

	/*최종수정시점*/
	private String lastUpdtPnttm;

    /* 사이트대분류그룹 */
	private String siteLclasGroup;
	
    /* 사이트중분류그룹 */
	private String siteMlsfcGroup;
	
	/* 메뉴설정SEQ */
	private String estbsinfoSeq;
	
	/* 네이버 메타키 */
	private String naverMetaKey;
	
	/* 구글 메타키 */
	private String googleMetaKey;
	
	/* 메뉴설정여부 */
	private String menuEstbsAt;
	
	private String sslUseAt;
	
	private String tel;
	private String fax;
	private String zopcode;
	private String adres;
	

	/** 첨부 제공 용량 사용여부 */
    private String fileProvdAt;
    
    /** 첨부 제공파일 용량 */
    private String fileProvdMg;

    /** 첨부 허용파일 용량 구분 */
    private String fileCpctySe;
    
    private String dupLoginAt;
    
    private String iconSImagePath;
    
    private String connIpEstbs;

    /** 대표로고이미지 대체텍스트 */
    private String logoTImageReplcText;
    /** 카피라이터 대체텍스트 */
    private String logoFImageReplcText;
    /** 우클릭 허용 여부 */
    private String rghtClickAt;
    
}

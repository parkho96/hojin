package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSiteInfoVO implements Serializable {
    
	/*사이트SEQ*/
	private String siteSeq;

    /*조합번호*/
    private String asscNo;

	/*사이트전체명*/
	private String siteFullNm;

	/*사이트약어명 */
	private String siteAbrvNm;

	/*사이트설명*/
	private String siteDc;

	/*우편번호*/
	private String zipcode;

	/*기본주소*/
	private String adresBass;

	/*상세주소*/
	private String adresDetail;

	/*전화번호1*/
	private String telno1;

	/*전화번호2*/
	private String telno2;

	/*전화번호3*/
	private String telno3;

	/*팩스번호1*/
	private String faxnum1;

	/*팩스번호2*/
	private String faxnum2;

	/*팩스번호3*/
	private String faxnum3;

	/*생성일자*/
	private String creatDe;

	/*서비스여부*/
	private String srvcAt;

	/*서비스시작일자*/
	private String srvcBeginDe;

	/*폐쇄여부*/
	private String ablEnncAt;

	/*폐쇄일자*/
	private String ablDe;
	
	/*사용여부*/
	private String useAt;

	/*최초등록자ID*/
	private String frstRegisterId;

	/*최초등록시점*/
	private String frstRegistPnttm;

	/*최종수정자ID*/
	private String lastUpdusrId;

	/*최종수정시점*/
	private String lastUpdtPnttm;
	
	/*사이트URL*/
	private String siteUrl;
	
	/******** 홈페이지 작업알림 ************/

	/** 작업 SEQ */
	private String opertSeq					=	"";

	/** 작업명 */
	private String opertNm					=	"";

	/** 작업내용 */
	private String opertCn					=	"";

	/** 작업시작일 */
	private String opertBgnde				=	"";
	
	/** 작업시작시간 */
	private String beginTime				=	"";

	/** 작업종료일 */
	private String opertEndde				=	"";
	
	/** 작업종료시간 */
	private String endTime					=	"";
	
	/** 적용여부 */
	private String opertApplcAt				=	"";

	/***************************************/

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

    /** 검색Keyword */
    private String searchKeyword = "";

    /** 1차그룹 */
    private String siteLclasGroup = "";
    
    /** 2차그룹 */
    private String siteMlsfcGroup = "";
    
    /** 조회조건 */
    private String searchCondition = "";
    
    /** 언어코드 */
    private String langCode = "";
    
    private String siteLclasGroupNm="";
    
    private String siteMlsfcGroupNm="";
    
    private String siteKey;
    
    private String prevSiteKey;
    
    private String domnSeq;
    
}

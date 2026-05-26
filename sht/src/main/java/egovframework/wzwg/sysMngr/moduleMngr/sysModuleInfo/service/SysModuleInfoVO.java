package egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysModuleInfoVO implements Serializable {
	
	/** 시스템모듈SEQ */
	private String sysmoduleSeq;
    
    /** 모듈타입코드 */
    private String moduleTyCode;
    
    /** 모듈타입코드명 */
    private String moduleTyNm;
	
	/** 모듈명 */
	private String moduleNm;
	
	/** 모듈영문명 */
	private String moduleNmEng;
	
	/** 모듈닉네임 **/
	private String moduleNcnm;

    /** 모듈메소드닉네임 **/
	private String moduleMethodNcnm;
    
    /** 모듈설명 */
    private String moduleDc;
    
    /** 모듈VO */
    private String masterModuleVo;
    
    /** 모듈VO */
    private String moduleVo;
	
	/** 패키지경로 */
	private String pckagePath;
	
	/** 마스터인스턴스명 **/
	private String masterInstcNm;
	
	/** 인스턴스명 */
	private String instcNm;
	
	/** 관리자페이지URL */
	private String mngrPageUrl;
	
	/** 사용자페이지URL */
	private String usrPageUrl;
	
	/** API제공여부 */
	private String apiProvdAt;
	
	/** 데이터 복사 대상 여부 **/
	private String dataCopyAt;
	
	/** 사용여부 */
	private String useAt;
	
	/** 최초등록자ID */
	private String frstRegisterId;
	
	/** 최초등록시점 */
	private String frstRegistPnttm;
	
	/** 최종수정자ID */
	private String lastUpdusrId;
	
	/** 최종수정시점 */
	private String lastUpdtPnttm;
	
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
    
    /** 조회모듈SEQ **/
    private String searchModuleSeq;

    /** 조회조건 **/
    private String searchCondition;

    /** 검색어 **/
    private String searchKeyword;
    
    /** 언어코드 */
    private String langCode;
    
    private String siteSeq;
    
}

package egovframework.com.sym.log.clg.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @Class Name : LoginLog.java
 * @Description : 접속 로그 관리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------      -------     -------------------
 *    2009. 3. 11.  이삼섭      최초생성
 *    2011. 7. 01.  이기하      패키지 분리(sym.log -> sym.log.clg)
 *    2011.09.14       서준식      화면에 검색일자를 표시하기위한 멤버변수 추가.
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
@Getter
@Setter
@ToString
public class LoginLog implements Serializable {

	/** 로그ID */
	private String logId;

	/** 사용자ID */
	private String loginId;

	/** 사용자명 */
	private String loginNm;

	/** 접속IP */
	private String loginIp;

	/** 접속방식 */
	private String loginMthd;

	/** 에러발생여부 */
	private String errOccrrAt;

	/** 에러코드 */
	private String errorCode;

	/** 생성일시 */
	private String creatDt;

	/**
	 * 검색시작일
	 */
	private String searchBgnDe = "";
	/**
	 * 검색조건
	 */
	private String searchCnd = "";
	/**
	 * 검색종료일
	 */
	private String searchEndDe = "";
	/**
	 * 검색단어
	 */
	private String searchWrd = "";
	/**
	 * 정렬순서(DESC,ASC)
	 */
	private String sortOrdr = "";
	
	/** 검색사용여부 */
    private String searchUseYn = "";
    
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
		
    /** rowNo  */
	private int rowNo = 0;
	
	/**
	 * 검색시작일_화면용
	 */
	private String searchBgnDeView = "";//2011.09.14
	
	/**
	 * 검색종료일_화면용
	 */
	private String searchEndDeView = "";//2011.09.14
	
	private String siteId ="";
	
	private String userTyId="";
	
	private String userId="";
	
	private String conectTy;
	
	private String siteNm;
	
}

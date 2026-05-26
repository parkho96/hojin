package egovframework.wzwg.module.upload.file.service;

import java.io.Serializable;
import java.util.HashMap;

import org.apache.commons.lang.builder.ToStringBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @Class Name : FileVO.java
 * @Description : 파일정보 처리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class ModuleUploadFileVO implements Serializable {

    /**
     * 첨부파일 아이디
     */
    public String atchFileId = "";
    /**
     * 생성일자
     */
    public String creatDt = "";
    /**
     * 파일내용
     */
    public String fileDc = "";
    /**
     * 파일확장자
     */
    public String fileExtsn = "";
    /**
     * 파일크기
     */
    public String fileMg = "";
    /**
     * 파일연번
     */
    public String fileSn = "";
    /**
     * 파일저장경로
     */
    public String fileStreCours = "";
    /**
     * 원파일명
     */
    public String orignlFileNm = "";
    /**
     * 저장파일명
     */
    public String streFileNm = "";
    /**
     * 저장 폴더 구분
     */
    public String fileDir = "";
    
    /** 첨부가능파일갯수 */
	private String posblAtchFileNumber;
	/**
     * 썸네일 파일저장경로
     */
    public String thumbStreCours = "";
    /**
     * 썸네일 저장파일명
     */
    public String thumbFileNm = "";
    
    private String updateFlag = "";
    
    private String useAt = "";
    
    /**
     * 첨부파일 파라미터명
     */
    private String paramName;
    
    /**
     * 파일 네임명
     * */
    private String name;
    
    private String helpAt = "";
    
    
    /********** 첨부 파일관리 Start **********/
    
    /** 사이트SEQ */
    private String siteSeq;
    
    /** 사이트컨텐츠SEQ */
    private String sitecntntsSeq;
    
    /** 컨텐츠SEQ */
    private String cntntsSeq;
    
    /** 첨부 허용파일 유형 코드 */
    private String fileTyCode;
    
    /** 첨부 허용파일 유형 코드 Arr */
    private String fileTyCodeArr;
    
    /** 첨부 허용파일 유형 코드명 */
    private String fileTyCodeNm;
    
    /** 첨부 허용파일 용량 */
    private String fileCpcty;
    
    /** 첨부 허용파일 용량 Arr */
    private String fileCpctyArr;
    
    /** 첨부 허용파일 용량 구분 */
    private String fileCpctySe;
    
    /** 첨부 허용파일 용량 구분Arr */
    private String fileCpctySeArr;
    
    /** 첨부 허용파일 허용여부 */
    private String permAt;
    
    /** 첨부 허용파일 허용여부Arr */
    private String permAtArr;
    
    /** 첨부 허용파일 확장자 */
    private String fileEstbsExtsn;
    
    /** 첨부파일 컨텐츠 허용여부 */
    private String mdPermAt;
    
    /** 첨부파일 컨텐츠 허용여부 */
    private String mdPermAtArr;
    
    /** 최초등록자ID */
	private String frstRegisterId;

	/** 최초등록시점 */
	private String frstRegistPnttm;

	/** 최종수정자ID */
	private String lastUpdusrId;

	/** 최종수정시점 */
	private String lastUpdtPnttm;
    
    /********** 첨부 파일관리 End **********/
    
	private String langCode;
	
	/** 첨부 허용파일 유형별 전체 용량 */
    private String fileAllCpcty;
	
    /** 첨부 허용파일 유형별 전체 용량 Arr*/
    private String fileAllCpctyArr;

    /* 동영상 구분 */
    private String mvpSe;
    
    /* 다운로모드 */
    private String usemode;

	public void setData(HashMap<String, Object> setMap) {
		setAtchFileId((String)setMap.get("atchFileId"));
		setCreatDt((String)setMap.get("creatDt"));
		setFileDc((String)setMap.get("fileDc"));
		setFileExtsn((String)setMap.get("fileExtsn"));
		setFileMg((String)setMap.get("fileMg"));
		setFileSn((String)setMap.get("fileSn"));
		setFileStreCours((String)setMap.get("fileStreCours"));
		setOrignlFileNm((String)setMap.get("orignlFileNm"));
		setStreFileNm((String)setMap.get("streFileNm"));
		setFileDir((String)setMap.get("fileDir"));
		setPosblAtchFileNumber((String)setMap.get("posblAtchFileNumber"));
		setThumbStreCours((String)setMap.get("thumbStreCours"));
		setThumbFileNm((String)setMap.get("thumbFileNm"));
		setUpdateFlag((String)setMap.get("updateFlag"));
        setName((String)setMap.get("name"));
        setHelpAt((String)setMap.get("helpAt"));
    }
	
}

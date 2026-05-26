package egovframework.wzwg.module.upload.file.service;

import egovframework.com.cmm.ComDefaultVO;
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
public class ModuleUsrFileVO extends ComDefaultVO  {
	
	private String usrfileSeq;
	private String usrfileNm;
	private String filectgrySeq;
	private String fileStreCours;
	private String streFileNm;
	private String orignlFileNm;
	private String fileExtsn;
	private String fileMg;
	private String useAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String siteSeq;
	
	private String filectgrySeqWrite;
	
	private String filectgrySeqList;
	
	private String filectgryNm;

}

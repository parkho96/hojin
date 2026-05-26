package egovframework.wzwg.module.onlineReqst.mngr.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MngrOnlineReqstRceptVO extends MngrOnlineReqstCommonVO {
	
	/* 온라인신청접수Seq*/
	private String rceptSeq;
	
	/* 온라인신청게시물Seq */
	private String reqstnttSeq;	
	
	/* 온라인신청정보Seq */
	private String usrSeq;

	/* 승인상태코드 */
	private String confmSttusCode;
	
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
	
	/* 사용자Id */
	private String userId;

	/* 사용자이름 */
	private String userNm;
	
	private String rceptSeqChkStr;

}

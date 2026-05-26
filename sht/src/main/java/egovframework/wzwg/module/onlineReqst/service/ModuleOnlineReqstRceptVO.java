package egovframework.wzwg.module.onlineReqst.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineReqstRceptVO extends ModuleOnlineReqstCommonVO {
	
	/* 온라인신청접수Seq*/
	private String rceptSeq;
	
	/* 온라인신청정보Seq */
	private String reqstnttSeq;	
	
	/* 온라인신청Seq */
	private String reqstSeq;	
	
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
	
	/* 사이트SEQ */
	private String siteSeq;
	
	/* 사용자그룹SEQ */
	private String usrGroupSeq;
	
	/* 사용자그룹명 */
	private String usrGroupNm;
	
	/* 이전승인상태코드 */
	private String beforeConfmSttusCode;

}

package egovframework.wzwg.module.onlineReqst.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleOnlineReqstInfoVO extends ModuleOnlineReqstCommonVO  {
	
	/* 사이트 Seq */
	private String siteSeq;
	
	/* 온라인신청Seq */
	private String reqstSeq;
	
	/* 온라인신청명 */
	private String reqstNm;
	
	/* 온라인신청설명 */
	private String reqstDc;
	
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
	
	/* 메뉴Seq */
	private String menuSeq;
	
	/* 사이트컨텐츠SEQ */
	private String SitecntntsSeq;
	
	/* 컨텐츠SEQ */
	private String cntntsSeq;
	
	private String reqstnttSeq;
	
}

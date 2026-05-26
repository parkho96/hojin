package egovframework.wzwg.module.ntt.module.scrap.service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttScrapVO extends ModuleNttVO {

	
	/* 사이트SEQ */
	private String siteSeq;
	
	/* 게시판SEQ */
	private String bbsSeq;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 스크랩SEQ */
	private String scrapSeq;

	/* 스크랩그룹SEQ */
	private String scrapgroupSeq;

	/* 그룹명 */
	private String groupNm;
	
	/* 스크랩제목 */
	private String scrapSj;

	/* 스크랩설명 */
	private String scrapDc;
	
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

}

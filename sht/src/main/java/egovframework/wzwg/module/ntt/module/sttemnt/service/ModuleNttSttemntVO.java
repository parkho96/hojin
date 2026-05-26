package egovframework.wzwg.module.ntt.module.sttemnt.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttSttemntVO {

	/* 사이트SEQ */
	private String siteSeq;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 신고SEQ */
	private String sttemntSeq;
	
	/* 게시물신고코드 */
	private String nttStmtCode;
	
	/* 기타 */
	private String etc;

	/* 최초등록자ID */
	private String frstRegisterId;

	/* 최초등록시점 */
	private String frstRegistPnttm;

}

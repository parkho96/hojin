package egovframework.wzwg.module.ntt.module.like.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttLikeVO {


	/* 사이트SEQ */
	private String siteSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 사용자명 */
	private String userNm;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 좋아요 갯수 */
	private String likeCnt;

	/* 최초등록자ID */
	private String frstRegisterId;
	
	/* 최초등록시점 */
	private String frstRegistPnttm;

}

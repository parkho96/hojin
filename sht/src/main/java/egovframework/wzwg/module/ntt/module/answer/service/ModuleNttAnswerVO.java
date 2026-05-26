package egovframework.wzwg.module.ntt.module.answer.service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttAnswerVO extends ModuleNttVO {

	/* 사이트SEQ */
	private String siteSeq;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 댓글SEQ */
	private String answerSeq;
	
	/* 부모댓글SEQ */
	private String parntsAnswerSeq;
	
	/* 부모댓글 작성자명 */
	private String parntsWrterNm;
	
	/* 부모글 여부 */
	private String parntsAt;
	
	/* 작성자ID */
	private String wrterId;
	
	/* 작성자고유번호 */
	private String wrterSeq;
	
	/* 작성자명 */
	private String wrterNm;
	
	/* 댓글내용 */
	private String answerCn;
	
	/* 댓글 갯수 */
	private String answerCnt;
	
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

	/* 목록 level depth */
	private String listDepth;
	
	/* 정렬기준 (A:오름차순, D:내림차순) */
	private String ordrSe;
	
	/* 게시판SEQ */
	private String bbsSeq;
	
}

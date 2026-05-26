package egovframework.wzwg.sysMngr.opnsu.ntt.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OpnsuNttVO extends OpnsuNttCmmnVO {

	/* 사이트SEQ */
	private String siteSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 게시판SEQ */
	private String bbsSeq;

	/* 게시판명 */
	private String bbsNm;
	
	/* 모듈명 */
	private String moduleNm;
	
	/* 게시물SEQ */
	private String nttSeq;
	
	/* 임시게시물SEQ */
	private String tmprnttSeq;

	/* 부모게시물SEQ */
	private String parntsNttSeq;

	/* 말머리SEQ */
	private String subospecSeq;
	
	/* 말머리제목 */
	private String subospecSj;

	/* 게시물제목 */
	private String nttSj;

	/* 게시물내용 */
	private String nttCn;
	
	/* 양식SEQ */
	private String formSeq;
	
	/* 양식내용 */
	private String formCn;

	/* 조회수 */
	private String inqireCnt;

	/* 첨부파일SEQ */
	private String atchFileId;
	
	/* 첨부파일갯수 */
	private String atchFileCnt;

	/* 게시자ID */
	private String ntcrId;

	/* 게시자명 */
	private String ntcrNm;

	/* 공지여부 */
	private String noticeAt;
	
	/* 비밀글여부 */
	private String secretAt;
	
	/* 익명글여부 */
	private String annymtyAt;
	
	/* 댓글허용여부 */
	private String answerPermAt;
	
	/* 댓글수 */
	private String answerCnt;
	
	/* 패스워드 */
	private String password;
	
	/* 자주묻는질문탭여부 */
	private String faqTabAt;
	
	/* 자주묻는질문여부 */
	private String faqAt;
	
	/* 자주묻는질문등록시점 */
	private String faqRegistPnttm;
	
	/* 답변수 */
	private String nttReplyCnt;
	
	/* 게시물 채택 여부 */
	private String nttChoiceAt;
	
	/* 채택 게시물SEQ */
	private String choiceNttSeq;
	
	/* 답변채택여부 */
	private String answerChoiceAt;
	
	/* 답변채택시점 */
	private String answerChoicePnttm;
	
	/* 질문자코멘트 */
	private String qestnUsrCm;
	
	/* 답변신고여부 */
	private String sttmntAt;
	
	/* 좋아요 사용여부 */
	private String likeUseAt;
	
	/* 좋아요 수 */
	private String likeCnt;
	
	/* 새글여부 */
	private String nttNew;
	
	/* 게시물 상태코드 */
	private String nttSttusCode;
	
	/* 태그SEQ */
	private String tagSeq;
	
	/* 태그명 */
	private String tagNm;
	
	/* 태그Arr */
	private String tagArr;
	
	/* 목록 유형 */
	private String listScrinCode;
	
	private String menuSeq;
	
	private String bbsViewLink;
	
	/* 관리자페이지여부 */
	private String sysMngrAt;	
	
	/* 부모글 작성자 */
	private String parntsNtcrId;
	
	/* 사이트SEQ */
	private String siteFullNm;
	
	/* 사이트도메인 */
	private String siteUrl;
	
	/* 첨부파일 가능 여부 */
    private String atchFilePosblAt;
    
    /* 첨부파일 가능 개수 */
    private String atchFilePosblCo;
    
    /* 스크랩 기능 사용여부 */
    private String scrapAt;
    
    private String uploadedFilesInfo;
    
    private String modifiedFilesInfo;
    
    private String ntcrSeq;

	/* 컨텐트SEQ */
	private String sitecntntsSeq;
	
}

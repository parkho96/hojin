package egovframework.wzwg.module.ntt.mvp.service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttMvpVO extends ModuleNttCmmnVO {

	/* 사이트SEQ */
	private String siteSeq;
	
	/* 컨텐트SEQ */
	private String sitecntntsSeq;
	
	/* 사용자SEQ */
	private String usrSeq;
	
	/* 게시판SEQ */
	private String bbsSeq;

	/* 게시판명 */
	private String bbsNm;
	
	/* 모듈명 */
	private String moduleNm;
	
	/* 게시물SEQ */
	private String mvpnttSeq;
	
	/* 임시게시물SEQ */
	private String tmprnttSeq;

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

	/* 댓글허용여부 */
	private String answerPermAt;
	
	/* 댓글수 */
	private String answerCnt;
	
	/* 패스워드 */
	private String password;
	
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
	
	/* 임시 태그Arr */
	private String tmpTagArr;
	
	/* 목록 유형 */
	private String listScrinCode;
	
	private String menuSeq;
	
	private String bbsViewLink;
	
	private String bbsThumLink;
	
	/* 관리자페이지여부 */
	private String mngrAt;	
	
	/* 동영상 key */
	private String mvpKey;
	
	/* 동영상 URL */
	private String mvpUrl;
	
	/* 동영상자막 */
	private String mvpCap;
	
	/* 커뮤니티 사용여부*/
	private String cmntUseAt;
	
	/* 게시물 내용(텍스트) */
	private String nttCnChrctr;
	
	/* 게시물 목록번호 노출 코드*/
	private String listNumCode;
	
	/* 목록화면 게시물 갯수 */
	private String listCount; 
	
	/* 위젯 표시용 요일 */
	private String registDayNm;
	private String registDayNo;
	

    /* 첨부파일 가능 여부 */
    private String atchFilePosblAt;
    
    /* 첨부파일 가능 개수 */
    private String atchFilePosblCo;
    
    /* 스크랩 기능 사용여부 */
    private String scrapAt;
    
    private String uploadedFilesInfo;
    
    private String modifiedFilesInfo;

    private String expsrAt;
    
    private String ntcrSeq;
    
}

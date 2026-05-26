package egovframework.wzwg.module.ntt.link.service;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleNttLinkVO extends ModuleNttCmmnVO {

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
	private String linknttSeq;
	
	/* 게시물URL */
	private String linkUrl;
	
	/* 게시물설명 */
	private String linkDc;
	
	/* 임시게시물SEQ */
	private String tmprnttSeq;

	/* 말머리SEQ */
	private String subospecSeq;
	
	/* 말머리제목 */
	private String subospecSj;

	/* 게시물제목 */
	private String nttSj;

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

	/* 새글여부 */
	private String nttNew;
	
	/* 목록 유형 */
	private String listScrinCode;
	
	private String menuSeq;
	
	private String bbsViewLink;
	
	private String bbsThumLink;
	
	/* 관리자페이지여부 */
	private String mngrAt;	
	
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
	
	private String ntcrSeq;
	
}

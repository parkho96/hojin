package egovframework.wzwg.module.popup.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModulePopupInfoVO extends ComDefaultVO{
	
	/** 팝업시퀀스 */
	private String popupSeq						=	"";
	
	/** 사이트시퀀스 */
	private String siteSeq						=	"";
	
	/** 팝업타입코드 */
	private String popupTyCode					=	"";
	
	/** 팝업타입코드명 */
	private String popupTyCodeNm				=	"";
	
	/** 팝업제목 */
	private String popupSj						=	"";
	
	/** 팝업제목내용 */
	private String popupSjCn					= 	"";
	
	/** 팝업내용 */
	private String popupCn						=	"";
	
	/** 썸네일 시퀀스 */
	private String thumbFileId					=	"";
	
	/** 썸네일 파일명 */
	private String thumbFileNm					=	"";
	
	/** 썸네일 대체 텍스트 */
	private String thumbReplcText				=	"";
	
	/** 팝업 시작일 */
	private String startDt						=	"";
	
	/** 팝업 시작시간 */
	private String startTime					=	"";
	
	/** 팝업 종료일 */
	private String endDt						=	"";
	
	/** 팝업 종료시간 */	
	private String endTime						=	"";
	
	/** 가로 */
	private String width						=	"";
	
	/** 세로 */
	private String height						=	"";
	
	/** 팝업위치 지정여부 */
	private String positionAt					=	"";
	
	/** X좌표 */
	private String xPosition					=	"";
	
	/** Y좌표 */
	private String yPosition					=	"";
	
	/** 팝업정렬순서 */
	private String mainSortOrdr					=	"";
	
	/** 공지여부 */		
	private String noticeAt						=	"";
	
	/** 이미지시퀀스 */
	private String atchFileId					=	"";
	
	/** 이미지 파일명 */
	private String atchFileNm					=	"";
	
	/** 이미지 대체 텍스트 */
	private String imgReplcText					=	"";
	
	/** 이미지 링크 URL */
	private String linkUrl						=	"";
	
	/** 템플릿 SEQ */
	private String tmplatSeq					=	"";
		
	/** 사용여부 */
	private String useAt						=	"";
	
	/** 팝업노출 */
	private String exposureAt 					=	"";
	
	/** 사용자ID */
	private String userId						=	"";
		
	/** 1차구분 */
	private String lcalsCode					=	"";
	
	/** 1차구분명 */
	private String lcalsCodeNm					=	"";
	
	/** 2차구분 */
	private String mlsfcCode					=	"";
	
	/** 2차구분명 */
	private String mlsfcCodeNm					=	"";
	
	/** 이미지링크 사용여부 */
	private String imgLinkuseAt					=	"";
	
	/** 이미지 새창 여부 */
	private String linkTargetSe					=	"";
	
	/** 팝엄 명? (사용X) */
	private String popupNm						=	"";
	
	/** 메인사용여부? (사용X) */
	private String mainUseAt					=	"";
	
	/** 팝업 등록일자 */
	private String frstRegistPnttm				=	"";
	
	/** 검색조건에서 사용하는 팝업상태 */
	private String searchPopupSttus				=	"";
	
	/** 검색조건에서 사용하는 사용여부 */
	private String searchNoticeAt				=	"";

	/** 팝업 상태 (대기,진행중,종료) */
	private String popupSttus					=	"";
	
}

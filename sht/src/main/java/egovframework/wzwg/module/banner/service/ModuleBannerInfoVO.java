package egovframework.wzwg.module.banner.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class ModuleBannerInfoVO extends ComDefaultVO {

	/** 배너SEQ */
	private String bannerSeq;
	
	/** 사이트SEQ */
	private String siteSeq;

	/** 배너 대분류코드 */
	private String bannerLclCode;
	
	/** 배너 대분류코드명 */
	private String bannerLclCodeNm;
	
	/** 배너 중분류코드 */
	private String bannerMclCode;
	
	/** 배너 중분류코드명 */
	private String bannerMclCodeNm;
	
	/** 배너명 */
	private String bannerNm;

	/** 무제한 적용 여부 */
	private String pdSetupAt;
	
	/** 시작일자 */
	private String startDt;
	
	/** 시작시간 */
	private String startTime;
	
	/** 종료일자 */
	private String endDt;
	
	/** 종료시간 */
	private String endTime;
	
	/** 링크 URL */
	private String linkUrl;
	
	/** 링크유형코드 */
	private String linkTyCd;
	
	/** 링크 사용여부 */
	private String linkUseAt;
	
	/** 첨부파일 ID */
	private String atchFileId;
	
	/** 이미지 대체 텍스트 */
	private String imgReplcText;
	
	/** 상태 */
	private String sttus;
	
	/** 사용여부 */
	private String useAt;
	
	/** 공지여부 */
	private String noticeAt;
	
	/** 최초등록자 ID */
	private String frstRegisterId;
	
	/** 최초등록일시 */
	private String frstRegistPnttm;
	
	/** 최종수정자 ID */
	private String lastUpdusrId;
	
	/** 최종수정일자 */
	private String lastUpdtPnttm;
	
	/** 사용자 ID */
	private String userId;
	
	/** 검색조건(무제한/제한여부) */
	private String searchPdSetupAt;
	
	/** 검색조건(공지여부) */
	private String searchNoticeAt;
	
	private String sortOrdr;

	/** 검색조건(상태) */
	private String searchPopupSttus;
	
}


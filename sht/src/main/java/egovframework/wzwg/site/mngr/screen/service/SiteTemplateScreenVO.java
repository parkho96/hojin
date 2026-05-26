package egovframework.wzwg.site.mngr.screen.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteTemplateScreenVO   {
	private String templateSeq;
	private String templateNm;
	private String templateNcnm;
	private String templateSeCode;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String templateLclCode;
	private String templateMclCode;
	private String templateSclCode;
	private String useAt;
	private String templateStreCours;
	private String thumbUrl;
	private String thumbUrlSub1;
	private String thumbUrlSub2;
	private String thumbUrlSub3;
	private String thumbUrlSub4;
	private String thumbUrlSub5;
	private String thumbUrlSubMobile;
	private String userId;
	private String siteSeq;
	private String domnSeq;
	private String templateLclNm;
	private String templateMclNm;
	private String templateSclNm;
	private String templateCnt;
	private String searchCondition;
	private String searchKeyword;
	private String templateCntns;
	
	private String codeAbrvNm;
	
	private String code;
	
	private String codeNm;
	
	private String cnt;
	
	private String layoutSeCode;
	
	/** 현재페이지 */
	private int pageIndex = 1;
	/** 페이지갯수 */
	private int pageUnit = 10;
	/** 페이지사이즈 */
	private int pageSize = 10;
	/** firstIndex */
	private int firstIndex = 1;
	/** lastIndex */
	private int lastIndex = 1;
	/** recordCountPerPage */
	private int recordCountPerPage = 10;
	
	private String langCode;
	private String mngrYt;
	
}

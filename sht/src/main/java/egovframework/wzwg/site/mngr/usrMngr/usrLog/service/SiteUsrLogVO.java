package egovframework.wzwg.site.mngr.usrMngr.usrLog.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteUsrLogVO {
	private String siteusrlogSeq;
	private String siteSeq;
	private String usrSeq;
	private String usrChngCode;
	private String usrlogUrl;
	private String usrlogParam;
	private String usrlogUsrSeq;
	private String conectIp;
	private String linkageAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	
	private String 	siteNm;
	private String	userId;
	private String	trgtUsrSeq;
	private String 	trgtUserId;
	private String	chngNm;
	private String langCode;
	
	 /** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 검색여부 */
    private String searchAt = "";
    
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
  
    private String searchKeywordFrom = "";
    
    private String searchKeywordTo = "";
	
}

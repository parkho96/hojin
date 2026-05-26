package egovframework.wzwg.site.mngr.inqryDtls.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteInqryDtlsVO {
    
    private String siteSeq;
    private String inqrydtlsSeq;
    private String waterNm;
    private String waterCttpl;
    private String inqrySj;
    private String inqryCn;
    private String frstRegistPnttm;
    private String lastUpdusrId;
    private String lastUpdtPnttm;
	
    /* 현재페이지 */
    private int pageIndex = 1;

    /* 페이지갯수 */
    private int pageUnit = 10;

    /* 페이지사이즈 */
    private int pageSize = 10;

    /* firstIndex */
    private int firstIndex = 1;

    /* lastIndex */
    private int lastIndex = 1;

    /* recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /* 검색구분 */
    private String searchCondition;
    
    /* 검색keyword */
    private String searchKeyword;

}

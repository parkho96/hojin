package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SiteStplatInfoVO implements Serializable {

	private String siteSeq;
	private String stplatSeq;
	private String stplatNm;
	private String stplatDc;
	private String stplatTyCode;
	private String stplatTyCodeNm;
	private String useAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String stplatInfoUserId ;
	private String stplatInfoRegDate;
	private String usrSeq;
	private String defaultAt;
	private String essntlAt;
	private String expsrAt;
	private String sysStplatSeq;
	private String sysStplatsimpSeq;
	
	private String[] stplatsimpSeqArr;
	private String stplatsimpSeq;

	private String stplatSj;
	private String stplatCn;
	private String opertnDe;
	private String endDe;
	
	private String agreAt;
	
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
    
    /** 검색조건 */
    private String searchCondition = "";
    
    /** 검색Keyword */
    private String searchKeyword = "";
    
    /** 언어코드 */
    private String langCode;

	public String[] getStplatsimpSeqArr() {
		if(stplatsimpSeqArr != null) {
			return Arrays.copyOf(stplatsimpSeqArr,stplatsimpSeqArr.length);
		}else {
			return null;
		}
	}

	public void setStplatsimpSeqArr(String[] stplatsimpSeqArr) {
		if (stplatsimpSeqArr != null) {
			this.stplatsimpSeqArr = Arrays.copyOf(stplatsimpSeqArr, stplatsimpSeqArr.length);
		} else {
			this.stplatsimpSeqArr = null;
		}
	}

}

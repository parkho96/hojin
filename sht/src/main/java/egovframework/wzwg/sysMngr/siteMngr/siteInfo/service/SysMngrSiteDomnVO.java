package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSiteDomnVO implements Serializable {

	/*도메인SEQ*/
	private String domnSeq;

	/*도메인구분코드*/
	private String domnSeCode;
	
	/*도메인구분코드명*/
	private String domnSeCodeNm;

	/*사이트 사용 언어 코드*/
	private String useLangCode;

	/*사이트 사용 언어 코드명*/
	private String useLangCodeNm;

	/*사이트 URL*/
	private String siteUrl;

	/*최초등록자ID*/
	private String frstRegisterId;

	/*최초등록시점*/
	private String frstRegistPnttm;

	/*최종수정자ID*/
	private String lastUpdusrId;

	/*최종수정시점*/
	private String lastUpdtPnttm;

	/*사이트SEQ*/
	private String siteSeq;
	
	/*대표도메인여부*/
	private String reprsntDomnAt;

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
    
    /** 도메인삭제 **/
    private String[] domnSeqArr;

    /** recordCountPerPage */
    private int recordCountPerPage = 10;
    
    /** 언어코드 */
    private String langCode;
    
    /** 기존 사이트 URL */
    private String prevSiteUrl;
    
	public String[] getDomnSeqArr() {
		if(domnSeqArr != null) {
			return Arrays.copyOf(domnSeqArr,domnSeqArr.length);
		}else {
			return null;
		}
	}

	public void setDomnSeqArr(String[] domnSeqArr) {
		if (domnSeqArr != null) {
			this.domnSeqArr = Arrays.copyOf(domnSeqArr, domnSeqArr.length);
		} else {
			this.domnSeqArr = null;
		}
	}

}
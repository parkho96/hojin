package egovframework.wzwg.site.mngr.cmnt.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteCmntInfoVO   {
	 
	
	private String cmntSeq;
	 
	private String siteSeq;
	
	private String cmntNm;
	
	private String cmntMngrSeq;
	
	private String cmntTelno;
	
	private String cmntEmailAdres;
	
	private String cmntMeaning;
	
	private String cmntOpenCode;
	
	private String cmntApprovalCode;
	
	private String cmntApprovalPnttm;
	
	private String cmntAppvlCode;
	
	private String cmntIntro;
	
	private String cmntProvisionAt;
	
	private String cmntProvisionInfo;
	
	private String cmntUseAt;
	
	private String cmntIconStre;
	
	private String cmntMngrNm;
	
	private String cmntMngrTy;
	
	private String cmntApprovalNm;
	
	private String cmntOpenNm;
	
	private String cmntMngrId;
	
	private String cmntOrdr;
	private String ordrGubun;
	
	private String[] chkAppvlArr;
	private String[] usrgroupSeqArry;
	
	
	 /** 최초등록자 **/
    private String frstRegisterId;
    
    /** 최초등록일시 **/
    private String frstRegistPnttm;

    /** 최종등록자 **/
    private String lastUpdusrId;
    
    /** 최종등록일시 **/
    private String lastUpdtPnttm;
    
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
    
    private String searchCondition;
    private String searchKeyword;
    private String cmntApprovalCodeSearch;
    
    private String usrgroupSeq;

    private String langCode;
    
    private String cmntSimpIntro;
    
	public String[] getChkAppvlArr() {
		if(chkAppvlArr != null) {
			return Arrays.copyOf(chkAppvlArr,chkAppvlArr.length);
		}else {
			return null;
		}
	}

	public void setChkAppvlArr(String[] chkAppvlArr) {
		if (chkAppvlArr != null) {
			this.chkAppvlArr = Arrays.copyOf(chkAppvlArr, chkAppvlArr.length);
		} else {
			this.chkAppvlArr = null;
		}
	}

	public String[] getUsrgroupSeqArry() {
		if(usrgroupSeqArry != null) {
			return Arrays.copyOf(usrgroupSeqArry,usrgroupSeqArry.length);
		}else {
			return null;
		}
	}

	public void setUsrgroupSeqArry(String[] usrgroupSeqArry) {
		if (usrgroupSeqArry != null) {
			this.usrgroupSeqArry = Arrays.copyOf(usrgroupSeqArry, usrgroupSeqArry.length);
		} else {
			this.usrgroupSeqArry = null;
		}
	}

}

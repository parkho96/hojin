package egovframework.wzwg.module.cmnt.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmntUserVO   {
	 
	 private String siteSeq;
	 
	 private String usrSeq;
	 
	 private String cmntSeq;
	 
	 private String apprvlCode;
	 
	 private String apprvlPnttm;
	 
	 private String userGroupseq; 
	 
	 private String useAt;
	
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
    private String apprvlCodeSearch;
    
    private String connCnt;
    private String userId;
    private String userNm;
    private String bbsCnt;
    private String lastConnPnttm;
    
    private String[] chkAppvlArr;
    
    private String[] usrSeqArr;
    
    private String[] apprvlCodeArr;

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

	public String[] getUsrSeqArr() {
		if(usrSeqArr != null) {
			return Arrays.copyOf(usrSeqArr,usrSeqArr.length);
		}else {
			return null;
		}
	}

	public void setUsrSeqArr(String[] usrSeqArr) {
		if (usrSeqArr != null) {
			this.usrSeqArr = Arrays.copyOf(usrSeqArr, usrSeqArr.length);
		} else {
			this.usrSeqArr = null;
		}
	}

	public String[] getApprvlCodeArr() {
		if(apprvlCodeArr != null) {
			return Arrays.copyOf(apprvlCodeArr,apprvlCodeArr.length);
		}else {
			return null;
		}
	}

	public void setApprvlCodeArr(String[] apprvlCodeArr) {
		if (apprvlCodeArr != null) {
			this.apprvlCodeArr = Arrays.copyOf(apprvlCodeArr, apprvlCodeArr.length);
		} else {
			this.apprvlCodeArr = null;
		}
	}

}

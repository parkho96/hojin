package egovframework.wzwg.site.mngr.cmnt.service;

import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteCmntCfgVO   {
	 
	private String siteSeq			= "";
	
	private String cmntEstblCode			= "";
	
	private String cmntAppvlCode ="";
	
	private String cmntInfo ="";
	
	 /** 최초등록자 **/
    private String frstRegisterId;
    
    /** 최초등록일시 **/
    private String frstRegistPnttm;

    /** 최종등록자 **/
    private String lastUpdusrId;
    
    /** 최종등록일시 **/
    private String lastUpdtPnttm;
    
    private String usrgroupSeq;
    
    private String[] usrgroupSeqArry;
    
    private String usrgroupNm;
    
    private String userId;
    
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

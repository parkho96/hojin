package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SysMngrSiteModuleInfoVO implements Serializable {
    
	private String siteSeq;
	private String sysmoduleSeq;
	private String[] sysmoduleSeqArr;
	private String moduleCnt;
	private String moduleTyCode;
	private String moduleNm;
	private String moduleNmEng;
	private String frstRegisterId;
	private String frstRegisterIp;
	
	/**
	public String[] getSysmoduleSeqArr() {
		if(sysmoduleSeqArr != null) {
				return Arrays.copyOf(sysmoduleSeqArr,sysmoduleSeqArr.length);
			}else {
				return null;
			} 
	}
	
	public void setSysmoduleSeqArr(String[] sysmoduleSeqArr) {
		if (sysmoduleSeqArr != null) {
			this.sysmoduleSeqArr = Arrays.copyOf(sysmoduleSeqArr, sysmoduleSeqArr.length);
		} else {
			this.sysmoduleSeqArr = null;
		}
	}
	**/
	
	
}

package egovframework.com.cmm.interceptor.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MngrAuthVO implements Serializable{
    
	private static final long serialVersionUID = 1L;
    
    private String siteSeq;
    private String usrSeq;
    private String codegrpSeq;
    private String authgrpNm;
    private String authgrpId;
    private String userId;
	private String[] codegrpSeqArr;
	private String[] mngrMenuSeqArry;
	
    public String[] getCodegrpSeqArr() {
    	if(codegrpSeqArr != null) {
            return Arrays.copyOf(codegrpSeqArr, codegrpSeqArr.length);
    	} else {
    		return null;
    	}
    }

    public void setCodegrpSeqArr(String[] codegrpSeqArr) {
		if (codegrpSeqArr != null) {
			this.codegrpSeqArr = Arrays.copyOf(codegrpSeqArr, codegrpSeqArr.length);
		} else {
			this.codegrpSeqArr = null;
		}
    }

	public String[] getMngrMenuSeqArry() {
		if(mngrMenuSeqArry != null) {
	        return Arrays.copyOf(mngrMenuSeqArry, mngrMenuSeqArry.length);
        } else {
            return null;
        } 
	}

	public void setMngrMenuSeqArry(String[] mngrMenuSeqArry) {
		if (mngrMenuSeqArry != null) {
			this.mngrMenuSeqArry = Arrays.copyOf(mngrMenuSeqArry, mngrMenuSeqArry.length);
		} else {
			this.mngrMenuSeqArry = null;
		}
	}
    
}

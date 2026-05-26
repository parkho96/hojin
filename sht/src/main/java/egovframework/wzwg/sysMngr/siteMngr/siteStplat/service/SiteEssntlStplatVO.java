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
public class SiteEssntlStplatVO implements Serializable {
    
    private String siteSeq;
    private String stplatTyCode;
    private String stplatTyCodeNm;
    private String stplatSeq;
    private String stplatNm;
	private String stplatdetailSeq;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String[] stplatTyCodeArr;
	private String stplatlogSeq;
	private String langCode;
	
    public String[] getStplatTyCodeArr() {
    	if(stplatTyCodeArr != null) {
            return Arrays.copyOf(stplatTyCodeArr,stplatTyCodeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setStplatTyCodeArr(String[] stplatTyCodeArr) {
		if (stplatTyCodeArr != null) {
			this.stplatTyCodeArr = Arrays.copyOf(stplatTyCodeArr, stplatTyCodeArr.length);
		} else {
			this.stplatTyCodeArr = null;
		}
    }

}

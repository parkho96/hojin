package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service;

import java.io.Serializable;
import java.util.Arrays;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SiteStplatLogVO extends ComDefaultVO implements Serializable{

    private String stpdetaillogSeq;
    private String stplatlogSeq;
    private String siteSeq;
    private String stplatSeq;
    private String stplatdetailSeq;
    private String stplatTyCode;
    private String stplatNm;
    private String stplatDc;
    private String stplatCn;
    private String ordr;
    private String stplatdetailTyCode;
    private String stplatDetailNm;
    private String stplatDetailDc;
    private String stplatDetailCn;
    private String essntlAgreAt;
    private String beginPnttm;
    private String endPnttm;
    private String useAt;
    private String frstRegisterId;
    private String frstRegistPnttm;
    private String sdRegisterId;
    private String sdRegistPnttm;
    private String lastUpdusrId;
    private String lastUpdtPnttm;
    private String stplatUpdusrId;
    private String stplatUpdtPnttm;
    private String stplatdUpdusrId;
    private String stplatdUpdtPnttm;
    private String usrSeq;
    private String[] stplatlogSeqArr;
    private String stplatsimpSeq;

    public String[] getStplatlogSeqArr() {
    	if(stplatlogSeqArr !=  null) {
            return Arrays.copyOf(stplatlogSeqArr,stplatlogSeqArr.length);
    	}else {
    		return null;
    	}
    }
    
    public void setStplatlogSeqArr(String[] stplatlogSeqArr) {
		if (stplatlogSeqArr != null) {
			this.stplatlogSeqArr = Arrays.copyOf(stplatlogSeqArr, stplatlogSeqArr.length);
		} else {
			this.stplatlogSeqArr = null;
		}
    }

}

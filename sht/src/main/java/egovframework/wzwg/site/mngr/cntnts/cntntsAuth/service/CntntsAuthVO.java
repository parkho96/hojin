package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CntntsAuthVO implements Serializable  {

	private static final long serialVersionUID = 1L;

    private String usrgroupSeq;
    private String siteSeq;
    private String tyNm;
    private String usrGroupNm;
    private String usrDc;
    private String sitecntntsSeq;
    private String frstRegisterId;
    private String frstRegistPnttm;
    private String lastUpdusrId;
    private String lastUpdtPnttm;
    private String authorSe;
    private String usrSeq;
    private String cntntsSeq;    
    private String[] nmbrUsrGroupSeq; 
    private String[] authorSeArr;
    private String[] usrgroupSeqArr;
    
    private String authorSeStrArr;
    
    private String menuSeq;
    
    private String writeAuthAt;
    
    private String atchFileId;

    public String[] getAuthorSeArr() {
    	if(authorSeArr != null) {
            return Arrays.copyOf(authorSeArr,authorSeArr.length);
    	}else {
    		return null;
    	}
    }

    public void setAuthorSeArr(String[] authorSeArr) {
		if (authorSeArr != null) {
			this.authorSeArr = Arrays.copyOf(authorSeArr, authorSeArr.length);
		} else {
			this.authorSeArr = null;
		}
    }

    public String[] getUsrgroupSeqArr() {
    	if(usrgroupSeqArr != null) {
            return Arrays.copyOf(usrgroupSeqArr,usrgroupSeqArr.length);
    	}else {
    		return null;
    	}
    }

    public void setUsrgroupSeqArr(String[] usrgroupSeqArr) {
		if (usrgroupSeqArr != null) {
			this.usrgroupSeqArr = Arrays.copyOf(usrgroupSeqArr, usrgroupSeqArr.length);
		} else {
			this.usrgroupSeqArr = null;
		}
    }

	public String[] getNmbrUsrGroupSeq() {
    	if(nmbrUsrGroupSeq != null) {
            return Arrays.copyOf(nmbrUsrGroupSeq,nmbrUsrGroupSeq.length);
    	}else {
    		return null;
    	}
    }

    public void setNmbrUsrGroupSeq(String[] nmbrUsrGroupSeq) {
		if (nmbrUsrGroupSeq != null) {
			this.nmbrUsrGroupSeq = Arrays.copyOf(nmbrUsrGroupSeq, nmbrUsrGroupSeq.length);
		} else {
			this.nmbrUsrGroupSeq = null;
		}
    }

}

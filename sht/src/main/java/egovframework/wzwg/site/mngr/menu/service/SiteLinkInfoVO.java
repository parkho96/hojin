package egovframework.wzwg.site.mngr.menu.service;

import java.util.Arrays;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class SiteLinkInfoVO extends ComDefaultVO{

    private static final long serialVersionUID = 1L;
    
    private String linkSeq;
    private String linkNm;
    private String linkDc;
    private String linkUrl;
    private String ordr;
    private String ordrGubun;
    private String[] linkSeqArr;
    
    public String[] getLinkSeqArr() {
    	if(linkSeqArr != null) {
            return Arrays.copyOf(linkSeqArr,linkSeqArr.length);
    	}else {
    		return null;
    	}
    }
    public void setLinkSeqArr(String[] linkSeqArr) {
        if (linkSeqArr != null) {
            this.linkSeqArr = Arrays.copyOf(linkSeqArr, linkSeqArr.length);
        } else {
            this.linkSeqArr = null;
        }
    }
}

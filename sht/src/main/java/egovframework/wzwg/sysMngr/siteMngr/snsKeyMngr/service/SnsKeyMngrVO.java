package egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service;

import java.io.Serializable;
import java.util.Arrays;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@SuppressWarnings("serial")
public class SnsKeyMngrVO implements Serializable {
    
    private String siteSeq;
    private String snsTyCode;
    private String snsTyCodeNm;
    private String clientId;
    private String clientSecret;
	private String frstRegisterId;
	private String frstRegistPnttm;

    private String[] snsTyCodeArr;
    private String[] clientIdArr;
    private String[] clientSecretArr;
    
    private String langCode;
    
    public String[] getSnsTyCodeArr() {
    	if(snsTyCodeArr != null) {
            return Arrays.copyOf(snsTyCodeArr,snsTyCodeArr.length);
    	}else {
    		return null;
    	}
    }
    public void setSnsTyCodeArr(String[] snsTyCodeArr) {
		if (snsTyCodeArr != null) {
			this.snsTyCodeArr = Arrays.copyOf(snsTyCodeArr, snsTyCodeArr.length);
		} else {
			this.snsTyCodeArr = null;
		}
    }

    public String[] getClientIdArr() {
    	if(clientIdArr != null) {
            return Arrays.copyOf(clientIdArr,clientIdArr.length);
    	}else {
    		return null;
    	}
    }

    public void setClientIdArr(String[] clientIdArr) {
		if (clientIdArr != null) {
			this.clientIdArr = Arrays.copyOf(clientIdArr, clientIdArr.length);
		} else {
			this.clientIdArr = null;
		}
    }

    public String[] getClientSecretArr() {
    	if(clientSecretArr != null) {
            return Arrays.copyOf(clientSecretArr,clientSecretArr.length);
    	}else {
    		return null;
    	}
    }

    public void setClientSecretArr(String[] clientSecretArr) {
		if (clientSecretArr != null) {
			this.clientSecretArr = Arrays.copyOf(clientSecretArr, clientSecretArr.length);
		} else {
			this.clientSecretArr = null;
		}
    }

}

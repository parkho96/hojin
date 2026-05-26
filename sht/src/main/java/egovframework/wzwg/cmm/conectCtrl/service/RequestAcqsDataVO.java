package egovframework.wzwg.cmm.conectCtrl.service;


public class RequestAcqsDataVO  {

    private String siteSeq;
    private String siteNm;
    private String siteUrl;
    private String retUrl;
    private String userAuth;
    private String menuNo;
    private String reqUsrGubun;
    private String userMenuAuth;
    private String bbsMenuAuth;
    private String errCd;
    private String sysSiteAt;
    private String siteLclasGroup;
    private String siteMlsfcGroup;
    private String useLangCode;
    private String sslUseAt;
    private String ablEnncAt;
    private String asscNo;
    private String siteKey;
    private boolean siteKeyYn = false;
    
    private boolean superAdmin = false;
    
    /** 도메인 Seq **/
    private String domnSeq;
    
    public String getSiteSeq() {
        return siteSeq;
    }

    public void setSiteSeq(String siteSeq) {
        this.siteSeq = siteSeq;
    }

    public String getSiteNm() {
        return siteNm;
    }

    public void setSiteNm(String siteNm) {
        this.siteNm = siteNm;
    }

    public String getSiteUrl() {
        return siteUrl;
    }

    public void setSiteUrl(String siteUrl) {
        this.siteUrl = siteUrl;
    }

    public String getRetUrl() {
        return retUrl;
    }

    public void setRetUrl(String retUrl) {
        this.retUrl = retUrl;
    }

    public String getUserAuth() {
        return userAuth;
    }

    public void setUserAuth(String userAuth) {
        this.userAuth = userAuth;
    }

    public String getMenuNo() {
        return menuNo;
    }

    public void setMenuNo(String menuNo) {
        this.menuNo = menuNo;
    }

    public String getReqUsrGubun() {
        return reqUsrGubun;
    }

    public void setReqUsrGubun(String reqUsrGubun) {
        this.reqUsrGubun = reqUsrGubun;
    }

    public String getUserMenuAuth() {
        return userMenuAuth;
    }

    public void setUserMenuAuth(String userMenuAuth) {
        this.userMenuAuth = userMenuAuth;
    }

    public boolean isSuperAdmin() {
        return superAdmin;
    }

    public void setSuperAdmin(boolean superAdmin) {
        this.superAdmin = superAdmin;
    }

    public String getBbsMenuAuth() {
        return bbsMenuAuth;
    }

    public void setBbsMenuAuth(String bbsMenuAuth) {
        this.bbsMenuAuth = bbsMenuAuth;
    }

    public String getErrCd() {
        return errCd;
    }

    public void setErrCd(String errCd) {
        this.errCd = errCd;
    }

	public String getSysSiteAt() {
		return sysSiteAt;
	}

	public void setSysSiteAt(String sysSiteAt) {
		this.sysSiteAt = sysSiteAt;
	}

	public String getDomnSeq() {
		return domnSeq;
	}

	public void setDomnSeq(String domnSeq) {
		this.domnSeq = domnSeq;
	}

    public String getSiteLclasGroup() {
        return siteLclasGroup;
    }

    public void setSiteLclasGroup(String siteLclasGroup) {
        this.siteLclasGroup = siteLclasGroup;
    }

    public String getSiteMlsfcGroup() {
        return siteMlsfcGroup;
    }

    public void setSiteMlsfcGroup(String siteMlsfcGroup) {
        this.siteMlsfcGroup = siteMlsfcGroup;
    }

    public String getUseLangCode() {
        return useLangCode;
    }

    public void setUseLangCode(String useLangCode) {
        this.useLangCode = useLangCode;
    }

    public String getSslUseAt() {
        return sslUseAt;
    }

    public void setSslUseAt(String sslUseAt) {
        this.sslUseAt = sslUseAt;
    }

    public String getAblEnncAt() {
        return ablEnncAt;
    }

    public void setAblEnncAt(String ablEnncAt) {
        this.ablEnncAt = ablEnncAt;
    }

	public String getAsscNo() {
		return asscNo;
	}

	public void setAsscNo(String asscNo) {
		this.asscNo = asscNo;
	}

	public String getSiteKey() {
		return siteKey;
	}

	public void setSiteKey(String siteKey) {
		this.siteKey = siteKey;
	}

	public boolean isSiteKeyYn() {
		return siteKeyYn;
	}

	public void setSiteKeyYn(boolean siteKeyYn) {
		this.siteKeyYn = siteKeyYn;
	}
	
}

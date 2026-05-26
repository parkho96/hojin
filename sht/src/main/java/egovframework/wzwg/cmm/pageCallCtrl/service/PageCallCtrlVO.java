package egovframework.wzwg.cmm.pageCallCtrl.service;

public class PageCallCtrlVO {

    /**사이트SEQ**/
    private String siteSeq;

    /**사이트컨텐츠SEQ**/
    private String sitecntntsSeq;
    
    /**메뉴SEQ**/
    private String menuSeq;
    
    private String menuPath;
    
    private String menuNm;

    /**메뉴타입구분**/
    private String menuTySe;

    public String getSiteSeq() {
        return siteSeq;
    }

    public void setSiteSeq(String siteSeq) {
        this.siteSeq = siteSeq;
    }

    public String getSitecntntsSeq() {
        return sitecntntsSeq;
    }

    public void setSitecntntsSeq(String sitecntntsSeq) {
        this.sitecntntsSeq = sitecntntsSeq;
    }

    public String getMenuSeq() {
        return menuSeq;
    }

    public void setMenuSeq(String menuSeq) {
        this.menuSeq = menuSeq;
    }

    public String getMenuTySe() {
        return menuTySe;
    }

    public void setMenuTySe(String menuTySe) {
        this.menuTySe = menuTySe;
    }

	public String getMenuPath() {
		return menuPath;
	}

	public void setMenuPath(String menuPath) {
		this.menuPath = menuPath;
	}

	public String getMenuNm() {
		return menuNm;
	}

	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}

}

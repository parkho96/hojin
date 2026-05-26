package egovframework.wzwg.site.mngr.menu.service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteMngrBkmkVO extends CntntsInfoVO {
	 
	  private String mngrBkmkSeq;
	  private String siteSeq;
	  private String mngrMenuSeq;
	  private String mngrMenuNm;
	  private String mngrMenuNmEng;
	  private String menuLinkUrl;
	  private String frstRegisterId;
	  private String frstRegistPnttm;
	  private String lastUpdtPnttm;
	  
	  private String mngrParentMenuNm;
	  private String mngrParentMenuNmEng;
	  
}

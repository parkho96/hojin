package egovframework.wzwg.site.mngr.menu.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
public class SiteLinkGrpInfoVO extends SiteLinkInfoVO {
	
    private static final long serialVersionUID = 1L;
    
    private String linkGrpSeq;
    private String siteSeq;
    private String groupNm;
    private String groupDc;
    private String linkTyCode;
    private String useAt;
    private String frstRegisterId; 
    private String frstRegistPnttm; 
    private String lastUpdusrId; 
    private String lastUpdtPnttm;
    private String userId;
    
}

package egovframework.wzwg.module.cmnt.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmntMenuAuthVO   {
	
	private String siteSeq;
	
	private String menuSeq;
	
	private String cmntSeq;
	
	private String apprvlCode;
	
	private String authSe; 
	
	private String authSeAppC;
	
	private String authSeAppR;
	
	private String authSeAppW;
	
	private String authSeNappC;
	
	private String authSeNappR;
	
	private String authSeNappW;

	 /** 최초등록자 **/
    private String frstRegisterId;
    
    /** 최초등록일시 **/
    private String frstRegistPnttm;

    /** 최종등록자 **/
    private String lastUpdusrId;
    
    /** 최종등록일시 **/
    private String lastUpdtPnttm;
    
    
    private String bbsSeq;
    
    private String authorSe;
    
}

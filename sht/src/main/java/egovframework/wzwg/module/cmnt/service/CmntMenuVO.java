package egovframework.wzwg.module.cmnt.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmntMenuVO   {
	
	private String siteSeq;
	
	private String menuSeq;
	
	private String cmntSeq;
	
	private String bbsSeq;
	
	private String menuNm;
	
	private String useAt;
	
	private String menuOrdr;
	
	private String listScrinCode;

	 /** 최초등록자 **/
    private String frstRegisterId;
    
    /** 최초등록일시 **/
    private String frstRegistPnttm;

    /** 최종등록자 **/
    private String lastUpdusrId;
    
    /** 최종등록일시 **/
    private String lastUpdtPnttm;
      
    /* 첨부파일 가능 여부 */
    private String atchFilePosblAt;
    
    /* 첨부파일 가능 개수 */
    private String atchFilePosblCo;
    
}

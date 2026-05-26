package egovframework.wzwg.site.mngr.screen.service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteScreenVO extends CntntsInfoVO {
	 
	private String backup			= "";
	
	private String contents			= "";
	
	private String topContents ="";
	
	private String footerContents ="";
	
	private String menuSeq="";
	
	private String leftContents="";
	
	private String templtUrl="";
	
	private String topMenuSe="";
	
	private String topSubImgSource="";
	
	private String btnSubImgSource="";
	
	private String tempYn="";
	
	private String tmpbakupSeq;
	
	private String templateSeq;
	
	private String backupNm;
	
	private String indexFileNm;
	
	private String upendmenuFileNm;
	
	private String lptmenuFileNm;
	
	private String userId;
	
	private String frstRegisterId;
	
	/* moo0506 */
	private String headCss;
	private String footCss;
	private String subCss;
	
	private String headMenuCss;
	private String headMenuData;

	private String subMenuSeqs;
	private String usrSubEdit;
	
	private String sysmoduleSeq;
	
	/* 분류컨텐츠 모듈 연결을 위해추가 */
	private String nttSeq;
	private String bbsSeq;
	private String nttSj;
	
}

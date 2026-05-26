package egovframework.wzwg.site.mngr.menu.service;

import java.io.Serializable;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SiteHdftrMenuVO implements Serializable {
	 
	private String hdftrmenuSeq;
	private String siteSeq;
	private String hdftrmenuNm;
	private String hdftrmenuTyCode;
	private String hdftrmenuLinkUrl;
	private String hdftrmenuDc;
	private String hdftrCode;
	private String hdftrmenuOrdr;
	private String lgnAt;
	private String useAt;
	private String frstRegisterId;
	private String frstRegistPnttm; 
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String  userId;
	private String hdftrmenuOrdrNew;
	private String ordrGubun;
	private String hdftrmenuTyNm;
	private String defaultAt;
	private String menuTySe;
	private String linkGrpSeq;
	private String langCode;
	private String yChk;
	private String nChk;
	private String chkCondition;
	private String iconFileId;
	private String iconReplcText;
	private String strngthStyle;
	private String lognN;
	private String lognY;
	
}

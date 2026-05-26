package egovframework.wzwg.module.upload.image.service;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ModuleUploadImageVO {

	/** SITEUSRIMG Start */
	private String siteimageId;
	private String usrimgId;
	private String imageStreCours;
	private String streImageNm;
	private String orignlImageNm;
	private String imageExtsn;
	private String imageMg;
	private int scrollPageIdx = 0;
	private int startScrollPageIdx = 0;
	private int endScrollPageIdx = 0;
	/** SITEUSRIMG End */
	

	/** SITEUSRIMGFOLDER Start*/
	private String imgfolderId;
	private String imgfolderNm;
	private String imgfolderOrdr;
	private String imagePath;
	private String siteSeq;	
	private String siteFullNm;
	private String siteUrl;
	private String parntsImgfolderId;
	/** SITEUSRIMGFOLDER End */
	

	private String useAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String imageTotCnt;
	private String imageCnt;
	private String searchFolderId;
	private String totCnt;
	private String usrTySe;
	private String searchSiteSeq;
	private String subCnt;
	
	
}

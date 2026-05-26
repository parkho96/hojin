package egovframework.wzwg.site.mngr.screen.service;

import egovframework.com.cmm.ComDefaultVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SiteLayoutVO  extends ComDefaultVO {
	
	private static final long serialVersionUID = 1L;

	private String layoutSeq;
	private String layoutNm;
	private String widthCssNm;
	private String vrticlCssNm;
	private String thumbFileNm;
	private String thumbStreCours;
	private String useAt;
	private String blankAt;
	private String frstRegisterId;
	private String frstRegistPnttm;
	private String lastUpdusrId;
	private String lastUpdtPnttm;
	private String userId;
	private String layoutSe;
	private String layoutCn;
	
	private String layoutcntntsSeq;
	private String layoutcntntsNm;
	private String layoutcntntsDc;
	private String category;
	private String width;
	private String height;
	private String thumbMPath;
	private String thumbLPath;
	private String thumbHPath;
	private String thumbWPath;
	private String sampleFileNm;
	private String sampleCssNm;
	private String sampleFileCours;
	
	private String widgSeq;
	private String layoutcntntsworkSeq;
	private String categoryCnt;
	
	private String sortCondition;
	
}

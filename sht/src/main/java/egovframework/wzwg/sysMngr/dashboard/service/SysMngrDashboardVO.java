package egovframework.wzwg.sysMngr.dashboard.service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SysMngrDashboardVO extends CntntsInfoVO {

	private String lastLgnDt;
	private String cnt;
	private String statNm="";
	private String todayYn;
	private String siteSeq;
	private String contectId;
	
	private String siteNm;
	private String visitCnt;
	private String usrCnt;
	private String bbsCnt;
	private String menuCnt;
	private String asscNo;
	
	private String startYear = "";
	private String startMonth = "";
	private String endYear = "";
	private String endMonth = "";
	
	private String bgnde = "";
	private String endde = "";
		
}

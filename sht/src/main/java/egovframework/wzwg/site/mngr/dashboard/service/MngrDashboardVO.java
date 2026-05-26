package egovframework.wzwg.site.mngr.dashboard.service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MngrDashboardVO extends CntntsInfoVO {

	private String lastLgnDt;
	private String cnt;
	private String statNm="";
	private String todayYn;
	private String siteSeq;
	private String contectId;
	
}

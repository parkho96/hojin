package egovframework.wzwg.sysMngr.stat.service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SysMngrStatVO extends CntntsInfoVO {
		
	private String startDate;
	private String endDate;
	private String statDate="";
	private String cnt;
	private String siteSeq;
	
	private String startYear;
	private String startMonth;
	private String endYear;
	private String endMonth;
	

	private String bgnde = "";
	private String endde = "";
	
}

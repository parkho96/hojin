package egovframework.wzwg.site.mngr.dashboard.service;

import java.util.List;

public interface MngrDashboardService {
	  public String selectSiteLastLgnDt(MngrDashboardVO paramVO) ;
		
		public String selectSiteUsrCnt(MngrDashboardVO paramVO) ;
		
		public String selectSiteVisitCnt(MngrDashboardVO paramVO) ;
		
		public String selectSiteVisitTotCnt(MngrDashboardVO paramVO) ;
		
		public String selectSiteNttCnt(MngrDashboardVO paramVO) ;
		
		public List<MngrDashboardVO> selectSiteNttStatList(MngrDashboardVO paramVO);
		
		public List<MngrDashboardVO> selectSiteUsrStatList(MngrDashboardVO paramVO) ;

}

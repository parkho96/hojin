package egovframework.wzwg.sysMngr.dashboard.service;

import java.util.List;

public interface SysMngrDashboardService {
		
		public String selectSiteUsrCnt(SysMngrDashboardVO paramVO) ;
		
		public String selectSiteVisitCnt(SysMngrDashboardVO paramVO) ;
		
		public String selectSiteVisitTotCnt(SysMngrDashboardVO paramVO) ;
		
		public String selectSiteNttCnt(SysMngrDashboardVO paramVO) ;
		
		public List<SysMngrDashboardVO> selectSiteStatList(SysMngrDashboardVO paramVO);
		
		public List<SysMngrDashboardVO> selectSiteStatListExcel(SysMngrDashboardVO paramVO);
		

}

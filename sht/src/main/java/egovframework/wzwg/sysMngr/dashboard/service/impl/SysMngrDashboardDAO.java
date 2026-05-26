package egovframework.wzwg.sysMngr.dashboard.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.dashboard.service.SysMngrDashboardVO;

@Repository("SysMngrDashboardDAO")
public class SysMngrDashboardDAO extends EgovAbstractMapper {
 
	
	public String selectSiteUsrCnt(SysMngrDashboardVO paramVO) {
		return (String)selectOne("SysMngrDashboardDAO_selectSiteUsrCnt", paramVO);
	} 
	
	public String selectSiteVisitCnt(SysMngrDashboardVO paramVO) {
		return (String)selectOne("SysMngrDashboardDAO_selectSiteVisitCnt", paramVO);
	} 
	
	public String selectSiteVisitTotCnt(SysMngrDashboardVO paramVO) {
		return (String)selectOne("SysMngrDashboardDAO_selectSiteVisitTotCnt", paramVO);
	} 
	
	public String selectSiteNttCnt(SysMngrDashboardVO paramVO) {
		return (String)selectOne("SysMngrDashboardDAO_selectSiteNttCnt", paramVO);
	} 
	
	public List<SysMngrDashboardVO> selectSiteStatList(SysMngrDashboardVO paramVO) {
		return selectList("SysMngrDashboardDAO_selectSiteStatList", paramVO);
	}  
	
	public List<SysMngrDashboardVO> selectSiteStatListExcel(SysMngrDashboardVO paramVO) {
		return selectList("SysMngrDashboardDAO_selectSiteStatListExcel", paramVO);
	}  
	
}

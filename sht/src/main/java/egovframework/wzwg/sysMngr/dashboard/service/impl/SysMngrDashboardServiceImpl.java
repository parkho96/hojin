package egovframework.wzwg.sysMngr.dashboard.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.dashboard.service.SysMngrDashboardService;
import egovframework.wzwg.sysMngr.dashboard.service.SysMngrDashboardVO;

@Service("SysMngrDashboardService")
public class SysMngrDashboardServiceImpl extends EgovAbstractServiceImpl implements SysMngrDashboardService {
    
    @Resource(name="SysMngrDashboardDAO")
    private SysMngrDashboardDAO sysMngrDashboardDAO;
     
	
	public String selectSiteUsrCnt(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteUsrCnt(paramVO);
	} 
	
	public String selectSiteVisitCnt(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteVisitCnt(paramVO);
	} 
	
	public String selectSiteVisitTotCnt(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteVisitTotCnt(paramVO);
	} 
	
	public String selectSiteNttCnt(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteNttCnt(paramVO);
	} 
	
	public List<SysMngrDashboardVO> selectSiteStatList(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteStatList(paramVO);
	} 
	
	public List<SysMngrDashboardVO> selectSiteStatListExcel(SysMngrDashboardVO paramVO) {
		return sysMngrDashboardDAO.selectSiteStatListExcel(paramVO);
	} 
	 
}

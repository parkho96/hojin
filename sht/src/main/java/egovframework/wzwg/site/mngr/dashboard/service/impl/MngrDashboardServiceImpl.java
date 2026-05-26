package egovframework.wzwg.site.mngr.dashboard.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardService;
import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardVO;

@Service("MngrDashboardService")
public class MngrDashboardServiceImpl extends EgovAbstractServiceImpl implements MngrDashboardService {
    
    @Resource(name="MngrDashboardDAO")
    private MngrDashboardDAO mngrDashboardDAO;
    
    public String selectSiteLastLgnDt(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteLastLgnDt(paramVO);
	} 
	
	public String selectSiteUsrCnt(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteUsrCnt(paramVO);
	} 
	
	public String selectSiteVisitCnt(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteVisitCnt(paramVO);
	} 
	
	public String selectSiteVisitTotCnt(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteVisitTotCnt(paramVO);
	} 
	
	public String selectSiteNttCnt(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteNttCnt(paramVO);
	} 
	
	public List<MngrDashboardVO> selectSiteNttStatList(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteNttStatList(paramVO);
	} 
	
	public List<MngrDashboardVO> selectSiteUsrStatList(MngrDashboardVO paramVO) {
		return mngrDashboardDAO.selectSiteUsrStatList(paramVO);
	} 
}

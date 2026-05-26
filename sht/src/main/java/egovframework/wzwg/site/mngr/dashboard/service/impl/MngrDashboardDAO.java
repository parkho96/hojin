package egovframework.wzwg.site.mngr.dashboard.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardVO;

@Repository("MngrDashboardDAO")
public class MngrDashboardDAO extends EgovAbstractMapper {

	/**
	 * 사이트 메뉴 목록
	 * @return
	 */
	
	public String selectSiteLastLgnDt(MngrDashboardVO paramVO) {
		return (String)selectOne("MngrDashboardDAO_selectSiteLastLgnDt", paramVO);
	} 
	
	public String selectSiteUsrCnt(MngrDashboardVO paramVO) {
		return (String)selectOne("MngrDashboardDAO_selectSiteUsrCnt", paramVO);
	} 
	
	public String selectSiteVisitCnt(MngrDashboardVO paramVO) {
		return (String)selectOne("MngrDashboardDAO_selectSiteVisitCnt", paramVO);
	} 
	
	public String selectSiteVisitTotCnt(MngrDashboardVO paramVO) {
		return (String)selectOne("MngrDashboardDAO_selectSiteVisitTotCnt", paramVO);
	} 
	
	public String selectSiteNttCnt(MngrDashboardVO paramVO) {
		return (String)selectOne("MngrDashboardDAO_selectSiteNttCnt", paramVO);
	} 
	
	public List<MngrDashboardVO> selectSiteNttStatList(MngrDashboardVO paramVO) {
		return selectList("MngrDashboardDAO_selectSiteNttStatList", paramVO);
	} 
	
	public List<MngrDashboardVO> selectSiteUsrStatList(MngrDashboardVO paramVO) {
		return selectList("MngrDashboardDAO_selectSiteUsrStatList", paramVO);
	} 
	
}

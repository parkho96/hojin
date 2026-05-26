package egovframework.com.cmm.interceptor.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.interceptor.service.VisitrMenuStatsService;
import egovframework.com.cmm.interceptor.service.VisitrMenuStatsVO;

@Service("VisitrMenuStatsService")
public class VisitrMenuStatsServiceImpl extends EgovAbstractServiceImpl implements VisitrMenuStatsService {

	@Resource(name="VisitrMenuStatsDAO")
	VisitrMenuStatsDAO visitrMenuStatsDAO;
	
	 

	@Override
	public void registSiteMenuConect(VisitrMenuStatsVO visitrMenuStatsVO)
			throws Exception {
		// TODO Auto-generated method stub
		visitrMenuStatsDAO.registSiteMenuConect(visitrMenuStatsVO);
		
	}

	/*
	@Override
	@Scheduled(cron="0 10 5 * * * " )
	public void summarySiteMenuConect()
			throws Exception {
		// TODO Auto-generated method stub
		visitrMenuStatsDAO.summarySiteMenuConect();
	}

	@Override
	@Scheduled(cron="0 40 5 * * * " )
	public void summarySiteDeviceConect()
			throws Exception {
		// TODO Auto-generated method stub
		visitrMenuStatsDAO.summarySiteDeviceConect();
	}
	
	public List<VisitrMenuStatsVO> selectVisitrMenuStats(VisitrMenuStatsVO visitrMenuStatsVO) throws Exception{
		return visitrMenuStatsDAO.selectVisitrMenuStats(visitrMenuStatsVO);
	}
	
	public List<VisitrMenuStatsVO> selectVisitrMenuStatsExcel(VisitrMenuStatsVO visitrMenuStatsVO) throws Exception{
		return visitrMenuStatsDAO.selectVisitrMenuStatsExcel(visitrMenuStatsVO);
	}
	*/
}




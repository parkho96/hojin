package egovframework.wzwg.site.mngr.usrMngr.usrLog.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;

@Service("SiteUsrLogService")
public class SiteUsrLogServiceImpl extends EgovAbstractServiceImpl implements SiteUsrLogService {
	@Resource(name="SiteUsrLogDAO")
	SiteUsrLogDAO siteUsrLogDAO;
	
	public int insertSiteUsrLog(SiteUsrLogVO paramVO) {
		return siteUsrLogDAO.insertSiteUsrLog(paramVO);
	}
	
	
	public List<SiteUsrLogVO> selectSiteUsrLogList(SiteUsrLogVO paramVO) {
		System.out.println("\n\n\n\n\n\nparamVO c: "+paramVO.getSearchCondition());
		System.out.println("\n\n\n\n\n\nparamVO k: "+paramVO.getSearchKeyword());
		return siteUsrLogDAO.selectSiteUsrLogList(paramVO);
	}
	
	
	public int selectSiteUsrLogCnt(SiteUsrLogVO paramVO) {
		  
		return siteUsrLogDAO.selectSiteUsrLogCnt(paramVO);
	}


}

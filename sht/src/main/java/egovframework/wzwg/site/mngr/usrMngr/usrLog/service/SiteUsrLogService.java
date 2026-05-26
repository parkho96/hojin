package egovframework.wzwg.site.mngr.usrMngr.usrLog.service;

import java.util.List;

public interface SiteUsrLogService {
	
	public int insertSiteUsrLog(SiteUsrLogVO paramVO);
	 
	public List<SiteUsrLogVO> selectSiteUsrLogList(SiteUsrLogVO paramVO);
	
	
	public int selectSiteUsrLogCnt(SiteUsrLogVO paramVO) ;

}

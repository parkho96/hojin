package egovframework.wzwg.site.mngr.usrMngr.usrLog.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;

@Repository("SiteUsrLogDAO")
public class SiteUsrLogDAO extends EgovAbstractMapper {
	@Autowired
	HttpSession session;
	 
	/**
	 * 사이트 사용자 로그 등록
	 * @param siteUsrGroupVO
	 * @return
	 */
	public int insertSiteUsrLog(SiteUsrLogVO paramVO) {
		return update("SiteUsrLogDAO_insertSiteUsrLog", paramVO);
	}
	
	
	public List<SiteUsrLogVO> selectSiteUsrLogList(SiteUsrLogVO paramVO) {
		 String langcode =""; 
    	 if(session.getAttribute("useLangCode") != null){
    		  langcode = session.getAttribute("useLangCode").toString();
    	 }
    	 paramVO.setLangCode(langcode); 
		  
		return selectList("SiteUsrLogDAO_selectSiteUsrLogList", paramVO);
	}
	
	
	public int selectSiteUsrLogCnt(SiteUsrLogVO paramVO) {
		  
		return ((Integer) selectOne("SiteUsrLogDAO_selectSiteUsrLogCnt", paramVO)).intValue();
	}

	 
}

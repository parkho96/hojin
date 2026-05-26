package egovframework.wzwg.cmm.mber.sbscrb.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

@Repository("CmmSbscrbDAO")

public class CmmSbscrbDAO extends EgovAbstractMapper {

	/**
     * @uml.property  name="session"
     * @uml.associationEnd  readOnly="true"
     */
	@Autowired
	HttpSession session;
	
    public Integer selectSbscrbCrtfc(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return (Integer) selectOne("CmmSbscrbDAO_selectSbscrbCrtfc_S", cmmSbscrbVO);
    }
    
    public Integer selectSbscrbUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return (Integer) selectOne("CmmSbscrbDAO_selectSbscrbUsrInfo_S", cmmSbscrbVO);
    }
    
	public List<SiteStplatInfoVO> selectSiteStplatList(SiteStplatInfoVO sysMngrSiteStplatInfoVO) throws Exception {
    	return selectList("CmmSbscrbDAO_selectSiteStplatList_S", sysMngrSiteStplatInfoVO);
    }
    
    public String selectSbscrbUserIdDplctCeck(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return (String) selectOne("CmmSbscrbDAO_selectSbscrbUserIdDplctCeck_S", cmmSbscrbVO);
    }
	
    public String selectNextUsrSeq() throws Exception {
    	return (String) selectOne("CmmSbscrbDAO_selectNextUsrSeq_S", new String());
    }
    
    public void registSiteSbscrbstplat(CmmSbscrbVO cmmSbscrbVO) throws Exception {
        insert("CmmSbscrbDAO_registSiteSbscrbstplat_I", cmmSbscrbVO);
    }
    
    public void registSiteSbscrbstplatSimp(CmmSbscrbVO cmmSbscrbVO) throws Exception {
        insert("CmmSbscrbDAO_registSiteSbscrbstplatSimp_I", cmmSbscrbVO);
    }
    
    public int registUsrSbscrbInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	
    	if(!"Y".equals(cmmSbscrbVO.getUnitySbscrbYn())){
	    	update("CmmSbscrbDAO_registUsrSbscrbInfo_I", cmmSbscrbVO); 
	    	update("CmmSbscrbDAO_registUsrSbscrbAdiInfo_I", cmmSbscrbVO);
	    	update("CmmSbscrbDAO_registSiteUsrCrtfctInfo_I", cmmSbscrbVO);
	    	// 소셜인증
	    	if (!"".equals(StringUtils.defaultString(cmmSbscrbVO.getCrtfcSns()))) {
	            update("CmmSbscrbDAO_registSiteUsrSnsCrtfcInfo_I", cmmSbscrbVO);
	    	}
	    	
    	}
    	
    	return update("CmmSbscrbDAO_registSiteUsrSbscrbInfo_I", cmmSbscrbVO);
    }
    
    public List<CmmSbscrbVO> selectSysSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO) {
    	String langcode = null;

    	if(session.getAttribute("useLangCode") != null){
    		langcode = session.getAttribute("useLangCode").toString();
    	}

    	cmmSbscrbVO.setLangCode(langcode);
    	
        return selectList("CmmSbscrbDAO_selectSysSbscrbUsrTy_S", cmmSbscrbVO);
    }
    
    public List<CmmSbscrbVO> selectSiteSbscrbUsrTyList(CmmSbscrbVO cmmSbscrbVO) {
    	return selectList("CmmSbscrbDAO_selectSiteSbscrbUsrTyList_S", cmmSbscrbVO);
    }	
  
    public CmmSbscrbVO selectSiteSbscrbUsrTy(CmmSbscrbVO cmmSbscrbVO) {
        return (CmmSbscrbVO)selectOne("CmmSbscrbDAO_selectSiteSbscrbUsrTy_S", cmmSbscrbVO);
    }
    
    public CmmSiteInfoVO selectSiteInfo(CmmSiteInfoVO cmmSiteInfoVO) throws Exception {
        return (CmmSiteInfoVO)selectOne("CmmSbscrbDAO_selectSiteInfo", cmmSiteInfoVO);
    }
    public String selectUserSeq(CmmSbscrbVO cmmSbscrbVO) throws Exception {
    	return (String) selectOne("CmmSbscrbDAO_selectUserSeq_S", cmmSbscrbVO);
    }
    
    public String selectSiteUsrTyCheck(CmmSbscrbVO paramVO) {
        return (String)selectOne("CmmSbscrbDAO_selectSiteUsrTyCheck", paramVO);
    }
    
    public CmmLoginVO selectSiteUsrCrtfc(CmmSbscrbVO paramVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmSbscrbDAO_selectSiteUsrCrtfc", paramVO);
    }
    
    public CmmLoginVO selectSiteUsrCrtfcBySiteSeq(CmmSbscrbVO paramVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmSbscrbDAO_selectSiteUsrCrtfcBySiteSeq", paramVO);
    }
}

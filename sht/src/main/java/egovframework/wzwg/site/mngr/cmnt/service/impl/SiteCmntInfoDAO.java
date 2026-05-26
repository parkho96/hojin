package egovframework.wzwg.site.mngr.cmnt.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;

@Repository("SiteCmntInfoDAO")
public class SiteCmntInfoDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	
	
	public void registSiteCmntInfo(SiteCmntInfoVO paramVO) {
		  insert("siteCmntInfoDAO_registSiteCmntInfo", paramVO);
	}
	
	
	public void modifySiteCmntInfo(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfo", paramVO);
	}
	
	public void modifySiteCmntInfoApproval(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfoApproval", paramVO);
	}
	
	public void modifySiteCmntInfoMngrSeq(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfoMngrSeq", paramVO);
	}
	
	
	public void modifySiteCmntInfoIconStre(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfoIconStre", paramVO);
	}
	
	public void modifySiteCmntInfoProvision(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfoProvision", paramVO);
	}
	
	public void modifySiteCmntInfoMngr(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_modifySiteCmntInfoMngr", paramVO);
	}
	
	
	public SiteCmntInfoVO selectSiteCmntInfo(SiteCmntInfoVO paramVO) {
		
		String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		
		paramVO.setLangCode(langcode);
		
		 return (SiteCmntInfoVO)selectOne("siteCmntInfoDAO_selectSiteCmntInfo", paramVO);
	}

	
	public SiteCmntInfoVO selectSiteCmntInfoProvision(SiteCmntInfoVO paramVO) {
		 return (SiteCmntInfoVO)selectOne("siteCmntInfoDAO_selectSiteCmntInfoProvision", paramVO);
	}
	
	public List<SiteCmntInfoVO> selectSiteCmntInfoList(SiteCmntInfoVO paramVO) {
		
		String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}
		
		paramVO.setLangCode(langcode);
		
		 return selectList("siteCmntInfoDAO_selectSiteCmntInfoList", paramVO);
	}
	
	public int selectSiteCmntInfoCnt(SiteCmntInfoVO paramVO) {
		 return ((Integer)selectOne("siteCmntInfoDAO_selectSiteCmntInfoCnt", paramVO)).intValue();
	}
	
	public int selectSiteCmntInfoNm(SiteCmntInfoVO paramVO) {
		 return ((Integer)selectOne("siteCmntInfoDAO_selectSiteCmntInfoNm", paramVO)).intValue();
	}
	
	public String selectSiteCmntSeq(SiteCmntInfoVO paramVO) {
		 return  (String)selectOne("siteCmntInfoDAO_selectSiteCmntSeq", paramVO);
	}
	
	public void deleteSiteCmntInfo(SiteCmntInfoVO paramVO) {
		  update("siteCmntInfoDAO_deleteSiteCmntInfo", paramVO);
	}
	
	public void registSiteCmntCfgroup(SiteCmntInfoVO paramVO) {
		  insert("siteCmntInfoDAO_registSiteCmntInfoGroup", paramVO);
	}
	
	public void deleteSiteCmntInfoGroup(SiteCmntInfoVO paramVO) {
		  delete("siteCmntInfoDAO_deleteSiteCmntInfoGroup", paramVO);
	}
	
	public List<SiteCmntInfoVO> selectSiteCmntInfoGroupList(SiteCmntInfoVO paramVO) {
		 return selectList("siteCmntInfoDAO_selectSiteCmntInfoGroupList", paramVO);
	}
  
	 public SiteCmntInfoVO selectSiteCmntOrdrUp(SiteCmntInfoVO paramVO) throws Exception {
        return (SiteCmntInfoVO)selectOne("siteCmntInfoDAO_selectSiteCmntOrdrUp", paramVO);
    }

    public SiteCmntInfoVO selectSiteCmntOrdrDown(SiteCmntInfoVO paramVO) throws Exception {
        return (SiteCmntInfoVO)selectOne("siteCmntInfoDAO_selectSiteCmntOrdrDown", paramVO);
    }

    public int modifySiteCmntOrdr(SiteCmntInfoVO paramVO) throws Exception {
        return update("siteCmntInfoDAO_modifySiteCmntOrdr", paramVO);
    }
	
	
}

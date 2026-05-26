package egovframework.wzwg.site.mngr.cmnt.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Service("SiteCmntInfoService")
public class SiteCmntInfoServiceImpl extends EgovAbstractServiceImpl implements SiteCmntInfoService {
     

	/** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="SiteCmntInfoDAO")
    private SiteCmntInfoDAO siteCmntInfoDAO;
    
    @SuppressWarnings("unchecked")
    public void registSiteCmntInfo(SiteCmntInfoVO paramVO) {
    	siteCmntInfoDAO.registSiteCmntInfo(paramVO);
	}
	
	@SuppressWarnings("unchecked")
	public void modifySiteCmntInfo(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfo(paramVO);
	}
	
	public void modifySiteCmntInfoApproval(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfoApproval(paramVO);
	}
	
	public void modifySiteCmntInfoMngrSeq(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfoMngrSeq(paramVO);
	}
	
	public void modifySiteCmntInfoIconStre(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfoIconStre(paramVO);
	}
	
	public void modifySiteCmntInfoProvision(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfoProvision(paramVO);
	}
	
	public void modifySiteCmntInfoMngr(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.modifySiteCmntInfoMngr(paramVO);
	}
	
	@SuppressWarnings("unchecked")
	public SiteCmntInfoVO selectSiteCmntInfo(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfo(paramVO);
	}
	
	public SiteCmntInfoVO selectSiteCmntInfoProvision(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfoProvision(paramVO);
	}
 
	public List<SiteCmntInfoVO> selectSiteCmntInfoList(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfoList(paramVO);
	}
	
	public int selectSiteCmntInfoCnt(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfoCnt(paramVO);
	}
	
	public int selectSiteCmntInfoNm(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfoNm(paramVO);
	}
	
	public String selectSiteCmntSeq(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntSeq(paramVO);
	}
	
	public void deleteSiteCmntInfo(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.deleteSiteCmntInfo(paramVO);
	}
    
	
	public void registSiteCmntCfgroup(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.registSiteCmntCfgroup(paramVO);
	}
	
	public void deleteSiteCmntInfoGroup(SiteCmntInfoVO paramVO) {
		siteCmntInfoDAO.deleteSiteCmntInfoGroup(paramVO);
	}
	
	public List<SiteCmntInfoVO> selectSiteCmntInfoGroupList(SiteCmntInfoVO paramVO) {
		 return siteCmntInfoDAO.selectSiteCmntInfoGroupList(paramVO);
	}

	@Override
	public int modifySiteCmntOrdr(SiteCmntInfoVO paramVO) throws Exception {
		
		SiteCmntInfoVO thisVO = new SiteCmntInfoVO();
		SiteCmntInfoVO targetVO = new SiteCmntInfoVO();
        if(paramVO.getOrdrGubun().equals("U"))
            targetVO = siteCmntInfoDAO.selectSiteCmntOrdrUp(paramVO);
        else
        if(paramVO.getOrdrGubun().equals("D"))
            targetVO = siteCmntInfoDAO.selectSiteCmntOrdrDown(paramVO);
        if(targetVO == null)
        {
            return -1;
        } else {
        	
            thisVO.setCmntSeq(paramVO.getCmntSeq());
            thisVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            thisVO.setCmntOrdr(targetVO.getCmntOrdr());
            thisVO.setSiteSeq(paramVO.getSiteSeq());
            
            targetVO.setLastUpdusrId(paramVO.getLastUpdusrId());
            targetVO.setCmntOrdr(paramVO.getCmntOrdr());
            targetVO.setSiteSeq(paramVO.getSiteSeq());
            
            int result = 0;
            result += siteCmntInfoDAO.modifySiteCmntOrdr(thisVO);
            result += siteCmntInfoDAO.modifySiteCmntOrdr(targetVO);
            
            return result;
            
        }
		
	}

}

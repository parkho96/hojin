package egovframework.wzwg.site.mngr.cmnt.service;

import java.util.List;

public interface SiteCmntInfoService {
	
	public void registSiteCmntInfo(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfo(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfoApproval(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfoMngrSeq(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfoIconStre(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfoProvision(SiteCmntInfoVO paramVO);
	
	public void modifySiteCmntInfoMngr(SiteCmntInfoVO paramVO);
	
	public SiteCmntInfoVO selectSiteCmntInfo(SiteCmntInfoVO paramVO);
	
	public SiteCmntInfoVO selectSiteCmntInfoProvision(SiteCmntInfoVO paramVO);
 
	public List<SiteCmntInfoVO> selectSiteCmntInfoList(SiteCmntInfoVO paramVO);
	
	public int selectSiteCmntInfoCnt(SiteCmntInfoVO paramVO);
	
	public int selectSiteCmntInfoNm(SiteCmntInfoVO paramVO); 
	
	public String selectSiteCmntSeq(SiteCmntInfoVO paramVO);
	
	public void deleteSiteCmntInfo(SiteCmntInfoVO paramVO) ;
	
	public void registSiteCmntCfgroup(SiteCmntInfoVO paramVO) ;
	
	public void deleteSiteCmntInfoGroup(SiteCmntInfoVO paramVO) ;
	
	public List<SiteCmntInfoVO> selectSiteCmntInfoGroupList(SiteCmntInfoVO paramVO) ;
	
	public int modifySiteCmntOrdr(SiteCmntInfoVO paramVO) throws Exception;
	
}

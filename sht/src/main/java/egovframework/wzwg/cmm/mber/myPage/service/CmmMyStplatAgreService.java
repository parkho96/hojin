package egovframework.wzwg.cmm.mber.myPage.service;

import java.util.List;

import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;


public interface CmmMyStplatAgreService {
	
	 /*************************** 2019.03.06 start *******************************/
	public List<SiteStplatInfoVO> selectMyStplatAgreList(SiteStplatInfoVO paramVO) throws Exception;
	public int modifyMyStplatAgre(CmmSbscrbVO paramVO) throws Exception;
	 /*************************** 2019.03.06 end *******************************/

	
}

package egovframework.wzwg.cmm.mber.myPage.service;

import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;


public interface CmmMyPageService {

    public CmmSbscrbVO selectMyPageUsrInfo(CmmSbscrbVO cmmSbscrbVO) throws Exception;
    
	public int modifyMyPageUsrInfo(CmmSbscrbVO paramVO) throws Exception;   

	public int modifyUsrSecsn(CmmSbscrbVO paramVO);   

}

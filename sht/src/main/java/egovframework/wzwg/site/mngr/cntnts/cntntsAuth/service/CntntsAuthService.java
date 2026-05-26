package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service;

import java.util.List;

public interface CntntsAuthService {
	
	public CntntsAuthVO selectCntntsAuthForNtt(CntntsAuthVO paramVO);
	
    public List<CntntsAuthVO> selectCntntsAuthList(CntntsAuthVO paramVO);
    
    public List<CntntsAuthVO> selectCntntsAuthAllList(CntntsAuthVO paramVO);

    public int registCntntsAuth(CntntsAuthVO paramVO);
    
    public CntntsAuthVO selectWriteAuthAt(CntntsAuthVO paramVO) ;
    
    public String selectCntntsFileAuthInfo(CntntsAuthVO paramVO);
    
    public String selectCntntsSeqAuthInfo(CntntsAuthVO paramVO);

}

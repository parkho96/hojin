package egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service;

import java.sql.SQLException;
import java.util.List;



public interface SnsKeyMngrService {
    
    public List<SnsKeyMngrVO> selectSnsKeyMngrList(SnsKeyMngrVO paramVO) throws Exception;
    
    public SnsKeyMngrVO selectSnsKeyMngr(SnsKeyMngrVO paramVO) throws SQLException;
    
    public int registSnsKeyMngr(SnsKeyMngrVO paramVO) throws Exception;
    
}

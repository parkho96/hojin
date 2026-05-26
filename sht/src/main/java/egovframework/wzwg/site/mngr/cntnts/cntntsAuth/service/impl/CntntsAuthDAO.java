package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;

@Repository("CntntsAuthDAO")
public class CntntsAuthDAO extends EgovAbstractMapper {
	
	public CntntsAuthVO selectCntntsAuthForNtt(CntntsAuthVO paramVO) {
		return (CntntsAuthVO) selectOne("CntntsAuthDAO_selectCntntsAuthForNtt", paramVO);
	}	

	
	public List<CntntsAuthVO> selectCntntsAuthList(CntntsAuthVO paramVO) {
		return selectList("CntntsAuthDAO_selectCntntsAuthList", paramVO);
	}

    public int registCntntsAuth(CntntsAuthVO paramVO) {
        return update("CntntsAuthDAO_registCntntsAuth", paramVO);
    }

    
    public List<CntntsAuthVO> selectCntntsAuthInfo(String sitecntntsSeq) {
        return selectList("CntntsAuthDAO_selectCntntsAuthInfo", sitecntntsSeq);
    }
    
    
    public List<CntntsAuthVO> selectCntntsAuthAllList(CntntsAuthVO paramVO) {
        return selectList("CntntsAuthDAO_selectCntntsAuthAllList", paramVO);
    }
    
    public int registCntntsAuthInfo(CntntsAuthVO paramVO) {
        return update("CntntsAuthDAO_registCntntsAuthInfo", paramVO);
    }
    
	public Integer selectCntntsAuthChk(CntntsAuthVO paramVO) {
		return (Integer) selectOne("CntntsAuthDAO_selectCntntsAuthChk", paramVO);
	}	
	
    public int updateCntntsAuth(CntntsAuthVO paramVO) {
        return update("CntntsAuthDAO_updateCntntsAuth", paramVO);
    }
    
	public CntntsAuthVO selectWriteAuthAt(CntntsAuthVO paramVO) {
		return (CntntsAuthVO) selectOne("CntntsAuthDAO_selectWriteAuthAt", paramVO);
	}	
	
	public String selectCntntsFileAuthInfo(CntntsAuthVO paramVO) {
		return (String) selectOne("CntntsAuthDAO_selectCntntsFileAuthInfo", paramVO);
	}
    
    public String selectCntntsSeqAuthInfo(CntntsAuthVO paramVO) {
    	return (String) selectOne("CntntsAuthDAO_selectCntntsSeqAuthInfo", paramVO);
    }
}

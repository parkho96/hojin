package egovframework.wzwg.cmm.mber.login.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;

@Repository("CmmLoginDAO")
public class CmmLoginDAO extends EgovAbstractMapper {

    public CmmLoginVO actionSnsLogin(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_actionSnsLogin", loginVO);
    }

    public CmmLoginVO actionLogin(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_actionLogin", loginVO);
    }

    public CmmLoginVO actionMergeTransLogin(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_actionMergeTransLogin", loginVO);
    }

    public CmmLoginVO actionSysMngrLogin(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_actionSysMngrLogin", loginVO);
    }

    public String selectUsrSnsCnfirm(CmmLoginVO loginVO) throws Exception {
        return (String) selectOne("CmmLoginDAO_selectUsrSnsCnfirm_S", loginVO);
    }

    
    public List<CmmLoginVO> selectSearchUserId(CmmLoginVO loginVO) throws Exception {
        return selectList("CmmLoginDAO_selectSearchUserId", loginVO);
    }
    
	public String selectSearchUsrInfoCheck(CmmLoginVO loginVO) throws Exception {
        return (String)selectOne("CmmLoginDAO_selectSearchUsrInfoCheck", loginVO);
    }    
    
    public int modifyTmprPassword(CmmLoginVO paramVO) throws Exception {
        return update("CmmLoginDAO_modifyTmprPassword",paramVO);
    }   

    public CmmLoginVO actionUsrinfoChk(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_actionUsrinfoChk", loginVO);
    }

    public CmmLoginVO selectSiteUsrinfo(CmmLoginVO loginVO) throws Exception {
        return (CmmLoginVO)selectOne("CmmLoginDAO_selectSiteUsrinfo", loginVO);
    }

    public int modifyPwUpdtDe(CmmLoginVO loginVO) throws Exception {
        return update("CmmLoginDAO_modifyPwUpdtDe", loginVO);
    }

    public int modifyPwUpdt(CmmLoginVO loginVO) throws Exception {
        return update("CmmLoginDAO_modifyPwUpdt", loginVO);
    }
    
    public int selectSiteUsrCrtfcCnt(CmmLoginVO loginVO) throws Exception {
        return (Integer)selectOne("CmmLoginDAO_selectSiteUsrCrtfcCnt", loginVO);
    }
    
    public int modifyUsrPassFailLoginCnt(CmmLoginVO loginVO) throws Exception {
        return update("CmmLoginDAO_modifyUsrPassFailLoginCnt", loginVO);
    }
    
    public int modifyUsrPassFailLoginInit(CmmLoginVO loginVO) throws Exception {
        return update("CmmLoginDAO_modifyUsrPassFailLoginInit", loginVO);
    }
    
    public String selectPassFailYn(CmmLoginVO loginVO) throws Exception {
        return (String)selectOne("CmmLoginDAO_selectPassFailYn", loginVO);
    } 
}

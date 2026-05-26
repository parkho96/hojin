package egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Service("SbscrbCrtfcEstbsService")
public class SbscrbCrtfcEstbsServiceImpl extends EgovAbstractServiceImpl implements SbscrbCrtfcEstbsService {
	
	@Resource(name="SbscrbCrtfcEstbsDAO")
	SbscrbCrtfcEstbsDAO sbscrbCrtfcEstbsDAO;

	/** 가입인증설정 목록*/
	public List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsList(SbscrbCrtfcEstbsVO paramVO) {
		
		return sbscrbCrtfcEstbsDAO.selectSbscrbCrtfcEstbsList(paramVO);
	}

	/** 가입인증설정 등록*/
	public void registSbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO) {
	
		String[] estbsAtArr = paramVO.getEstbsAtArr();

        sbscrbCrtfcEstbsDAO.deleteSbscrbCrtfcEstbs(paramVO);
		if (estbsAtArr != null) {
		    
			
			for (int i=0; i<estbsAtArr.length; i++) {
				
				String[] estbsVal = estbsAtArr[i].split(":");

				paramVO.setUsrtySeq(estbsVal[0]);
				paramVO.setUcrtfcEstbsCode(estbsVal[1]);
				
				int result = sbscrbCrtfcEstbsDAO.selectSbscrbCrtfcEstbs(paramVO);
				
				if (result > 0) {
					sbscrbCrtfcEstbsDAO.modifySbscrbCrtfcEstbs(paramVO);
				} else {
					sbscrbCrtfcEstbsDAO.registSbscrbCrtfcEstbs(paramVO);
				}
			}
		}
	}
    
    /**
     *  시스템인증설정 목록
     * @param cmmSbscrbVO
     * @return
     * @throws Exception
     */
    public List<UsrPrefcesVO> selectCrtfcEstbsList(String grpcode) {
        return sbscrbCrtfcEstbsDAO.selectCrtfcEstbsList(grpcode);
    }
    
    public List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsByUsrTy(SbscrbCrtfcEstbsVO paramVO) {
        return sbscrbCrtfcEstbsDAO.selectSbscrbCrtfcEstbsByUsrTy(paramVO);
    }

    public int selectSbscrbCrtfcEstbsByUsrTyChk(SbscrbCrtfcEstbsVO paramVO) {
		
		return sbscrbCrtfcEstbsDAO.selectSbscrbCrtfcEstbsByUsrTyChk(paramVO);
	}
}

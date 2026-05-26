package egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service;

import java.util.List;

import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

public interface SbscrbCrtfcEstbsService {

	/** 가입인증설정 목록*/
	List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsList(SbscrbCrtfcEstbsVO paramVO);

	/** 가입인증설정 등록*/
	void registSbscrbCrtfcEstbs(SbscrbCrtfcEstbsVO paramVO);
    
    /**
     *  시스템인증설정 목록
     * @param cmmSbscrbVO
     * @return
     * @throws Exception
     */
    List<UsrPrefcesVO> selectCrtfcEstbsList(String grpcode);
    
    List<SbscrbCrtfcEstbsVO> selectSbscrbCrtfcEstbsByUsrTy(SbscrbCrtfcEstbsVO paramVO);
    
    public int selectSbscrbCrtfcEstbsByUsrTyChk(SbscrbCrtfcEstbsVO paramVO); 
}

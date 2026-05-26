package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service;

import java.util.List;

public interface UsrTySbscrbFormService {
	
	/** 회원유형가입양식설정 조회 **/
	public List<UsrTySbscrbFormVO> selectUsrTySbscrbFormList(UsrTySbscrbFormVO paramVO) throws Exception;


    /** 회원유형가입양식설정 등록/수정 **/
    public int modifyUsrTySbscrbForm(UsrTySbscrbFormVO paramVO) throws Exception;
    
}

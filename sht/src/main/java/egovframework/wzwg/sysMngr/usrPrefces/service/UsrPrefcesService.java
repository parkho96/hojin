package egovframework.wzwg.sysMngr.usrPrefces.service;

import java.util.List;

public interface UsrPrefcesService {
	
	/** 회원관리환경설정 조회 **/
	public List<UsrPrefcesVO> selectusrPrefcesIemList(UsrPrefcesVO paramVO) throws Exception;


    /** 회원관리환경설정 등록/수정 **/
    public int modifyUsrPrefces(UsrPrefcesVO paramVO) throws Exception;

    /** 비밀번호 변경 주기(개월수) **/
    public int selectUpdtEstbsMonth(UsrPrefcesVO paramVO) throws Exception;
    
    /** 중복로그인 체크 **/
    public String selectDupLoginChk(UsrPrefcesVO paramVO) throws Exception ;
    
    /** 세션유지 타임 체크 **/
    public String selectSessionInterval(UsrPrefcesVO paramVO) throws Exception ;
    
}

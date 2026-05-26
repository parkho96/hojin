package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service;

import java.util.List;


/**
 * ㅁ 시스템 - 사용자관리 - 가입정보관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrSbscrbInfoService {

	/**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSbscrbVO> selectSbscrbInfoList(SysMngrSbscrbVO paramVO) throws Exception;

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSbscrbInfoListTotCnt(SysMngrSbscrbVO paramVO) throws Exception;
	
	/**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception;

    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception;

    /**
     * 사이트SEQ:회원유형 에따른 회원가입정보가 등록되어있나 체크 안되어있으면 등록시킴
     */
    public int registSbscrbInfoChk(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySiteUsrTySbscrb(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입정보설정여부 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public int selectSbscrbinfoSeq(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 상세정보
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public SysMngrSbscrbVO selectSbscrbInfoDetail(SysMngrSbscrbVO paramVO) throws Exception;

    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception;

    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 가입절차에 필요한 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbProcssInfo(SysMngrSbscrbVO paramVO) throws Exception;
   	

}

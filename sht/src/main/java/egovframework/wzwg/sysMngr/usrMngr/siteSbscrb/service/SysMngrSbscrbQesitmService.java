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
public interface SysMngrSbscrbQesitmService {


	/**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception;

    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception;
    
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrSbscrbVO> selectSbscrbQesitmList(SysMngrSbscrbVO paramVO) throws Exception;
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrSbscrbVO> selectSbscrbIemList(SysMngrSbscrbVO paramVO) throws Exception;
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 질문삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public int deleteSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbIemUsrRspns(SysMngrSbscrbVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbQesitmUsrRspns(SysMngrSbscrbVO paramVO) throws Exception;
   	

}

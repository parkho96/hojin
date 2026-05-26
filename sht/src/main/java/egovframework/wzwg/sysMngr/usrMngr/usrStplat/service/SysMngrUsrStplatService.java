package egovframework.wzwg.sysMngr.usrMngr.usrStplat.service;

import java.util.List;


/**
 * ㅁ 시스템 - 사용자관리 - 가입약관관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
public interface SysMngrUsrStplatService {
    
    public List<SysMngrUsrStplatVO> selectSysUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception;
    public int selectSysUsrStplatListCnt(SysMngrUsrStplatVO paramVO) throws Exception;
    public SysMngrUsrStplatVO selectSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;
    public int registSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;
    public int modifySysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;
    public int deleteSysUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;
    public List<SysMngrUsrStplatVO> selectSysUsrStplatHistList(SysMngrUsrStplatVO paramVO) throws Exception;
    public int registSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception;
    public int deleteSysUsrStplatHist(SysMngrUsrStplatVO paramVO) throws Exception;

	/**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrUsrStplatVO> selectUsrStplatList(SysMngrUsrStplatVO paramVO) throws Exception;

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입약관관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectUsrStplatListTotCnt(SysMngrUsrStplatVO paramVO) throws Exception;
	
	/**
   	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;

    /**
   	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyUsrStplat(SysMngrUsrStplatVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입정보설정여부 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public int selectSbscrbinfoSeq(SysMngrUsrStplatVO paramVO) throws Exception;
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 상세정보
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public SysMngrUsrStplatVO selectUsrStplatDetail(SysMngrUsrStplatVO paramVO) throws Exception;

   	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrUsrStplatVO> selectSbscrbQesitmList(SysMngrUsrStplatVO paramVO) throws Exception;
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrUsrStplatVO> selectSbscrbIemList(SysMngrUsrStplatVO paramVO) throws Exception;
   	

}

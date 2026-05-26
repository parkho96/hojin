package egovframework.wzwg.sysMngr.usrMngr.usrTy.service;

import java.util.List;

import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;

public interface SysMngrUsrTyService {
	/** 사용자 유형 리스트조회 */
	public List<SysMngrUsrTyVO> selectUsrTyList(SysMngrUsrTyVO sysMngrUsrTyVO);
	
	/** 사용자 유형 등록 */
	public int registUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO, SysMngrSbscrbVO siteSbscrbVO) throws Exception;

	/** 사용자 유형 상세조회 */
	public SysMngrUsrTyVO selectUsrTyDetail(SysMngrUsrTyVO sysMngrUsrTyVO);
	
	/** 사용자 유형 수정 */
	public int modifyUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO, SysMngrSbscrbVO siteSbscrbVO) throws Exception;

	/** 사용자 유형 삭제 */
	public int deleteUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO);

	/** 사용자 유형 리스트 카운트 조회 */
	public int selectSysMngrUsrTyTotCnt(SysMngrUsrTyVO sysMngrUsrTyVO);
	
	/** 사용자 유형 코드 정보 조회 */
	public List<SysMngrUsrTyVO> selectUsrTyCodeList();

    /**
     * 사용자 유형 Ajax 셀렉트박스
     * @param sysMngrUsrTyVO
     * @return
     */
    public List<SysMngrUsrTyVO> selectSiteUsrTySbscrb(SysMngrUsrTyVO sysMngrUsrTyVO);

    /**
     * 사용자 유형 테이블에 등록된 갯수 카운트(USR_TY_CODE)
     */
	public int selectUsrTyCodeApplcCnt(String code);

}

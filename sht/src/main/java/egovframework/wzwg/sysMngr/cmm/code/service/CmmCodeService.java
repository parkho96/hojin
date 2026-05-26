package egovframework.wzwg.sysMngr.cmm.code.service;

import java.util.List;

public interface CmmCodeService {
	
	/** 코드그룹 조회 */
	public List<CmmGrpCodeVO> selectCmmGrpCodeList(String grpcode) throws Exception;
    
    /** 코드조회 */
    public List<CmmCodeVO> selectCmmCodeList(String code) throws Exception;
    
    /** 코드조회 */
    public List<CmmCodeVO> selectCmmCodeList(CmmCodeVO paramVO) throws Exception;

    /** 코드정보조회 **/
    public List<CmmCodeVO> selectCodeInfoList(String grpcode) throws Exception;

    /** 코드정보조회 **/
    public CmmCodeVO selectCodeInfo(CmmCodeVO paramVO) throws Exception;

    /** 코드정보조회 총건수 **/
    public int selectCodeInfoListCnt(String grpcode) throws Exception;
	
	/** 코드정보 등록 **/
	public int registCodeInfo(CmmCodeVO paramVO) throws Exception;
	
	/** 코드정보 수정 **/
	public int modifyCodeInfo(CmmCodeVO paramVO) throws Exception;
	
	/** 코드정보 삭제(DELETE_AT -> 'N') */
	public int deleteCodeInfo(CmmCodeVO paramVO) throws Exception;
}

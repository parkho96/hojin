package egovframework.wzwg.sysMngr.cmm.code.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmGrpCodeVO;

@Service("CmmCodeService")
public class CmmCodeServiceImpl extends EgovAbstractServiceImpl	implements CmmCodeService {
	
	@Resource(name = "CmmCodeDAO")
    private CmmCodeDAO cmmCodeDAO;
	
	/** 코드그룹 조회 */
	public List<CmmGrpCodeVO> selectCmmGrpCodeList(String grpcode) throws Exception {
		
		return cmmCodeDAO.selectCmmGrpCodeList(grpcode);
	}
    
    /** 코드조회 */
    public List<CmmCodeVO> selectCmmCodeList(String code) throws Exception {
        
        return cmmCodeDAO.selectCmmCodeList(code);
    }
    
    /** 코드조회 */
    public List<CmmCodeVO> selectCmmCodeList(CmmCodeVO paramVO) throws Exception {
        
        return cmmCodeDAO.selectCmmCodeList(paramVO);
    }

    /** 코드정보조회 **/
    public List<CmmCodeVO> selectCodeInfoList(String grpcode) throws Exception {
        return cmmCodeDAO.selectCodeInfoList(grpcode);
    }

    /** 코드정보조회 총건수 **/
    public int selectCodeInfoListCnt(String grpcode) throws Exception {
        return cmmCodeDAO.selectCodeInfoListCnt(grpcode);
    }

    /** 코드정보조회 **/
    public CmmCodeVO selectCodeInfo(CmmCodeVO paramVO) throws Exception {
        return cmmCodeDAO.selectCodeInfo(paramVO);
    }
    
    /** 코드정보 등록 **/
    public int registCodeInfo(CmmCodeVO paramVO) throws Exception {
        
        // 코드SEQ
        String code = cmmCodeDAO.selectSyscodeSeq();
        
        paramVO.setCode(code);
        
        // 코드 등록
        cmmCodeDAO.registCodeInfo(paramVO);
        
        // 그룹&코드 매핑 등록
        return cmmCodeDAO.registSysCodeGrpcode(paramVO);
    }
    
    /** 코드정보 수정 **/
    public int modifyCodeInfo(CmmCodeVO paramVO) throws Exception {
        return cmmCodeDAO.modifyCodeInfo(paramVO);
    }
    
    /** 코드정보 삭제(DELETE_AT -> 'N') */
    public int deleteCodeInfo(CmmCodeVO paramVO) throws Exception {
        return cmmCodeDAO.deleteCodeInfo(paramVO);
    }
}

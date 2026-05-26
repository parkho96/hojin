package egovframework.wzwg.sysMngr.usrMngr.usrTy.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;

@Service("SysMngrUsrTyService")
public class SysMngrUsrTyServiceImpl extends EgovAbstractServiceImpl implements SysMngrUsrTyService{
	@Resource(name="SysMngrUsrTyDAO")
	private SysMngrUsrTyDAO sysMngrUsrTyDAO;

    @Resource(name="SysMngrSbscrbInfoService")
    private SysMngrSbscrbInfoService sysMngrSbscrbInfoService;

	/**
	 * 사용자 유형 리스트 카운트 조회
	 */
	public int selectSysMngrUsrTyTotCnt(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return sysMngrUsrTyDAO.selectSysMngrUsrTyTotCnt(sysMngrUsrTyVO);
	}
	
	/**
	 * 사용자 유형 리스트조회
	 */
	public List<SysMngrUsrTyVO> selectUsrTyList(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return sysMngrUsrTyDAO.selectUsrTyList(sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 등록
	 */
	public int registUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO, SysMngrSbscrbVO siteSbscrbVO) throws Exception {
	    
		String usrtySeq = sysMngrUsrTyDAO.selectUsrTySeq();
		sysMngrUsrTyVO.setUsrTySeq(usrtySeq);
		
        siteSbscrbVO.setSiteSeq(sysMngrUsrTyVO.getSiteSeq());
        siteSbscrbVO.setUsrtySeq(usrtySeq);
        
        int result = sysMngrUsrTyDAO.registUsrTy(sysMngrUsrTyVO);
        
        if (result > 0) {
            result = sysMngrSbscrbInfoService.registSbscrbInfoChk(siteSbscrbVO);
        }
        
        return result;
	}

	/**
	 * 사용자 유형 상세조회
	 */
	public SysMngrUsrTyVO selectUsrTyDetail(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return sysMngrUsrTyDAO.selectUsrTyDetail(sysMngrUsrTyVO);
	}
	
	/**
	 * 사용자 유형 수정
	 */
	public int modifyUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO, SysMngrSbscrbVO siteSbscrbVO) throws Exception {
        
        siteSbscrbVO.setSiteSeq(sysMngrUsrTyVO.getSiteSeq());
        siteSbscrbVO.setUsrtySeq(sysMngrUsrTyVO.getUsrTySeq());
        
        sysMngrSbscrbInfoService.registSbscrbInfoChk(siteSbscrbVO);
        
        sysMngrSbscrbInfoService.modifySbscrbProcssInfo(siteSbscrbVO);
        
		return sysMngrUsrTyDAO.modifyUsrTy(sysMngrUsrTyVO); 
	}

	/**
	 * 사용자 유형 삭제
	 */
	public int deleteUsrTy(SysMngrUsrTyVO sysMngrUsrTyVO) {
		return sysMngrUsrTyDAO.deleteUsrTy(sysMngrUsrTyVO);
	}

	/**
	 * 사용자 유형 코드 조회
	 */
	public List<SysMngrUsrTyVO> selectUsrTyCodeList(){
		return sysMngrUsrTyDAO.selectUsrTyCodeList();
	}

    /**
     * 사용자 유형 Ajax 셀렉트박스
     * @param sysMngrUsrTyVO
     * @return
     */
    public List<SysMngrUsrTyVO> selectSiteUsrTySbscrb(SysMngrUsrTyVO sysMngrUsrTyVO) {
        return sysMngrUsrTyDAO.selectSiteUsrTySbscrb(sysMngrUsrTyVO);
    }

	/**
	 * 사용자 유형 테이블에 등록된 갯수 카운트(USR_TY_CODE)
	 */
	public int selectUsrTyCodeApplcCnt(String code) {
		return sysMngrUsrTyDAO.selectUsrTyCodeApplcCnt(code);
	}

}

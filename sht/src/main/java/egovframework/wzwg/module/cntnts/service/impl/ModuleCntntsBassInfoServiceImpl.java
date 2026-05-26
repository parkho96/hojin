package egovframework.wzwg.module.cntnts.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.cntnts.service.ModuleCntntsBassInfoService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("ModuleCntntsBassInfoService")
public class ModuleCntntsBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleCntntsBassInfoService {
    
    @Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
	@Resource(name="ModuleCntntsBassInfoDAO")
	ModuleCntntsBassInfoDAO moduleCntntsBassInfoDAO;

	/**
	 * 게시판 기본정보 리스트
	 */
	public List<ModuleCntntsVO> selectModuleCntntsList(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsBassInfoDAO.selectModuleCntntsList(moduleCntntsVO);
	}
	
	/**
	 * 게시판SEQ
	 * */
	public String selectCntntsSeq() {
	    return moduleCntntsBassInfoDAO.selectModuleCntntsSeq();
	}

	/**
	 * 게시판 기본정보 등록
	 */
	public int registModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO) {
		String cntntsSeq = moduleCntntsBassInfoDAO.selectModuleCntntsSeq();
		moduleCntntsVO.setCntntsSeq(cntntsSeq);
		
		if (RequestContextHolder.getRequestAttributes() != null) {
			RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", cntntsSeq, RequestAttributes.SCOPE_SESSION);
		}
		
		return moduleCntntsBassInfoDAO.registModuleCntntsAjax(moduleCntntsVO);
	}

	/**
	 * 게시판 기본정보 상세조회
	 */
	public ModuleCntntsVO selectCntntsBassInfoDetail(ModuleCntntsVO moduleCntntsVO) {
		return moduleCntntsBassInfoDAO.selectCntntsBassInfoDetail(moduleCntntsVO);
	}

	/**
	 * 게시판 기본정보 수정
	 */
	public int modifyModuleCntntsAjax(ModuleCntntsVO moduleCntntsVO) {
	    
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(moduleCntntsVO.getCntntsNm());
        paramVO.setCntntsDc(moduleCntntsVO.getCntntsDc());
        paramVO.setSitecntntsSeq(moduleCntntsVO.getSitecntntsSeq());
        paramVO.setLastUpdusrId(moduleCntntsVO.getUserId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);

	    
		return moduleCntntsBassInfoDAO.modifyModuleCntntsAjax(moduleCntntsVO);
	}
	
	/**
	 * 게시판 템플릿 정보 수정
	 */
	public int modifyModuleCntntsTmplatAjax(ModuleCntntsVO moduleCntntsVO) {
		
		return moduleCntntsBassInfoDAO.modifyModuleCntntsTmplatAjax(moduleCntntsVO);
	}
	
	public int modifyModuleCntnts(ModuleCntntsVO moduleCntntsVO) {
	    
		return moduleCntntsBassInfoDAO.modifyModuleCntntsAjax(moduleCntntsVO);
	}
    
    /**
     * ㅁ 게시판 초기 기본정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String registCntntsBassInfoInit(ModuleCntntsVO moduleCntntsVO) throws Exception {
        String cntntsSeq = moduleCntntsBassInfoDAO.selectModuleCntntsSeq();
        moduleCntntsVO.setCntntsSeq(cntntsSeq);
        moduleCntntsBassInfoDAO.registModuleCntntsAjax(moduleCntntsVO);
        return cntntsSeq;
    }
    
    /**
     * ㅁ 게시판 초기 기본데이터 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registCntntsDataCopy(ModuleCntntsVO moduleCntntsVO) throws Exception {

        moduleCntntsBassInfoDAO.registCntntsDataCopy(moduleCntntsVO);
    }
}

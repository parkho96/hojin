package egovframework.wzwg.module.calc.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.wzwg.module.calc.service.ModuleCalcBassInfoService;
import egovframework.wzwg.module.calc.service.ModuleCalcVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;

@Service("ModuleCalcBassInfoService")
public class ModuleCalcBassInfoServiceImpl extends EgovAbstractServiceImpl implements ModuleCalcBassInfoService {
    
	@Resource(name="CntntsInfoDAO")
    CntntsInfoDAO cntntsInfoDAO;
    
	@Resource(name="ModuleCalcBassInfoDAO")
	ModulCalcBassInfoDAO moduleCalcBassInfoDAO;

	/**
	 * 금융계산기 기본정보 리스트
	 */
	public List<ModuleCalcVO> selectModuleCalcList(ModuleCalcVO ModuleCalcVO) {
		return moduleCalcBassInfoDAO.selectModuleCalcList(ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 등록
	 */
	public int registModuleCalcAjax(ModuleCalcVO ModuleCalcVO) {
		String calcinfoSeq = moduleCalcBassInfoDAO.selectModuleCalcSeq();
		ModuleCalcVO.setCalcinfoSeq(calcinfoSeq);
		
		if (RequestContextHolder.getRequestAttributes() != null) {
			RequestContextHolder.getRequestAttributes().setAttribute("regist_sysModuleSeq", calcinfoSeq, RequestAttributes.SCOPE_SESSION);
		}
		
		return moduleCalcBassInfoDAO.registModuleCalcAjax(ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 상세조회
	 */
	public ModuleCalcVO selectCalcBassInfoDetail(ModuleCalcVO ModuleCalcVO) {
		return moduleCalcBassInfoDAO.selectCalcBassInfoDetail(ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 수정
	 */
	public int modifyModuleCalcAjax(ModuleCalcVO ModuleCalcVO) {
	    
        CntntsInfoVO paramVO = new CntntsInfoVO();
        
        paramVO.setCntntsNm(ModuleCalcVO.getCalcNm());
        paramVO.setCntntsDc(ModuleCalcVO.getCalcNm());
        paramVO.setSitecntntsSeq(ModuleCalcVO.getCalcinfoSeq());
        paramVO.setLastUpdusrId(ModuleCalcVO.getUserId());
        
        cntntsInfoDAO.modifyCntntsInfoInit(paramVO);

	    
		return moduleCalcBassInfoDAO.modifyModuleCalcAjax(ModuleCalcVO);
	}
 
}

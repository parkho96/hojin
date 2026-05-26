package egovframework.wzwg.module.calc.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.calc.service.ModuleCalcService;
import egovframework.wzwg.module.calc.service.ModuleCalcVO;

@Service("ModuleCalcService")
public class ModuleCalcServiceImpl extends EgovAbstractServiceImpl implements ModuleCalcService {
	@Resource(name="ModuleCalcDAO")
	ModuleCalcDAO moduleCalcDAO;


	/**
	 * 지도 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCalcVO selectModuleCalcDetail(ModuleCalcVO moduleCalcVO) {
		return moduleCalcDAO.selectModuleCalcDetail(moduleCalcVO);
	}
	
	/**
	 * 지도 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleCalcSeq() {
		return moduleCalcDAO.selectModuleCalcSeq();
	}

	/**
	 * 지도 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		 String calcSeq = selectModuleCalcSeq();
		 moduleCalcVO.setCalcSeq(calcSeq);
		  moduleCalcDAO.registModuleCalcAjax(moduleCalcVO);
	}
	
	/**
	 * 지도 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		return moduleCalcDAO.modifyModuleCalcAjax(moduleCalcVO);
	}
	
	/**
	 * 지도 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcCnDeleteAjax(ModuleCalcVO moduleCalcVO) {
		return moduleCalcDAO.modifyModuleCalcCnDeleteAjax(moduleCalcVO);
	}

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		return moduleCalcDAO.deleteModuleCalcAjax(moduleCalcVO);
	}
     
   /**
     * 지도 상세 - 서비스 화면
     */
    public ModuleCalcVO selectCalcScrinCntnts(ModuleCalcVO moduleCalcVO) {
        return moduleCalcDAO.selectCalcScrinCntnts(moduleCalcVO);
    }
}

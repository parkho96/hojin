package egovframework.wzwg.module.calc.service;

import java.util.List;

public interface ModuleCalcBassInfoService {

	/** 금융계산기 기본정보 리스트 */
	List<ModuleCalcVO> selectModuleCalcList(ModuleCalcVO ModuleCalcVO);

	/** 금융계산기 기본정보 등록 */
	int registModuleCalcAjax(ModuleCalcVO ModuleCalcVO);

	/** 금융계산기 기본정보 상세조회 */
	ModuleCalcVO selectCalcBassInfoDetail(ModuleCalcVO ModuleCalcVO);

	/** 금융계산기 기본정보 수정 */
	int modifyModuleCalcAjax(ModuleCalcVO ModuleCalcVO);

}

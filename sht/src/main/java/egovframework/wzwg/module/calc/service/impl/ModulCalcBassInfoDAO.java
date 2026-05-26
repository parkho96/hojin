package egovframework.wzwg.module.calc.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.calc.service.ModuleCalcVO;


@Repository("ModuleCalcBassInfoDAO")
public class ModulCalcBassInfoDAO extends EgovAbstractMapper{

	/**
	 * 금융계산기 기본정보 리스트
	 * @param ModuleCalcVO
	 * @return
	 */
	public List<ModuleCalcVO> selectModuleCalcList(ModuleCalcVO ModuleCalcVO) {
		return selectList("ModuleCalcBassInfoDAO_selectModuleCalcList", ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 시퀀스 조회(CNTNTS_SEQ)
	 * @return
	 */
	public String selectModuleCalcSeq() {
		return (String) selectOne("ModuleCalcBassInfoDAO_selectModuleCalcSeq", null);
	}

	/**
	 * 금융계산기 기본정보 등록
	 * @param ModuleCalcVO
	 * @return
	 */
	public int registModuleCalcAjax(ModuleCalcVO ModuleCalcVO) {
		return update("ModuleCalcBassInfoDAO_registModuleCalcAjax", ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 상세조회
	 * @param ModuleCalcVO
	 * @return
	 */
	public ModuleCalcVO selectCalcBassInfoDetail(ModuleCalcVO ModuleCalcVO) {
		return (ModuleCalcVO) selectOne("ModuleCalcBassInfoDAO_selectCalcBassInfoDetail", ModuleCalcVO);
	}

	/**
	 * 금융계산기 기본정보 수정
	 * @param ModuleCalcVO
	 * @return
	 */
	public int modifyModuleCalcAjax(ModuleCalcVO ModuleCalcVO) {
		return update("ModuleCalcBassInfoDAO_modifyModuleCalcAjax", ModuleCalcVO);
	}

}

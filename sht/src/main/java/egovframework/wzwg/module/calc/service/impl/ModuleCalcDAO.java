package egovframework.wzwg.module.calc.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.calc.service.ModuleCalcVO;


@Repository("ModuleCalcDAO")
public class ModuleCalcDAO extends EgovAbstractMapper{
 

	/**
	 * 지도 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCalcVO selectModuleCalcDetail(ModuleCalcVO moduleCalcVO) {
		/*Map<String, String> result = (Map<String, String>) selectOne("ModuleCalcDAO_selectModuleCalcDetail2", moduleCalcVO);
		
		ModuleCalcVO resultVO = new ModuleCalcVO();
		
		if(result != null && result.size() > 0){
			resultVO.setCalcCn(String.valueOf(result.get("calcCn")));
			resultVO.setCalcSeq    (String.valueOf(result.get("clacSeq")));
			resultVO.setCalcType   (String.valueOf(result.get("calcType")));
			resultVO.setCalcinfoSeq(String.valueOf(result.get("clacinfoSeq")));
		}
		
		return resultVO;*/
		return (ModuleCalcVO) selectOne("ModuleCalcDAO_selectModuleCalcDetail", moduleCalcVO);
	}
	
	/**
	 * 지도 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleCalcSeq() {
		return (String) selectOne("ModuleCalcDAO_selectModuleCalcSeq", null);
	}

	/**
	 * 지도 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		  insert("ModuleCalcDAO_registModuleCalcAjax", moduleCalcVO);
	}
	

	/**
	 * 지도 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		return update("ModuleCalcDAO_modifyModuleCalcAjax", moduleCalcVO);
	}
	
	/**
	 * 지도 데이터 컨텐츠 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcCnDeleteAjax(ModuleCalcVO moduleCalcVO) {
		return update("ModuleCalcDAO_modifyModuleCalcCnDeleteAjax", moduleCalcVO);
	}
	

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleCalcAjax(ModuleCalcVO moduleCalcVO) {
		return update("ModuleCalcDAO_deleteModuleCalcAjax", moduleCalcVO);
	}
	
    /**
     * 지도 상세 - 서비스 화면
     */
    public ModuleCalcVO selectCalcScrinCntnts(ModuleCalcVO moduleCalcVO) {
        return (ModuleCalcVO)selectOne("ModuleCalcDAO_selectModuleCalcDetail", moduleCalcVO);
    }

}

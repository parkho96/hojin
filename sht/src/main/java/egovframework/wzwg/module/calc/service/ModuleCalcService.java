package egovframework.wzwg.module.calc.service;


public interface ModuleCalcService {

	/**
	 * 금융계산기 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleCalcVO selectModuleCalcDetail(ModuleCalcVO moduleCalcVO);
	
	/**
	 * 금융계산기 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleCalcSeq() ;
	/**
	 * 금융계산기 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleCalcAjax(ModuleCalcVO moduleCalcVO);
	
	/**
	 * 금융계산기 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcAjax(ModuleCalcVO moduleCalcVO);

	/**
	 * 금융계산기 컨텐츠 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleCalcCnDeleteAjax(ModuleCalcVO moduleCalcVO) ;
	
	/**
	 * 금융계산기 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleCalcAjax(ModuleCalcVO moduleCalcVO) ;
	
    /**
     * 금융계산기 상세 - 서비스 화면
     */
    public ModuleCalcVO selectCalcScrinCntnts(ModuleCalcVO moduleCalcVO);

}

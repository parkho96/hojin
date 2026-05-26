package egovframework.wzwg.module.beffatPlbc.service;

import java.util.List;

public interface ModuleBeffatPlbcService {
	
	/**
	 * 사전정보공표 카테고리 초기화
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public void initCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	
	/**
	 * 사전정보공표 카테고리 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgryList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 정보 낮은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgrySortDown(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 정보 높은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyCtgrySortUp(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 카테고리 정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteCtgryData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사전정보공표 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcMainList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 정보 낮은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainSortDown(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 정보 높은 순번과 변경 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainSortUp(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 데이터 퀵메뉴 등록/해제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainQkMenu(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 메인데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcMainData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 사전정보공표 서브 데이터 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 서브 데이터 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<ModuleBeffatPlbcVO> selectBeffatPlbcSubList(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 서브 데이터 목록 개수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public String selectBeffatPlbcSubTotalCount(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 서브 데이터 상세 데이터 조회
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public ModuleBeffatPlbcVO selectBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 서브 데이터 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifyBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception;
	
	/**
	 * 사전정보공표 서브 데이터 삭제(업데이트)
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteBeffatPlbcSubData(ModuleBeffatPlbcVO paramVO) throws Exception;
}

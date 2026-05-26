package egovframework.wzwg.module.ntt.schdul.service;

import java.util.List;
import java.util.Map;

public interface ModuleNttSchdulDataManageService {
	
	/**
	 * ㅁ 일정 데이터  목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<ModuleNttSchdulDataManageVO> selectNttSchdulDataList(ModuleNttSchdulDataManageVO paramVO) throws Exception;
	
	/**
	 * ㅁ 일정 데이터 기본정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public ModuleNttSchdulDataManageVO selectNttSchdulDataDetail(ModuleNttSchdulDataManageVO paramVO) throws Exception;
	
	/**
     * ㅁ 일정 데이터 기본정보 (일반, 급식) 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifyNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception;
	
    /**
     * ㅁ 일정 데이터 기본정보(일반, 급식) 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception;
    
    /**
     * ㅁ 일정 데이터 기본정보 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int deleteNttSchdulData(ModuleNttSchdulDataManageVO paramVO) throws Exception;
    
    /**
     * 
     */
    public Map<String, Object> createCalendarData (ModuleNttSchdulDataManageVO paramVO) throws Exception;

}

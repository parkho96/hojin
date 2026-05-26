package egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service;

import java.util.List;

public interface SysModuleInfoService {
	
	/**
	 * 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysModuleInfoVO> selectSysModuleInfoList(SysModuleInfoVO paramVO) throws Exception;
	
	/**
	 * 시스템모듈목록 총 갯수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysModuleInfoListCnt(SysModuleInfoVO paramVO) throws Exception;
	  
	
	/**
	 * 상세
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SysModuleInfoVO selectSysModuleInfoDetail(SysModuleInfoVO paramVO) throws Exception;
	
	
	/**
	 * 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registSysModuleInfo(SysModuleInfoVO paramVO) throws Exception;
	
	
	/**
	 * 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifySysModuleInfo(SysModuleInfoVO paramVO) throws Exception;

	
	/**
	 * 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysModuleInfo(SysModuleInfoVO paramVO) throws Exception;

	
	/**
	 * 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysModuleInfoVO> selectSysModuleInfoAllList(String siteSeq) throws Exception;
	

}

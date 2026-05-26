package egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;

@Service("SysModuleInfoService")
public class SysModuleInfoServiceImpl extends EgovAbstractServiceImpl implements SysModuleInfoService {
	
	@Resource(name="SysModuleInfoDAO")
    private SysModuleInfoDAO sysModuleInfoDAO;
	
	/**
	 * 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysModuleInfoVO> selectSysModuleInfoList(SysModuleInfoVO paramVO) throws Exception {
		
		return sysModuleInfoDAO.selectSysModuleInfoList(paramVO);
	}
	
	/**
	 * 시스템모듈목록 총 갯수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysModuleInfoListCnt(SysModuleInfoVO paramVO) throws Exception {
		return sysModuleInfoDAO.selectSysModuleInfoListCnt(paramVO);
	}
	  
	
	/**
	 * 상세
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SysModuleInfoVO selectSysModuleInfoDetail(SysModuleInfoVO paramVO) throws Exception {
		
		return sysModuleInfoDAO.selectSysModuleInfoDetail(paramVO);
	}
	
	
	/**
	 * 등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registSysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return sysModuleInfoDAO.registSysModuleInfo(paramVO);
	}
	
	
	/**
	 * 수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifySysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return sysModuleInfoDAO.modifySysModuleInfo(paramVO);
	}

	
	/**
	 * 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return sysModuleInfoDAO.deleteSysModuleInfo(paramVO);
	}
	
	/**
	 * 목록 전체
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysModuleInfoVO> selectSysModuleInfoAllList(String siteSeq) throws Exception {
		
		return sysModuleInfoDAO.selectSysModuleInfoAllList(siteSeq);
	}
	
}

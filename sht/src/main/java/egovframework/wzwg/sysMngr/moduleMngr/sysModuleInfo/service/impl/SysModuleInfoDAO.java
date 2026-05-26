package egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;

@Repository("SysModuleInfoDAO")
public class SysModuleInfoDAO extends EgovAbstractMapper {
	
	@Autowired
	HttpSession session;
	
	/**
	 * 시스템모듈목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public List<SysModuleInfoVO> selectSysModuleInfoList(SysModuleInfoVO paramVO) throws Exception {
		
		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("SysModuleInfoDAO_selectSysModuleInfoList", paramVO);
	}
	
	/**
	 * 시스템모듈목록 총 갯수
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysModuleInfoListCnt(SysModuleInfoVO paramVO) throws Exception {
		return (Integer)selectOne("SysModuleInfoDAO_selectSysModuleInfoListCnt", paramVO);
	}
    
    
  /**
   * 시스템모듈상세
   * @param paramVO
   * @return
   * @throws Exception
   */
  public SysModuleInfoVO selectSysModuleInfoDetail(String sysmoduleSeq) throws Exception {
	  String langcode = null;

	  SysModuleInfoVO paramVO = new SysModuleInfoVO();
	  
	  if(session.getAttribute("useLangCode") != null){
	  	langcode = session.getAttribute("useLangCode").toString();
	  }

	  paramVO.setSysmoduleSeq(sysmoduleSeq);
	  paramVO.setLangCode(langcode);
	  
      return (SysModuleInfoVO) selectOne("SysModuleInfoDAO_selectSysModuleInfoDetail", paramVO);
  }
	  
	
	/**
	 * 시스템모듈상세
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public SysModuleInfoVO selectSysModuleInfoDetail(SysModuleInfoVO paramVO) throws Exception {
		
	    return selectSysModuleInfoDetail(paramVO.getSysmoduleSeq());
	}
	
	
	/**
	 * 시스템모듈등록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int registSysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return update("SysModuleInfoDAO_registSysModuleInfo", paramVO);
	}
	
	
	/**
	 * 시스템모듈수정
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int modifySysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return update("SysModuleInfoDAO_modifySysModuleInfo", paramVO);
	}

	
	/**
	 * 시스템모듈삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysModuleInfo(SysModuleInfoVO paramVO) throws Exception {
		
		return update("SysModuleInfoDAO_deleteSysModuleInfo", paramVO);
	}
	
	/**
	 * 시스템모듈전체목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	
	public List<SysModuleInfoVO> selectSysModuleInfoAllList(String siteSeq) throws Exception {
		String langcode = null;
		SysModuleInfoVO paramVO = new SysModuleInfoVO();
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		paramVO.setSiteSeq(siteSeq);
		
		return selectList("SysModuleInfoDAO_selectSysModuleInfoAllList", paramVO);
	}
}

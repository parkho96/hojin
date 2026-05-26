package egovframework.wzwg.module.sideQuick.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.sideQuick.service.ModuleSideQuickVO;

@Repository("ModuleSideQuickDAO")

public class ModuleSideQuickDAO extends EgovAbstractMapper{
	
	
	public ModuleSideQuickVO selectSideQuickStbs(String siteSeq) throws Exception{
		return (ModuleSideQuickVO) selectOne("ModuleSideQuickDAO_selectSideQuickStbs", siteSeq);
	}

	
	public String selectSideQuickStbsSeq() throws Exception{
		return (String) selectOne("ModuleSideQuickDAO_selectSideQuickStbsSeq");
	}
	
	
	public int registSideQuickStbs(ModuleSideQuickVO quickVO) throws Exception{
		String seq = selectSideQuickStbsSeq();
		quickVO.setQmenuetSeq(seq);
		
		Integer result = (Integer) update("ModuleSideQuickDAO_registSideQuickStbs", quickVO); 
		
		return result == null ? 0 : 1;
	}
	
	
	public int modifySideQuickStbs(ModuleSideQuickVO quickVO) throws Exception{
		
		Integer result = (Integer) update("ModuleSideQuickDAO_modifySideQuickStbs", quickVO); 
		
		return result == null ? 0 : 1;
	}
	
	public List<ModuleSideQuickVO> selectSideQuickLinkList(String siteSeq) throws Exception{
		
		return selectList("ModuleSideQuickDAO_selectSideQuickLinkList", siteSeq);
	}
	
	public int registQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception{
		Integer result = (Integer) update("ModuleSideQuickDAO_registQuickLinkInfo", quickVO); 
		
		return result == null ? 0 : 1;
	}
	
	public ModuleSideQuickVO selectSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception{
		
		return (ModuleSideQuickVO) selectOne("ModuleSideQuickDAO_selectSideQuickLinkInfo", quickVO);
	}
	
	public int modifySideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception{
		
		return update("ModuleSideQuickDAO_modifyQuickLinkInfo", quickVO);
	}
	
	/**
	 * 퀵메뉴 링크 데이터 삭제
	 * @param quickVO
	 * @return
	 */
	public int deleteSideQuickLinkInfo(ModuleSideQuickVO quickVO) throws Exception{
		return update("ModuleSideQuickDAO_deleteQuickLinkInfo", quickVO);
	}
	
	public ModuleSideQuickVO selectSideQuickLinkInfoOrdrPrev(ModuleSideQuickVO quickVO) throws Exception{
		return (ModuleSideQuickVO) selectOne("ModuleSideQuickDAO_selectQuickLinkInfoOrdrPrev", quickVO);
	}
	
	public ModuleSideQuickVO selectSideQuickLinkInfoOrdrNext(ModuleSideQuickVO quickVO) throws Exception{
		return (ModuleSideQuickVO) selectOne("ModuleSideQuickDAO_selectQuickLinkInfoOrdrNext", quickVO);
	}
	
	public int modifySideQuickLinkInfoOrdr(ModuleSideQuickVO quickVO) throws Exception{
		return update("ModuleSideQuickDAO_modifyQuickLinkInfoOrdr", quickVO);
	}
}

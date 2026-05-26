package egovframework.wzwg.cmm.mber.myPage.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;

@Repository("CmmMyWritngDAO")

public class CmmMyWritngDAO extends EgovAbstractMapper {


	public List<ModuleNttVO> selectMyWritngNttList(ModuleNttVO vo) throws Exception {
    	return selectList("CmmMyWritngDAO_selectMyWritngNttList_S", vo);
    }
	
	public Integer selectMyWritngNttListTotCnt(ModuleNttVO vo) throws Exception {
		return (Integer) selectOne("CmmMyWritngDAO_selectMyWritngNttListTotCnt_S", vo);
	}
    
    public List<ModuleNttAnswerVO> selectMyWritngAnswerList(ModuleNttAnswerVO vo) throws Exception {
    	return selectList("CmmMyWritngDAO_selectMyWritngAnswerList_S", vo);
    }
    
    public Integer selectMyWritngAnswerListTotCnt(ModuleNttAnswerVO vo) throws Exception {
		return (Integer) selectOne("CmmMyWritngDAO_selectMyWritngAnswerListTotCnt_S", vo);
	}
    
    public List<ModuleNttScrapVO> selectMyScrapList(ModuleNttScrapVO vo) throws Exception {
    	return selectList("CmmMyWritngDAO_selectMyScrapList_S", vo);
	}
	
	public Integer selectMyScrapListTotCnt(ModuleNttScrapVO vo) throws Exception {
		return (Integer) selectOne("CmmMyWritngDAO_selectMyScrapListTotCnt_S", vo);
	}
}

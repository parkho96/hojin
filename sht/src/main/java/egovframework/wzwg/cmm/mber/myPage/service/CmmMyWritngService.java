package egovframework.wzwg.cmm.mber.myPage.service;

import java.util.List;

import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;


public interface CmmMyWritngService {
	
	public List<ModuleNttVO> selectMyWritngNttList(ModuleNttVO vo) throws Exception;
	
	public Integer selectMyWritngNttListTotCnt(ModuleNttVO vo) throws Exception;
	
	public List<ModuleNttAnswerVO> selectMyWritngAnswerList(ModuleNttAnswerVO vo) throws Exception;
	
	public Integer selectMyWritngAnswerListTotCnt(ModuleNttAnswerVO vo) throws Exception;

	public List<ModuleNttScrapVO> selectMyScrapList(ModuleNttScrapVO vo) throws Exception;
	
	public Integer selectMyScrapListTotCnt(ModuleNttScrapVO vo) throws Exception;
	
	
}

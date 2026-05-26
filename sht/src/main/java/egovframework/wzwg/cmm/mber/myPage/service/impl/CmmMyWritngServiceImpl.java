package egovframework.wzwg.cmm.mber.myPage.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.cmm.mber.myPage.service.CmmMyWritngService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;


@Service("CmmMyWritngService")
public class CmmMyWritngServiceImpl extends EgovAbstractServiceImpl implements CmmMyWritngService {

    @Resource(name="CmmMyWritngDAO")
    private CmmMyWritngDAO cmmMyWritngDAO;
	

    public List<ModuleNttVO> selectMyWritngNttList(ModuleNttVO vo) throws Exception {
    	return cmmMyWritngDAO.selectMyWritngNttList(vo);
    }
    
    public Integer selectMyWritngNttListTotCnt(ModuleNttVO vo) throws Exception {
		return cmmMyWritngDAO.selectMyWritngNttListTotCnt(vo);
	}
    
    public List<ModuleNttAnswerVO> selectMyWritngAnswerList(ModuleNttAnswerVO vo) throws Exception {
    	return cmmMyWritngDAO.selectMyWritngAnswerList(vo);
    }
    
    public Integer selectMyWritngAnswerListTotCnt(ModuleNttAnswerVO vo) throws Exception {
		return cmmMyWritngDAO.selectMyWritngAnswerListTotCnt(vo);
	}
    
	public List<ModuleNttScrapVO> selectMyScrapList(ModuleNttScrapVO vo) throws Exception {
		return cmmMyWritngDAO.selectMyScrapList(vo);
	}
	
	public Integer selectMyScrapListTotCnt(ModuleNttScrapVO vo) throws Exception {
		return cmmMyWritngDAO.selectMyScrapListTotCnt(vo);
	}
    

}

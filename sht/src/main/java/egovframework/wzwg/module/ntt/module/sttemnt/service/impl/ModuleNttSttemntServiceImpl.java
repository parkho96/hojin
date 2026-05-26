package egovframework.wzwg.module.ntt.module.sttemnt.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.ntt.module.sttemnt.service.ModuleNttSttemntService;
import egovframework.wzwg.module.ntt.module.sttemnt.service.ModuleNttSttemntVO;



@Service("ModuleNttSttemntService")
public class ModuleNttSttemntServiceImpl extends EgovAbstractServiceImpl implements ModuleNttSttemntService {

	
	@Resource(name="ModuleNttSttemntDAO")
    protected ModuleNttSttemntDAO nttSttemntDAO;
	
	
	
	/**
	 * ㅁ 게시물 신고SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextNttSttemntSeq() throws Exception {
		return nttSttemntDAO.selectNextNttSttemntSeq();
	}
	
	/**
	 * ㅁ 게시물 신고
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer registNttSttemnt(ModuleNttSttemntVO nttSttemntVO) throws Exception {
		return nttSttemntDAO.registNttSttemnt(nttSttemntVO);
	}
	
	
}
